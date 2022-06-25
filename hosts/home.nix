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
     kitty
     wezterm
     zsh
     fzf
     tree
     texlive.combined.scheme-full
     autojump
     zsh-powerlevel10k
     btop
     scrot
     zsh-syntax-highlighting
     xorg.xkill
     openconnect
     usbutils
     pciutils
     zsh-completions
     nix-zsh-completions
     zsh-z
     xclip
   # file management
     gnome.file-roller
     unzip
     unrar
     rsync
     djvu2pdf

   # development
     gcc
   # texteditors
    #vim
    #neovim 
   
   # --yet unsorted
     emacs
     notepadqq
     udiskie
     cinnamon.nemo
     line-awesome
   
   # Office
     libreoffice
     #polybar

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
   # virtual machines
     libvirt 
     qemu_full
     virtmanager
   # Apps 
     firefox
     whatsapp-for-linux
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
     spotify
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
      size = 8;
    };
  };


}
