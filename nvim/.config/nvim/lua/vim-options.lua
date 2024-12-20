vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set nowrap")
vim.cmd("inoremap <S-Tab> <C-d>")

vim.cmd("set number")
-- vim.cmd("set number relativenumber")
-- vim.o.statuscolumn = "%l\\ %r"
vim.g.mapleader = " "
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
vim.keymap.set("n", "<leader>di", "gg=G", { desc = "Document Auto Indent" })
vim.keymap.set("n", "<leader>dca", ":let @+ = expand('%:p')<CR>", { desc = "Document Clipboard Absolute Path" })
vim.keymap.set("n", "<leader>dcr", ":let @+ = expand('%:.')<CR>", { desc = "Document Clipboard Relative Path" })
vim.keymap.set("n", "<leader>dcf", ":let @+ = expand('%:t')<CR>", { desc = "Document Clipboard Filename" })
vim.keymap.set("n", "<leader>dcp", ":let @+ = expand('%')<CR>", { desc = "Document Clipboard Path" })
vim.keymap.set("n", "<M-r>", ":set rnu! rnu?<CR>", { desc = "Toggle relative line numbers" })
