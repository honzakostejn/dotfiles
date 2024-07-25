{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  users.users.honzakostejn = {
    isNormalUser = true;
    initialPassword = "12345";
    description = "honzakostejn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.honzakostejn = import ../home/default.nix;
  };
}