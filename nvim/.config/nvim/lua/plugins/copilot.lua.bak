return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept()", { expr = true, silent = true, noremap = false })
			vim.g.copilot_workspace_folders = {
				"~/docker-lw/html/legisweb",
				"~/docker-lw/html/classes",
			}
			-- <M-]> next suggestion
			-- <M-[> previous suggestion
			-- <C-]> dismiss suggestion
			-- <C-l> accept suggestion
			-- <M-Right> accept next word of the current suggestion
			-- <M-C-Right> accept next line of the next suggestion
			-- <M-\> open suggestion
		end,
	},
}
