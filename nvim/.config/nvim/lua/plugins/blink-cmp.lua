return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
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
			-- use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			-- nerd_font_variant = "mono",
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

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		-- sources = {
		-- 	default = {
		-- 		"lsp",
		-- 		"path",
		-- 		"snippets",
		-- 		"buffer",
		-- 	},
		-- 	-- Disable cmdline completions
		-- 	cmdline = {},
		-- },

		sources = {
			default = function(ctx)
				local success, node = pcall(vim.treesitter.get_node)
				if vim.bo.filetype == "lua" then
					return { "lsp", "path", "snippets", "buffer" }
				elseif
					success
					and node
					and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
				then
					return { "buffer" }
				else
					return { "lsp", "path", "snippets", "buffer", "dadbod" }
				end
			end,
			providers = {
				snippets = {
					-- 		should_show_items = function(ctx)
					-- 			return ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
					-- 		end,
					-- enabled = function(ctx)
					-- 	return ctx ~= nil
					-- 		and ctx.trigger.kind ~= vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
					-- end,
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
							return vim.bo.filetype
						end,
					},
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
			},
			cmdline = {},
		},

		-- Style
		completion = {
			menu = {
				border = "rounded",
				draw = {
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
			documentation = { window = { border = "single" }, auto_show = true, auto_show_delay_ms = 500 },

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
}
