return {
    cmd = {
        -- "/home/administrador/.local/share/nvim/mason/bin/tailwindcss-language-server"
        -- vim.fn.stdpath("data") .. "/mason/bin/" .. "tailwindcss-language-server",
        "tailwindcss-language-server",
    },
    filetypes = {
        -- "html",
        "blade",
        -- "css",
        -- "javascript",
        -- "javascriptreact",
        -- "typescript",
        -- "typescriptreact",
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
}
