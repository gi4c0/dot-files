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
    kitty
    obsidian
    neovim
    telegram-desktop
    # bitwarden-desktop
    bitwarden-cli
    # bitwarden-menu
    yazi
    tmux
    stow
    zoxide
    # fish
    starship
    ripgrep
    lazygit
    nodejs
    unzip
    go
    sqlite
    gcc
    nixd
  ];

  # The magic link: point Home Manager to your mutable dotfiles repo
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/nvim/.config/nvim";
    # ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/kitty";
    # ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/fish/.config/fish/config.fish";
    # You can add tmux, stow, or any other directory similarly
  };

   programs.fish = {
     enable = true;
     interactiveShellInit = ''
       source ~/.dot-files/fish/.config/fish/config.fish
    '';
   };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
