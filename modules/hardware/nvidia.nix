{ options, config, lib, pkgs,inputs, ...}:

with lib;
with lib.my;
let cfg = config.modules.hardware.nvidia;

in {
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
    };

  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    hardware.nvidia = {
      modesetting.enable = true;
      prime.offload.enable = false;
      prime.nvidiaBusId = "PCI:1:0:0";
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = with pkgs; [
      nvtop-nvidia
      libva
      libva-utils
      glxinfo
      (writeScriptBin "nvidia-settings" ''
        #!${stdenv.shell}
	mkdir -p "$XDG_CONFIG_HOME/nvidia"
	exec ${config.boot.kernelPackages.nvidia_x11.settings}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
      '')
      ];
   };
}
