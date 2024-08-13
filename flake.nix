{
  description = "azure-aarch64-nixos";

  inputs = {
    nixpkgs.url = "github:codgician/nixpkgs/azure";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, ... }: {
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

      azure-x86-legacy = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-legacy.nix ];
        system = "x86_64-linux";
      };

      azure-aarch64-legacy = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration-legacy.nix ];
        system = "aarch64-linux";
      };
    };
  };
}
