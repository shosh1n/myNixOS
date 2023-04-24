{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop;
in {
  options.modules.desktop = {
    default = mkOpt types.str "hyprland";
  };

  config = mkIf (cfg.default != null ){

      };
}
