return {
  -- the colorscheme should be available when starting Neovim
  {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          alpha = true,
          dashboard = true,
          neotree = true,
          telescope = true,
          treesitter = true,
          mason = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          treesitter_context = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
