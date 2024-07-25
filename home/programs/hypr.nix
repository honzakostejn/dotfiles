{ config, inputs, pkgs, ...}:

{
  programs.hyprland.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
  };
}