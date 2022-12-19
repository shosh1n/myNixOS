{ config, lib, pkgs, ... }:

{
programs = {
    xmobar = {
      enable = true;
      dotDir = ".config/xmonad/xmobar";

    };
    extraConfig = ''
        Config
          {  font = "xft:Roboto:size=12:bold"
       , additionalFonts =
          [ "xft:FontAwesome 6 Free Solid:pixelsize=14"
          , "xft:FontAwesome:pixelsize=10:bold"
          , "xft:FontAwesome 6 Free Solid:pixelsize=16"
          , "xft:Hack Nerd Font Mono:pixelsize=21"
          , "xft:Hack Nerd Font Mono:pixelsize=25"
          ]
       , border = NoBorder
       , bgColor = "#2B2E37"
       , fgColor = "#929AAD"
       , alpha = 255
       , position = TopSize L 100 40
       , textOffset = 24
       , textOffsets = [ 25, 24 ]
       , lowerOnStart = True
       , allDesktops = True
       , persistent = False
       , hideOnStart = False
       , iconRoot = "/home/shoshin/.config/xmonad/xmobar/icons/"
       , commands =
         [ Run UnsafeXPropertyLog "_XMONAD_LOG_0"
         , Run Date "%a, %d %b   <fn=1></fn>   %H:%M:%S" "date" 10
         , Run Memory ["-t","Mem: <fc=#AAC0F0><usedratio></fc>%"] 10
         , Run Cpu ["-t", "cpu: <fc=#AAC0F0"><usedbar> <usedratio>%</fc>"] 10
         , Run Gpu ["-t", "gpu: <fc=#AAC0F0"><usedbar> <usedratio>%</fc>"] 10
         , Run Network "enp3s0" ["-S", "True", "-t", "eth: <fc=#AAC0F0><rx></fc>/<fc=#AAC0F0><tx></fc>"] 10
         , Run Com ""  "volume" 10
         , Run Com "" "bluetooth" 10
         , Run Com "" "network" 10
         , Run Com ""  "trayerpad" 10
         ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "\
            \    \
            \%_XMONAD_LOG_0%\
            \}\
            \<acti%date%</action>\
            \{\
            \<action=setsid -f $TERMINAL -e ~/Scripts/pop_upgrade.sh>%updates%</action>\
            \<action=xdotool key super+y>\
            \     \
            \%memory%\
            \     \
            \|\
            \     \
            \%cpu%\
            \     \
            \|\
            \     \
            \%gpu%\
            \       \
            \</action>\
            \%trayerpad%"}
    '';



};
}
