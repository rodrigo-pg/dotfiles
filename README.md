# Dotfiles

Repositório de configurações pessoais. Atualmente inclui o Neovim; outras
configurações podem ser adicionadas em pastas próprias, sem copiar segredos.

## Estrutura

```text
nvim/        Configuração LazyVim, Go, Kotlin, Markdown, tema e atalhos
install.sh   Cria o link da configuração, preservando backup da anterior
```

`~/.config/nvim` aponta para `nvim/` deste repositório. Alterações feitas pelo
Neovim, inclusive no lockfile, ficam diretamente aqui. Não mova ou apague o
repositório sem atualizar o link.

## Instalar em outro computador (macOS/Linux)

Depois de transferir ou clonar o repositório:

```sh
cd /caminho/do/dotfiles
./install.sh
nvim
```

No Neovim, execute `:Lazy restore` para instalar as versões do `lazy-lock.json`.
Requisitos: Neovim >= 0.11.2 com LuaJIT, Git, curl, unzip, ripgrep, fd, fzf,
lazygit, Node.js/npm, compilador C e tree-sitter CLI. Go precisa estar instalado
para desenvolver em Go. Projetos Kotlin podem exigir um JDK compatível.
Nerd Font é recomendada para os ícones.

As ferramentas são instaladas pelo Mason ao carregar os recursos correspondentes.
O Kotlin LSP usa o instalador auxiliar, pois seu URL no catálogo retornava 404:

```sh
nvim --headless '+luafile ~/.config/nvim/scripts/install-kotlin.lua'
```

Se usar XDG_CONFIG_HOME personalizado, ajuste esse caminho.
A fonte e a opacidade do terminal são configuradas separadamente.
Ative a transparência no Neovim com `:TransparentEnable`.

O instalador cria backups antes de substituir uma configuração existente e não
instala dependências nem altera perfis de shell. Plugins, caches, servidores e
histórico do Neovim não são versionados; são baixados na máquina de destino.
No Windows, a configuração deve ser colocada em `%LOCALAPPDATA%\nvim`;
o instalador shell não é destinado ao Windows.

## Uso diário

```sh
cd ~/projects/dotfiles
git status
git diff
git add .
git commit -m "Atualiza configurações"
```

Antes do primeiro commit, configure sua identidade Git se necessário:

```sh
git config user.name "Seu Nome"
git config user.email "seu-email"
```

Os comandos acima configuram a identidade somente neste repositório.
Para sincronizar entre computadores, crie um repositório remoto e adicione-o:

```sh
git remote add origin URL_DO_REPOSITORIO
git push -u origin main
```

Nenhum remoto foi criado nem dados foram publicados automaticamente. Revise os
arquivos antes de publicar. Backups temporários e arquivos comuns de segredos
são ignorados, mas isso não substitui uma revisão manual.

## Guia de atalhos

Abra `nvim/atalhos.html` no navegador (no Mac: `open ~/.config/nvim/atalhos.html`).
Mais instruções específicas em `nvim/README.md`.
