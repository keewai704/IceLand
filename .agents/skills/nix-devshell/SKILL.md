---
name: nix-devshell
description: Maintain IceLand flake.nix, flake.lock, direnv integration, Nix devshell packages, Quickshell pinning, Qt tooling, Vulkan diagnostics, and reproducible CI commands.
---

# IceLand Nix development environment

## Invariants

- Support `x86_64-linux` and `aarch64-linux` unless a dependency makes that impossible and the limitation is documented.
- Pin Quickshell through the flake input and make its `nixpkgs` input follow the repository `nixpkgs` input.
- Put every required formatter, linter, runtime helper, and diagnostic command in the devshell.
- Keep Vulkan as the default RHI through environment configuration, while allowing caller overrides.
- Do not hide host-specific setup in shell aliases or untracked files.

## Change procedure

1. Explain why each new package is required.
2. Prefer packages already present in the selected nixpkgs revision.
3. Run `nix fmt` or `just format`.
4. Run `nix flake check --no-build`.
5. Enter a fresh `nix develop` and run `just check`.
6. Update `flake.lock` only for intentional input changes and review the diff.
7. Update `docs/DEVELOPMENT.md` when commands or prerequisites change.

Avoid adding a second environment manager for tools already provided by Nix.
