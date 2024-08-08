{ config, inputs, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$menu" = "rofi -show run";

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, SPACEBAR, exec, $menu"
      ];
    };
  };
}