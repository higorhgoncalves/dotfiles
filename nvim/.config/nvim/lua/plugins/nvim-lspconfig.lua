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
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "cssls",
                "html",
                "intelephense",
                -- "phpactor",
                "lua_ls",
                "sqls",
                "tailwindcss",
                "ts_ls",
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
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            ensure_installed = {
                "blade-formatter",
                "nixfmt",
                "phpcs",
                "php-cs-fixer",
                "rustywind",
                "shfmt",
                "sleek",
                "stylua",
            },
        },
    }
}
