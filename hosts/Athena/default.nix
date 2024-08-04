{
  inputs,
  pkgs,
  lib,
  ...
}: let
  bondName = "bond0";
  inherit (lib) mkForce;
in {
  imports = [
    ./disko.nix
    ./sing-box.nix
    ../../modules/nixos/common
    inputs.disko.nixosModules.default
    inputs.agenix.nixosModules.default
  ];

  dotfiles.nixos.props = {
    nix.roles.consumer = true;
    users = {
      rootAccess = true;
      fanghr.disableHm = true;
    };
    hardware = {
      cpu.intel = true;
      # vmHost = true;
    };
  };

  time.timeZone = "Asia/Hong_Kong";

  users.users = {
    fanghr.hashedPassword = "$y$j9T$tn5fAVwNCepbQ4xrimozH0$FhC1TMwwwcKFfDFtX4qx23AUhHRee9o2GviL5dM35b.";
    root.hashedPassword = "$y$j9T$LclEAQG.FK8eoV2.mc6ku1$dDc7MUikq2gi7Jpbo4AeQsnkdUjEFsfJ0XbhMY3yedA";
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "igc"
    ];
    kernelModules = ["tcp_bbr"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
  };

  nix.gc.options = "--delete-older-than +8";

  networking = {
    hostName = "Athena";
    nftables.enable = true;
    bonds.${bondName} = {
      interfaces = ["enp1s0" "enp2s0"];
      driverOptions = {
        mode = "802.3ad";
      };
    };
    useNetworkd = true;
    interfaces.${bondName}.useDHCP = true;
    firewall.enable = true;
  };

  environment.defaultPackages = [
    pkgs.zellij
    pkgs.minicom
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  powerManagement.cpuFreqGovernor = "ondemand";

  services = {
    tailscale.useRoutingFeatures = mkForce "both";
    iperf3 = {
      enable = true;
      openFirewall = true;
    };
  };
}
