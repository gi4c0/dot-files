{ config, pkgs, inputs, ... }:
let
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  
  # Set home directory based on OS
  isDarwin = pkgs.stdenv.isDarwin;
  username = "nas";
  homeDir = if isDarwin then "/Users/${username}" else "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
    typos-lsp
    bitwarden-desktop
    pkgs-unstable.immich-go
    opencode
    obsidian
    kepubify
    pkgs-unstable.telegram-desktop
    bitwarden-cli
    yazi
    claude-code
    stow
    ripgrep
    lazygit
    nodejs
    unzip
    go
    sqlite
    gcc
    nixd
    cspell
    devenv
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
      ${builtins.readFile ../tmux/.tmux.nix.conf}

      # Nix-managed Fish configuration
      set -g default-command ${pkgs.fish}/bin/fish
      set -g default-shell ${pkgs.fish}/bin/fish
    '';
  };

  programs.kitty = {
    enable = true;
    # Uses home directory relative path
    extraConfig = "include ~/.dot-files/kitty/.config/kitty/kitty.conf";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test -f ~/.dot-files/fish/.config/fish/config.fish
        source ~/.dot-files/fish/.config/fish/config.fish
      end
    '';
  };

  home.file = {
    ".config/nvim/after".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/after";
    ".config/nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/lua";
    ".config/nvim/snips".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/snips";
    ".config/nvim/scripts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/scripts";
    ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/init.lua";
    ".config/nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/nvim/.config/nvim/lazy-lock.json";
    ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dot-files/yazi/.config/yazi";
  };

  programs.home-manager.enable = true;
}
