-- Indent Opts
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.cmd("inoremap <S-Tab> <C-d>")

-- Line Numbers Opts
vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.o.statuscolumn = "%l\\ %r"

-- Clipboard Opts
vim.opt.clipboard = "unnamedplus"
-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }

-- Navigate vim panes better
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Navigate to the left pane" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Navigate to the bottom pane" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Navigate to the top pane" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Navigate to the right pane" })

-- Other keymaps
vim.keymap.set("n", "<M-r>", ":set rnu! rnu?<CR>", { desc = "Toggle relative line numbers" })
vim.keymap.set("n", "<leader>di", "gg=G", { desc = "Document Auto Indent" })
vim.keymap.set("n", "<leader>dca", ":let @+ = expand('%:p')<CR>", { desc = "Document Clipboard Absolute Path" })
vim.keymap.set("n", "<leader>dcr", ":let @+ = expand('%:.')<CR>", { desc = "Document Clipboard Relative Path" })
vim.keymap.set("n", "<leader>dcf", ":let @+ = expand('%:t')<CR>", { desc = "Document Clipboard Filename" })
vim.keymap.set("n", "<leader>dcp", ":let @+ = expand('%')<CR>", { desc = "Document Clipboard Path" })

-- Folding Opts
vim.opt.foldenable = true
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Fix Insert Indent
vim.keymap.set("n", "i", function()
	return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })
