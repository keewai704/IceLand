---
name: verify-island
description: Validate an IceLand change before completion using static checks, Quickshell IPC, Wayland behavior, Vulkan RHI diagnostics, activity preemption, timeout cleanup, and multi-monitor scenarios.
---

# Verify IceLand

Run the cheapest deterministic checks first, then interactive checks.

## Static

```bash
nix develop
just format
just check
nix flake check --no-build
```

Review the resulting diff after formatting. Formatting must not silently change behavior.

## Runtime

```bash
just dev
```

In another devshell:

```bash
qs ipc call island ping
just demo
qs ipc call island setExpanded true
qs ipc call island updateProgress demo 0.9
qs ipc call island clearActivity demo
```

## Required scenarios

- Island appears on every intended monitor.
- Transparent window space does not intercept clicks.
- Compact, activity, and expanded sizes stay on-screen at non-1 scale factors.
- Repeated events restart timeout correctly.
- Lower-priority events do not replace a current higher-priority event.
- Equal/higher-priority events preempt cleanly.
- Clearing an unknown activity id does not clear the current one.
- Idle state stops visual animation.
- Missing optional services do not crash the shell.

## Rendering

```bash
just rhi-info
```

Confirm the selected backend, inspect validation output, then repeat once with:

```bash
QSG_RHI_BACKEND=opengl just dev
```

Report any runtime check that could not be executed because no Wayland session, monitor configuration, service, or GPU was available.
