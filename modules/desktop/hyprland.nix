  { options,inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.hyprland= {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users.shoshin = {
      programgs.hyprland.enable = true;
      systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
     ## wayland.windowManager.hyprland = {
     ##   systemdIntegration = true;
     ##   extraConfig =''
     ##   $mainMod = mod4Mask
     ##   monitor=DP-0, 1920x1080@120,0x0,1
     ##   monitor=HMDI-0, 1680x1050@60,1920x0,0.857

     ##   input {
     ##     kb_layout = de
     ##     kb_variant =
     ##     kb_model =
     ##     kb_options =
     ##     kb_rules =
     ##   }

     ##   bind = $mainMod, Return, exec, xst zsh
     ##   '';
     ## };
    };
  };
}
