return {
	{
		"mg979/vim-visual-multi",
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
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true, php = true, lua = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
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
				-- php = {
				-- 	"pretty-php",
				-- 	"pint",
				-- 	"php-cs-fixer",
				-- 	stop_after_first = true,
				-- },
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
