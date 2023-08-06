  { options, inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;

in {
  imports = [ ./eww.nix inputs.hyprland.nixosModules.default];
  options.modules.desktop.hyprland= {
    enable = mkBoolOpt false;
   };

  config = mkIf cfg.enable (mkMerge[
    {
    programs.dconf.enable = true;
    programs.hyprland  = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
    environment.systemPackages = with pkgs;
      with inputs.hyprland-contrib.packages.${pkgs.system}; [
       #dunst
       libnotify
      (inputs.hyprland.packages."x86_64-linux".waybar-hyprland.override {
        wireplumberSupport = true;
        nlSupport = true;
      })
       wl-clipboard
       grimblast
       networkmanagerapplet
       cinnamon.nemo
       feh
       qt5ct

       wf-recorder
       wlsunset
       hyprpicker
       #hyprpaper
     ];
   user.packages = with pkgs; [
       ledger
       pavucontrol
       beancount
       my.swww
   ];

     # systemd.user.services."dunst" = {
     #   enable = true;
     #   description = "";
     #   wantedBy = ["default.target"];
     #   serviceConfig.Restart = "always";
     #   serviceConfig.RestartSec = 2;
     #   serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
     # };
   home-manager.users.shoshin ={
   services.mako = {
     enable = true;
     };
   };
    xdg.portal = {
      enable = true;
      wlr.enable = false;
       };


    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'Hyprland' --remember --asterisks --user-menu";
          user = "shoshin";
        };
      };
    };

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

   home.configFile = {
     "hypr" = {
       source = "${configDir}/hypr";
       recursive = true;
     };
   };
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = ["Iosevka Aile"];
          monospace = ["JetBrainsMonoNL"];
        };
      };
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        ubuntu_font_family
        fira
        jetbrains-mono
        (iosevka-bin.override { variant = "aile";})
        (nerdfonts.override {fonts = ["Iosevka"];})
        noto-fonts
        noto-fonts-cjk
        dejavu_fonts
        symbola
      ];
    };
  }
  # Nvidia
    (mkIf config.modules.hardware.nvidia.enable {
      programs.hyprland.nvidiaPatches = true;
      environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    })
  ]);
}
