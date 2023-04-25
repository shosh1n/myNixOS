{ lib, ... }:

let
  inherit (lib) mkOption types; #calls 'mkOption' and 'types' from the functions defined in (lib)
in
rec {
  mkOpt  = type: default:
    mkOption { inherit type default; };

  mkOpt' = type: default: description:
    mkOption { inherit type default description; };

  mkBoolOpt = default: mkOption {
    inherit default;
    type = types.bool;
    example = true;
  };
}
