{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (config.dotfiles.shared.props.purposes.graphical.gaming) (lib.mkMerge [
  {
    networking = {
      useNetworkd = false;
      networkmanager = {
        enable = true;
        insertNameservers = ["8.8.8.8" "1.1.1.1" "114.114.114.114"];
      };
    };

    services.seatd.enable = true;

    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      dualsensectl
      chiaki4deck
      prismlauncher
    ];

    nixpkgs.config.allowUnfree = true;
  }
  (lib.mkIf (!config.dotfiles.shared.props.hardware.steamdeck) {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  })
])
