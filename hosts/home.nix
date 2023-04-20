{ config, lib, ... }:

with lib;
  {
    networking.hosts = let
      hostConfig =
      {
        "192.168.1.216" = [ "shoshin" ];
      };
      hosts = flatten (attrValues hostConfig);
      hostName = config.networking.hostName;
    in mkIf (builtins.elem hostName hosts) hostConfig;



  time.timeZone = mkDefault "Europe/Berlin";


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
