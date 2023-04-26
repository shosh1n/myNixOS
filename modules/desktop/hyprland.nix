  { options, inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.hyprland= {
    enable = mkBoolOpt false;
   };

  config = mkIf cfg.enable {
    #systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    #nixpkgs.overlays = [inputs.hyprland.overlay];

    programs.hyprland = {
      enable = true;
      #package = hyprland.packages.${pkgs.system}.default;
      xwayland = {
        enable = true;
        hidpi = true;
    };
    nvidiaPatches = true;
    };
   services.redshift = {
        enable = true;
        temperature.night = 3400;
      };
   home.configFile = {
     "hyprland.conf".source = "${configDir}/hyprland";
   };

  };
}
