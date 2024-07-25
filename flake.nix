{
  description = "This is honzakostejn's flake. It contains the configurations for all of his devices.";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          # disk configuration
          ./hosts/vm/disk-config.nix

          # configuration
          ./hosts/vm/configuration.nix
          ./modules/default.nix
        ];
    };
  };
}