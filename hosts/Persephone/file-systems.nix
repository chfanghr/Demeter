{
  config,
  lib,
  ...
}: {
  boot = {
    kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
    initrd.supportedFilesystems.zfs = true;
    supportedFilesystems.zfs = true;
    zfs.forceImportAll = true;
    plymouth.enable = false;
  };

  fileSystems = {
    "/" = {
      device = "rpool/root";
      fsType = "zfs";
    };
    "/var" = {
      device = "rpool/var";
      fsType = "zfs";
    };
    "/home" = {
      device = "rpool/home";
      fsType = "zfs";
    };
    "/nix" = {
      device = "tank/nix";
      fsType = "zfs";
      options = ["noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/96CB-AEF3";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/ebbdd45a-ff71-4e5c-a4aa-ac604feb813d";}
  ];

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
