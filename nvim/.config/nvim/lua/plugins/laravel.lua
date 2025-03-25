return {
    {
        -- Add the Laravel.nvim plugin which gives the ability to run Artisan commands
        -- from Neovim.
        "adalessa/laravel.nvim",
        dependencies = {
            "tpope/vim-dotenv",
            "folke/snacks.nvim",
            "kevinhwang91/promise-async",
        },
        cmd = { "Laravel" },
        keys = {
            { "<leader>la", ":Laravel artisan<cr>" },
            { "<leader>lr", ":Laravel routes<cr>" },
            { "<leader>lm", ":Laravel related<cr>" },
        },
        event = { "VeryLazy" },
        opts = {
            lsp_server = "intelephense",
            features = {
                null_ls = { enable = false }
            },
            pickers = {
                enabled = true,
                provider = "snacks",
            },
        },
        config = true,
    },
    {
        -- Add the blade-nav.nvim plugin which provides Goto File capabilities
        -- for Blade files.
        "ricardoramirezr/blade-nav.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        ft = { "blade", "php" },
    },
}
