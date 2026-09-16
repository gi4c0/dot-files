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
  # Keep only the 2 newest generations on the ESP. Each generation is ~66 MB
  # (initrd + kernel), and the bootable UGOS ESP is only 256 MB, so unlimited
  # generations would overflow it (the original cause of the stale boot).
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Sync boot files to the UGOS ESP (BIOS boots from here), so the latest
  # generation is always bootable. Fail loudly on any error instead of
  # silently keeping a stale ESP that boots an old generation without fish/tmux.
  boot.loader.systemd-boot.extraInstallCommands = ''
    set -e
    UGOS_LABEL="UGOS ESP (nvme-YSO128GTLCW-E3C-2_511250811096003796)"

    # Ensure no leftover mount is still occupied from a previous failed run
    ${pkgs.util-linux}/bin/umount /boot-ugos 2>/dev/null || true

    # Sync to the UGOS ESP that the BIOS boots from
    UGOS_DEV=$(${pkgs.coreutils}/bin/readlink -f /dev/disk/by-id/nvme-YSO128GTLCW-E3C-2_511250811096003796)
    if [ -z "$UGOS_DEV" ]; then
      echo "ERROR: $UGOS_LABEL not found; skipping sync" >&2
      exit 1
    fi

    ${pkgs.util-linux}/bin/blockdev --setrw "$UGOS_DEV"
    ${pkgs.util-linux}/bin/blockdev --setrw "$UGOS_DEV"p1
    ${pkgs.coreutils}/bin/mkdir -p /boot-ugos
    ${pkgs.util-linux}/bin/mount "$UGOS_DEV"p1 /boot-ugos
    trap '${pkgs.util-linux}/bin/umount /boot-ugos 2>/dev/null || true' EXIT
    ${pkgs.rsync}/bin/rsync -a --delete --exclude='EFI/debian' --exclude='boot' /boot/ /boot-ugos/

    # Sanity check: newest boot entry must have reached the UGOS ESP
    NEWEST_BOOT=$(${pkgs.coreutils}/bin/ls /boot/loader/entries | ${pkgs.coreutils}/bin/sort -V | ${pkgs.coreutils}/bin/tail -n1)
    NEWEST_UGOS=$(${pkgs.coreutils}/bin/ls /boot-ugos/loader/entries | ${pkgs.coreutils}/bin/sort -V | ${pkgs.coreutils}/bin/tail -n1)
    if [ "$NEWEST_BOOT" != "$NEWEST_UGOS" ]; then
      echo "ERROR: newest boot entry $NEWEST_BOOT not synced to $UGOS_LABEL (still $NEWEST_UGOS)" >&2
      exit 1
    fi

    ${pkgs.util-linux}/bin/blockdev --setro "$UGOS_DEV"p1
    ${pkgs.util-linux}/bin/blockdev --setro "$UGOS_DEV"
  '';

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/8baec209-5d57-434b-9390-26b66afee78a";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ];
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable Tailscale service
  services.tailscale.enable = true;

  # Open UDP port 41641 for optimal peer-to-peer performance
  networking.firewall.allowedUDPPorts = [ 41641 ];

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
      kdePackages.kate
    #  thunderbird
    ];

    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    configure = {
      # extraPackages = with pkgs; [ sqlite ];
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ nvim-treesitter.withAllGrammars ];
      };

      customRC = ''
        lua << EOF
          vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
        EOF

        set runtimepath+=~/.config/nvim
        source ~/.config/nvim/init.lua
      '';
    };
  };
  
  sops = {
      defaultSopsFile = /home/nas/.dot-files/nix-nas/secrets.yaml;
      defaultSopsFormat = "yaml";
    
    # Tell sops-nix to use the SSH host key for decryption at boot
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
   
    secrets.nextcloud_admin_pass = {
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  programs.git = {
    enable = true;
    config.user = {
    	name = "Oleksii Panchenko";
      email = "alex.pan4@proton.me";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.shells = [ pkgs.fish ];

# Disable systemd sleep, suspend, and hibernation targets
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

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
