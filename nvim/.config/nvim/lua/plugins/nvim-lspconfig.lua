return {
    { "jwalton512/vim-blade" },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },

		-- example using `opts` for defining servers
		opts = {
			servers = {
				lua_ls = {},
				intelephense = {
                    filetypes = { "php", "blade", "php_only" },
					init_options = {
						licenceKey = "/home/administrador/intelephense/key.txt",
					},
					settings = {
						intelephense = {
							environment = {
								includePaths = {
									-- Use Docker container paths if Intelephense runs inside container
									"/home/administrador/docker-lw/html/classes",
									-- "/home/administrador/docker-lw/html/classes/**",
									-- "/home/administrador/docker-lw/html/classes/vendor",
									-- "/home/administrador/docker-lw/html/classes/src",
								},
							},
							files = {
								maxSize = 5000000,
							},
							-- Add workspace settings if needed
							workspace = {
								-- Add other project roots if needed
								-- "/var/www/html/intranet",
								-- "/var/www/html/legisweb"
							},
						},
					},
				},
                stimulus_ls = {},
				-- phpactor = {},
				html = {},
				cssls = {},
				biome = {},
                tailwindcss = {
                    settings = {
                        tailwindCSS = {
                            experimental = {
                                classRegex = {
                                    "@?class\\(([^]*)\\)",
                                    "'([^']*)'",
                                },
                            },
                        },
                    },
                },
				-- sqlls = {
				-- 	cmd = { "sql-language-server", "up", "--method", "stdio" },
				-- 	filetypes = { "sql", "mysql" },
				-- },
			},
		},
		config = function(_, opts)
			-- Configuração dos servidores LSP
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"intelephense",
					-- "phpactor",
					"html",
					"biome",
					"cssls",
				},
				-- handlers = {
				-- 	function(server_name)
				-- 		require("lspconfig")[server_name].setup({})
				-- 	end,
				-- },
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

			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,

		-- example calling setup directly for each LSP
		-- config = function()
		--     local capabilities = require('blink.cmp').get_lsp_capabilities()
		--     local lspconfig = require('lspconfig')
		--
		--     lspconfig['lua-ls'].setup({ capabilities = capabilities })
		-- end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
