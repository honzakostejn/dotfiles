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

  outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: 
    let
    system = "x86_64-linux";
    # rootAuthorizedKeys = [
    #   # This user can ssh using `ssh root@<ip>`
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQRxPoqlThDrkR58pKnJgmeWPY9/wleReRbZ2MOZRyd"
    # ];
  in
  {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # disk configuration
          ./disk-config.nix
          disko.nixosModules.disko

          # configuration
          ./hosts/vm/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.honzakostejn = import ./home/honzakostejn/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
