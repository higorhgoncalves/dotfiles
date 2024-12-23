return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			-- Configuração do nvim-cmp
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load({
				include = { "html", "php", "javascript", "css" },
			})

			-- Configuração do snippet
			luasnip.filetype_extend("php", { "html", "css", "javascript" })
			luasnip.filetype_extend("html", { "css", "javascript" })

			cmp.setup({
				snippet = {
					expand = function(args)
						-- You need Neovim v0.10 to use vim.snippet
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- mapping = cmp.mapping.preset.insert({}),
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Reservar espaço no gutter para evitar layout shift
			vim.opt.signcolumn = "yes"

			-- Adicionar as capacidades do cmp_nvim_lsp ao lspconfig
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)
			-- -- Combine additional default capabilities of Nvim-CMP with the LSP capabilities to work smoothly in autocomplete:
			-- local capabilities =
			-- 	require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Configuração dos servidores LSP
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					-- "intelephense",
					-- "phpactor",
					"html",
					"biome",
					"cssls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					-- this is the "custom handler" for `intelephense`
					intelephense = function()
						require("lspconfig").intelephense.setup({
							single_file_support = false,
							init_options = {
								licenceKey = "/home/administrador/intelephense/key.txt",
							},
							settings = {
								intelephense = {
									files = {
										maxSize = 5000000,
									},
								},
							},
							-- on_attach = function(client, bufnr)
							-- 	-- print("hello from intelephense")
							-- 	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
							-- end,
						})
					end,
				},
			})

			-- Autocomandos para LSP actions
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					vim.keymap.set(
						"n",
						"<leader>cK",
						vim.lsp.buf.hover,
						{ buffer = event.buf, desc = "Show LSP Information" }
					)
					vim.keymap.set(
						"n",
						"<leader>cd",
						vim.lsp.buf.definition,
						{ buffer = event.buf, desc = "Goto definition" }
					)
					vim.keymap.set(
						"n",
						"<leader>cD",
						vim.lsp.buf.declaration,
						{ buffer = event.buf, desc = "Goto Declaration" }
					)
					vim.keymap.set(
						"n",
						"<leader>ci",
						vim.lsp.buf.implementation,
						{ buffer = event.buf, desc = "Goto Implementation" }
					)
					vim.keymap.set(
						"n",
						"<leader>co",
						vim.lsp.buf.type_definition,
						{ buffer = event.buf, desc = "Goto Type Definition" }
					)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf, desc = "Goto References" })
					vim.keymap.set(
						"n",
						"<leader>cs",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Show Signature Help" }
					)
					vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename LSP" })
					vim.keymap.set({ "n", "x" }, "<leader>dfl", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = event.buf, desc = "Document Auto Format (LSP)" })
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "Show Code Actions" }
					)
				end,
			})
		end,
	},
}
