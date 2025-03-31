local servers = {
    "lua_ls",
    "intelephense",
    "biome",
    "html",
    "cssls",
    "tailwindcss",
    "sqls",
}

-- Defined in init.lua
vim.lsp.config('*', {
    -- capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(),   
    root_markers = { '.git' },
})

-- Carregar as configurações individuais de cada servidor
for _, server in ipairs(servers) do
    -- Verifica os filetypes específicos para cada servidor
    -- Exemplo: se o arquivo for PHP, carrega o intelephense
    -- if server == "intelephense" and vim.bo.filetype ~= "php" then
        vim.lsp.enable({
            server
        })
    -- end
end

-- Configuração de keybindings para quando um LSP conecta
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
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
            vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
        end
        
        -- Auto-format ao salvar
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.format', {clear=false}),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
