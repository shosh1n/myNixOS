#
# missing driver ACH
#

{config, lib, pkgs, nixos-hardware , ...}

{
  modules =[
    nixos-hardware.nixosModules.lenovo-legion-15ach6
  ]

}
