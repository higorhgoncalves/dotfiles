return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 1, 0 } },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = { 1, 0 } },
				{ section = "keys" },
				{ section = "startup" },
			},
			preset = {
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":Telescope find_files file_encoding=latin1",
					},
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = "󰙅 ", key = "e", desc = "Explore Files", action = ":lua MiniFiles.open()" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":Telescope live_grep file_encoding=latin1",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":Telescope oldfiles file_encoding=latin1",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua require('telescope.builtin').find_files {cwd = vim.fn.stdpath('config')}",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		dim = { enabled = true },
		git = { enabled = true },
		input = { enabled = true },
		indent = {
			enabled = true,
			indent = {
				char = "▏",
				hl = {
					"SnacksIndent1",
					"SnacksIndent2",
					"SnacksIndent3",
					"SnacksIndent4",
					"SnacksIndent5",
					"SnacksIndent6",
					"SnacksIndent7",
					"SnacksIndent8",
				},
			},
			scope = {
				enabled = false, -- enable highlighting the current scope
			},
		},
		lazygit = { enabled = true },
		notifier = { enabled = true, timeout = 3000, style = "fancy" },
		scratch = {
			enabled = true,
			ft = function()
				if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
					return vim.bo.filetype
				end
				return "markdown"
			end,
			win = {
				keys = {
					["execute"] = {
						"<cr>",
						function()
							vim.cmd("%SnipRun")
						end,
						desc = "Execute buffer",
						mode = { "n", "x" },
					},
				},
			},
			win_by_ft = {
				lua = {
					keys = {
						["source"] = {
							"<cr>",
							function(self)
								local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
								Snacks.debug.run({ buf = self.buf, name = name })
							end,
							desc = "Source buffer",
							mode = { "n", "x" },
						},
						["execute"] = {
							"e",
							function()
								vim.cmd("%SnipRun")
							end,
							desc = "Execute buffer",
							mode = { "n", "x" },
						},
					},
				},
				php = {
					keys = {
						["execute"] = {
							"<cr>",
							function()
								vim.cmd("%SnipRun")
							end,
							desc = "Execute buffer",
							mode = { "n", "x" },
						},
					},
				},
			},
		},
		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true, -- show open fold icons
				git_hl = true, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50,
		},
		toggle = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>rR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>wh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Open Workspace Notification History",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
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
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>fn",
			function(opts)
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				-- local make_entry = require("telescope.make_entry")
				local previewers = require("telescope.previewers")
				local conf = require("telescope.config").values

				opts = opts or {}
				local notifications = {}
				for k, v in pairs(Snacks.notifier.get_history()) do
					-- table.insert(notifications, v["icon"] .. v["level"] .. ": " .. v["msg"])
					table.insert(
						notifications,
						table.concat({
							v["icon"],
							v["level"],
							": ",
							v["msg"],
						})
					)
					-- for key, values in pairs(v) do
					-- 	Snacks.notify.notify(key)
					-- end
				end

				pickers
					.new(opts, {
						prompt_title = "Notification History",
						finder = finders.new_table({
							results = notifications,
						}),
						sorter = conf.generic_sorter(opts),
						previewer = conf.grep_previewer(opts),
						-- previewer = previewers.new_buffer_previewer({
						-- 	title = "Minha visualização",
						-- 	define_preview = function(self, entry, status)
						-- 		vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "linha 1", "linha 2" })
						-- 	end,
						-- }),
					})
					:find()
			end,
			desc = "Find in Notification History",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})

		-- Ajustar os highlights usando a API Lua
		-- vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#E06C75" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#E5C07B" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#61AFEF" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#D19A66" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#98C379" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#C678DD" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#56B6C2" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#d20f39" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#df8e1d" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#1e66f5" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#fe640b" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#40a02b" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#8839ef" })
		-- vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#209fb5" })
	end,
}
