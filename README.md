# NixOS on Azure aarch64 

This is a test flake for NixOS on Azure aarch64 for [nixos/nixpkgs: PR #333508](https://github.com/NixOS/nixpkgs/pull/333508).

Following changes are made in the proposed PR: 

* [azure-agent] Removed x86 assertions
* [azure-image] Support generating v2 image (UEFI boot without Secure Boot)
* [azure-common] Support accelerated networking

## Quick start

This flake contains NixOS configuration for both x86_64 and aarch64 on Azure:

* azure-aarch64: Gen 2 VM for aarch64, using systemd-boot
* azure-x86: Gen 2 VM for x86_64, using systemd-boot
* azure-aarch64-legacy: Gen 1 VM for aarch64
* azure-x86-legacy: Gen 1 VM for x86_64
* azure-aarch64-grub: Gen 2 VM for aarch64, using grub
* azure-x86-legacy: Gen 2 VM for x86_64, using grub
* azure-aarch64-xfs: Gen 2 VM for aarch64, using systemd-boot and XFS root partition
* azure-x86-xfs: Gen 2 VM for x86_64, using systemd-boot and XFS root partition

To generate VHD for aarch64 Gen 2 VM:

```bash
nix build .#nixosConfigurations.azure-aarch64.config.system.build.azureImage
```

... and the resulting vhd could be found under: `./result/disk.vhd`.

Default username and password are both `nixos`.
