return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"L3MON4D3/LuaSnip",
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
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- -- Super tab
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	local col = vim.fn.col(".") - 1
					--
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item({ behavior = "select" })
					-- 	elseif luasnip.expand_or_locally_jumpable() then
					-- 		luasnip.expand_or_jump()
					-- 	elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					-- 		fallback()
					-- 	else
					-- 		cmp.complete()
					-- 	end
					-- end, { "i", "s" }),
					--
					-- -- Super shift tab
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item({ behavior = "select" })
					-- 	elseif luasnip.locally_jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
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

			-- Configuração dos servidores LSP
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"intelephense",
					"phpactor",
					"html",
					"biome",
					"cssls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})

			-- Autocomandos para LSP actions
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Show LSP Information" })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ buffer = event.buf, desc = "Go to declaration" }
					)
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ buffer = event.buf, desc = "Go to implementation" }
					)
					vim.keymap.set(
						"n",
						"go",
						vim.lsp.buf.type_definition,
						{ buffer = event.buf, desc = "Go to type definition" }
					)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf, desc = "Go to references" })
					vim.keymap.set(
						"n",
						"gs",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Show signature help" }
					)
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						{ buffer = event.buf, desc = "Code LSP Rename" }
					)
					vim.keymap.set({ "n", "x" }, "<leader>dfl", function()
						vim.lsp.buf.format({ async = true, wrapLineLength = 9999 })
					end, { buffer = event.buf, desc = "Document Auto Format (LSP)" })
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "Show code actions" }
					)
				end,
			})
		end,
	},
}
