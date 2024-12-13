return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
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
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load({
				include = { "html", "php" },
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						local luasnip = require("luasnip")
						luasnip.lsp_expand(args.body)
						luasnip.filetype_extend("php", { "html" })
						luasnip.filetype_extend("html", { "php" })
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
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			local luasnip = require("luasnip")

			-- Permitir que snippets de HTML sejam usados em arquivos PHP e vice-versa
			luasnip.filetype_extend("php", { "html" })
			luasnip.filetype_extend("html", { "php" })
		end,
	},
}
