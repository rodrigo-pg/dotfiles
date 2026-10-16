# LazyVim + Kotlin + Go

Migrado para o starter oficial do LazyVim, preservando habamax e transparent.nvim.

## Arquivos

- `lua/plugins/custom.lua`: tema, transparência e Kotlin LSP oficial.
- `lua/config/options.lua`: opções pessoais.
- `lua/config/keymaps.lua`: atalhos pessoais.
- `lazy-lock.json`: versões instaladas dos plugins.
- `scripts/install-kotlin.lua`: instalador auxiliar do Kotlin LSP, contornando
  o URL direto do CDN do Mason que retornava 404 no momento da instalação.

Não habilite o extra `lang.kotlin` sem revisar: atualmente ele usa o antigo
`kotlin_language_server`. Aqui usamos `kotlin_lsp` da JetBrains, já instalado
pelo Mason, sem instalar um segundo servidor. O autocomplete é o blink.cmp
padrão do LazyVim, substituindo o nvim-cmp da configuração anterior.

## Começar

```sh
cd /caminho/do/projeto
nvim .
```

O líder é Espaço. Pressione Espaço e aguarde para ver os atalhos disponíveis.

| Atalho | Ação |
| --- | --- |
| Espaço e | Explorador de arquivos |
| Espaço Espaço | Buscar arquivo |
| Espaço / | Buscar texto no projeto |
| Espaço , | Buscar buffers abertos |
| Shift+h / Shift+l | Buffer anterior/próximo |
| Espaço bd | Fechar buffer |
| Espaço gg | Interface Git (lazygit) |
| Espaço ft | Terminal do projeto |
| gd | Definição |
| gr | Referências |
| K | Documentação |
| Espaço cr | Renomear símbolo |
| Espaço ca | Ações de código |
| Espaço cf | Formatar |
| Espaço ut | Alternar transparência |
| Espaço cm | Mason |
| Espaço l | Lazy |

`:wq` salva e sai; `:q!` sai sem salvar. Há mais atalhos em:
https://www.lazyvim.org/keymaps

O fundo continua sendo o do seu terminal. Janelas flutuantes mantêm o fundo
para legibilidade. Se os ícones aparecerem como quadrados, selecione uma Nerd
Font nas preferências do terminal; nenhuma fonte do terminal foi alterada.

## Markdown

Extra oficial `lang.markdown` habilitado:

- Renderização no editor com render-markdown.nvim: `Espaço um` alterna.
- Preview ao vivo no navegador: `Espaço cp` ou `:MarkdownPreviewToggle`.
- `:MarkdownPreviewStop` encerra o preview.
- Marksman fornece navegação/diagnósticos de Markdown.
- markdownlint-cli2 e markdown-toc instalados via Mason.

Abra um arquivo `.md` para usar. No modo de inserção, a linha sob edição pode
mostrar a sintaxe original; isso é esperado. A renderização é apenas visual,
sem alterar o conteúdo do arquivo. O preview no navegador usa o estilo próprio,
não o fundo transparente do terminal.

Validados: renderização habilitada, conexão com Marksman e resposta HTTP do
servidor de preview. O navegador não foi aberto durante o teste automatizado.

## Go

Habilitados os extras oficiais `lang.go`, `dap.core` e `test.core`.
O Go já estava instalado (1.27.1). Ferramentas disponíveis via Mason:
`gopls`, `goimports`, `gofumpt`, `delve` e `golangci-lint`.

Abra a raiz do módulo:

```sh
cd /caminho/do/projeto
nvim .
```

Para um projeto novo, execute `go mod init exemplo.com/meu-projeto` antes.
O gopls fornece autocomplete, navegação, diagnósticos e ações de código.
Goimports organiza imports e gofumpt formata o código; o LazyVim também
formata ao salvar (alternável em Espaço uf).

| Atalho | Ação |
| --- | --- |
| Espaço cf | Formatar/organizar imports |
| Espaço ca | Ações de código |
| Espaço cr | Renomear símbolo |
| Espaço tr | Rodar teste mais próximo |
| Espaço tt | Rodar testes do arquivo |
| Espaço tT | Rodar testes do diretório atual |
| Espaço ts | Painel de testes |
| Espaço to | Saída do teste |
| Espaço db | Alternar breakpoint |
| Espaço dc | Iniciar/continuar debug; selecionar a configuração Go |
| Espaço dO | Step over |
| Espaço di | Step into |
| Espaço dt | Encerrar debug |
| Espaço du | Painel do debugger |
| Espaço td | Debug do teste mais próximo |

Validação: gopls inicializado, parsers Go instalados, formatação funcionando,
adapter Delve configurado, `go test`, `go vet`, golangci-lint e teste executado
pelo Neotest passaram em módulo temporário. Não foi executada uma sessão de
debug interativa nem validado um projeto real do usuário.

Backup anterior à configuração de Go:
`~/.config/nvim.backup-go-20261015-230057`.
Nenhum perfil de shell foi modificado.

## Kotlin

O LSP inicia dentro de projetos com settings.gradle(.kts), build.gradle(.kts),
pom.xml ou workspace.json. O runtime do servidor vem integrado. Para compilar
ou importar projetos reais, ainda pode ser necessário configurar JAVA_HOME
com um JDK compatível com o projeto/Gradle. Nenhum perfil de shell foi alterado.

Validação realizada: inicialização do LSP oficial em uma raiz de teste,
carregamento do tema habamax, remoção do background e instalação do parser Kotlin.
Não foi validada a compilação de um projeto real do usuário.

Para reinstalar o servidor caso seja removido:

```sh
nvim --headless '+luafile ~/.config/nvim/scripts/install-kotlin.lua'
```

## Backup e restauração

Configuração anterior completa:
`~/.config/nvim.backup-20261015-225455`

A pasta de dados foi reutilizada para preservar o servidor Kotlin e seu runtime.
Os plugins compartilhados foram sincronizados com as versões do LazyVim;
o backup inclui o lockfile anterior, mas não uma cópia da pasta de dados.

Para restaurar, feche todas as instâncias do Neovim e execute:

```sh
mv ~/.config/nvim ~/.config/nvim.lazyvim-saved-$(date +%Y%m%d-%H%M%S)
cp -R ~/.config/nvim.backup-20261015-225455 ~/.config/nvim
nvim --headless '+Lazy! restore' +qa
```

Isso restaura a configuração e as versões anteriores dos plugins.
