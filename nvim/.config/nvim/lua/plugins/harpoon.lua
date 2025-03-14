return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/snacks.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        local normalize_list = function(t)
            local normalized = {}
            for _, v in pairs(t) do
                if v ~= nil then
                    table.insert(normalized, v)
                end
            end
            return normalized
        end

        local harpoon_snacks = function()
            Snacks.picker({
                finder = function()
                    local file_paths = {}
                    local list = normalize_list(harpoon:list().items)
                    for i, item in ipairs(list) do
                        table.insert(file_paths, { text = item.value, file = item.value })
                    end
                    return file_paths
                end,
                win = {
                    input = {
                        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                    },
                    list = {
                        keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                    },
                },
                actions = {
                    harpoon_delete = function(picker, item)
                        local to_remove = item or picker:selected()
                        harpoon:list():remove({ value = to_remove.text })
                        harpoon:list().items = normalize_list(harpoon:list().items)
                        picker:find({ refresh = true })
                    end,
                },
            })
        end

        vim.keymap.set("n", "<C-e>", function() harpoon_snacks() end, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>fh", function() harpoon_snacks() end, { noremap = true, silent = true, desc = "Find Harpoon" })
    end,
}
