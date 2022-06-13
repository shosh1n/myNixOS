#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib ,pkgs, inputs, user, location, ... }:



{  
 programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  

  networking.hostName = "NixOS"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_De.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LANGUAGE =  "en_US.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
    LC_ALL = "de_DE.utf8";
  };


  # Configure console keymap
  console = {
    font =  "Lat2-Terminus16";
    keyMap = "de";
  };
  
  fonts.fonts = with pkgs; [
   source-code-pro
   font-awesome
   corefonts
   (nerdfonts.override {
     fonts = [
	"FiraCode"
     ];
   })
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
	support32Bit = true;
      };
      pulse.enable = true;
     };
     #flatpak.enable = false;
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    variables = {
      TERMINAL = "wezterm";
      EDITOR = "nvim";
      VISUAL = "nvim";
      interactiveShellInit = ''
        alias vim ='neovide'
      '';
    };
  };  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nixpkgs.overlays = [
    (self: super: {
      sl = super.sl.overrideAttrs (old: {
        src = super.fetchFromGitHub {
	  owner = "mtoyoda";
	    repo = "sl";
	    rev = "923e7d7ebc5c1f009755bdeb789ac25658ccce03"; #pin commit
	    sha256 = "0000000000000000000000000000000000000000000000000000";
	};
      });
    })
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { 
          src = builtins.fetchTarball {
	    url = "https://discord.com/api/download?platform=linux&format=tar.gz";
	    sha256 = "0hdgif8jpp5pz2c8lxas88ix7mywghdf9c9fn95n0dwf8g1c1xbb";
          }; }
	);
      })
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
      	vimAlias = true;
      };
    })
  ];

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
      '';

  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.05"; # Did you read the comment? <- "No!"

 }
