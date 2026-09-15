# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes and the new nix CLI.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];



  # ============================================================
  # Boot
  # ============================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Sync boot files to backup ESP on second NVMe after each update
  boot.loader.systemd-boot.extraInstallCommands = ''
    # Sync to backup ESP (Patriot P300 #2)
    # DEVICE="/dev/disk/by-id/nvme-Patriot_M.2_P300_128GB_P300LCBA2508221720"
    # BACKUP_PART="''${DEVICE}-part1"
    # ${pkgs.coreutils}/bin/mkdir -p /boot-backup
    # ${pkgs.util-linux}/bin/mount "$BACKUP_PART" /boot-backup || true
    # ${pkgs.rsync}/bin/rsync -a --delete /boot/ /boot-backup/ || true
    # ${pkgs.util-linux}/bin/umount /boot-backup 2>/dev/null || true

    # Sync to UGOS ESP (BIOS boots from here)
    UGOS_DEV=$(${pkgs.coreutils}/bin/readlink -f /dev/disk/by-id/nvme-YSO128GTLCW-E3C-2_511250811096003796 2>/dev/null || true)
    if [ -n "$UGOS_DEV" ]; then
      ${pkgs.util-linux}/bin/blockdev --setrw "''${UGOS_DEV}" 2>/dev/null || true
      ${pkgs.util-linux}/bin/blockdev --setrw "''${UGOS_DEV}p1" 2>/dev/null || true
      ${pkgs.coreutils}/bin/mkdir -p /boot-ugos
      ${pkgs.util-linux}/bin/mount -o rw "''${UGOS_DEV}p1" /boot-ugos 2>/dev/null || true
      ${pkgs.rsync}/bin/rsync -a --delete --exclude='EFI/debian' --exclude='boot' /boot/ /boot-ugos/ 2>/dev/null || true
      ${pkgs.util-linux}/bin/umount /boot-ugos 2>/dev/null || true
      ${pkgs.util-linux}/bin/blockdev --setro "''${UGOS_DEV}p1" 2>/dev/null || true
      ${pkgs.util-linux}/bin/blockdev --setro "''${UGOS_DEV}" 2>/dev/null || true
    fi
  '';

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nas" = {
    isNormalUser = true;
    description = "nas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neovim
      kitty
      yazi
      opencode
      stow
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config.user = {
    	name = "Oleksii Panchenko";
	email = "alex.pan4@proton.me";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
