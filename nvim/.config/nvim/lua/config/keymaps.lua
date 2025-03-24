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

    -- Fix Insert Indent
    vim.keymap.set("n", "i", function()
        return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
    end, { expr = true })

    vim.keymap.set("i", "<S-Tab>", "<C-d>")
    vim.keymap.set("v", "<TAB>", ">gv")
    vim.keymap.set("v", "<S-TAB>", "<gv")

    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    vim.keymap.set("x", "<leader>p", [["_dP]])

    ---@diagnostic disable-next-line: undefined-field
    if not vim.tbl_contains(vim.opt.clipboard:get(), "unnamedplus") then
        vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
        vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })
    end

    vim.keymap.set("n", "Q", "<nop>")
    -- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
    -- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
    -- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
    -- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

    vim.keymap.set("n", "<leader>cs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        { desc = "Change word under cursor" })
end

return M
