{ inputs, config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      # Hint Electron apps to use wayland

      NIXOS_OZONE_WL = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
    systemPackages = with pkgs; [
      htop
      git
      neovim
      wget
    ];
  };
}