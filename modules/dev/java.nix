{ config, lib, pkgs, ... }:

with lib;

let
  cfg =  config.programs.java;
in

{

  options ={

    programs.java = {
      enable = mkEnableOption "" //{
        description = ''
        Install the JDK and set the <envar>JAVA_HOME</envar> Variable
        '';
      };

      package = mkOption {
        type = types.package;
        default = pkgs.jdk;
        defaultText = "pkgs.jdk";
        description = '' Java package to install. Typical values
        are <literal>pkgs.jdk</literal> or <pkgs.jre</literal>//Great, 'ol! ;)
        '';
      };

    };

  };

  config = mkIf cfg.enable {
    home.packages = [ cgf.package ];

    home.sessionVariables.JAVA_HOME = cfg.package.home;
  };

}
