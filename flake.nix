{
  description = "A very basic flake";
 
  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = 
    {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {                                                    
   home-manager    url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, nixgl, flake-utils, ...} :
    let

      supportedSystems = "x86_64-linux";
      user = "shoshin";
      location = "$Home/.setup";
      trustedUsers = ["root" "shoshin"];
      nixosConfigurations.user = nixpkgs.lib.nixosSystem { modules = [nixos-hardware.nixosModules.lenovo-legion-15ach6]; };
     

  in 
  {
    nixosConfigurations = (
       import ./hosts {
         
         inherit (nixpkgs) lib;
         inherit inputs nixpkgs user home-manager location;
	}
      );
    };
}	   

