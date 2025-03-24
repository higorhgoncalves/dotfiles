-- Indent Opts
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Line Numbers Opts
vim.opt.number = true

-- Clipboard Opts
vim.opt.clipboard = "unnamedplus"

-- Folding Opts
vim.opt.foldenable = true
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
