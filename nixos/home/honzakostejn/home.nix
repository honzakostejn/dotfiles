{ inputs, config, pkgs, ... }:

{
  imports = [
    ./programs/hypr.nix
  ];

  home.stateVersion = "24.05";

  # Info about user and path it manages
  home.username = "honzakostejn";
  home.homeDirectory = "/home/honzakostejn";
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # User packages
  home.packages = with pkgs; [
    kitty
    neofetch
    neovim
    git
    rofi-wayland
    ungoogled-chromium
    vscode
  ];
}