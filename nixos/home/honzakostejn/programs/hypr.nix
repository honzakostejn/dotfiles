{ config, inputs, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      $mainMod = SUPER

      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, R, exec, sh rofi -show drun
    '';
  };
}