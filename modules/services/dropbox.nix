{ config, lib, pkgs, ... }:

with lib;
{
  options ={
    dropbox = {
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
}
