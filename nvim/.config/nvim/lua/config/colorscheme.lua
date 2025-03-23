return {
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
				integrations = {
					dashboard = true,
					neotree = true,
					telescope = true,
					treesitter = true,
					mason = true,
					blink_cmp = true,
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
