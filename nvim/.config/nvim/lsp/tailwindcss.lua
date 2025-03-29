return {
    filetypes = {                 -- Lista de filetypes onde o Tailwind CSS deve ativar
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
}
