---
name: island-motion
description: Design or tune IceLand Dynamic Island geometry, spring-like transitions, content choreography, interruption behavior, shader effects, and high-refresh-rate rendering performance.
---

# IceLand motion design

Motion communicates state change; it is not decoration.

## Order of work

1. Define source and destination state, including content hierarchy.
2. Decide which dimensions change: width, height, radius, opacity, translation, and scale.
3. Keep the top center visually anchored while expansion moves downward/outward.
4. Make the geometry transition begin before incoming content becomes fully visible.
5. Fade or translate outgoing content without leaving both states legible at once.
6. Verify that a new event can interrupt the transition without snapping.
7. Verify settled idle state causes no continuing animation or frame loop.

## Defaults

- Prefer 180-360 ms for ordinary transitions.
- Use a restrained overshoot only for user-visible expansion, never for progress updates.
- Progress changes should be smooth and short, not elastic.
- Keep corner radius proportional while compact; use a bounded radius when expanded.
- Avoid blur or shader effects until geometry and choreography are correct.

## Vulkan/RHI review

Use `just rhi-info` for rendering changes. Look for excessive redraw, texture churn, validation errors, and effects whose cost scales with the full transparent window rather than the Island bounds.

Do not introduce a custom shader without documenting its fallback, alpha handling, bounding rectangle, and expected idle cost.
