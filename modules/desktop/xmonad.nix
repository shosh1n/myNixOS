{ options, config, lib, pkgs, bla ,... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.xmonad;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.xmonad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
 
    
    environment.systemPackages = with pkgs; [
      lightdm
      xmobar
    ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        enable = true;
          libinput = {
            enable = true;
          };
          layout = "de";

        displayManager = {
          defaultSession = "none+xmonad";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };


  windowManager.xmonad.enable = true;
	windowManager.xmonad.enableContribAndExtras = true;
	windowManager.xmonad.extraPackages = hp: [
	hp.xmonad-contrib
	hp.xmonad-extras
	hp.xmonad
	hp.xmobar
	hp.dbus
	hp.monad-logger
	];
    };
    };
   
    
    # link recursively so other modules can link files in their folders
      home.configFile = {
      "xmonad" = {
        source = "${configDir}/xmonad";
        recursive = true;
      };
      };
};
}
