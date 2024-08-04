{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./file-systems.nix
    ./networking.nix
    ../../modules/nixos/common
  ];

  dotfiles = {
    shared.props = {
      networking.home = {
        onLanNetwork = true;
      };
    };
    nixos.props = {
      hardware = {
        cpu.amd = true;
        emulation = true;
        vmHost = true;
      };
      nix.roles.builder = true;
      ociHost = true;
    };
  };

  users.users.fanghr.hashedPassword = "$y$j9T$XaW9wwzHGPQ7kqLde615M0$jUxI2Jsv7KKq4xBZQZfnxjr1txKlBN7lDk/RKk0BclA";

  environment.systemPackages = [
    pkgs.megacli
    pkgs.minicom
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "megacli"
    ];
}
