return {
  {
    "folke/snacks.nvim",
    opts = { indent = { enabled = false } },
  },
  -- Preservar o tema usado na configuração anterior.
  { "LazyVim/LazyVim", opts = { colorscheme = "habamax" } },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = { "TabLineFill", "BufferLineFill", "SnacksNormal", "SnacksNormalNC" },
    },
    config = function(_, opts)
      require("transparent").setup(opts)
      require("transparent").clear_prefix("BufferLine")
      require("transparent").clear_prefix("lualine")
    end,
    keys = {
      { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "Alternar transparência" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Não usar o antigo servidor fwcd do extra lang.kotlin.
        kotlin_language_server = { enabled = false },
        -- Já instalado pelo Mason, com runtime Java integrado.
        kotlin_lsp = { mason = false },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
}
