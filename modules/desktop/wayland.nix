  { options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.wayland;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.wayland = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      ly
      wayland
    ];


      wayland = {
        enable = true;
        windowManager.hyprland = {
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
