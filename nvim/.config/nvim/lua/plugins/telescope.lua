return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = '0.1.8',
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{
				"<leader>f/",
				"<cmd>Telescope current_buffer_fuzzy_find file_encoding=latin1<cr>",
				desc = "Find in buffer",
			},
			{ "<leader>ff", "<cmd>Telescope find_files file_encoding=latin1<cr>", desc = "Find find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep file_encoding=latin1<cr>", desc = "Find live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers file_encoding=latin1<cr>", desc = "Find buffers" },
			{ "<leader>fB", "<cmd>Telescope builtin file_encoding=latin1<cr>", desc = "Find built-in pickers" },
			{ "<leader>fk", "<cmd>Telescope keymaps file_encoding=latin1<cr>", desc = "Find keymaps" },
			{
				"<leader>fC",
				"<cmd>Telescope commands file_encoding=latin1<cr>",
				desc = "Find available plugin/user commands",
			},
			{
				"<leader>f:",
				"<cmd>Telescope command_history file_encoding=latin1<cr>",
				desc = "Find commands that were executed recently",
			},
			{ "<leader>fq", "<cmd>Telescope quickfix file_encoding=latin1<cr>", desc = "Find in quickfix list" },
			{ "<leader>fM", "<cmd>Telescope man_pages file_encoding=latin1<cr>", desc = "Find in manpage entries" },
			{ "<leader>fh", "<cmd>Telescope help_tags file_encoding=latin1<cr>", desc = "Find help tags" },
			{
				"<leader>fo",
				"<cmd>Telescope oldfiles file_encoding=latin1<cr>",
				desc = "Find in previously open files",
			},
			-- { "<leader>fn", "<cmd>Telescope notify file_encoding=latin1<cr>", desc = "Find notifications" },
			{ "<leader>fD", "<cmd>Telescope diagnostics file_encoding=latin1<cr>", desc = "Find LSP diagnostics" },
			{
				"<leader>fI",
				"<cmd>Telescope lsp_incoming_calls file_encoding=latin1<cr>",
				desc = "Find LSP incoming calls",
			},
			{
				"<leader>fO",
				"<cmd>Telescope lsp_outgoing_calls file_encoding=latin1<cr>",
				desc = "Find LSP outgoing calls",
			},
			{ "<leader>fd", "<cmd>Telescope lsp_definitions file_encoding=latin1<cr>", desc = "Find LSP definitions" },
			{ "<leader>fr", "<cmd>Telescope lsp_references file_encoding=latin1<cr>", desc = "Find LSP references" },
			{
				"<leader>fi",
				"<cmd>Telescope lsp_implementations file_encoding=latin1<cr>",
				desc = "Find LSP implementations",
			},
			{
				"<leader>ft",
				"<cmd>Telescope lsp_type_definitions file_encoding=latin1<cr>",
				desc = "Find LSP type definitions",
			},
			{
				"<leader>fs",
				"<cmd>Telescope lsp_document_symbols file_encoding=latin1<cr>",
				desc = "Find LSP document symbols",
			},
			{
				"<leader>fw",
				"<cmd>Telescope lsp_workspace_symbols file_encoding=latin1<cr>",
				desc = "Find LSP workspace symbols",
			},
			{
				"<leader>fW",
				"<cmd>Telescope lsp_dynamic_workspace_symbols file_encoding=latin1<cr>",
				desc = "Find LSP dynamic workspace symbols",
			},
			{ "<leader>fGc", "<cmd>Telescope git_commits file_encoding=latin1<cr>", desc = "Find Git Commits" },
			{
				"<leader>fGC",
				"<cmd>Telescope git_bcommits file_encoding=latin1<cr>",
				desc = "Find Git Buffer's Commits",
			},
			{ "<leader>fGb", "<cmd>Telescope git_branches file_encoding=latin1<cr>", desc = "Find Git Branches" },
			{ "<leader>fGs", "<cmd>Telescope git_status file_encoding=latin1<cr>", desc = "Find Git Status" },
			{ "<leader>fGf", "<cmd>Telescope git_files file_encoding=latin1<cr>", desc = "Find Git Files" },
			{ "<leader>fGa", "<cmd>Telescope git_stash file_encoding=latin1<cr>", desc = "Find Git Stash" },
			{
				"<leader>fc",
				'<cmd>lua require("telescope.builtin").find_files { cwd = vim.fn.stdpath("config") }<cr>',
				desc = "Find in config files",
			},
			{
				"<leader>fp",
				'<cmd>lua require("telescope.builtin").find_files { cwd = vim.fn.stdpath("data") }<cr>',
				desc = "Find in packages",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						-- "--hidden",
					},
					find_command = {
						"fd",
						"--type",
						"f",
						"--color=never",
						-- '--hidden',
						"--follow",
						"-E",
						".git/*",
					},
				},
				pickers = {
					find_files = {
						file_ignore_patterns = { "node_modules", ".git", ".venv" },
						hidden = true,
					},
					live_grep = {
						file_ignore_patterns = { "node_modules", ".git", ".venv" },
						hidden = true,
					},
				},
				extensions = {
					"fzf",
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						-- filetypes = { "png", "webp", "jpg", "jpeg" },
						-- find command (defaults to `fd`)
						find_cmd = "rg",
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("media_files")

			-- local builtin = require('telescope.builtin')
			-- vim.keymap.set('n', '<leader>fc', function () builtin.find_files { cwd = vim.fn.stdpath("config") } end, { desc = 'Find in config' })
			-- vim.keymap.set('n', '<leader>fp', function () builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") } end, { desc = 'Find in packages' })
			require("config.telescope.multigrep").setup()

			-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			-- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope oldfiles" })
			-- vim.keymap.set('n', '<leader>fn', ":Telescope notify<CR>", { desc = "Telescope notifications" })
			-- vim.keymap.set("n", '<leader>gr', builtin.lsp_references, { desc = "Telescope LSP references" })
			-- vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope in buffer' })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
