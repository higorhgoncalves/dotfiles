local M = {}

local default_opts = {
    file_encoding = "latin1",
    layout = {
        preset = "default",
        config = {
            preview = {
                width = 0.6
            }
        }
    }
}

function M.setup(user_opts)
    default_opts = vim.tbl_deep_extend("force", default_opts, user_opts or {})
end

-- Implementação simples que funciona com a API do Snacks
function M.grep(opts)
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})

    -- Usar a implementação básica do grep
    Snacks.picker.grep({
        prompt_title = "Multi Grep",

        -- Configurações básicas da busca
        args = { "--encoding=" .. opts.file_encoding, "--fixed-strings" },
        hidden = true,
        smartcase = true,
        regex = false,

        -- Format function com verificação de valores nulos
        format = function(item)
            -- Garantir que temos valores válidos
            local file = item.file or "[Unknown file]"
            local lnum = item.lnum or 0
            local text = item.text or ""

            return {
                { text,                                  "Comment" },
                { string.format(" [%s:%d]", file, lnum), "Identifier" }
            }
        end,

        preview = "file",
        layout = opts.layout,
        win = {
            preview = {
                bo = {
                    fileencoding = opts.file_encoding
                }
            }
        }
    })
end

-- Função adicional para grep com glob - abordagem mais simples
function M.glob_grep(opts)
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})

    -- Solicitar os valores separadamente
    vim.ui.input({ prompt = "Padrão de busca: " }, function(pattern)
        if not pattern then return end

        vim.ui.input({ prompt = "Padrão glob: " }, function(glob)
            if not glob then
                glob = "*" -- Valor padrão
            end

            -- Usar grep_string com os valores fornecidos
            Snacks.picker.grep({
                prompt_title = string.format("Grep: %s (glob: %s)", pattern, glob),

                -- Usar o pattern diretamente
                search = pattern,

                -- Limitar aos arquivos que correspondem ao glob
                glob = glob,

                -- Outras opções padrão
                args = { "--encoding=" .. opts.file_encoding, "--fixed-strings" },
                hidden = true,
                smartcase = true,
                regex = false,

                format = function(item)
                    local file = item.file or "[Unknown file]"
                    local lnum = item.lnum or 0
                    local text = item.text or ""

                    return {
                        { text,                                  "Comment" },
                        { string.format(" [%s:%d]", file, lnum), "Identifier" }
                    }
                end,

                preview = "file",
                layout = opts.layout,
                win = {
                    preview = {
                        bo = {
                            fileencoding = opts.file_encoding
                        }
                    }
                }
            })
        end)
    end)
end

return M
