  { options, inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;

in {
  imports = [inputs.hyprland.nixosModules.default];
  options.modules.desktop.hyprland= {
    enable = mkBoolOpt false;
   };

  config = mkIf cfg.enable (mkMerge[
    {
    programs.hyprland  = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
    environment.systemPackages = with pkgs;
      with inputs.hyprland-contrib.packages.${pkgs.system}; [
       dunst
       libnotify
      (inputs.hyprland.packages."x86_64-linux".waybar-hyprland.override {
        wireplumberSupport = true;
        nlSupport = true;
      })
       wl-clipboard
       grimblast
       wf-recorder
       wlsunset
       scratchpad
       wofi
       hyprpicker
     ];

      systemd.user.services."dunst" = {
        enable = true;
        description = "";
        wantedBy = ["default.target"];
        serviceConfig.Restart = "always";
        serviceConfig.RestartSec = 2;
        serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
      };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'Hyprland' --remember --asteriks --user-menu";
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
  }
  # Nvidia
    (mkIf config.modules.hardware.nvidia.enable {
      programs.hyprland.nvidiaPatches = true;
      environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    })
  ]);
}
