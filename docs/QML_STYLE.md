# QML style

## Imports and modules

Use root-relative repository imports:

```qml
import qs.components
import qs.config
import qs.core
```

Keep `qmldir` files aligned with public types and singletons. Avoid relative directory imports that depend on the caller’s location.

Order imports as Qt modules, Quickshell modules, then repository modules.

## State and bindings

- Store mutable shared state in one singleton owner.
- Express derived values as `readonly property` bindings.
- Use functions for discrete transitions, not for continuously synchronizing properties.
- Do not assign to a property that normally has a binding unless intentionally replacing that binding.
- Stop or restart timers explicitly when Activity ownership changes.

## Components

- A reusable visual component exposes only the inputs needed by its caller.
- Keep ids local; other files communicate through properties, signals, or singleton APIs.
- Use `implicitWidth` and `implicitHeight` for content-sized reusable components.
- Use anchors for simple relationships and layouts for repeated content. Avoid mixing mutually controlling geometry systems on one item.

## Text and assets

- External strings use `textFormat: Text.PlainText`.
- Use elision or bounded wrapping; provider text cannot determine unbounded window size.
- Icon strings are temporary scaffold behavior. Production integrations should map semantic tokens to trusted local assets.
- Do not fetch remote images directly from notification payloads without cache, size, and scheme policy.

## Motion

- Geometry changes remain top-centered.
- Content fade follows geometry start and completes before the surface settles.
- Progress animation is short and non-elastic.
- Every animation must settle; no always-running NumberAnimation in idle state.
- Higher-priority events may interrupt any transition without invalid intermediate state.

## Performance

- One provider instance serves every monitor.
- Do not create one `Process`, `SystemClock`, or DBus listener per repeated delegate when shared state suffices.
- Avoid full-window shader effects on a mostly transparent layer surface.
- Throttle high-frequency data before crossing into visual QML state.

## Naming

- Types and QML files: `UpperCamelCase`
- ids, properties, functions, and signals: `lowerCamelCase`
- readonly design constants: descriptive `lowerCamelCase` properties on `Theme`
- Activity ids: stable `provider:item` strings where practical
