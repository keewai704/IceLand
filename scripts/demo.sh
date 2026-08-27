#!/usr/bin/env bash
set -euo pipefail

title="${1:-Building IceLand}"
detail="${2:-128 / 347}"
progress="${3:-0.37}"

exec qs ipc call island showActivity \
  demo \
  "$title" \
  "$detail" \
  "✦" \
  "$progress" \
  5000 \
  50 \
  false
