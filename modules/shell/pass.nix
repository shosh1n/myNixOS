
{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.shell.pass = {
    enable = true;
  };

  config = mkIf config.modules.shell.pass.enable {
    my = {
      packages = with pkgs;
        [ (pass.withExtensions (exts: [ exts.pass-otp exts.pass-genphrase ])) ];
      env.PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };
}
