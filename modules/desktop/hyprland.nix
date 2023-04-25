  { options, inputs, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.hyprland;
    #defaultHyprlandPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    #enableXWayland = cfg.xwayland.enable;
    #hidpiXWayland = cfg.xwayland.hidpi;
    #inherit (cfg) nvidiaPatches;
    #};

in {
#  meta.maintainers = [lib.maintainers.fufexan];
  #disabledModules = ["programs/hyprland.nix"];
  #imports = [inputs.hyprland.homeManagerModules.default];

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

     #environment.systemPackages = with pkgs;  [nitrogen ];
 #   options.wayland.windowManager.hyprland.enable = true;
     # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
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
	 };
  };
}
