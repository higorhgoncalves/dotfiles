return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.8',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find find files' },
            { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Find live grep' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help tags' },
            { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = "Find oldfiles" },
            { '<leader>fn', '<cmd>Telescope notify<cr>', desc = "Find notifications" },
            { '<leader>fr', '<cmd>Telescope lsp_references<cr>', desc = "Find references" },
            { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Find in buffer' },
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden',
                    },
                },
                pickers = {
                    find_files = {
                        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                        additional_args = function(_)
                            return { "--hidden" }
                        end
                    },
                    live_grep = {
                        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                        hidden = true,
                    },
                },
                extensions = {
                    "fzf",
                }
            }

            telescope.load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fc', function () builtin.find_files { cwd = vim.fn.stdpath("config") } end, { desc = 'Find in config' })
            vim.keymap.set('n', '<leader>fp', function () builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") } end, { desc = 'Find in packages' })
            require "config.telescope.multigrep".setup()

            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            -- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope oldfiles" })
            -- vim.keymap.set('n', '<leader>fn', ":Telescope notify<CR>", { desc = "Telescope notifications" })
            -- vim.keymap.set("n", '<leader>gr', builtin.lsp_references, { desc = "Telescope LSP references" })
            -- vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope in buffer' })
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
