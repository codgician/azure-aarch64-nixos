{
  description = "azure-aarch64-nixos";

  inputs = {
    nixpkgs.url = "github:codgician/nixpkgs/fix-azure-modules";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, ... }: {
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
        modules = [ ./configuration.nix ];
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

      azure-x86-xfs = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-xfs.nix ];
        system = "x86_64-linux";
      };

      azure-aarch64-xfs = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-xfs.nix ];
        system = "aarch64-linux";
      };
    };
  };
}
