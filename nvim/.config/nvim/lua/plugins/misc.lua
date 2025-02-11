return {
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>du", ":UndotreeToggle<CR>:UndotreeFocus<CR>", { desc = "Toggle undotree" })
		end,
	},
}
