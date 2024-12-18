return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr, desc = "Open in vertical split" })

				vim.keymap.set("n", "<C-x>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr, desc = "Open in horizontal split" })

				-- vim.keymap.set("n", "<C-t>", function()
				-- 	harpoon.ui:select_menu_item({ tabedit = true })
				-- end, { buffer = cx.bufnr, desc = "Open in new tab" })
			end,
		})

		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Navigation List" })
		vim.keymap.set("n", "<leader>wl", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open Workspace Navigation List" })

		vim.keymap.set("n", "<leader>wa", function()
			harpoon:list():add()
		end, { desc = 'Add to Workspace Navigation List' })
		vim.keymap.set("n", "<leader>wr", function()
			harpoon:list():remove()
		end, { desc = 'Remove from Workspace Navigation List' })
		-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- vim.keymap.set("n", "<C-h>", function()
		-- 	harpoon:list():select(1)
		-- end)
		-- vim.keymap.set("n", "<C-t>", function()
		-- 	harpoon:list():select(2)
		-- end)
		-- vim.keymap.set("n", "<C-n>", function()
		-- 	harpoon:list():select(3)
		-- end)
		-- vim.keymap.set("n", "<C-s>", function()
		-- 	harpoon:list():select(4)
		-- end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<M-S-Tab>", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon buffer" })
		vim.keymap.set("n", "<M-Tab>", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon buffer" })
	end,
}
