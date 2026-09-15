{
  description = "NAS Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Uncomment if you later need unstable packages (e.g. latest Neovim):
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Change 'nas' to this machine's hostname if you rename it.
    nixosConfigurations.nas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass 'inputs' through so configuration.nix can use 'inputs.*'.
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        ./modules/ugos-protection.nix
        ./modules/fan-control.nix
      ];
    };
  };
}
