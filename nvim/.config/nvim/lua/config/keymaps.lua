local M = {}

function M.setup()
    -- Keymaps
    vim.keymap.set("n", "<M-r>", ":set rnu! rnu?<CR>", { desc = "Toggle relative line numbers" })
    vim.keymap.set("n", "<leader>Ca", ":let @+ = expand('%:p')<CR>", { desc = "Copy Absolute Path" })
    vim.keymap.set("n", "<leader>Cr", ":let @+ = expand('%')<CR>", { desc = "Copy Relative Path" })
    vim.keymap.set("n", "<leader>Cn", ":let @+ = expand('%:t')<CR>", { desc = "Copy Filename" })
    vim.keymap.set('n', '<leader>Cw', ":let @+ = fnamemodify(getcwd(), ':t') . '/' . expand('%:.')<CR>",
        { desc = 'Clipboard Workspace Relative Path' })

    -- Navigate vim panes better
    vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Navigate to the left pane" })
    vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Navigate to the bottom pane" })
    vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Navigate to the top pane" })
    vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Navigate to the right pane" })
end

return M
