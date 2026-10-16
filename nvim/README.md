# LazyVim + Kotlin + Go

Based on the official LazyVim starter, with the habamax theme and transparent.nvim.

## Files

- `lua/plugins/custom.lua`: theme, transparency, and the official Kotlin LSP.
- `lua/config/options.lua`: personal options; whitespace markers are disabled.
- `lua/config/keymaps.lua`: personal keymaps.
- `lazy-lock.json`: installed plugin versions.
- `shortcuts.html`: searchable, printable keyboard shortcut guide.
- `scripts/install-kotlin.lua`: Kotlin LSP installer with a workaround for the
  registry's direct CDN URL, which returned HTTP 404 during installation.

Review the `lang.kotlin` extra before enabling it: it currently uses the older
`kotlin_language_server`. This setup uses JetBrains' official `kotlin_lsp`,
already installed through Mason, without running a second Kotlin server.
Completion uses LazyVim's default blink.cmp, replacing the previous nvim-cmp setup.

## Getting started

```sh
cd /path/to/project
nvim .
```

The leader key is **Space**. Press it and wait to see available shortcuts.
Most shortcuts below are used in normal mode; press Escape to return to it.

| Shortcut | Action |
| --- | --- |
| Space e | File explorer |
| Space Space | Find files |
| Space / | Search project text |
| Space , | Find open buffers |
| Shift+h / Shift+l | Previous / next buffer |
| Space bd | Close buffer |
| Space gg | Git interface (lazygit) |
| Space ft | Project terminal |
| gd | Go to definition |
| gr | References |
| K | Documentation |
| Space cr | Rename symbol |
| Space ca | Code actions |
| Space cf | Format |
| Space ut | Toggle transparency |
| Space cm | Mason |
| Space l | Lazy |

`:wq` saves and closes the window; `:q!` closes without saving.
More shortcuts: https://www.lazyvim.org/keymaps

Transparency uses your terminal's background. Floating windows retain their
background for readability. Select a Nerd Font in your terminal preferences if
icons appear as squares. The setup does not change terminal fonts or opacity.
Indent guides and whitespace markers are disabled by default.

## Markdown

The official `lang.markdown` extra provides:

- In-editor rendering with render-markdown.nvim: toggle with `Space um`.
- Live browser preview: `Space cp` or `:MarkdownPreviewToggle`.
- `:MarkdownPreviewStop` to stop the preview.
- Markdown navigation and diagnostics through Marksman.
- markdownlint-cli2 and markdown-toc installed through Mason.

Open a `.md` file to use these features. The line being edited may show raw
Markdown in insert mode; this is expected. Rendering does not change the file's
contents. The browser preview has its own styling, not the terminal background.

Validated: enabled rendering, Marksman connection, and an HTTP response from
the preview server. The automated test did not open a browser window.

## Go

Enabled extras: `lang.go`, `dap.core`, and `test.core`.
Go was already installed (1.27.1). Mason tools include `gopls`, `goimports`,
`gofumpt`, `delve`, and `golangci-lint`.

Open the module root with `nvim .`. For a new project, first run:

```sh
go mod init example.com/my-project
```

gopls provides completion, navigation, diagnostics, and code actions. goimports
organizes imports and gofumpt formats code. LazyVim also formats on save;
toggle this with `Space uf`.

| Shortcut | Action |
| --- | --- |
| Space cf | Format and organize imports |
| Space ca | Code actions |
| Space cr | Rename symbol |
| Space tr | Run nearest test |
| Space tt | Run tests in the current file |
| Space tT | Run tests in the current directory |
| Space ts | Test summary panel |
| Space to | Test output |
| Space db | Toggle breakpoint |
| Space dc | Start / continue debugging; select a Go configuration |
| Space dO | Step over |
| Space di | Step into |
| Space dt | Terminate debugging |
| Space du | Debugger panel |
| Space td | Debug nearest test |

Validated in a temporary module: gopls initialization, Go parsers, formatting,
Delve adapter configuration, `go test`, `go vet`, golangci-lint, and a test run
through Neotest. An interactive debug session and a real user project were not
tested. No shell profiles were changed.

## Kotlin

The LSP starts in projects containing settings.gradle(.kts), build.gradle(.kts),
pom.xml, or workspace.json. The server includes a Java runtime. Compiling or
importing projects may still require JAVA_HOME pointing to a JDK compatible
with the project and Gradle version. No shell profiles were changed.

Validated: official LSP initialization in a test root, habamax loading,
background transparency, and Kotlin parser installation. Building a real user
project was not tested.

To reinstall the server if removed:

```sh
nvim --headless '+luafile ~/.config/nvim/scripts/install-kotlin.lua'
```

## Local migration backups

These backups exist only on the original machine, not in this repository:

- Before LazyVim: `~/.config/nvim.backup-20261015-225455`
- Before Go support: `~/.config/nvim.backup-go-20261015-230057`

The data directory was reused to preserve the Kotlin server and its runtime.
Shared plugins were synchronized to LazyVim's versions. The configuration
backup includes the old lockfile, but not a copy of the data directory.

To restore the pre-LazyVim configuration, close Neovim and run:

```sh
mv ~/.config/nvim ~/.config/nvim.lazyvim-saved-$(date +%Y%m%d-%H%M%S)
cp -R ~/.config/nvim.backup-20261015-225455 ~/.config/nvim
nvim --headless '+Lazy! restore' +qa
```

This replaces the active configuration link with a standalone configuration
and restores its recorded plugin versions; the dotfiles repository remains intact.
