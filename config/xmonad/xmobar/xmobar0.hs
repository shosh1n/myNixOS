Config { font = "xft:Roboto:size=12:bold"
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
       , textOffset = 1
       , textOffsets = [ 2, 1 ]
       , lowerOnStart = True
       , allDesktops = True
       , persistent = False
       , hideOnStart = False
       , iconRoot = "/home/shoshin/.config/xmonad/xmobar/icons/"
       , commands =
         [ Run UnsafeXPropertyLog "_XMONAD_LOG_0"
         , Run Date "%a, %d %b   <fn=1>-</fn>   %H:%M:%S" "date" 10
         , Run Memory ["-t","Mem: <fc=#AAC0F0><usedratio></fc>%"] 10
         , Run Cpu ["-t", "cpu:  <fc=#AAC0F0><total>%</fc>"] 10
	 , Run Com "nvidia-settings" ["-t", "-q", "[gpu:0]/GPUCoreTemp"] "gpu" 10
         , Run Network "enp3s0" ["-S", "True", "-t", "eth: <fc=#4eb4fa><rx></fc>/<fc=#4eb4fa><tx></fc>"] 10
	 , Run Battery [
	"-t", "<acstatus>: <left>% - <timeleft>",
	"--",
	--"-c", "charge_full",
	"-O", "AC",
	"-o", "Bat",
	"-h", "green",
	"-l", "red"
	] 10
         ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "\
            \    \
            \%_XMONAD_LOG_0%\
            \}\
            \<action=xdotool key super+r>%date%</action>\
            \{\
            \<action=xdotool key super+y>\
	    \      \
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
            \|\
            \     \
            \%enp3s0%\
            \       \
            \</action>\
            \%battery%"
       }
