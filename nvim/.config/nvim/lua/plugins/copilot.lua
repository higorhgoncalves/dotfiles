return {
	-- {
	-- 	"github/copilot.vim",
	-- 	config = function()
	-- 		vim.g.copilot_no_tab_map = true
	-- 		vim.g.copilot_workspace_folders = {
	-- 			"~/docker-lw/html/legisweb",
	-- 			"~/docker-lw/html/classes",
	-- 		}
	--
	-- 		vim.api.nvim_set_keymap("i", "<M-l>", "copilot#Accept()", { expr = true, silent = true, noremap = false })
	-- 		-- <M-l> accept suggestion
	-- 		-- <M-]> next suggestion
	-- 		-- <M-[> previous suggestion
	-- 		-- <C-]> dismiss suggestion
	-- 		-- <M-Right> accept next word of the current suggestion
	-- 		-- <M-C-Right> accept next line of the next suggestion
	-- 		-- <M-\> open suggestion
	-- 	end,
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept = "<M-l>",
						accept_word = "<M-Right>",
						accept_line = "<M-C-Right>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				-- copilot_model = "gpt-4o-copilot",
				server_opts_overrides = {
					offset_encoding = "utf-8" -- Set the offset encoding same as above, see `:h vim.lsp.start` for more info
				},
				workspace_folders = {
					"/home/administrador/docker-lw/html/legisweb",
					"/home/administrador/docker-lw/html/classes",
				},
			})

		end,
	}
}
