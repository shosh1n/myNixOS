{ config, options, lib, pkgs, inputs ,... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.blender;
in {
  options.modules.desktop.media.blender = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      [ inputs.blender.packages.${system}.blender_3_5 ];
  };
}
