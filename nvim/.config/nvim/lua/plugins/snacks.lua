return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 1, 0 } },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = { 1, 0 } },
                { section = "keys" },
                { section = "startup" },
            },
            preset = {
                keys = {
                    {
                        icon = " ",
                        key = "f",
                        desc = "Find File",
                        action = function() Snacks.picker.files() end,
                    },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = "󰙅 ", key = "e", desc = "Explore Files", action = function() Snacks.explorer() end },
                    {
                        icon = " ",
                        key = "g",
                        desc = "Find Text",
                        action = function() Snacks.picker.grep() end,
                    },
                    {
                        icon = " ",
                        key = "r",
                        desc = "Recent Files",
                        action = function() Snacks.picker.recent() end
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
                    },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
        dim = { enabled = true },
        git = { enabled = true },
        image = { enabled = true },
        indent = {
            enabled = true,
            indent = {
                char = "▏",
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                    "SnacksIndent3",
                    "SnacksIndent4",
                    "SnacksIndent5",
                    "SnacksIndent6",
                    "SnacksIndent7",
                    "SnacksIndent8",
                },
            },
            scope = {
                enabled = false, -- enable highlighting the current scope
            },
        },
        input = { enabled = true },
        lazygit = { enabled = true },
        notifier = { enabled = true, timeout = 3000, style = "fancy" },
        picker = {
            cmd = "rg",
            -- Configure sources directly
            sources = {
                grep = {
                    args = { "--encoding=latin1", "--fixed-strings" },
                    hidden = true,
                },
                grep_buffers = {
                    args = { "--encoding=latin1", "--fixed-strings" },
                },
                grep_word = {
                    args = { "--encoding=latin1", "--fixed-strings" },
                },
                files = {
                    args = { "--encoding=latin1" },
                    hidden = true,
                },
                explorer = {
                    hidden = true,
                },
            },
            win = {
                list = {
                    keys = {
                        ["<C-b>"] = "close",
                    }
                },
            },
        },
        scratch = {
            enabled = true,
            ft = function()
                if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
                    return vim.bo.filetype
                end
                return "markdown"
            end,
            win = {
                keys = {
                    ["execute"] = {
                        "<cr>",
                        function()
                            vim.cmd("%SnipRun")
                        end,
                        desc = "Execute buffer",
                        mode = { "n", "x" },
                    },
                },
            },
            win_by_ft = {
                lua = {
                    keys = {
                        ["source"] = {
                            "<cr>",
                            function(self)
                                local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                Snacks.debug.run({ buf = self.buf, name = name })
                            end,
                            desc = "Source buffer",
                            mode = { "n", "x" },
                        },
                        ["execute"] = {
                            "e",
                            function()
                                vim.cmd("%SnipRun")
                            end,
                            desc = "Execute buffer",
                            mode = { "n", "x" },
                        },
                    },
                },
                php = {
                    keys = {
                        ["execute"] = {
                            "<cr>",
                            function()
                                vim.cmd("%SnipRun")
                            end,
                            desc = "Execute buffer",
                            mode = { "n", "x" },
                        },
                    },
                },
                javascript = {
                    keys = {
                        ["execute"] = {
                            "<cr>",
                            function()
                                vim.cmd("%SnipRun")
                            end,
                            desc = "Execute buffer",
                            mode = { "n", "x" },
                        },
                    },
                },
            },
        },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = true,           -- show open fold icons
                git_hl = true,         -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50,
        },
        toggle = { enabled = true },
        words = { enabled = true },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
    end,

    keys = {
        { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer", },
        { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer", },
        { "<leader>rf",      function() Snacks.rename.rename_file() end,                             desc = "Rename File", },
        { "<leader>gb",      function() Snacks.git.blame_line() end,                                 desc = "Git Blame Line", },
        { "<leader>gf",      function() Snacks.lazygit.log_file() end,                               desc = "Lazygit Current File History", },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit", },
        -- { "<leader>gl",      function() Snacks.lazygit.log() end,                  desc = "Lazygit Log (cwd)", },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications", },
        -- Top Pickers & Explorer
        { "<leader>P",       function() Snacks.picker() end,                                         desc = "Show Pickers", },
        { "<C-b>",           function() Snacks.explorer() end,                                       desc = "Toggle Explorer", },
        { "<leader>ue",      function() Snacks.explorer() end,                                       desc = "Toggle Explorer", },
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        -- git
        { "<leader>gB",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                         desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto Type Definition" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",     mode = { "n", "x" } },
        -- Search
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
        { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        -- Find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })

        -- Ajustar os highlights usando a API Lua
        -- vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#E06C75" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#E5C07B" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#61AFEF" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#D19A66" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#98C379" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#C678DD" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#56B6C2" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#d20f39" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#df8e1d" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#1e66f5" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#fe640b" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#40a02b" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#8839ef" })
        -- vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#209fb5" })
    end,
}
