return {
	-- {
	-- 	"github/copilot.vim",
	-- },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					-- yaml = false,
					-- markdown = false,
					-- help = false,
					-- gitcommit = false,
					-- gitrebase = false,
					-- hgcommit = false,
					-- svn = false,
					-- cvs = false,
					-- ["."] = false,
				},
				-- default prompts
				prompts = {
					Explain = {
						-- prompt = '> /COPILOT_EXPLAIN\n\nWrite an explanation for the selected code as paragraphs of text.',
						prompt = "> /COPILOT_EXPLAIN\n\nEscreva uma explicação para o código selecionado como parágrafos de texto.",
					},
					Review = {
						-- prompt = '> /COPILOT_REVIEW\n\nReview the selected code.',
						prompt = "> /COPILOT_REVIEW\n\nAvalie o código selecionado.",
						-- see config.lua for implementation
					},
					Fix = {
						-- prompt = '> /COPILOT_GENERATE\n\nThere is a problem in this code. Rewrite the code to show it with the bug fixed.',
						prompt = "> /COPILOT_GENERATE\n\nHá um problema neste código. Reescreva o código para mostrá-lo com o bug corrigido.",
					},
					Optimize = {
						-- prompt = '> /COPILOT_GENERATE\n\nOptimize the selected code to improve performance and readability.',
						prompt = "> /COPILOT_GENERATE\n\nOtimize o código selecionado para melhorar a performance e legibilidade.",
					},
					Docs = {
						-- prompt = '> /COPILOT_GENERATE\n\nPlease add documentation comments to the selected code.',
						prompt = "> /COPILOT_GENERATE\n\nPor favor adicione comentários de documentação ao código selecionado.",
					},
					Tests = {
						-- prompt = "> /COPILOT_GENERATE\n\nPlease generate tests for my code.",
						prompt = "> /COPILOT_GENERATE\n\nPor favor gere testes para o meu código.",
					},
					Commit = {
						-- prompt = '> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
						prompt = "> #git:staged\n\nEscreva uma mensagem de commit para a mudança com a convençao commitzen. Certifique-se de que o título tenha no máximo 50 caracteres e que a mensagem tenha 72 caracteres. Envolva toda a mensagem em um bloco de código com a linguagem gitcommit.",
					},
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			-- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
			mappings = {
				submit_prompt = {
					normal = "<Leader>s",
					insert = "<C-s>",
				},
			},
			window = {
				layout = "float",
				relative = "cursor",
				width = 1,
				height = 0.4,
				row = 1,
			},
		},
		keys = {
			-- Quick chat with Copilot
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
