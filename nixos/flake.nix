{
  description = "PC Nix";

  inputs = {
    # The source for your stable system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 

    # The source for unstable packages (like Neovim)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    # Replace 'my-machine' with the output of the command: hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # This line is key: it passes 'inputs' to configuration.nix 
      # so you can use 'inputs.nixpkgs-unstable' there.
      specialArgs = { inherit inputs; }; 

      modules = [
        ./configuration.nix
        # If your hardware file is named differently, update this
        ./hardware-configuration.nix 
      ];
    };
  };
}
