{
  description = "NAS Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Uncomment if you later need unstable packages (e.g. latest Neovim):
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, ... }@inputs: {
    # Change 'nas' to this machine's hostname if you rename it.
    nixosConfigurations.nas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass 'inputs' through so configuration.nix can use 'inputs.*'.
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        ./apps/nextcloud.nix
        ./apps/immich.nix
        ./apps/navidrome.nix
        ./modules/ugos-protection.nix
        ./modules/fan-control.nix
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nas = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
