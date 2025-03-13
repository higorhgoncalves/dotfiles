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

function M.grep(opts)
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})

    -- Usar implementação que suporta entrada direta no prompt
    Snacks.picker.grep({
        prompt_title = "Multi Grep (Padrão  Glob)",
        prompt_prefix = "Padrão  Glob> ",

        -- Configuração do comando ripgrep personalizado
        command = function(input)
            -- Split por dois ou mais espaços
            local parts = vim.split(input, "%s%s+")
            local pattern = parts[1] or ""
            local glob = parts[2] or ""

            -- Montar o comando base do ripgrep
            local cmd = { "rg", "--column", "--line-number", "--no-heading", "--color=never" }

            -- Adicionar encoding e configurar como fixed-strings (literal)
            table.insert(cmd, "--encoding=" .. opts.file_encoding)
            table.insert(cmd, "--fixed-strings")

            -- Se tiver um padrão glob, adicione ao comando
            if glob and glob ~= "" then
                table.insert(cmd, "--glob")
                table.insert(cmd, glob)
            end

            -- Adicionar o hidden e outros argumentos padrão
            table.insert(cmd, "--hidden")

            -- Adicionar o padrão de busca no final
            table.insert(cmd, pattern)

            -- Retornar o comando completo
            return cmd
        end,

        -- Formatação dos resultados
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
        },

        -- Adicionar texto de ajuda explicando o formato
        help = "Digite o padrão de busca seguido de dois espaços e um padrão glob (ex: texto  *.php)"
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
