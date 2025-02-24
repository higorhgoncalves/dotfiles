return {
	"michaelb/sniprun",

	build = "sh install.sh",

	config = function()
		local sniprun = require("sniprun")
		local sniprun_api = require("sniprun.api")

		sniprun.setup({
			display = { "Api" },
			show_no_output = { "Classic", "TempFloatingWindow" },
			display_options = {
				terminal_width = 45,
				notification_timeout = 5,
			},

			inline_messages = 0,
			borders = "single",
			interpreter_options = {
				Generic = {
					error_truncate = "long", -- strongly recommended to figure out what's going on
					MyPHPConfig = { -- any key name is ok
						supported_filetypes = { "php" }, -- mandatory
						extension = ".php", -- recommended, but not mandatory. Sniprun use this to create temporary files

						interpreter = "php", -- interpreter or compiler (+ options if any)
						compiler = "", -- exactly one of those MUST be non-empty
						-- boilerplate_pre = "<?php ",
					},
                    MyJSConfig = { -- any key name is ok
						supported_filetypes = { "javascript" }, -- mandatory
						extension = ".js", -- recommended, but not mandatory. Sniprun use this to create temporary files

						interpreter = "node", -- interpreter or compiler (+ options if any)
						compiler = "", -- exactly one of those MUST be non-empty
						-- boilerplate_pre = "<?php ",
					},

				},
			},
			selected_interpreters = { "Generic" },
		})

		local api_listener = function(d)
			if d.status == "ok" then
				vim.notify("Output: \n" .. d.message, vim.log.levels.INFO)
			elseif d.status == "error" then
				vim.notify("Error: \n" .. d.message, vim.log.levels.ERROR)
			else
				vim.notify("Sniprun: " .. d.message, vim.log.levels.INFO)
			end
		end

		sniprun_api.register_listener(api_listener)
	end,
	cmd = "SnipRun",
}
