# Product definition

## Purpose

IceLand is a top-center event hub for Linux desktops. It gives ongoing or newly changed state a temporary, spatially stable home without turning the top edge into a permanently dense dashboard.

The product should feel useful even when only the clock and generic IPC Activity are implemented. Integrations extend the same model rather than adding unrelated widgets.

## Product principles

1. **Quiet by default.** Idle shows minimal information.
2. **Events, not telemetry.** CPU, memory, network rate, and temperatures do not belong in the compact idle surface unless they cross an actionable threshold.
3. **One spatial anchor.** Related state morphs in place instead of spawning unrelated banners.
4. **Progressive disclosure.** Compact state answers “what changed”; expanded state exposes detail and controls.
5. **Interruptible priority.** Safety, permissions, calls, and privacy can preempt lower-value activities.
6. **Native Linux integration.** Prefer freedesktop, PipeWire, MPRIS, UPower, NetworkManager, and compositor APIs.
7. **Extensible by scripts and agents.** A stable typed IPC Activity API is a first-class feature.
8. **Low idle cost.** No continuous redraw or polling merely to keep the Island visible.

## UI states

### Idle

A compact clock or a tiny persistent indicator. It must not look like a conventional status bar.

### Activity

A transient capsule with an icon, title, detail, and optional progress. It may time out or stay pinned while work continues.

### Expanded

A user-requested detail surface for the current Activity. Actions must remain specific to the Activity; a general control center is later work.

## Priority model

Higher values preempt lower values. Values are policy defaults, not visual styling.

| Priority | Category |
| ---: | --- |
| 100 | Critical alert or destructive permission decision |
| 90 | Incoming/active call |
| 80 | Camera, microphone, or screen-recording privacy state |
| 70 | Volume, brightness, keyboard, and output-device OSD |
| 60 | User notifications |
| 50 | Timer, Pomodoro, build, copy, and download progress |
| 40 | Media playback |
| 10 | Clock / idle |

The first implementation keeps one active slot and rejects lower-priority events. A later scheduler may queue or summarize background activities without changing provider contracts.

## Initial milestone

- Multi-monitor top-center Island
- Clock idle state
- Generic typed IPC Activity
- Priority preemption and timeout cleanup
- Compact/expanded interaction
- Vulkan-backed Qt Quick development path
- Codex-ready repository rules and reproducible environment

## Product boundaries

IceLand is not initially:

- a complete Waybar replacement;
- a notification daemon;
- a command launcher;
- a full control center;
- an arbitrary HTML/markup renderer;
- a plugin host for untrusted code.
