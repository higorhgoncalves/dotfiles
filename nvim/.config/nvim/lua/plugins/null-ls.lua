return {
    -- Para PHP_CodeSniffer (análise)
    {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function(_, opts)
            local null_ls = require("null-ls")
            opts.sources = {
                null_ls.builtins.diagnostics.phpcs.with({
                    extra_args = { "--standard=psr12" }, -- Usa o PSR-12
                }),
                -- null_ls.builtins.formatting.phpcbf,
                -- null_ls.builtins.formatting.phpcsfixer,
                null_ls.builtins.formatting.pint,
                -- null_ls.builtins.formatting.prettyphp,
            }
            return opts
        end,
        keys = {
            {
                "<leader>Fn", "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format (NULL)",
            }
        },
    }
}
