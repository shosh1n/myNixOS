{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop;
in {
  config = mkIf config.programs.hyprland.enable {

    user.packages = with pkgs; [
      feh       # image viewer
      xclip
      xdotool
      xorg.xwininfo
      libqalculate  # calculator cli w/ currency conversion
      (makeDesktopItem {
        name = "scratch-calc";
        desktopName = "Calculator";
        icon = "calc";
        exec = ''scratch "${tmux}/bin/tmux new-session -s calc -n calc qalc"'';
        categories = [ "Development" ];
      })
      qgnomeplatform        # QPlatformTheme for a better Qt application inclusion in GNOME
      libsForQt5.qtstyleplugin-kvantum # SVG-based Qt5 theme engine plus a config tool and extra theme
    ];

   
  };
}
