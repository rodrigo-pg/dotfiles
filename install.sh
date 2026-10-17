#!/usr/bin/env bash
# Link this repository's configuration for the current user (macOS/Linux).
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$config_dir"
for app in nvim helix; do
  target="$config_dir/$app"
  source_dir="$repo_dir/$app"
  if [[ -L "$target" && "$(readlink "$target")" == "$source_dir" ]]; then
    printf '%s is already linked: %s\n' "$app" "$target"
    continue
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup="${target}.backup-dotfiles-$(date +%Y%m%d-%H%M%S)-$$"
    mv "$target" "$backup"
    printf 'Backup saved to: %s\n' "$backup"
  fi

  ln -s "$source_dir" "$target"
  printf '%s linked: %s -> %s\n' "$app" "$target" "$source_dir"
done
printf 'Open nvim and run :Lazy restore to install the recorded plugin versions.\n'
