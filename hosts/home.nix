{ config, pkgs, lib, user, ... }:

{
  imports = 
    (import ../modules/editors) ++ 
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/shell);
    
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
   # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   # Terminal 
     wget
     git
     ranger
   # kitty
     wezterm
     zsh
     btop
     scrot
     zsh-syntax-highlighting
     xorg.xkill
     openconnect
     usbutils
     pciutils
     xclip
   # File Management
     gnome.file-roller
     unzip
     unrar
     rsync
     pcmanfm

   # texteditors
    #vim
    #neovim 
   
   # --yet unsorted
     emacs
     notepadqq
    #pcmanfm
     cinnamon.nemo
     line-awesome
   
   # Office
     libreoffice
     polybar

   # window managers related stuff
     xmobar
     picom
     dmenu
     conky
     dzen2
     trayer
     xscreensaver
     networkmanager_dmenu
     
   # organize
     rofi

   # Apps 
     firefox

   # work
     nice-dcv-client

     xorg.libX11
     openssl
     xorg.xrandr  #copy to config
   
   # social
     discord
   
   # Video/Audio
     feh
     mpv
     nitrogen
     vlc

    ];
   # file.".config/wall".source = ../modules/themes/wall;
    pointerCursor = {                         
      name = "numix-cursors-theme";
      package = pkgs.numix-cursor-theme;
      size = 16;
    };
    stateVersion = "22.05";  
  };
   programs.home-manager.enable = true;
  
  gtk = {
    enable = true;
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "zafiro-icons";
      package = pkgs.zafiro-icons;
    };
    font = {
      name = "FiraCode";
    };
  };


}
