#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{inputs,config, lib, pkgs, user,... }:



{
 #  imports =
  #    [(import ./hardware-configuration.nix)] ++
      #[(import ../../modules/programs/games.nix)] ++        # Gaming
   #   (import ../../modules/hardware);
  imports = [
    ../home.nix
    ./hardware-configuration.nix
    #./modules/vaultwarden.nix
    #./modules/metrics.nix
    #./modules/shlink.nix
    #./modules/cgit.nix
    #./modules/paperless.nix
  ];
   modules = {
     desktop =
     {
       awesomewm.enable = false;
       xmonad.enable = false;
       bspwm.enable = false;
       hyprland.enable = true;
       apps =
       {
	       rofi.enable = true;
	       discord.enable = true;
         swww.enable = true;
       };

       browsers =
       {
	       default = "firefox";
	       firefox.enable = true;
       };

       term =
       {
        default = "kitty";
        wezterm.enable = false;
        kitty.enable = true;
        st.enable = true;
       };
     
       gaming =
       {
	       steam.enable = true;
       };

       media =
       {
         daw.enable = true;
         graphics.enable = true;
         blender.enable = true;
         logseq.enable = true;
	       ncmpcpp.enable = true;
	       mpv.enable = true;
         spotify.enable = true;
         blog.enable = true;
         documents.enable = true;
       };
     };

     shell =
     {
       zsh.enable = true;

       gnupg.enable = true;
       git.enable = true;
       direnv.enable = true;
       pass.enable = true;
       #vaultwarden.enable = true;
      };

     dev =
     {
	     cc.enable = true;
	     rust.enable = true;
	     python.enable = true;
       python.conda.enable = true;
       node.enable =  true;
       go.enable = true;
     };

     editors =
     {
	     default = "nvim";
       code.enable = true;
	     vim.enable = true;
	     emacs.enable = true;
	   };

     services =
     {
       ssh.enable = true;
       paperless.enable = false;
       #cgit.enable = false;
       #gpg-agent.enable = false;
       docker.enable = true;
       nginx.enable = true;
       fail2ban.enable = false;
     };
     hardware =
       {
         audio.enable = true;
         bluetooth.enable = true;
       };

	   #theme.active = "alucard";
   };




  networking.firewall = {
    allowedTCPPorts = [ 17500 1714 1715 ];
    allowedUDPPorts = [ 17500 1715 1715 ];
  };

  systemd.user.services.maestral = {
    description = "maestral";
    wantedBy = [ "graphical-session.target" ];
 
  environment = {
    QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
    QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
  };

   serviceConfig = {
      ExecStart = "${pkgs.maestral.out}/bin/maestral";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
    };



 # services.nginx = {
 #   # Make it easier to whitelist by country on some virtualhosts


 #   # nginx hosts
 #   virtualHosts."home.cherma.org" = {
 #     default = true;
 #     http2 = true;
 #     forceSSL = true;
 #     enableACME = true;
 #     root = "/srv/www/home.cherma.org";
 #     # extraConfig = ''
 #     #   client_max_body_size 10m;
 #     #   proxy_buffering off;
 #     #   proxy_redirect off;
 #     # '';
 #     # locations."/".proxyPass = "http://kiiro:8000";
 #   };
 # };
  user.packages = with pkgs; [
    #my.houdini
  ];


      # ...
  #user.packages = with nixpkgs  ;[ inputs.nixos-hardware.nixosModules.lenovo-legion-15ach6];
  programs.ssh.startAgent = true;
  networking.networkmanager.enable = true;
  #security.acme.defaults.email = "hermannschris@googlemail.com";
  # Bootloader.
  boot =
  {
	  kernelPackages = pkgs.linuxPackages_latest;

    loader =
    {
      systemd-boot.enable = false;
        
	    efi =
      {
		    canTouchEfiVariables = true;
		    efiSysMountPoint = "/boot/efi";
		  };

	    grub =
      {
		    enable = true;
		    devices = ["nodev"];
		    efiSupport = true;
		    useOSProber = true;
		    configurationLimit = 5;
		  };

      timeout = 5;
	  };
  };
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager maestral ];
}
