# modules/desktop/media/docs.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
     home-manager.users.shoshin.programs.zathura = {
      enable = true;
    };

     home.configFile = {
       "zathura" = {
         source = "${configDir}/zathura";
         recursive = true;
       };
     };

  };
}
