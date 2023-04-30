{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.swww;

in {
    options.modules.desktop.apps.swww = {
      enable = mkBoolOpt false;

      package = mkOption {
        type = types.package;
        default = pkgs.my.swww;
        defaultText = "swww";
        description = "0.7.2";
        };
      };
    config = mkIf cfg.enable {
      user.packages = [cfg.package];
      systemd.user.services.swww = {
        description = "swww-daemon.";
        partOf = ["hyperland-session.target"];
        after = ["hyperland-session.target"];
        wantedBy = ["hyprland-session.target"];
        serviceConfig  ={
        Type      = "simple";
        ExecStart = ''${pkgs.swww}/bin/swww-daemon'';
        ExecStop  = ''${pkgs.swww}/bin/swww kill'';
        Restart   = "on-failure";
      };
        };
    systemd.services.default_wall = {
        description = "default wallpaper";
        requires = ["swww.service"];
        after = ["swww.service"];
        partOf = ["swww.service"];
      wantedBy = ["swww.service"];
      serviceConfig = {
        ExecStart = ''${pkgs.swww}/bin/swww img "${../../themes/wallz/background.jpeg}""'';
        Restart = "on-failure";
        Type = "oneshot";
      };
    };
    };
}
