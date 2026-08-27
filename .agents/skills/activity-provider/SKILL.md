---
name: activity-provider
description: Add or change an IceLand data provider or Live Activity integration such as MPRIS media, notifications, volume, brightness, timers, downloads, screen recording, network, Bluetooth, or Codex agent status.
---

# IceLand Activity providers

Use this Skill when external state must appear in the Island.

## Provider contract

Map external data to the Activity fields documented in `docs/ARCHITECTURE.md`:

- stable `activityId`
- semantic type
- plain-text title and detail
- icon token or trusted local asset
- progress in `[-1, 1]`, where `-1` means indeterminate or absent
- priority
- timeout or pinned lifetime
- optional actions, added only through a typed trusted API

## Procedure

1. Determine whether Quickshell already exposes a native service module.
2. Prefer DBus, sockets, or signals over command polling.
3. Create one provider singleton for the service.
4. Define service unavailable, disconnect, restart, and malformed-data behavior.
5. Submit normalized activities through the controller; do not mutate visual component internals.
6. Stop timers, processes, and subscriptions when no longer needed.
7. Document external runtime dependencies and permissions.
8. Add a deterministic IPC/demo path when practical.
9. Test simultaneous lower- and higher-priority activities.

## Security constraints

- Never evaluate payload text as QML, JavaScript, markup, or shell.
- Do not expose a generic "run command" action through untrusted events.
- Do not display clipboard secrets or password-manager content by default.
- Keep notification and media text in `Text.PlainText`.
- Treat file paths and URLs as data until a user action passes a validated typed handler.

## Performance constraints

A service gets one long-lived subscription, not one per monitor or widget. Throttle high-rate sources such as audio levels before updating QML. No source should force continuous rendering while visually idle.
