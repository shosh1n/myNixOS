{ config, options, lib, pkgs ,... }:
#this file is a mess, It needs to be split up in terms of functionalities!
with lib;
with lib.my;
let cfg = config.modules.desktop.apps;
    wallDir = config.dotfiles.wallDir;
in {
  config = mkIf config.programs.hyprland.enable {
    modules.desktop.apps.swww.enable = true;
    #systemd.user.services.swww = {
    #  Service = {
    #    ExecStart = ''${pkgs.swww}/bin/swww img "${../../wallz/background.png}" --transition-type random'';
    #    Restart = "on-failure";
    #    Type = "oneshot";
    #  };
    #};
  };
}
