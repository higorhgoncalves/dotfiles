vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
-- vim.cmd("set number relativenumber")
-- vim.o.statuscolumn = "%l\\ %r"
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- Navigate vim panes better
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<M-r>', ':set rnu! rnu?<CR>')
