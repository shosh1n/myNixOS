{
  description = "A very basic flake";
 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };


    nixgl = {                                                    
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixgl, ...}:
    let
      #system =  "x86_64-linux";
      user = "shoshin";
      location = "$Home/.setup";


  in 
   {
     nixosConfigurations = (
       import ./hosts {
         inherit (nixpkgs) lib;
         inherit inputs nixpkgs user home-manager location;

	}
      );

    #  homeConfigurations = (
    #    import ./nix {
    #	  inherit (nixpkgs) lib;
    #	  inherit nixpkgs home-manager nixgl user;
    #	  }
    #	);  
    };
    



}	   

	    # shoshin = lib.nixosSystem {
	    # inherit system;
	    # modules = [ 
	    #   ./configuration.nix 
	    #   home-manager.nixosModules.home-manager {
	    #     home-manager.useGlobalPkgs = true;
	    #     home-manager.useUserPackages = true;
	    #     home-manager.users.shoshin = {
	    #	   imports = [ ./home.nix ];
	    #	  };
	    #	}
	    #    ];
	    # };
            # };	
	
       # hmConfig = { 
       #  shoshin = home-manager.lib.homeManagerConfiguration {
       #    inherit system pkgs;
       #    username = "shoshin";
       #    homeDirectory = "/home/shoshin";
       #    stateVersion = "22.05";
       #    configuration = {
       #      imports = [
       #	./home.nix
       #      ];
       #    };
       #   };
       # };
       # };
       #  }
