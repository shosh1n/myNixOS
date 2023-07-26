{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      #settings.KbdInteractiveAuthentication = false;
      #settings.passwordAuthentication = false;
    };

    user.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRaYHZU8LZcK8kJcOapATe2MeVLLDhedn1soZ3pWEgL hermannschris@googlemail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKFmXmnKqwP7SlR7epj8Y3xQQXTRrZZn+/N8uWBumpI hermannschris@googlemail.com"
   ];
  };
}
