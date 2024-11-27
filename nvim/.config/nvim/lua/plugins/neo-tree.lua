return {
  "nvim-neo-tree/neo-tree.nvim",
  -- branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = 'Neotree',
  keys = {
    { '<C-b>', ':Neotree toggle<CR>', desc = '[B]rowse', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<C-b>'] = {'close_window'},
        },
      },
    },
  },
}
