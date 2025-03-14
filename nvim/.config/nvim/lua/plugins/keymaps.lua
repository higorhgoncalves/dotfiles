return {
    -- Other keymaps
    vim.keymap.set("n", "<M-r>", ":set rnu! rnu?<CR>", { desc = "Toggle relative line numbers" }),
    vim.keymap.set("n", "<leader>Fi", "gg=G", { desc = "Format (NVIM)" }),
    vim.keymap.set("n", "<leader>Ca", ":let @+ = expand('%:p')<CR>", { desc = "Clipboard Absolute Path" }),
    vim.keymap.set("n", "<leader>Cr", ":let @+ = expand('%:.')<CR>", { desc = "Clipboard Relative Path" }),
    vim.keymap.set("n", "<leader>Cf", ":let @+ = expand('%:t')<CR>", { desc = "Clipboard Filename" }),
    vim.keymap.set("n", "<leader>Cp", ":let @+ = expand('%')<CR>", { desc = "Clipboard Path" }),
}
