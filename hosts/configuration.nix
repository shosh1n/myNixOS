#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib ,pkgs, inputs, user, location, ... }:



{  
 programs.dconf.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  #imports = [
   #./cachix.nix
  #];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "jackaudio"];
    shell = pkgs.zsh;
  };

  systemd.services.nvidia-control-devices ={
    wantedBy = ["multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  ###Coming up Maestral
  #systemd.services.maestral-start ={
  #  wantedBy = ["multi-user.target"];
  #  serviceConfig.ExecStart = 
  #}
  services.emacs.enable = true;

  networking.hostName = "NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.utf8";
    LC_IDENTIFICATION = "en_US.utf8";
    LANGUAGE =  "en_US.utf8";
    LC_MEASUREMENT = "en_US.utf8";
    LC_MONETARY = "en_US.utf8";
    LC_NAME = "en_US.utf8";
    LC_NUMERIC = "en_US.utf8";
    LC_PAPER = "en_US.utf8";
    LC_TELEPHONE = "en_US.utf8";
    LC_TIME = "en_US.utf8";
    LC_ALL = "en_US.utf8";
  };
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc ];

  # Configure console keymap
  console = {
    font =  "Lat2-Terminus16";
    keyMap = "de";
  };
  
  fonts.fonts = with pkgs; [
   carlito
   dejavu_fonts
   ipafont
   kochi-substitute
   ttf_bitstream_vera
   source-code-pro
   jetbrains-mono
   noto-fonts
   noto-fonts-cjk
   noto-fonts-emoji
   liberation_ttf
   mplus-outline-fonts.githubRelease
   dina-font
   proggyfonts
   font-awesome
   cantarell-fonts
   corefonts
   fira-code
   fira-code-symbols
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif =[
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  
 sound = {
   enable = true;
   mediaKeys = {
     enable = true;
     };
 };
 security.rtkit.enable = true;
 services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  media-session.config.bluez-monitor.rules = [
    {
      # Matches all cards
      matches = [ { "device.name" = "~bluez_card.*"; } ];
      actions = {
        "update-props" = {
          "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
          # mSBC is not expected to work on all headset + adapter combinations.
          "bluez5.msbc-support" = true;
          # SBC-XQ is not expected to work on all headset + adapter combinations.
          "bluez5.sbc-xq-support" = true;
        };
      };
    }
    {
      matches = [
        # Matches all sources
        { "node.name" = "~bluez_input.*"; }
        # Matches all outputs
        { "node.name" = "~bluez_output.*"; }
      ];
      actions = {
        "node.pause-on-idle" = false;
      };
    }
  ];
};


  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;


hardware = {
  bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}; 
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  ##services.xserver.libinput.enable = true;
  #services.xserver.synaptics.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs;
    [
      (python39.withPackages(ps: with ps; [h5py chess seaborn scikit-learn numpy toolz jupyter opencv4 librosa matplotlib pandas scipy pytorch h5py tensorflow networkx gdown pandas glob2 tabulate pygments]))
      discord
    ];
    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
      interactiveShellInit = ''
        alias vim ='nvim'
      '';
    };
  };  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.lorri.enable = true;
  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedTCPPorts = [ 57621 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  nixpkgs.overlays = [

    (self: super: {
      sl = super.sl.overrideAttrs (old: {
        src = super.fetchFromGitHub {
	  owner = "mtoyoda";
	    repo = "sl";
	    rev = "923e7d7ebc5c1f009755bdeb789ac25658ccce03"; #pin commit
	    sha256 = "0000000000000000000000000000000000000000000000000000";
	};
      });
    })

    ##(self: super: {
    ##  discord = super.discord.overrideAttrs (
    ##    _: { 
    ##      src = builtins.fetchTarball {
    ##        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
    ##        sha256 = "1pw9q4290yn62xisbkc7a7ckb1sa5acp91plp2mfpg7gp7v60zvz";
    ##      }; }
    ##    );
    ##  })

   (self: super: {
     emacs = super.emacs.overrideAttrs (oldAttrs: {
     separateDebugInfo = true;
     });
    })
    

   #(self: super: {
   #  discord = super.discord.override { 
   #    withOpenASAR = true; 
   #  };
   # })



    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
      	vimAlias = true;
      };
    })
#    (self: super: {
#      picom = super.picom.overrideAttrs (old: {
#        src = super.fetchFromGitHub {
#          owner = "ibhagwan";
#          repo = "picom";
#          rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
#          sha256 = "0000000000000000000000000000000000000000000000000000";     
#        };
#      });
#    })
  ];

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
      '';

  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python3.9-mistune-0.8.4"
  ];
  system.stateVersion = "22.05"; # Did you read the comment? <- "No!"

 }
