return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            require("tiny-inline-diagnostic").setup()
        end,
    },
    -- { "jwalton512/vim-blade", },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "biome",
                "cssls",
                "html",
                "intelephense",
                "lua_ls",
                "sqls",
                -- "stimulus_ls",
                "tailwindcss",
            },
        },
        -- handlers = {
        --     function(server_name)
        --         require("lspconfig")[server_name].setup({})
        --     end,
        -- },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
}
