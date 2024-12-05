return {
  "christoomey/vim-tmux-navigator",
  vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>', { desc = 'Navigate to the left pane' }),
  vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>', { desc = 'Navigate to the bottom pane' }),
  vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>', { desc = 'Navigate to the top pane' }),
  vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>', { desc = 'Navigate to the right pane' }),
}
