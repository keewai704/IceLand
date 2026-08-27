---
name: quickshell-qml
description: Implement or review IceLand Quickshell 0.3 QML, including ShellRoot, Variants, PanelWindow, Wayland layer-shell, root-relative imports, Singletons, IPC handlers, masks, and multi-monitor behavior.
---

# Quickshell QML for IceLand

Use this Skill for any change to `shell.qml`, `components/`, `core/`, `config/`, or Quickshell-specific APIs.

## Procedure

1. Read `AGENTS.md`, `docs/ARCHITECTURE.md`, and `docs/QML_STYLE.md`.
2. Identify the owner of every state value before editing UI.
3. Verify version-sensitive API names against Quickshell v0.3 documentation.
4. Preserve the one-window-per-screen `Variants` pattern.
5. Keep the layer surface stable and animate the child Island geometry.
6. Ensure the `Region` mask follows the interactive Island item.
7. Use root-relative `qs.*` imports and keep `qmldir` declarations current.
8. Run `just format` and `just check`.
9. In a Wayland session, launch `just dev` and exercise the changed state through IPC or its provider.

## Preferred patterns

- `ShellRoot` owns application-level objects.
- `Variants { model: Quickshell.screens }` creates monitor-specific windows.
- `Singleton` objects own shared state and external subscriptions.
- `SystemClock`, service modules, and signals replace hand-written polling.
- Typed `IpcHandler` functions form the development and integration API.
- Bindings express derived geometry and visibility; functions express discrete events.

## Reject these patterns

- A `Process` in every widget instance.
- Rich text for external strings.
- Per-frame Wayland surface resizing.
- Imperative handlers that continuously copy one property into another.
- Monitor dimensions hard-coded into component widths.
- Animations that continue running after values settle.

## Validation focus

Check startup, reload, every monitor, scale factors, activity preemption, timeout cleanup, repeated IPC calls, expanded/collapsed transitions, and click-through outside the Island.
