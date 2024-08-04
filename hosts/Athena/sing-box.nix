{config, ...}: {
  services.sing-box = {
    enable = true;
    settings = {
      inbounds = [
        {
          type = "http";
          tag = "http-in";
          listen = "0.0.0.0";
          listen_port = 1086;
          users = [];
        }
        {
          type = "socks";
          tag = "socks-in";
          listen = "0.0.0.0";
          listen_port = 1087;
          users = [];
        }
      ];
      outbounds = [
        {
          _secret = config.age.secrets."outbound-server.json".path;
          quote = false;
        }
      ];
    };
  };

  age.secrets."outbound-server.json".file = ../../secrets/outbound-server.json.age;

  networking.firewall = {
    allowedTCPPorts = [1086 1087];
    allowedUDPPorts = [1086 1087];
  };
}
