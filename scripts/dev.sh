#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -z "${WAYLAND_DISPLAY:-}" ]]; then
  printf 'IceLand requires a Wayland graphical session (WAYLAND_DISPLAY is unset).\n' >&2
  exit 1
fi

export QT_QPA_PLATFORM="${QT_QPA_PLATFORM:-wayland}"
export QSG_RHI_BACKEND="${QSG_RHI_BACKEND:-vulkan}"

exec qs -p "$root/shell.qml" "$@"
