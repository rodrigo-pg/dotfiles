# Helix: Go and Kotlin

Language configuration for Helix 25.07.1, reusing Neovim's Mason tools without
changing the shell PATH or installing duplicate language servers.
The editor's default theme and keybindings are unchanged.

## Setup

Run `./install.sh` from the repository root. It links this directory to
`${XDG_CONFIG_HOME:-$HOME/.config}/helix`, backing up any existing configuration.

Install Helix and Go separately. These Mason executables must also exist:

```text
${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/bin/gopls
${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/bin/intellij-server
${XDG_DATA_HOME:-$HOME/.local/share}/nvim/mason/bin/dlv
```

They are already installed on the original machine. On another computer,
install `gopls` and `delve` through Neovim's `:Mason`, and install the official
Kotlin server with:

```sh
nvim --headless '+luafile ~/.config/nvim/scripts/install-kotlin.lua'
```

The configuration uses `sh` only to expand the current user's data directory
and then `exec` the tools. No user-specific absolute paths are stored.
Accordingly, `hx --health` displays `/bin/sh` as the server/debugger command;
that alone does not verify the underlying Mason executable. Check those tools
if the language server fails to start. This setup targets macOS/Linux.

## Go

Open a module or workspace:

```sh
cd /path/to/go-project
hx .
```

- gopls provides completion, diagnostics, navigation, and code actions.
- Formatting on save uses gopls with gofumpt enabled.
- Use code actions to organize imports.
- Go module, workspace, and template files also use gopls.
- Only gopls is enabled; Helix's optional golangci-lint language server is not
  required or installed by this configuration.
- Delve is configured with source, binary, test, and attach templates.
  Helix's debugger support is experimental; no interactive debug session was
  validated during setup.

## Kotlin

The server is JetBrains' official Kotlin LSP (`intellij-server --stdio`), not
the older fwcd server. Root markers cover Gradle, Maven, and workspace.json.
The request timeout is 120 seconds to allow for initial project import.

```sh
cd /path/to/kotlin-project
hx src/main/kotlin/Main.kt
```

Formatting on save uses the language server. Wait for project import/indexing
before relying on completion and diagnostics. The server includes a runtime,
but importing/building projects can require JAVA_HOME pointing to a compatible
JDK. Kotlin LSP is still alpha and project support has limitations.

## Useful default shortcuts

Use these in normal mode (press Escape first). Helix uses selection-first
editing, so its commands differ from Vim/Neovim.

| Shortcut | Action |
| --- | --- |
| Space f | File picker |
| gd | Go to definition |
| gr | Go to references |
| Space k | Hover documentation |
| Space r | Rename symbol |
| Space a | Code actions, including organize imports when available |
| = | Format selection |
| :format | Format the document |
| :write | Save and autoformat |
| :lsp-restart | Restart language servers for the current document |
| :log-open | Open the Helix log |

Run `hx --tutor` for the built-in tutorial.

## Validation

- `hx --health go`, `hx --health gomod`, and `hx --health kotlin` parse the
  configuration and find the configured launcher.
- Real Helix sessions completed LSP initialization with both gopls and the
  official Kotlin server in temporary projects.
- Go and Kotlin syntax parsers/queries are included with the installed Helix.
- An interactive debug session and full import/build of a real Kotlin project
  were not tested.
