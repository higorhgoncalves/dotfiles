local servers = {
    "intelephense",
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",
    "sqls",
    "lua_ls",
}

local capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
    ---@diagnostic disable-next-line: inject-field
    capabilities.textDocument.completion.autotrigger = false

    return capabilities
end,

-- Defined in init.lua
vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
})
vim.lsp.enable(servers)

-- Configuração de keybindings para quando um LSP conecta
vim.api.nvim_create_autocmd('LspAttach', {
    -- group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
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
    end,
})
