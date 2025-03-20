local M = {}

function M.init()
    vim.g.mapleader = " "  -- Set leader to space

    -- Keymaps
    vim.keymap.set("n", "<M-r>", ":set rnu! rnu?<CR>", { desc = "Toggle relative line numbers" })
    vim.keymap.set("n", "<leader>Ca", ":let @+ = expand('%:p')<CR>", { desc = "Copy Absolute Path" })
    vim.keymap.set("n", "<leader>Cr", ":let @+ = expand('%')<CR>", { desc = "Copy Relative Path" })
    vim.keymap.set("n", "<leader>Cn", ":let @+ = expand('%:t')<CR>", { desc = "Copy Filename" })
    vim.keymap.set('n', '<leader>Cw', ":let @+ = fnamemodify(getcwd(), ':t') . '/' . expand('%:.')<CR>", { desc = 'Clipboard Workspace Relative Path' })
end

return M
