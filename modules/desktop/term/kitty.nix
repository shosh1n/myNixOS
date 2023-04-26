
{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.term.kitty;
in {
  options.modules.desktop.term.kitty = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    home-manager.users.shoshin = {
      programs = {
        kitty = {
          enable = true;
          #extraConfig = ''
          #  local wezterm = require 'wezterm'
          # return {
          #    font = wezterm.font 'JetBrains Mono',
          #    window_background_opacity = 0.7,
          # }
          # '';
        };
      };
    };
  };
}
