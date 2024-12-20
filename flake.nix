{
  description = "azure-aarch64-nixos";

  inputs = {
    nixpkgs.url = "github:codgician/nixpkgs/fix-azure-modules";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, ... }: rec {
    # NixOS configurations
    nixosConfigurations = {
      azure-x86 = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
        system = "x86_64-linux";
      };

      azure-aarch64 = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
        system = "aarch64-linux";
      };

      azure-x86-grub = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-grub.nix ];
        system = "x86_64-linux";
      };

      azure-aarch64-grub = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-grub.nix ];
        system = "aarch64-linux";
      };

      azure-x86-legacy = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-legacy.nix ];
        system = "x86_64-linux";
      };

      azure-aarch64-legacy = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-legacy.nix ];
        system = "aarch64-linux";
      };
    };

    # Export Azure vhd as packages
    packages = {
      "aarch64-linux" = {
        azure-aarch64 = nixosConfigurations.azure-aarch64.config.system.build.azureImage;
        azure-aarch64-grub = nixosConfigurations.azure-aarch64-grub.config.system.build.azureImage;
        azure-aarch64-legacy = nixosConfigurations.azure-aarch64-legacy.config.system.build.azureImage;
      };
      "x86_64-linux" = {
        azure-x86 = nixosConfigurations.azure-x86.config.system.build.azureImage;
        azure-x86-grub = nixosConfigurations.azure-x86-grub.config.system.build.azureImage;
        azure-x86-legacy = nixosConfigurations.azure-x86-legacy.config.system.build.azureImage;
      };
    };
  };
}
