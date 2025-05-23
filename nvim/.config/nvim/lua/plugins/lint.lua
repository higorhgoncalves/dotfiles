return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				dockerfile = { "hadolint" },
				php = { 'phpcs' },
				sql = { "sqlfluff" },
			}

			local phpcs = require('lint').linters.phpcs
			phpcs.args = {
				'-q',
				-- <- Add a new parameter here
				"--standard=PSR12",
				'--report=json',
				'-'
			}

			-- To allow other plugins to add linters to require('lint').linters_by_ft,
			-- instead set linters_by_ft like this:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }

			-- However, note that this will enable a set of default linters,
			-- which will cause errors unless these tools are available:
			-- {
			--   dockerfile = { "hadolint" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			-- }

			-- You can disable the default linters by setting their filetypes to nil:
			-- lint.linters_by_ft['dockerfile'] = nil
			-- lint.linters_by_ft['json'] = nil
			-- lint.linters_by_ft['markdown'] = nil

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			-- 	group = lint_augroup,
			-- 	callback = function()
			-- 		-- Only run the linter in buffers that you can modify in order to
			-- 		-- avoid superfluous noise, notably within the handy LSP pop-ups that
			-- 		-- describe the hovered symbol using Markdown.
			-- 		if vim.opt_local.modifiable:get() then
			-- 			lint.try_lint()
			-- 		end
			-- 	end,
			-- })

			require("config.modules.toggle-lint")
			vim.keymap.set("n", "<leader>uE", "<CMD>:ToggleLinters<CR>", { noremap = true, silent = true, desc = "Toggle Linters" })
		end,
	},
}
