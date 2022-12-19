{ config, pkgs, ... }:

{
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;
}
 #smartcard-reader
 #services.pcscd.enable = true;



