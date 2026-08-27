# Execution plans

Use a root-level `PLAN.md` for work that spans multiple modules, changes public IPC, introduces a provider, or requires staged migration.

The plan is a living engineering record. Update it as facts change; do not preserve an obsolete plan merely because implementation has started.

## Required structure

```markdown
# <Outcome-oriented title>

## Context
What exists now, why the change is needed, and the relevant files.

## Goals
Observable outcomes that define success.

## Non-goals
Closely related work intentionally excluded.

## Design
State ownership, data flow, UI states, public interfaces, and failure behavior.

## Work breakdown
Ordered implementation slices. Each slice should leave the repository understandable.

## Validation
Exact commands and manual scenarios, including preemption and cleanup.

## Decisions
Dated decisions and their rationale.

## Progress
- [ ] Concrete task

## Risks and follow-ups
Known limitations and later work that is not required for this plan.
```

## Planning rules

- Resolve architectural ambiguity before listing file edits.
- State which component owns each new piece of state.
- Include provider teardown and degraded behavior.
- Include IPC compatibility when changing the Activity model.
- Include performance consequences for timers, animations, blur, shaders, or continuous audio data.
- Replace speculative details with verified facts as implementation progresses.
