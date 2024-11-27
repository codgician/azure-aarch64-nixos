# NixOS configuration for Azure Gen 2 VM using systemd-boot

{ pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/virtualisation/azure-image.nix")
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Azure image
  virtualisation.diskSize = 8 * 1024;
  virtualisation.azureImage.vmGeneration = "v2";
  virtualisation.azure.acceleratedNetworking = true;
  
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use networkd
  networking.useNetworkd = true;

  # Global packages
  environment.systemPackages = with pkgs; [
    fastfetch pciutils git htop
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

  # Enable zram swap
  zramSwap.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}