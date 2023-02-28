{
  nixConfig = {
    extra-substituters = "https://nix-community.cachix.org";
    extra-trusted-public-keys = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, emacs-overlay, ... }:
    let
      overlays = [
        emacs-overlay.overlays.default
      ];
      lib = import ./lib { inherit darwin home-manager overlays; };
    in {
      darwinConfigurations = {
        amalgam = lib.mkDarwinSystem {
          hostname = "amalgam";
          system = "aarch64-darwin";
          username = "eric.ottosson";
        };
      };
    };
}
