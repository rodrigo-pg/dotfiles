return {
  {
    "folke/snacks.nvim",
    opts = { indent = { enabled = false } },
  },
  -- Keep the theme from the previous configuration.
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
      { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparency" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Do not use the older fwcd server from the lang.kotlin extra.
        kotlin_language_server = { enabled = false },
        -- Already installed through Mason, with a bundled Java runtime.
        kotlin_lsp = { mason = false },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
}
