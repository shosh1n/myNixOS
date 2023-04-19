{ config, lib, ... }:

with builtins;
with lib;
let blocklist = fetchurl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts;
in {


  ## Location config -- since Toronto is my 127.0.0.1
  time.timeZone = mkDefault "Europe/Berlin";

 # i18n.extraLocaleSettings = mkDefault{
 #   LC_ADDRESS = "en_US.utf8";
 #   LC_IDENTIFICATION = "en_US.utf8";
 #   LANGUAGE = "en_US.utf8";
 #   LC_MEASUREMENT = "en_US.utf8";
 #   LC_MONETARY = "en_US.utf8";
 #   LC_NAME = "en_US.utf8";
 #   LC_NUMERIC = "en_US.utf8";
 #   LC_PAPER = "en_US.utf8";
 #   LC_TELEPHONE = "en_US.utf8";
 #   LC_TIME = "en_US.utf8";
 #   LC_ALL = "en_US.utf8";
 # };

  console = {
    font = "Lat2-Terminus16";
  #  keyMap = "de";
  };

  # For redshift, mainly
  location = (if config.time.timeZone == "America/Toronto" then {
    latitude = 43.70011;
    longitude = -79.4163;
  } else if config.time.timeZone == "Europe/Berlin" then {
    latitude = 55.88;
    longitude = 12.5;
  } else {});

  # So the vaultwarden CLI knows where to find my server.
  }
