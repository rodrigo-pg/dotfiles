# Dotfiles

Personal configuration files for Neovim and Helix. Additional tools can
be added in their own directories. Never include credentials or other secrets.

## Structure

```text
nvim/        LazyVim, Go, Kotlin, Markdown, theme, and keyboard shortcuts
helix/       Helix Go and official Kotlin LSP integration using Mason tools
install.sh   Links both configurations and backs up any existing setup
```

`~/.config/nvim` and `~/.config/helix` link to the corresponding directories
in this repository. Configuration edits, including Neovim lockfile updates,
are written directly here. Update the links if you move the repository.

## Install on another computer (macOS/Linux)

```sh
git clone https://github.com/rodrigo-pg/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
./install.sh
nvim
```

In Neovim, run `:Lazy restore` to install the versions in `lazy-lock.json`.

Requirements: Neovim >= 0.11.2 with LuaJIT, Git, curl, unzip, ripgrep, fd, fzf,
lazygit, Node.js/npm, a C compiler, and the tree-sitter CLI. Install Go for Go
development. Kotlin projects may require a compatible JDK. A Nerd Font is
recommended for icons.

Mason installs tools as the corresponding features load. The Kotlin LSP uses a
helper script because the registry's direct CDN URL returned HTTP 404 during
setup:

```sh
nvim --headless '+luafile ~/.config/nvim/scripts/install-kotlin.lua'
```

Adjust this path if you use a custom `XDG_CONFIG_HOME`. Configure the terminal
font and opacity separately. Enable Neovim transparency with `:TransparentEnable`.

The installer backs up an existing configuration before replacing it. It does
not install dependencies or change shell profiles. Plugins, language servers,
caches, and editing history are not tracked; install tools on the destination
machine. On Windows, place the configuration in `%LOCALAPPDATA%\nvim` instead;
the shell installer targets macOS/Linux only.

## Everyday use

```sh
cd ~/projects/dotfiles
git status
git diff
git add .
git commit -m "Update configuration"
git push
```

Configure your Git identity on a new computer if needed:

```sh
git config user.name "Your Name"
git config user.email "you@example.com"
```

These commands set the identity only for this repository. The repository is
public: review changes before pushing. Temporary backups and common secret
file patterns are ignored, but this does not replace a manual review.

## Keyboard shortcuts

Open [the shortcut guide](nvim/shortcuts.html) in a browser. On macOS:

```sh
open ~/.config/nvim/shortcuts.html
```

See [the Neovim README](nvim/README.md) for language support and setup details.

## Helix

Install Helix separately (`brew install helix` on macOS), then run `hx .` in a
project. Its Go and Kotlin integration reuses the Mason-installed servers, so
install those tools through the Neovim setup first. No shell PATH changes are
needed. See [the Helix README](helix/README.md) for details and shortcuts.
