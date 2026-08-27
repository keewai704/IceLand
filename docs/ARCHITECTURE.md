# Architecture

## Runtime shape

```text
shell.qml
├── one shared ActivityController singleton
├── one typed IpcHandler
└── Variants over Quickshell.screens
    └── IslandWindow per screen
        └── IslandSurface
            ├── IdleContent
            └── ActivityContent
```

Future service integrations live in `providers/` and submit normalized Activities to `ActivityController`. They do not directly manipulate component ids.

## Wayland window strategy

`IslandWindow` is a transparent `PanelWindow` anchored to the top, left, and right edges. Its height is the maximum design envelope. The visible Island is centered inside it.

This avoids changing layer-shell geometry on every animation frame. Width, height, radius, opacity, and content position animate inside Qt Quick instead.

The window input mask tracks `IslandSurface`, so the rest of the transparent layer passes pointer input to applications below it.

`ExclusionMode.Ignore` means IceLand overlays content and does not reserve desktop work area in the initial design. A future configurable bar mode must be implemented as a separate policy rather than silently changing this behavior.

## Rendering

Qt Quick renders through its Rendering Hardware Interface. The devshell requests Vulkan through `QSG_RHI_BACKEND=vulkan`. OpenGL remains a troubleshooting fallback.

Effects must be bounded to the visible Island. A full-window blur or permanent shader animation would make cost scale with the transparent surface and violates the low-idle-cost goal.

## Activity model

The public conceptual contract is:

```text
activityId   stable provider-scoped identifier
kind         semantic category (future controller field)
title        primary plain-text label
detail       secondary plain-text label
icon         trusted local icon token or short glyph
progress     -1 for absent/indeterminate, otherwise 0..1
priority     non-negative integer; higher preempts lower
timeoutMs    0 for no automatic timeout
pinned       true when provider lifetime controls removal
actions      future typed actions, never arbitrary shell text
```

The scaffold implements the fields required by the current IPC. Additive fields should be introduced without changing existing argument order or meaning. Breaking IPC changes require a documented migration.

## State ownership

`ActivityController` owns:

- active Activity data;
- priority acceptance/rejection;
- timeout lifecycle;
- compact versus expanded state.

Visual components derive geometry and opacity from controller state. They do not own duplicate copies.

A future scheduler may own a queue above the controller. Providers should continue submitting Activities rather than learning scheduler internals.

## Provider architecture

Each external service gets one singleton provider, independent of the number of monitors. Preferred order:

1. native Quickshell service module;
2. DBus subscription;
3. event socket or file descriptor;
4. one supervised long-lived process;
5. bounded polling only when no event API exists.

High-rate signals such as audio levels must be throttled to a visually meaningful rate and disabled when not visible.

## Module boundaries

- `config/`: design tokens and user-configurable values
- `core/`: generic state machines and scheduling
- `providers/`: external service adapters
- `components/`: reusable visual components
- `shell.qml`: composition, monitor variants, and public IPC
- `scripts/`: deterministic development commands

## Failure behavior

- A missing optional provider removes only its feature.
- Malformed external data is ignored or converted to safe fallback text.
- A rejected low-priority Activity must not reset the current timeout.
- Clearing with a non-matching id must leave the current Activity untouched.
- Quickshell reload must reconstruct state without orphan processes.

## Future scheduling

When multiple simultaneous activities are implemented, use:

- one foreground Activity;
- a bounded background queue;
- explicit coalescing by provider and activity id;
- priority plus recency ordering;
- provider-driven completion for pinned work;
- small background indicators rather than hidden unbounded state.
