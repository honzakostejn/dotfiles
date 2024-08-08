{ config, inputs, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$menu" = "rofi -show run";

      "$mod" = "SUPER";
      bind = [
        "$mod, SPACEBAR, exec, $menu"
      ];
    };
  };
}