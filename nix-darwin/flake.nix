{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."MacBook-Pro-Aleksey" = nix-darwin.lib.darwinSystem {
      modules = [ 
        ./configuration.nix 

        # Pull in the Home Manager nix-darwin module
        home-manager.darwinModules.home-manager 
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.alekseypanchenko = import ./home.nix;
          
          # Pass flake inputs into home.nix as well
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
