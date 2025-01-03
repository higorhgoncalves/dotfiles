return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
			},
			-- add blink.compat to dependencies
			{
				"saghen/blink.compat",
				optional = true, -- make optional so it's only enabled if any extras need it
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		-- use a release tag to download pre-built binaries
		-- version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		build = "cargo build --release",
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@diagnostic disable-next-line: undefined-doc-name
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "default" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				kind_icons = {
					Color = "██",
				},
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				-- nerd_font_variant = "mono",
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = function(ctx)
					local _ = ctx
					local success, node = pcall(vim.treesitter.get_node)
					if vim.bo.filetype == "lua" then
						return { "lazydev", "lsp", "path", "snippets", "buffer", "luasnip" }
					elseif
						success
						and node
						and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
					then
						return { "buffer" }
					else
						return { "lazydev", "lsp", "path", "snippets", "buffer", "luasnip", "dadbod" }
					end
				end,
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
					},
					lsp = {
						name = "lsp",
						module = "blink.cmp.sources.lsp",
						fallbacks = { "buffer" },
						-- Filter text items from the LSP provider, since we have the buffer provider for that
						transform_items = function(_, items)
							for _, item in ipairs(items) do
								if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
									item.score_offset = item.score_offset - 3
								end
							end

							return vim.tbl_filter(function(item)
								return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
							end, items)
						end,
						-- score_offset = 90,
					},
					luasnip = {
						name = "luasnip",
						enabled = true,
						module = "blink.cmp.sources.luasnip",
						min_keyword_length = 2,
						fallbacks = { "snippets" },
						score_offset = 85,
						max_items = 8,
						opts = {
							-- Whether to use show_condition for filtering snippets
							use_show_condition = true,
							-- Whether to show autosnippets in the completion list
							show_autosnippets = true,
						},
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 3,
						-- When typing a path, I would get snippets and text in the
						-- suggestions, I want those to show only if there are no path
						-- suggestions
						fallbacks = { "luasnip", "buffer" },
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 4,
					},
					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 4,
						module = "blink.cmp.sources.snippets",
						min_keyword_length = 2,
						score_offset = 80,
						opts = {
							friendly_snippets = true,
							-- search_paths = {
							-- 	vim.fn.stdpath("config") .. "/snippets",
							-- },
							global_snippets = { "all" },
							extended_filetypes = {
								php = { "html", "css", "javascript" },
							},
							ignored_filetypes = {},
							get_filetype = function(ctx)
								local _ = ctx
								return vim.bo.filetype
							end,
						},
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
						score_offset = 85,
					},
				},
				cmdline = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
			},

			snippets = {
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},

			-- Style
			completion = {
				menu = {
					border = "rounded",
					draw = {
						treesitter = { "lsp" },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
					},
				},
				-- Show documentation when selecting a completion item
				documentation = {
					window = {
						border = "single",
					},
					auto_show = true,
					auto_show_delay_ms = 500,
				},

				-- Display a preview of the selected item on the current line
				-- ghost_text = { enabled = true },
			},

			-- Experimental signature help support
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
