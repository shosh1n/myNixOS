{ config, pkgs, lib, user, ... }:

{
  imports = 
    (import ../modules/editors) ++ 
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/dev) ++
    (import ../modules/shell);
    
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
   # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   # Terminal
   #
   #Packages
   #Start decluttering and configuring this file
     wget
     git
     ranger
     kitty
     ripgrep
     lftp
     networkmanagerapplet
     eww
     #dropbox
     maestral
     fd
     wezterm
     tor
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
     emacsPackages.vterm
     libtool
     msmtp
     mu
     notmuch
     isync
     emacsPackages.mbsync
     libvterm
     cmake
     usbutils
     rtags
     qsampler
     qjackctl
     rPackages.phosphoricons
     cmake-language-server
     nix-zsh-completions
     languagetool
     emacsPackages.languagetool
     zsh-z
     emacsPackages.haskell-mode
     ccls
     llvm
     xclip
     llvmPackages_14.libcxx
   # file management
     gnome.file-roller
     unzip
     gnumake
     unrar
     procps
     util-linux
     m4
     gperf
     rsync
     djvu2pdf
     fira-code
     gcc
     cachix
     tor-browser-bundle-bin
     #clang_14
     cudatoolkit
     libGLU
     libGL
     xorg.libXi
     xorg.libXmu
     freeglut
     xorg.libXext
     xorg.libX11
     xorg.libXv
     xorg.libXrandr
     zlib
     freeglut
     ncurses5
     stdenv.cc
     autoconf
     gdb
    gitRepo
   # --yet unsorted
     emacs
     emacsPackages.reazon
     emacsPackages.dash
     emacsPackages.buttercup
     emacsPackages.s
     emacs28Packages.zmq
     flameshot
     notepadqq
     xdotool
     xorg.xprop
     jdk
     xorg.xwininfo
     nodejs
     udiskie
     cinnamon.nemo
     line-awesome
     yapf
     logseq
    #Office
     libreoffice
     clang-tools      
     fcitx5
   # window managers related stuff
     stack
     font-awesome
     material-design-icons
     xkb-switch
     ghc
     haskellPackages.X11-xft
     bear
     networkmanagerapplet
     xcape
     xorg.xkbcomp
     xorg.xmodmap
     pass
     offlineimap
     xmobar
     picom
     #taffybar
     dmenu
     conky
     dzen2
     trayer
     xscreensaver
     networkmanager_dmenu
     xorg.xmessage 
     #organize
     rofi
     libvirt
     auctex
     emacs28Packages.auctex
     vscode-fhs
     isync
     qemu_full
     tmatrix
     inkscape-with-extensions
     imagemagick
     reaper
     octave
     gimp
     #steam
     virtmanager
     evince
     pciutils
   # Apps 
     firefox
     emacsPackages.mastodon
   # work
     #gtk
     gnupg
     pavucontrol
     xorg.libX11
     emacsPackages.inheritenv
     openssl
     xorg.xrandr  #copy to config
     direnv
     teams 
     nix-direnv
     gtkwave
     blueman
   # social
     webcamoid
     openscad
     vimPlugins.yuck-vim
     emacsPackages.cuda-mode
     emacsPackages.yuck-mode
     emacsPackages.org-pdftools
   # Video/Audio
     linuxsampler
     feh
     mpv
     nitrogen
     lm_sensors
     vlc
     spotify
    ];
   # file.".config/wall".source = ../modules/themes/wall;
    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      name = "Dracula-cursors";
      #name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-cursors;
      size = 12;
    };
    stateVersion = "22.05";  
  };

  programs = {
    home-manager.enable = true;
  };

  
  gtk = {
    enable = true;
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    iconTheme = {
      name = "phosphoricons";
      package = pkgs.rPackages.phosphoricons;
    };
    font = {
      name = "FiraCode";
      size = 8;
    };
  };


}
