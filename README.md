# NixOS on Azure aarch64 

This is a test flake for NixOS on Azure aarch64 for [nixos/nixpkgs: PR #333508](https://github.com/NixOS/nixpkgs/pull/333508).

Following changes are made in the proposed PR: 

* [azure-agent] Removed x86 assertions
* [azure-image] Support generating v2 image (UEFI boot without Secure Boot)
* [azure-common] Support accelerated networking

## Quick start

This flake contains NixOS configuration for both x86_64 and aarch64 on Azure.

To generate VHD for aarch64 VM:

```bash
nix build .#nixosConfigurations.azure-aarch64.config.system.build.azureImage
```

... and the resulting vhd could be found under: `./result/disk.vhd`.
