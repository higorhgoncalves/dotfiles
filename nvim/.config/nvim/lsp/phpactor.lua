return {
    cmd = {
        -- "/home/administrador/.local/share/nvim/mason/bin/phpactor",
        -- vim.fn.stdpath("data") .. "/mason/bin/" .. "phpactor",
        "phpactor",
        "language-server",
        "-vvv"
    },
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.completionProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.implementationProvider = true
        client.server_capabilities.typeDefinitionProvider = false
        client.server_capabilities.diagnosticProvider = false
    end,
    filetypes = { "php" },
    settings = {
        phpactor = {
            language_server_phpstan = { enabled = false },
            language_server_psalm = { enabled = false },
            inlayHints = {
                enable = true,
                parameterHints = true,
                typeHints = true,
            },
        },
    }
}
