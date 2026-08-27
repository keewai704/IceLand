# Roadmap

The order is based on architectural leverage, not feature novelty.

## Phase 0: foundation

- [x] Reproducible Quickshell devshell
- [x] Codex repository instructions and Skills
- [x] Multi-monitor top-center layer surface
- [x] Idle clock
- [x] Generic priority-aware IPC Activity
- [x] Compact and expanded geometry
- [ ] Commit and maintain `flake.lock`
- [ ] Validate on Hyprland with multiple scale factors

## Phase 1: core desktop feedback

- [ ] Volume and mute OSD through PipeWire
- [ ] Brightness OSD
- [ ] Microphone mute and privacy indicator
- [ ] MPRIS media Activity and controls
- [ ] Workspace-switch feedback
- [ ] Timer / Pomodoro provider

## Phase 2: event center

- [ ] Freedesktop notification provider or daemon mode
- [ ] Notification history and coalescing
- [ ] Download, copy, and build progress through generic IPC
- [ ] Screen-recording Activity
- [ ] Bluetooth device connection feedback
- [ ] Wi-Fi, VPN, and Tailscale state changes

## Phase 3: agent and extensibility

- [ ] `islandctl` CLI with create/update/finish commands
- [ ] Codex and Hermes Activity adapters
- [ ] Typed Activity actions and permission prompts
- [ ] Multiple-activity scheduler and background indicators
- [ ] Stable JSON-over-Unix-socket API
- [ ] Versioned provider SDK

## Phase 4: visual refinement

- [ ] Interruption-aware spring model
- [ ] Morphing icon system
- [ ] Optional bounded shader effects
- [ ] Reduced-motion policy
- [ ] Theme/configuration schema
- [ ] Active-monitor and per-monitor display policy

A phase item is complete only after its provider lifecycle, degraded behavior, IPC/demo path, and validation are documented.
