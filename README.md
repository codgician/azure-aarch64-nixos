# NixOS on Azure aarch64 

[![build](https://github.com/codgician/azure-aarch64-nixos/actions/workflows/build.yml/badge.svg)](https://github.com/codgician/azure-aarch64-nixos/actions/workflows/build.yml)

This is a test flake for NixOS on Azure for [nixos/nixpkgs: PR #359365](https://github.com/NixOS/nixpkgs/pull/359365).

## Quick start

This flake contains NixOS configuration for both x86_64 and aarch64 on Azure:

* azure-aarch64: Gen 2 VM for aarch64, using systemd-boot
* azure-x86: Gen 2 VM for x86_64, using systemd-boot
* azure-aarch64-legacy: Gen 1 VM for aarch64
* azure-x86-legacy: Gen 1 VM for x86_64
* azure-aarch64-grub: Gen 2 VM for aarch64, using grub
* azure-x86-grub: Gen 2 VM for x86_64, using grub

To generate VHD for aarch64 Gen 2 VM:

```bash
nix build .#nixosConfigurations.azure-aarch64.config.system.build.azureImage
```

... and the resulting vhd could be found under: `./result/disk.vhd`.

Default username and password are both `nixos`.
