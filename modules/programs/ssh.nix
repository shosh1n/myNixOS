#
# ssh-config-file
#


{config, pkgs, lib, ... }:

{
  options ={
    programs = {
      ssh = {
        forwardX11 = true;

      

      };
    };




  };
}
