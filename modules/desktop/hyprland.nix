  { options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.hyprland= {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      ly
      wayland
    ];


    wayland.windowManager.hyprland = {
          enable = true;
          xwayland = {
            enable = true;
            hidpi = true;
            nvidiaPatches = true;
          };
        };
      };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

};
}
