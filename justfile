set shell := ["bash", "-euo", "pipefail", "-c"]

default: check

# Launch IceLand in the current Wayland session.
dev *args:
    ./scripts/dev.sh {{args}}

# Send a representative generic Activity through the public IPC API.
demo:
    ./scripts/demo.sh

# Run repository checks expected before a commit.
check:
    ./scripts/check.sh

# Format supported source files in place.
format:
    ./scripts/format.sh

# Launch with Qt Quick RHI diagnostics and Vulkan validation enabled.
rhi-info *args:
    ./scripts/rhi-info.sh {{args}}

# Inspect registered Quickshell IPC targets.
ipc:
    qs ipc show

# Refresh flake.lock after intentionally changing inputs.
lock:
    nix flake lock
