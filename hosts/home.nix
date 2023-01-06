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
     ripgrep
     lftp
     eww
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
     usbutils
     rtags
     rPackages.phosphoricons
     cmake-language-server
     nix-zsh-completions
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
   # development
     gdb
   # texteditors
    #vim
    gitRepo
    #neovim 
    #binutils
   # --yet unsorted
     emacs
     emacs28Packages.zmq
     flameshot
     notepadqq
     nodejs
     udiskie
     cinnamon.nemo
     line-awesome
   # DEV
    # clang
     yapf
     #conda
     #pylint
    #Office
     libreoffice
     clang-tools     

   # window managers related stuff
     stack
     font-awesome
     material-design-icons
     #xfce.orage
     
     #haskellPackages.brittany # code format
     #cabal2nix
     #cabal-install
     ghc
     #haskell-language-server
     #haskellPackages.hoogle
     #nix-tree
     haskellPackages.X11-xft   
     bear
     networkmanager_dmenu
     networkmanagerapplet
     xcape
     xorg.xkbcomp
     xorg.xmodmap

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
     #virtual machines
     libvirt 
     vscode-fhs
     isync
     qemu_full
     tmatrix
     #steam
     virtmanager
     pciutils
   # Apps 
     firefox
   #  whatsapp-for-linux
   # work
    # nice-dcv-client
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
     blueman
   # social
     #discord-ptb
     webcamoid
     vimPlugins.yuck-vim
     emacsPackages.cuda-mode
     emacsPackages.yuck-mode
     emacsPackages.org-pdftools
   # Video/Audio
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
