  { options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.xmonad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {


    environment.systemPackages = with pkgs; [
      ly
      wayland
    ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      wayland = {
        enable = true;
        windowManager = {
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
