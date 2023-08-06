{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
  #sound.enable = true;
    services.pipewire = {
      enable = true;
   #   audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.etc = {
      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
          default.clock.rate = 48000
          default.clock.quantum = 32
          default.clock.min-quantum = 32
          default.clock.max-quantum = 32
       }
      '';
    };
    security.rtkit.enable = true;


    # HACK Prevents ~/.esd_auth files by disabling the esound protocol module
    #      for pulseaudio, which I likely don't need. Is there a better way?
    hardware.pulseaudio.configFile =
      let inherit (pkgs) runCommand pulseaudio;
          paConfigFile =
            runCommand "disablePulseaudioEsoundModule"
              { buildInputs = [ pulseaudio ]; } ''
                mkdir "$out"
                cp ${pulseaudio}/etc/pulse/default.pa "$out/default.pa"
                sed -i -e 's|load-module module-esound-protocol-unix|# ...|' "$out/default.pa"
              '';
      in mkIf config.hardware.pulseaudio.enable
        "${paConfigFile}/default.pa";

   user.extraGroups = [ "audio" ];

    systemd.user.services.easyeffects = {
      enable = true;
      description = "";
      wantedBy = ["default.target"];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
    };
  };
}
