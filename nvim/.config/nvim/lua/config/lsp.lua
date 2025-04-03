local servers = {
    "intelephense",
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",
    "sqls",
    "lua_ls",
}

-- Defined in init.lua
vim.lsp.config('*', {
    capabilities = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
        ---@diagnostic disable-next-line: inject-field
        capabilities.textDocument.completion.autotrigger = false
        return capabilities
    end,

    root_markers = { '.git' },
})

vim.lsp.enable(servers)
