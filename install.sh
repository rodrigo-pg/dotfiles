#!/usr/bin/env bash
# Link this repository's configuration for the current user (macOS/Linux).
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
target="$config_dir/nvim"
source_dir="$repo_dir/nvim"

mkdir -p "$config_dir"
if [[ -L "$target" && "$(readlink "$target")" == "$source_dir" ]]; then
  printf 'Neovim is already linked: %s\n' "$target"
  exit 0
fi

if [[ -e "$target" || -L "$target" ]]; then
  backup="${target}.backup-dotfiles-$(date +%Y%m%d-%H%M%S)-$$"
  mv "$target" "$backup"
  printf 'Backup saved to: %s\n' "$backup"
fi

ln -s "$source_dir" "$target"
printf 'Neovim linked: %s -> %s\n' "$target" "$source_dir"
printf 'Open nvim and run :Lazy restore to install the recorded plugin versions.\n'
