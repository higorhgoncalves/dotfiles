return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- File browser
		--
		-- - <leader>mf - open file browser
		require("mini.files").setup()

		-- Split and join lines
		--
		-- - gS - [G]split lines
		require("mini.splitjoin").setup({
			mappings = {
				toggle = "",
			},
		})
		vim.keymap.set("n", "<leader>ds", ":lua MiniSplitjoin.toggle()<cr>", { desc = "Document Split/Join lines" })

		-- Sessions
		-- Save and restore your editing sessions
		-- - :mksession - save session
		require("mini.sessions").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		-- local statusline = require("mini.statusline")

		-- set use_icons to true if you have a Nerd Font
		-- statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- 	return "%2l:%-2v"
		-- end

		-- Keybindings
		vim.keymap.set("n", "<leader>wb", ":lua MiniFiles.open()<CR>", { desc = "Open Workspace File Browser" })
		vim.keymap.set("n", "<leader>wf", function()
			local MiniFiles = require("mini.files")
			local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			vim.defer_fn(function()
				MiniFiles.reveal_cwd()
			end, 30)
		end, { desc = "Open Workspace File Browser in CWD" })

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
