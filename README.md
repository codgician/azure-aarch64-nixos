# NixOS on Azure aarch64 

[![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fcodgician%2Fazure-aarch64-nixos%3Fbranch%3Dmain)](https://garnix.io/repo/codgician/azure-aarch64-nixos)

This is a test flake for NixOS on Azure for [nixos/nixpkgs: PR #359365](https://github.com/NixOS/nixpkgs/pull/359365).

## Quick start

This flake contains NixOS configuration for both x86_64 and aarch64 on Azure:

* azure-aarch64: Gen 2 VM for aarch64, using systemd-boot
* azure-x86: Gen 2 VM for x86_64, using systemd-boot
* azure-aarch64-legacy: Gen 1 VM for aarch64 **(not officially supported by Azure)**
* azure-x86-legacy: Gen 1 VM for x86_64
* azure-aarch64-grub: Gen 2 VM for aarch64, using grub
* azure-x86-grub: Gen 2 VM for x86_64, using grub

To generate VHD for aarch64 Gen 2 VM (on aarch64 machine):

```bash
nix build --accept-flake-config .#azure-aarch64 
```

... and the resulting vhd could be found under: `./result/disk.vhd`.

Default username and password are both `nixos`.
