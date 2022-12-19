{
  description = "A very basic flake";
 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    pypi-deps-db = {
      url = "github:DavHau/mach-nix/3.3.0";
    };

    mach-nix = {
      url = "github:DavHau/mach-nix/3.5.0";
    };

    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {                                                    
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixgl, flake-utils, mach-nix, nixos-hardware, ...} :
    let
      #l = nixpkgs.lib // builtins;
      supportedSystems = ["x86_64-linux" "aarch64-darwin"];
      user = "shoshin";
      location = "$Home/.setup";
      trustedUsers = ["root" "shoshin"];
      nixosConfigurations.user = nixpkgs.lib.nixosSystem { modules = [nixos-hardware.nixosModules.lenovo-legion-15ach6]; };
      mach-nix = import (builtins.fetchGit {
        url = "https://github.com/DavHau/mach-nix";
        ref = "refs/tags/3.5.0";  # update this version
      }) {
        python = "python37";
      };



     #forAllSystems = f: l.genAttrs supportedSystems
       #(system: f system (import nixpkgs {inherit system;}));

      machNix = mach-nix.mkPython rec {
        requirements = builtins.readFile ./requirements.txt;
        };


      jupyter = import (builtins.fetchGit {
        url = https://github.com/tweag/jupyterWith;
        ref = "master";
        #rev = "some_revision";
      }) {};

      iPython = jupyter.kernels.iPythonWith {
      name = "mach-nix-jupyter";
      python3 = machNix.python;
      packages = machNix.python.pkgs.selectPkgs;
     };

     jupyterEnvironment = jupyter.jupyterlabWith {
     kernels = [ iPython ];
     };



  in 
  {
   # defaultPackage = forAllSystems (system: pkgs: mach-nix.lib."${system}".mkPython {
   #   requirements = ''
   #     pillow
   #     numpy
   #     requests
   #     '';
   #   });
 
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
