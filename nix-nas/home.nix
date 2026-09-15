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
    opencode
    obsidian
    neovim
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
      # Inject existing .tmux.conf contents using dynamic homeDir
      ${builtins.readFile (homeDir + "/.dot-files/.tmux.conf")}

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
      fish_add_path /run/current-system/sw/bin
      fish_add_path /nix/var/nix/profiles/default/bin
    '';
  };

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dot-files/nvim/.config/nvim";
    ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/.dot-files/yazi/.config/yazi";
  };

  programs.home-manager.enable = true;
}
