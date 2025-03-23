-- Module for toggling nvim-lint linters
local M = {}

-- Estado inicial: nil significa que ainda não determinamos o estado
M.enabled = nil

-- Lista de linters configurados (obtidos da sua configuração)
local configured_linters = {
    "phpcs",      -- PHP
    "markdownlint", -- Markdown
    "hadolint",   -- Dockerfile
    -- Adicione outros linters que você estiver usando
}

-- Função para verificar se existem diagnósticos ativos dos linters configurados
local function has_active_lint_diagnostics()
    for _, linter_name in ipairs(configured_linters) do
        local ns = vim.api.nvim_create_namespace(linter_name)
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(bufnr) then
                local diags = vim.diagnostic.get(bufnr, { namespace = ns })
                if #diags > 0 then
                    return true
                end
            end
        end
    end
    return false
end

-- Função para limpar diagnósticos dos linters específicos
local function clear_lint_diagnostics()
    for _, linter_name in ipairs(configured_linters) do
        -- Limpa o namespace principal do linter
        local ns_main = vim.api.nvim_create_namespace(linter_name)

        -- Limpa os namespaces de diagnósticos/sinais relacionados
        local ns_underline = vim.api.nvim_create_namespace(linter_name .. "/diagnostic/underline")
        local ns_signs = vim.api.nvim_create_namespace(linter_name .. "/diagnostic/signs")

        -- Aplica a limpeza a todos os buffers
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(bufnr) then
                vim.diagnostic.reset(ns_main, bufnr)
                vim.diagnostic.reset(ns_underline, bufnr)
                vim.diagnostic.reset(ns_signs, bufnr)
            end
        end
    end
end

-- Armazena a função original apenas uma vez
local lint = require("lint")
local original_try_lint = lint.try_lint

-- Sobrescreve a função try_lint
lint.try_lint = function(...)
    -- Usamos uma verificação local do estado para evitar múltiplos toggles
    local is_enabled = M.enabled
    -- Se ainda não determinamos o estado, permitimos a execução para detecção
    if is_enabled == nil then
        original_try_lint(...)
        return
    end

    if is_enabled then
        original_try_lint(...)
    end
end

-- Função para alternar os linters
function M.toggle(debug)
    -- Na primeira execução, determinamos o estado atual
    if M.enabled == nil then
        M.enabled = has_active_lint_diagnostics()
        -- Se não encontramos diagnósticos ativos, assumimos que está desativado
        if debug then
            if not M.enabled then
                vim.notify("Estado inicial: Linters desativados", vim.log.levels.DEBUG)
            else
                vim.notify("Estado inicial: Linters ativados", vim.log.levels.DEBUG)
            end
        end
    end

    -- Inverte o estado
    M.enabled = not M.enabled

    if M.enabled then
        -- Reativar linters
        vim.notify("Enabled Linters", vim.log.levels.WARN, { title = "Linters" })

        -- Executar lint imediatamente para mostrar diagnósticos
        original_try_lint()
    else
        -- Desativar linters e limpar seus diagnósticos
        clear_lint_diagnostics()
        vim.notify("Disabled Linters", vim.log.levels.WARN, { title = "Linters" })
    end
end

-- Comandos personalizados para depuração
vim.api.nvim_create_user_command("LintNamespaces", function()
    local all_ns = vim.api.nvim_get_namespaces()
    for name, id in pairs(all_ns) do
        print(name .. " -> " .. id)
    end
end, {})

-- Comando personalizado para alternar linters
vim.api.nvim_create_user_command("ToggleLinters", function()
    M.toggle()
end, {})

-- Exportar o módulo
return M
