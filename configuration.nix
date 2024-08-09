{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/virtualisation/azure-common.nix")
    (modulesPath + "/virtualisation/azure-image.nix")
  ];

  boot.growPartition = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  # Azure image
  virtualisation.azureImage = {
    diskSize = 8 * 1024;
    vmGeneration = "v2";
  };

  # Azure specific configurations
  virtualisation.azure.acceleratedNetworking = true;
  virtualisation.azure.agent.enable = true;
  services.cloud-init.enable = true;
  systemd.services.cloud-config.serviceConfig = {
    Restart = "on-failure";
  };

  services.cloud-init.network.enable = true;

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use networkd
  networking.useNetworkd = true;

  # Global packages
  environment.systemPackages = with pkgs; [
    fastfetch pciutils
  ];

  # Users
  users.mutableUsers = false;
  users.users.root.hashedPassword = "!";
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "root" "@wheel" ];

  users.users.nixos = {
    name = "nixos";
    isNormalUser = true;
    hashedPassword = "$y$j9T$4KTiQeCdkgfQKOFh3fL3Q1$5nrQfo.OckiWsMqdBd029X2OAX9GxraXPhUgJe72Pe7"; # nixos
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [];
  };

  # OpenSSH
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}