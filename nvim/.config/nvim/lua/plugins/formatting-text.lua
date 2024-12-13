return {
	-- { -- Add indentation guides even on blank lines
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- 	-- See `:help ibl`
	-- 	main = "ibl",
	-- 	opts = {},
	-- },
	{
		"mg979/vim-visual-multi",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
}
