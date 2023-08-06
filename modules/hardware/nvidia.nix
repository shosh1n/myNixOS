{ options, config, lib, pkgs,inputs, ...}:

with lib;
with lib.my;
let cfg = config.modules.hardware.nvidia;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta;
  nvidiaPkg =
    if (lib.versionOlder nvBeta.version nvStable.version)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

in {
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
    };

  config = mkIf cfg.enable {
    hardware.opengl = {
    };

    hardware.nvidia = {
      modesetting.enable = true;
   #   prime.offload.enable = false;
   #   prime.nvidiaBusId = "PCI:1:0:0";
   #   prime.amdgpuBusId = "PCI:5:0:0";
    };

    hardware.nvidia.package = nvidiaPkg;
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = with pkgs; [
    nvtop-nvidia
    nvidia-vaapi-driver
    libva
    libva-utils
    #glxinfo
      (writeScriptBin "nvidia-settings" ''
        #!${stdenv.shell}
	      mkdir -p "$XDG_CONFIG_HOME/nvidia"
        exec ${config.boot.kernelPackages.nvidia_x11.settings}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
      '')
      ];
   };
}
