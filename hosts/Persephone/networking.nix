{
  networking = {
    hostName = "Persephone";
    hostId = "9ce62f33"; # Required by zfs

    useNetworkd = true;

    bonds.bond0 = {
      interfaces = ["enp195s0f0" "enp195s0f1"];
      driverOptions = {
        mode = "802.3ad";
      };
    };

    interfaces.bond0.useDHCP = true;

    firewall.enable = true;
  };
}
