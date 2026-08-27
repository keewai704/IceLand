#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

required_commands=(qmlformat qmllint shellcheck shfmt nixfmt)
for command_name in "${required_commands[@]}"; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    printf 'Missing required command: %s. Enter `nix develop`.\n' "$command_name" >&2
    exit 1
  fi
done

mapfile -d '' qml_files < <(find . -type f -name '*.qml' -not -path './.cache/*' -print0 | sort -z)
if ((${#qml_files[@]} == 0)); then
  printf 'No QML files found.\n' >&2
  exit 1
fi

temporary_directory="$(mktemp -d)"
trap 'rm -rf "$temporary_directory"' EXIT
ln -s "$root" "$temporary_directory/qs"

lint_arguments=(-I "$temporary_directory")
if [[ -n "${QML_IMPORT_PATH:-}" ]]; then
  IFS=':' read -r -a import_paths <<<"$QML_IMPORT_PATH"
  for import_path in "${import_paths[@]}"; do
    if [[ -n "$import_path" ]]; then
      lint_arguments+=(-I "$import_path")
    fi
  done
fi

for file in "${qml_files[@]}"; do
  qmlformat "$file" >/dev/null
  qmllint "${lint_arguments[@]}" "$file"
done

shellcheck scripts/*.sh
shfmt -d -i 2 -ci scripts/*.sh
nixfmt --check flake.nix

printf 'IceLand static checks passed.\n'
