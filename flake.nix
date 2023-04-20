{
  description = "A very basic flake";
 
  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    
    flake-utils.url = "github:numtide/flake-utils";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = github:nix-community/home-manager/;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {                                                    
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";



  #End of Inputs
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, nixgl, flake-utils, nixpkgs-unstable, ...} :
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;

      system = "x86_64-linux";
    
      #pkgs is a set
      mkPkgs = pkgs: extraOverlays: import pkgs{
        inherit system;
        config.allowUnfree = true;
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
      };

      pkgs = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [];

      lib = nixpkgs.lib.extend 
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });


      #user = "shoshin";
      #location = "$Home/.setup";
      #trustedUsers = ["root" "shoshin"];
      #nixosConfigurations.user = nixpkgs.lib.nixosSystem { modules = [nixos-hardware.nixosModules.lenovo-legion-15ach6]; };    
  in 
  {
    lib = lib.my;
  
    overlay = 
    final: prev: {
      unstable = pkgs';
      my = self.packages."${system}";
    };

    overlays =
      mapModules ./overlays import;

    packages."${system}" = 
      mapModules ./packages (p: pkgs.callPackage p{});

    nixosModules = 
      { dotfiles = import ./.; } // mapModulesRec ./modules import;

    nixosConfigurations = 
       mapHosts ./hosts {
         
         #inherit (nixpkgs) lib;
         #inherit inputs nixpkgs user home-manager location;
	};


        
      devShell."${system}" =
        import ./shell.nix { inherit pkgs; };

      templates = {
        full = {
          path = ./.;
          description = "A grossly incandescent nixos config";
        };
      } // import ./templates;
      defaultTemplate = self.templates.full;

      defaultApp."${system}" = {
        type = "app";
        program = ./bin/hey;
      };
      
    };
}	   

