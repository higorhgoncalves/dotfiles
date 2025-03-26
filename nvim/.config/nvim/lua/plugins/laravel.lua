return {
    {
        -- Add the Laravel.nvim plugin which gives the ability to run Artisan commands
        -- from Neovim.
        "adalessa/laravel.nvim",
        dependencies = {
            "tpope/vim-dotenv",
            "folke/snacks.nvim",
            "MunifTanjim/nui.nvim",
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
                pickers = {
                    provider = "snacks",
                },
            },
        },
    },
}
