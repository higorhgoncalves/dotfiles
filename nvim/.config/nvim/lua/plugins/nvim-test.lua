return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { desc = "Run test nearest" }),
	vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { desc = "Run test file" }),
	vim.keymap.set("n", "<leader>a", ":TestSuit<CR>", { desc = "Run test suit" }),
	vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { desc = "Run last test" }),
	vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", { desc = "Visit test file" }),
	vim.cmd("let test#strategy = 'vimux'"),
}
