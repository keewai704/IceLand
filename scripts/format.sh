#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

mapfile -d '' qml_files < <(find . -type f -name '*.qml' -not -path './.cache/*' -print0 | sort -z)

for file in "${qml_files[@]}"; do
  qmlformat -i "$file"
done

shfmt -w -i 2 -ci scripts/*.sh
nixfmt flake.nix
