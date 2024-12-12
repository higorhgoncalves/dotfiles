return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- bigfile = { enabled = true },
		notifier = { enabled = true, timeout = 3000, style = "fancy" },
		input = {
			enabled = true,
			backdrop = false,
			position = "float",
			border = "rounded",
			title_pos = "center",
			height = 1,
			width = 60,
			relative = "editor",
			row = 2,
			-- relative = "cursor",
			-- row = -3,
			-- col = 0,
			wo = {
				winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
				cursorline = false,
			},
			bo = { filetype = "snacks_input" },
			keys = {
				i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i" },
				-- i_esc = { "<esc>", "stopinsert", mode = "i" },
				i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i" },
				i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i" },
				q = "cancel",
			},
		},
		-- quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
		lazygit = { enabled = true },
	},
	keys = {
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
	},
}
