{ config, pkgs, ... }: {
  # Change these if your user or home paths differ
  home.username = "alekseypanchenko";
  home.homeDirectory = "/Users/alekseypanchenko";
  
  # State version for compatibility checks. Leave this as is.
  home.stateVersion = "26.05";


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # This patches the Neovim binary to always see the correct 64-bit SQLite
    # package = unstable.neovim-unwrapped;

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

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # User-specific packages. You can move your CLI tools here 
  # from environment.systemPackages if you want them isolated to your user.
  home.packages = with pkgs; [
    git
    kitty
    telegram-desktop
    wget
    gedit
    bitwarden-desktop
    bitwarden-cli
    bitwarden-menu
    yazi
    tmux
    stow
    zoxide
    starship
    ripgrep
    lazygit
    nodejs
    unzip
    go
    rustc
    sqlite
    gcc
  ];

  # The magic link: point Home Manager to your mutable dotfiles repo
  home.file = {
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/nvim";
    # ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/kitty";
    ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/Users/alekseypanchenko/.dot-files/fish";
    # You can add tmux, stow, or any other directory similarly
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
