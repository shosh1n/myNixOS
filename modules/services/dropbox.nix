{ config, lib, pkgs, ... }:

let cfg = config.services.dropbox;
  in
with lib;
{
  options ={
    services.dropbox = {
      enable = mkOption{
        default = false;
        type = with types; bool;
        description ="Dropbox daemon ⁰^°";
      };

      user = mkOption{
        default = config.user.name;
        description = "use . user";
      };

    };
  };

  config = mkIf cfg.enable{
    systemd.services.dropbox = {
      description = "A Dropbox";
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
        ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
        KillMode =  "control-group"; #upstream recommends
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };
  };

}
