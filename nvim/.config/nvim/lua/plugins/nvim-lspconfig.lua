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

                    -- Navegação LSP
                    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                    --     vim.tbl_extend("force", keymap_opts, { desc = "Ir para Definição" }))
                    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                    --     vim.tbl_extend("force", keymap_opts, { desc = "Ir para Declaração" }))
                    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                    --     vim.tbl_extend("force", keymap_opts, { desc = "Ir para Implementação" }))
                    -- vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
                    --     vim.tbl_extend("force", keymap_opts, { desc = "Ir para Tipo da Definição" }))
                    -- vim.keymap.set("n", "gr", vim.lsp.buf.references,
                    --     vim.tbl_extend("force", keymap_opts, { desc = "Mostrar Referências" }))

                    -- Informações e documentação
                    vim.keymap.set("n", "K", vim.lsp.buf.hover,
                        vim.tbl_extend("force", keymap_opts, { desc = "Mostrar Informações LSP" }))
                    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help,
                        vim.tbl_extend("force", keymap_opts, { desc = "Mostrar Assinatura" }))

                    -- Ações do LSP
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                        vim.tbl_extend("force", keymap_opts, { desc = "Renomear Símbolo" }))
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                        vim.tbl_extend("force", keymap_opts, { desc = "Ações de Código" }))

                    -- Diagnósticos
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
                        vim.tbl_extend("force", keymap_opts, { desc = "Erro Anterior" }))
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
                        vim.tbl_extend("force", keymap_opts, { desc = "Próximo Erro" }))
                    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
                        vim.tbl_extend("force", keymap_opts, { desc = "Mostrar Diagnóstico Atual" }))
                    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist,
                        vim.tbl_extend("force", keymap_opts, { desc = "Enviar Diagnósticos para Lista" }))

                    -- Formatação
                    vim.keymap.set("n", "<C-S-i>", function()
                        vim.lsp.buf.format { async = true }
                    end, vim.tbl_extend("force", keymap_opts, { desc = "Formatar Código" }))
                    vim.keymap.set("n", "<leader>Fl", function()
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
