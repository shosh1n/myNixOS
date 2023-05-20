{ config, lib, pkgs, ... }:

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

  # look at https://functor.tokyo/blog/2018-10-01-japanese-on-nixos
  fonts.fonts =  with pkgs; [
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };



  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "de_DE.utf8";
      LC_MEASUREMENT = "de_DE.utf8";
      LC_MONETARY = "de_DE.utf8";
      LC_NAME = "de_DE.utf8";
      LC_NUMERIC = "de_DE.utf8";
      LC_PAPER = "de_DE.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "de_DE.utf8";
    };
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
	      fcitx5-configtool
	      fcitx5-gtk
      ];
    };
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
