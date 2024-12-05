return {{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
}, {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {"lua_ls", "intelephense", "phpactor", "html", "cssls", "ts_ls", "nil_ls"}
        })
    end
}, {
    "neovim/nvim-lspconfig",
    config = function()
        -- local on_attach = function(client, bufnr)
        --     -- Desabilita a formatação padrão do LSP para evitar conflitos com null-ls
        --     if client.name == "html" or client.name == "cssls" or client.name == "ts_ls" or client.name == "intelephense" then
        --         client.server_capabilities.documentFormattingProvider = false
        --     end
        -- end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
        })
        lspconfig.intelephense.setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
        })
        lspconfig.phpactor.setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
        })
        lspconfig.html.setup({
            capabilities = capabilities,
            filetypes = {
                "html", "php"
            },
            single_file_support = true,
            -- on_attach = on_attach,
        })
        -- lspconfig.cssls.setup({
        --     capabilities = capabilities,
        --     filetypes = {
        --         "css", "php"
        --     },
        --     single_file_support = true,
        --     -- on_attach = on_attach,
        -- })
        lspconfig.nil_ls.setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
        })
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            filetypes = { "javascript", "php" },
            single_file_support = true,
            -- on_attach = on_attach,
        })
        

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set({"n"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
    end
}}
