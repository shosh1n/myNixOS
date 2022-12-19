#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user,... }:


{
  imports =
    [ # Include the results of the hardware scan.
      [(import ./hardware-configuration.nix)] ++
      [(import ../../modules/programs/games.nix)] ++        # Gaming
      [(import ../../modules/services/media.nix)] ++        # Media Center
      (import ../../modules/hardware);
    ];


  # Bootloader.
  boot ={
	kernelPackages = pkgs.linuxPackages_latest;

  loader = {

	systemd-boot.enable = false;
        
	efi = {
		canTouchEfiVariables = true;
		efiSysMountPoint = "/boot/efi";
		};

	grub = {
		enable = true;
		devices = ["nodev"];
		efiSupport = true;
		useOSProber = true;
		configurationLimit = 5;
 		
		splashImage ="/boot/my-background.png";
     	

		};
	timeout = 5;
	      };
          };

  environment = {
    systemPackages = with pkgs; [
      simple-scan
      ];
    };

  # Enable the X11 windowing system.
  services.xserver = {
	enable = true;
	videoDrivers = [ "nvidia" ];
	layout =  "de";
	displayManager.lightdm.enable = true;
	xkbVariant = "";
	windowManager = {
 	xmonad.enable = true;
	xmonad.enableContribAndExtras = true;
	xmonad.extraPackages = hpkgs: [
	  hpkgs.xmonad
	  hpkgs.xmonad-contrib
	  hpkgs.xmonad-extras
	];
       };
       exportConfiguration = true;
     };	

      displayManager.sessionCommands = ''
        #!/bin/sh
        SCREEN=$(${pkgs.xorg.xrandr}/bin/xrandr | grep " connected " | wc -l)
        if [[ $SCREEN -eq 1 ]]; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --primary --mode 1920x1080 --rotate normal --rate 120
        elif [[ $SCREEN -eq 2 ]]; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --primary --mode 1920x1080 --rotate normal --rate120 --output HDMI-0 --mode 1280x1024 --rotate normal --rate 60 --right-of DP-4
         fi
      '';  
 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
 }
