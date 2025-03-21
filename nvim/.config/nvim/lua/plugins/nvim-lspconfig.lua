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
    { "jwalton512/vim-blade" },
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
                -- "phpactor",
                "sqls",
                "stimulus_ls",
                -- "tailwindcss",
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
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },

        -- example using `opts` for defining servers
        opts = {
            servers = {
                lua_ls = {},
                intelephense = {
                    filetypes = {
                        "php",
                        "blade",
                        "php_only"
                    },
                    init_options = {
                        licenceKey = "/home/administrador/intelephense/key.txt",
                    },
                    settings = {
                        intelephense = {
                            environment = {
                                includePaths = {
                                    -- Use Docker container paths if Intelephense runs inside container
                                    "/home/administrador/docker-lw/html/classes",
                                },
                            },
                            files = {
                                maxSize = 5000000,
                            },
                            -- Add workspace settings if needed
                            workspace = {
                                -- Add other project roots if needed
                                -- "/var/www/html/intranet",
                                -- "/var/www/html/legisweb"
                            },
                        },
                    },
                },
                -- stimulus_ls = {},
                html = {},
                cssls = {},
                biome = {},
                tailwindcss = {
                    filetypes = { -- Lista de filetypes onde o Tailwind CSS deve ativar
                        "html",
                        "blade",
                        "css",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        -- Remova "php" se estiver presente
                    },
                    settings = {
                        tailwindCSS = {
                            experimental = {
                                classRegex = {
                                    "@?class\\(([^]*)\\)",
                                    "'([^']*)'",
                                },
                            },
                        },
                    },
                },
                sqls = {},
            },
        },
        config = function(_, opts)
            -- Autocomandos para LSP actions
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local keymap_opts = { buffer = event.buf, silent = true, noremap = true }

                    -- Docs and Info
                    vim.keymap.set("n", "K", vim.lsp.buf.hover,
                        vim.tbl_extend("force", keymap_opts, { desc = "Show Info" }))
                    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help,
                        vim.tbl_extend("force", keymap_opts, { desc = "Signature Help" }))

                    -- LSP Actions
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                        vim.tbl_extend("force", keymap_opts, { desc = "Rename Symbol" }))
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                        vim.tbl_extend("force", keymap_opts, { desc = "Code Action" }))

                    -- Formatting
                    vim.keymap.set({ "n", "x" }, "<C-S-i>", function()
                        vim.lsp.buf.format { async = true }
                    end, vim.tbl_extend("force", keymap_opts, { desc = "Format (LSP)" }))
                    vim.keymap.set({ "n", "x" }, "<leader>Fl", function()
                        vim.lsp.buf.format { async = true }
                    end, vim.tbl_extend("force", keymap_opts, { desc = "Format (LSP)" }))
                end,
            })

            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end,

        -- example calling setup directly for each LSP
        -- config = function()
        --     local capabilities = require('blink.cmp').get_lsp_capabilities()
        --     local lspconfig = require('lspconfig')
        --
        --     lspconfig['lua-ls'].setup({ capabilities = capabilities })
        -- end,
        event = { "BufReadPre", "BufNewFile" },
    },
}
