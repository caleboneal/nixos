{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cc6fbcf3-c86c-4b08-ae4d-cdc8c14b3250";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8B13-9E1E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ { device = "/dev/disk/by-uuid/3d5a7597-a023-47d3-96d0-ea77fd56392b"; }];
  boot.resumeDevice = "/dev/disk/by-uuid/3d5a7597-a023-47d3-96d0-ea77fd56392b";
  powerManagement.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager = {
    enable = true;
    wifi = {
      macAddress = "preserve";
      scanRandMacAddress = false;
    };
  };

  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  fonts.packages = [ pkgs.dejavu_fonts ];

  users.users."caleb" = {
    isNormalUser = true;
    description = "Caleb O'Neal";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "26.05";
}
