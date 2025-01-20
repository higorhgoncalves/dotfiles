return {
	{
		"letieu/harpoon-lualine",
		dependencies = {
			{
				"ThePrimeagen/harpoon",
				branch = "harpoon2",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lualine = require("lualine")

			-- local function show_macro_recording()
			-- 	local recording_register = vim.fn.reg_recording()
			-- 	if recording_register == "" then
			-- 		return ""
			-- 	else
			-- 		return "Recording @" .. recording_register
			-- 	end
			-- end
			--
			-- vim.api.nvim_create_autocmd("RecordingEnter", {
			-- 	callback = function()
			-- 		lualine.refresh({
			-- 			place = { "statusline" },
			-- 		})
			-- 	end,
			-- })
			--
			-- vim.api.nvim_create_autocmd("RecordingLeave", {
			-- 	callback = function()
			-- 		-- This is going to seem really weird!
			-- 		-- Instead of just calling refresh we need to wait a moment because of the nature of
			-- 		-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
			-- 		-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
			-- 		-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
			-- 		-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
			-- 		---@diagnostic disable-next-line: undefined-field
			-- 		local timer = vim.loop.new_timer()
			-- 		timer:start(
			-- 			50,
			-- 			0,
			-- 			vim.schedule_wrap(function()
			-- 				lualine.refresh({
			-- 					place = { "statusline" },
			-- 				})
			-- 			end)
			-- 		)
			-- 	end,
			-- })

			lualine.setup({
				options = {
					icons_enabled = true,
					-- theme = "auto",
					theme = "catppuccin",
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {
							"dashboard",
							"alpha",
							"ministarter",
							"snacks_dashboard",
						},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"branch",
						"diff",
						"diagnostics",
						-- { "macro-recording", fmt = show_macro_recording }
					},
					lualine_c = {
						{
							"harpoon2",
							icon = "",
							-- indicators = { "a", "s", "q", "w" },
							-- active_indicators = { "A", "S", "Q", "W" },
							color_active = { fg = "#00ff00" },
							_separator = " ",
							-- no_harpoon = "Harpoon not loaded",
						},
						"filename",
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
