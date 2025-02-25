return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_workspace_folders = {
				"~/docker-lw/html/legisweb",
				"~/docker-lw/html/classes",
			}

			vim.api.nvim_set_keymap("i", "<M-l>", "copilot#Accept()", { expr = true, silent = true, noremap = false })
			-- <M-l> accept suggestion
			-- <M-]> next suggestion
			-- <M-[> previous suggestion
			-- <C-]> dismiss suggestion
			-- <M-Right> accept next word of the current suggestion
			-- <M-C-Right> accept next line of the next suggestion
			-- <M-\> open suggestion
		end,
	},
}
