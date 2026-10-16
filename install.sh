#!/usr/bin/env bash
# Conecta as configurações do repositório ao usuário atual (macOS/Linux).
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
target="$config_dir/nvim"
source_dir="$repo_dir/nvim"

mkdir -p "$config_dir"
if [[ -L "$target" && "$(readlink "$target")" == "$source_dir" ]]; then
  printf 'Neovim já está conectado: %s\n' "$target"
  exit 0
fi

if [[ -e "$target" || -L "$target" ]]; then
  backup="${target}.backup-dotfiles-$(date +%Y%m%d-%H%M%S)-$$"
  mv "$target" "$backup"
  printf 'Backup preservado em: %s\n' "$backup"
fi

ln -s "$source_dir" "$target"
printf 'Neovim conectado: %s -> %s\n' "$target" "$source_dir"
printf 'Abra nvim e execute :Lazy restore para instalar as versões registradas.\n'
