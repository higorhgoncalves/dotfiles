return {
	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_set_default_mappings = 0 -- Disable default keybinds
		end,
		config = function()
			-- Delete lingering default keybinds
			vim.keymap.del("n", "<C-Up>")
			vim.keymap.del("n", "<C-Down>")
			vim.keymap.del({ "n", "x" }, "<C-n>")

			-- Normal mode mappings
			vim.keymap.set("n", "<M-n>", "<Plug>(VM-Find-Under)")
			vim.keymap.set("n", "<M-Up>", "<Plug>(VM-Add-Cursor-Up)")
			vim.keymap.set("n", "<M-Down>", "<Plug>(VM-Add-Cursor-Down)")

			-- Visual mode mappings
			vim.keymap.set("x", "<M-n>", "<Plug>(VM-Find-Under)")

			-- Your custom keymaps
			vim.keymap.set("n", "<leader>mc", "<Plug>(VM-Find-Under)", { desc = "Multi-Cursor" })
			vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)", { desc = "Select All Occurrences" })
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>dff",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Document Auto Format (Formatter)",
			},
		},
		-- optional = true,
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				html = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				css = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				javascript = {
					"prettierd",
					"prettier",
					stop_after_first = true,
				},
				json = {
					"prettier",
					stop_after_first = true,
				},
				sql = {
					"sqlfmt",
				},
				blade = {
					"blade-formatter",
                    "rustywind",
				},
				php = {
					"pretty-php",
					"pint",
					"php-cs-fixer",
					stop_after_first = true,
				},
			},
			formatters = {
				prettierd = {
					prepend_args = function(self, ctx)
						return { "-i", "4" }
					end,
				},
				prettier = {
					append_args = { "--tab-width", "4" },
				},
			},
		},
	},
}
