# IceLand repository instructions

## Mission

Build IceLand as a focused Wayland event hub, not as a dense status bar. The idle surface must stay quiet. Transient or ongoing activities may temporarily expand it and expose only the controls needed for that activity.

## Read before changing code

1. `docs/PRODUCT.md`
2. `docs/ARCHITECTURE.md`
3. `docs/QML_STYLE.md`
4. `docs/DEVELOPMENT.md`
5. The closest nested `AGENTS.md`, if one is added later

For changes spanning multiple modules or changing behavior, create or update `PLAN.md` using `PLANS.md` before implementation. Keep decisions and validation results current while working.

## Environment and commands

Enter the repository dev shell before using project tools:

```bash
nix develop
```

Canonical commands:

```bash
just dev
just demo
just check
just format
just rhi-info
```

Do not install ad-hoc host dependencies to make a change pass. Add reproducible tools to `flake.nix` instead.

## Architecture invariants

- Keep the Wayland `PanelWindow` at a stable maximum height. Animate the Island item inside it; do not resize the layer surface every animation frame.
- Keep the transparent portion click-through with `QsWindow.mask` / `Region`.
- Create one window per `Quickshell.screens` entry through `Variants`.
- Shared application state belongs in typed `Singleton` objects under `core/` or `providers/`.
- UI components consume provider state. They must not each start their own `Process`, DBus listener, timer, or polling loop.
- Prefer native Quickshell service modules and DBus APIs over parsing command output.
- External events enter through a typed provider API. UI files must not execute arbitrary shell text from an event payload.
- Treat all external strings as plain text. Never enable rich text for notification, media, clipboard, or agent content unless it is sanitized first.
- The generic Activity contract is documented in `docs/ARCHITECTURE.md`. Preserve backward compatibility for IPC functions unless a migration is documented.
- Vulkan is the default Qt Quick RHI backend, but the UI must also run with `QSG_RHI_BACKEND=opengl` for troubleshooting.
- Avoid permanent frame loops. Animations stop when settled; idle state must be event-driven.

## QML rules

- Use declarative bindings rather than imperative synchronization.
- Use root-relative imports such as `import qs.core` and `import qs.components`.
- Give reusable components explicit public properties and keep internal ids private.
- Use `implicitWidth` / `implicitHeight` for windows and reusable content where applicable.
- Keep layout, visual tokens, and motion constants in `config/Theme.qml` until a dedicated configuration model is introduced.
- Use one source of truth for each state. Never mirror a property merely to make a binding convenient.
- Design transitions to be interruptible. A higher-priority activity can preempt a lower-priority one at any point.
- Check small and scaled displays. Do not assume a 1920-pixel-wide monitor or scale factor 1.

## Provider rules

A provider must:

1. expose a small typed state/API;
2. own exactly one external subscription or long-lived process for its service;
3. clean up connections and timers;
4. map raw service data into the generic Activity model;
5. document permissions, dependencies, and failure behavior;
6. remain usable without its UI component loaded.

Do not add background polling when a signal, subscription, or file descriptor notification is available.

## Codex workflow

- Inspect existing code and documentation before editing.
- Use the repository Skills under `.agents/skills/` when their descriptions match the task.
- Delegate independent read-heavy investigation to custom agents under `.codex/agents/`.
- Do not let multiple agents write the same files concurrently.
- Make the smallest coherent change that establishes the requested behavior.
- Do not create GitHub issues as a substitute for completing work.
- Update documentation in the same change when behavior, IPC, architecture, setup, or dependencies change.

## Definition of done

Before finishing:

1. run `just format` when source files changed;
2. run `just check`;
3. launch with `just dev` in a Wayland session for UI changes;
4. exercise the affected IPC/provider path;
5. inspect with `just rhi-info` for rendering or animation changes;
6. report any validation that could not be performed and why.

A feature is not complete if only the happy-path visual works. Verify preemption, timeout/cleanup, multi-monitor behavior, click-through input, and missing-service behavior where relevant.
