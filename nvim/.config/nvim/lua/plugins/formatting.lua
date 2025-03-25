return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>Ff",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format (Formatter)",
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
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
