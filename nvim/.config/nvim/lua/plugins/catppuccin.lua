return {
  -- the colorscheme should be available when starting Neovim
  {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          treesitter = true,
        }
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
