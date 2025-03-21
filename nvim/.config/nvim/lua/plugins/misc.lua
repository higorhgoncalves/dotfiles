return {
    {
        "arnamak/stay-centered.nvim",
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        -- Optional dependency
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        'nmac427/guess-indent.nvim',
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
        keys = {
            { "<leader>qs", ":lua require('persistence').load()<CR>",                desc = "Restore Session" },
            { "<leader>qS", ":lua require('persistence').select()<CR>",              desc = "Select Session" },
            { "<leader>ql", ":lua require('persistence').load({ last = true })<CR>", desc = "Restore Last Session" },
            { "<leader>qd", ":lua require('persistence').stop()<CR>",                desc = "Don't Save Current Session" },
        },
    },
    -- {
    --     "mbbill/undotree",
    --     keys = {
    --         { "<leader>uU", ":UndotreeToggle<CR>:UndotreeFocus<CR>", desc = "Toggle Undotree" },
    --     },
    -- },
    {
        -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
            preset = "helix",
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },

            -- Document existing key chains
            spec = {
                { "<leader>a", group = "[A]vante",      mode = { "n", "x" } },
                { "<leader>c", group = "[C]ode" },
                { "<leader>C", group = "[C]lipboard" },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>f", group = "[F]ind" },
                { "<leader>F", group = "[F]ormat",      mode = { "n", "x" } },
                { "<leader>g", group = "[G]it",         mode = { "n" } },
                { "<leader>M", group = "[M]ulti Cursor" },
                { "<leader>q", group = "[Q]Session",    mode = { "n" } },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch",     mode = { "n", "x" } },
                { "<leader>u", group = "[U]Toggle" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
