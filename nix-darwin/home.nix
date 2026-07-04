{ config, pkgs, ... }: {
  # Change these if your user or home paths differ
  home.username = "alekseypanchenko";
  home.homeDirectory = "/Users/alekseypanchenko";
  
  # State version for compatibility checks. Leave this as is.
  home.stateVersion = "26.05";

  # User-specific packages. You can move your CLI tools here 
  # from environment.systemPackages if you want them isolated to your user.
  home.packages = with pkgs; [
    git
    obsidian
    neovim
    telegram-desktop
    # bitwarden-desktop
    bitwarden-cli
    # bitwarden-menu
    yazi
    stow
    # fish
    ripgrep
    lazygit
    nodejs
    unzip
    go
    sqlite
    gcc
    nixd
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # 1. Inject your existing .tmux.conf contents
      ${builtins.readFile /Users/alekseypanchenko/.dot-files/.tmux.conf}

      # 2. Append your Nix-managed Fish configuration
      set -g default-command ${pkgs.fish}/bin/fish
      set -g default-shell ${pkgs.fish}/bin/fish
    '';
  };

  programs.kitty = {
    enable = true;
    settings.shell = "/run/current-system/sw/bin/fish";
    extraConfig = "include ~/.dot-files/kitty/.config/kitty/kitty.conf";
  };

   programs.fish = {
     enable = true;
     interactiveShellInit = "source ~/.dot-files/fish/.config/fish/config.fish";
   };

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/nvim/.config/nvim";
    ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/yazi/.config/yazi";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
