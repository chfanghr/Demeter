{
  description = "System configuration for Demeter";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nvim = {
      url = "github:chfanghr/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.follows = "my-nvim/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    cardano-nix.url = "github:mlabs-haskell/cardano.nix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&&rev=9e781040d9067c2711ec2e9f5b47b76ef70762b3"; # v0.41.1
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    disko.url = "github:nix-community/disko";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      imports = [
        ./flake-part-modules.nix
        ./pre-commit.nix
      ];
    };
}
