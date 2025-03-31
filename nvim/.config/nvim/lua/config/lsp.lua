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
        capabilities.textDocument.completion.autotrigger = false
        return capabilities
    end,

    root_markers = { '.git' },
})

for _, server in pairs(servers) do
    -- Check if the server has the filetype from the buffer
    local filetype = vim.bo.filetype
    local config = vim.lsp.config[server]

    if config and config.filetypes then
        -- If server has specific filetypes, check if current filetype is supported
        if vim.tbl_contains(config.filetypes, filetype) then
            vim.lsp.enable(server)
        end
    else
        -- If server doesn't specify filetypes, enable it (or use your own logic)
        vim.lsp.enable(server)
    end
end

-- Configuração de keybindings para quando um LSP conecta
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end
        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
        end
        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
        local bufnr = args.buf

        -- Keymaps
        local keymap_opts = { buffer = bufnr, silent = true, noremap = true }

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

        -- Habilitar autocompletion
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- Auto-format ao salvar
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
