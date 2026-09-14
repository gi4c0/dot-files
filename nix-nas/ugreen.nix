# UGREEN DXP4800 Plus hardware support.
#
# Two pieces of hardware need out-of-tree kernel modules on this box:
#
#   1. Fan controller  -> ITE IT8613E Super I/O chip (mainline kernel does not
#      support it). We build the community "it87" module and force the chip ID.
#   2. Front LED panel -> communicates over I2C (SMBus I801) at 0x3a. On a
#      non-UGOS OS all LEDs blink in a rolling sequence. We build the
#      "led-ugreen" module and register the 0x3a device so the LEDs show up in
#      /sys/class/leds and can be driven normally.
{ config, pkgs, lib, ... }:

let
  # It87 fan/temperature driver for the IT8613E Super I/O chip.
  it87 = config.boot.kernelPackages.callPackage
    ({ stdenv, fetchFromGitHub, kernel }:
      stdenv.mkDerivation {
        pname = "it87";
        version = "unstable";
        src = fetchFromGitHub {
          owner = "frankcrawford";
          repo = "it87";
          rev = "bc06d3488439e5fcd725c1bdcfcac994d6d95cac";
          hash = "sha256-8JWooXloS19MGSK7zDKKApmlfiiyyR7qcRky32sb6rk=";
        };
        nativeBuildInputs = kernel.moduleBuildDependencies;
        makeFlags = [
          "TARGET=${kernel.modDirVersion}"
          "KERNEL_BUILD=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
          "INSTALL_MOD_PATH=$(out)"
        ];
        installPhase = ''
          install -Dm644 it87.ko $out/lib/modules/${kernel.modDirVersion}/extra/it87.ko
        '';
      }) { };

  # led-ugreen driver for the front panel LED controller.
  ledUgreen = config.boot.kernelPackages.callPackage
    ({ stdenv, fetchFromGitHub, kernel }:
      stdenv.mkDerivation {
        pname = "led-ugreen";
        version = "0.2";
        src = fetchFromGitHub {
          owner = "miskcoo";
          repo = "ugreen_leds_controller";
          rev = "992fc6dcb5da4cfc9aa25561eff2f584c06f586d";
          hash = "sha256-h0HJ7TqmRP1X6U3M4Vsivv2E6QjQsY38wRCqLOXuZxY=";
        };
        nativeBuildInputs = kernel.moduleBuildDependencies;
        KERNELRELEASE = kernel.modDirVersion;
        KDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
        makeFlags = [ "-C" "kmod" ];
        installPhase = ''
          install -Dm644 kmod/led-ugreen.ko \
            $out/lib/modules/${kernel.modDirVersion}/extra/led-ugreen.ko
        '';
      }) { };
in
{
  # ==== Fan controller (it87) ====

  # ACPI reserves the I/O ports the it87 driver needs (0x0a00-0x0a3f); relax
  # enforcement so the driver can claim them.
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  boot.extraModulePackages = [ it87 ledUgreen ];

  boot.extraModprobeConfig = ''
    # force_id: the IT8613E is not in mainline's ID table for it87.
    # ignore_resource_conflict: in-tree ACPI override for the SIO ports.
    options it87 force_id=0x8613 ignore_resource_conflict=1
  '';

  boot.kernelModules = [
    "it87"
    "i2c-dev"          # userspace I2C (/dev/i2c-*) for the LED controller
    "led-ugreen"
    "ledtrig-oneshot"
    "ledtrig-netdev"
  ];

  # Put every fan channel into hardware "automatic" mode on boot (enable=2).
  # The chip then drives the fans off its own temperature readings. If you
  # prefer a constant fan speed, set a channel to manual instead, e.g.:
  #   echo 1 > $hwmon/pwm3_enable   # manual
  #   echo 50 > $hwmon/pwm3          # duty cycle 0-255
  systemd.services.ugreen-fan-init = {
    description = "Initialise UGREEN fan channels (it87)";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      for attempt in $(seq 1 10); do
        for hwmon in /sys/class/hwmon/hwmon*; do
          if [ "$(cat "$hwmon/name" 2>/dev/null)" = "it8613" ]; then
            for pwm in "$hwmon"/pwm{2,3,4,5}_enable; do
              echo 2 > "$pwm" 2>/dev/null || true
            done
            echo "ugreen-fan-init: set all channels to auto on $hwmon"
            exit 0
          fi
        done
        sleep 1
      done
      echo "ugreen-fan-init: it8613 hwmon not found after 10 attempts" >&2
      exit 1
    '';
  };

  # ==== Front LED panel ====

  # Register the LED controller on the SMBus and set sane defaults.
  # Without this the panel sits in UGOS-pro's rolling blink sequence.
  systemd.services.ugreen-led-init = {
    description = "Register UGREEN front-panel LEDs";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # Locate the SMBus I801 adapter that hosts the LED chip.
      bus=""
      for dev in /sys/bus/i2c/devices/i2c-*; do
        if printf '%s' "$(cat "$dev/name" 2>/dev/null)" | grep -q "I801"; then
          bus="$(basename "$dev")"
          break
        fi
      done
      if [ -z "$bus" ]; then
        echo "ugreen-led-init: SMBus I801 adapter not found" >&2
        exit 1
      fi

      # Bind the led-ugreen driver to the LED chip at address 0x3a. This
      # creates the /sys/class/leds/{power,netdev,disk1..disk4} entries.
      dev_path="/sys/bus/i2c/devices/$bus/''${bus/i2c-/}-003a"
      if [ ! -d "$dev_path" ]; then
        echo "led-ugreen 0x3a" > "/sys/bus/i2c/devices/$bus/new_device"
      fi

      # Wait for the LED class devices to appear.
      for _ in $(seq 1 10); do
        [ -e /sys/class/leds/power ] && break
        sleep 1
      done

      # Power LED: solid white.
      echo 255 > /sys/class/leds/power/brightness
      echo "255 255 255" > /sys/class/leds/power/color

      # Network LED: blink on link activity (ledtrig-netdev).
      iface=""
      for d in /sys/class/net/*; do
        n="$(basename "$d")"
        if [ "$n" != "lo" ] && [ "$(cat "$d/type" 2>/dev/null)" = "1" ]; then
          iface="$n"
          break
        fi
      done
      if [ -n "$iface" ] && [ -e /sys/class/leds/netdev ]; then
        echo netdev > /sys/class/leds/netdev/trigger
        echo "$iface" > /sys/class/leds/netdev/device_name
        echo 1 > /sys/class/leds/netdev/link 2>/dev/null || true
      fi

      # Disk LEDs: left dark by default. To show drive presence, uncomment:
      # for i in 1 2 3 4; do
      #   echo 255 > /sys/class/leds/disk$i/brightness
      #   echo "255 255 255" > /sys/class/leds/disk$i/color
      # done

      echo "ugreen-led-init: LEDs registered on $bus"
    '';
  };
}
