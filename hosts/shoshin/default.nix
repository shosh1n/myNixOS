#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{lib, pkgs, user,... }:



{
   imports =
      [(import ./hardware-configuration.nix)] ++
      #[(import ../../modules/programs/games.nix)] ++        # Gaming
      (import ../../modules/hardware);

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
 		
		#splashImage ="/boot/my-background.png";
     	

		};
	timeout = 5;
	      };
          };
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
  # Enable the X11 windowing system.
  services.xserver = {
  libinput.enable = true;
 
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout =  "de,jp";

    displayManager = {

      sessionCommands = ''
        #!/bin/sh
        SCREEN=$(${pkgs.xorg.xrandr}/bin/xrandr | grep " connected " | wc -l)
        if [[ $SCREEN -eq 1 ]]; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --scale 1.0x1.0  --primary --mode 1920x1080 --rotate normal --rate 120
        elif [[ $SCREEN -eq 2 ]]; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --scale 1.0x1.0 --primary --mode 1920x1080 --rotate normal --rate 120 --output HDMI-0 --mode 1680x1050 --rotate normal --rate 75 --right-of DP-4
        fi  
      '';

      lightdm = {
        enable = true;
	background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
        greeters = {
	  gtk = {
	    theme = {
	      name = "Juno";
	      package = pkgs.juno-theme;
	    };
	    cursorTheme =  {
              name = "numix-cursor-theme";
	      package = pkgs.numix-cursor-theme;
	      size = 16;
              };
            iconTheme = {
              name = "zafiro-icons";
              package = pkgs.zafiro-icons;
              };
            extraConfig = ''
                [greeter]
                  active-monitor = 0
                  '';  
            };
          };
	};
      };	
	#xkbVariant = "";
	windowManager = {
 	xmonad.enable = true;
	xmonad.enableContribAndExtras = true;
	xmonad.extraPackages = hpkgs: [
	  hpkgs.xmonad
	  hpkgs.xmonad-contrib
	  hpkgs.xmonad-extras
          #hpkgs.xmobar
          hpkgs.xmonad-dbus
          hpkgs.monad-logger
          #hpkgs.xmonad-spotify
          #hpkgs.xmonad-volume
	];
       };
       exportConfiguration = true;
     };	
 

	  
  # Enable CUPS to print documents.
  services.printing.enable = true;

 # Enable sound with pipewire.
 # sound.enable = true;
 # hardware.pulseaudio.enable = true;
 # security.rtkit.enable = true;
 # services.pipewire = {
 #   enable = true;
 #   alsa.enable = true;
 #   alsa.support32Bit = true;
 #   pulse.enable = true;
 # };
 }
