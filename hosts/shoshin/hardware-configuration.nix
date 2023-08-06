# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, inputs ,... }:
let
  inherit (config.boot) kernelPackages;
in
{
  imports = [
    #deactivated due to fix-brightness error
    inputs.nixos-hardware.nixosModules.lenovo-legion-15ach6
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];


  modules.hardware = {
    nvidia.enable = true;
    audio.enable = true;
    wacom.enable = false;
    sensors.enable = false;
    bluetooth.enable = true;
    razer.enable = false;
    };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d0a53e3a-bdb4-43ca-bf06-4cb5cc90646b";
      fsType = "ext4";
    };

  fileSystems."/home/shoshin/space" =
    { device = "/dev/disk/by-uuid/a50eeb5f-95f5-449d-8731-8c2c9e15b0d7";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/BD1E-1C7E";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1dc1f689-7b4f-47b4-aa16-3922ff722258"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  #networking.useDHCP = lib.mkDefault true;
  #networking.networkmanager.enable = true;
  #networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  #networking.wireless.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

#  systemd.services.fix-brightness = {
#    before = [
#      "systemd-backlight@backlight:${
#        if lib.versionOlder kernelPackages.kernel.version "5.18" then "amdgpu_bl0" else "nvidia_wmi_ec_backlight"
#      }.service"
#    ];
#    description = "Convert 16-bit brightness values to 8-bit before systemd-backlight applies it";
#    script = ''
#      BRIGHTNESS_FILE="/var/lib/systemd/backlight/${
#        if lib.versionOlder kernelPackages.kernel.version "5.18" then
#          "pci-0000:05:00.0:backlight:amdgpu_bl0"
#        else
#          "platform-PNP0C14:00:backlight:nvidia_wmi_ec_backlight"
#      }"
#      BRIGHTNESS=$(cat "$BRIGHTNESS_FILE")
#      BRIGHTNESS=$(($BRIGHTNESS*255/65535))
#      BRIGHTNESS=''${BRIGHTNESS/.*} # truncating to int, just in case
#      echo $BRIGHTNESS > "$BRIGHTNESS_FILE"
#    '';
#    serviceConfig.Type = "oneshot";
#  };
	hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
