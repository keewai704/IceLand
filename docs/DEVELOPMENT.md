# Development

## Prerequisites

- Linux with Wayland
- A compositor supporting layer-shell, with Hyprland as the primary target
- Nix with flakes enabled
- Optional: direnv with nix-direnv
- A Vulkan-capable driver for the default rendering path

All project commands and tools are provided by `nix develop`.

## Enter the environment

```bash
nix develop
```

The shell:

- provides Quickshell 0.3 and Qt QML tooling;
- defaults `QT_QPA_PLATFORM` to `wayland`;
- defaults `QSG_RHI_BACKEND` to `vulkan`;
- creates the untracked `.qmlls.ini` entry point used by Quickshell tooling;
- exposes the Quickshell QML import directory for `qmllint` and `qmlls`.

With direnv:

```bash
direnv allow
```

## Run

```bash
just dev
```

The command launches the repository `shell.qml` explicitly, so it does not depend on the user’s normal Quickshell configuration path.

## IPC development API

Inspect handlers:

```bash
just ipc
```

Send a demo:

```bash
just demo
```

The generic call signature is:

```bash
qs ipc call island showActivity \
  <activityId> <title> <detail> <icon> \
  <progress> <timeoutMs> <priority> <pinned>
```

`progress=-1` hides progress. `timeoutMs=0` disables automatic dismissal. Pinned Activities are removed by their provider or an explicit clear call.

## Validation

```bash
just format
just check
nix flake check --no-build
```

`just check` performs QML parsing/linting, shell formatting checks, ShellCheck, and Nix formatting checks. It does not replace a live Wayland test.

For rendering work:

```bash
just rhi-info
```

This enables Qt Quick RHI information and Vulkan validation output. Test the fallback path separately:

```bash
QSG_RHI_BACKEND=opengl just dev
```

## Editor support

Use `qmlls` from the devshell. Quickshell populates `.qmlls.ini` with system-dependent import information when needed; the file remains untracked.

Point the editor at the repository root and ensure it inherits the devshell environment. Do not commit machine-specific QML import paths.

## Updating dependencies

After an intentional input change:

```bash
just lock
git diff -- flake.lock
nix flake check --no-build
just check
```

Do not refresh `flake.lock` as an unrelated drive-by change.

## Common failures

### No Wayland display

Run `just dev` inside the graphical user session. SSH and text consoles normally lack `WAYLAND_DISPLAY`.

### Vulkan startup failure

Confirm driver visibility with `vulkaninfo --summary`, then try:

```bash
QSG_RHI_BACKEND=opengl just dev
```

### QML import errors in the editor

Re-enter `nix develop`, remove the local `.qmlls.ini`, and launch Quickshell once with `just dev` so tooling metadata can be regenerated.
