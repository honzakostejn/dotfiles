# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; ref = "master"; }}/raspberry-pi/4"
      ./hardware-configuration.nix
    ];

  hardware = {
    raspberry-pi."4" = {
      # apply-overlays-dtmerge.enable = true;

      # audio.enable = true;

      fkms-3d.enable = true;
    };
    deviceTree = {
      enable = true;
      # filter = lib.mkForce "bcm2711-rpi-4-*.dtb";
      overlays = [{
      	name = "reTerminal-dts";
	dtsFile = /home/honzakostejn/seeed-linux-dtoverlays/overlays/rpi/reTerminal-overlay.dts;
      } {
        name = "reTerminal-dtbo";
	dtboFile = /home/honzakostejn/seeed-linux-dtoverlays/overlays/rpi/reTerminal-overlay.dtbo;
      }];
    };
    pulseaudio.enable = true;
    enableRedistributableFirmware = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  
  networking = {
    hostName = "handkerchief";
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
      networks."svarta_jump_official".psk = "toJUMPOVAL@666";
      networks."NETWORG".psk = "networg2019";
      networks."boris_wetter iPhone".psk = "networg2019";
    };
  };

  sound.enable = true;

  services.openssh.enable = true;
  
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  environment.systemPackages = with pkgs; [
    chatgpt-cli
    git
    libraspberrypi
    neovim
    raspberrypi-eeprom
    ungoogled-chromium
    wezterm
    wget
   
    # dtoverlays
    gcc
    gnumake
    dtc
  ];

  environment.sessionVariables = {
    OPENAI_API_KEY = "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";
  };

  users.users = {
    honzakostejn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

