return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.8',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        keys = {
            { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = 'Search find files' },
            { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Search live grep' },
            { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = 'Search buffers' },
            { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Search help tags' },
            { '<leader>so', '<cmd>Telescope oldfiles<cr>', desc = "Search oldfiles" },
            -- { '<leader>fn', '<cmd>Telescope notify<cr>', desc = "Telescope notifications" },
            { '<leader>sr', '<cmd>Telescope lsp_references<cr>', desc = "Search LSP references" },
            { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search in buffer' },

        },
        config = function()
            -- local builtin = require('telescope.builtin')
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            -- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope oldfiles" })
            -- vim.keymap.set('n', '<leader>fn', ":Telescope notify<CR>", { desc = "Telescope notifications" })
            -- vim.keymap.set("n", '<leader>gr', builtin.lsp_references, { desc = "Telescope LSP references" })
            -- vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope in buffer' })
            -- create a custom keymap that will show the notifications from snacks notifier
            -- vim.api.nvim_set_keymap("n", "<leader>nh", "<cmd>lua require('snacks').notifier.show_history()<CR>", { noremap = true, silent = true })


            -- function _G.show_notifications_with_telescope()
            --     local snacks = require('snacks')
            --     local notifications = snacks.notifier.get_history()
            --
            --     if not notifications or #notifications == 0 then
            --         print("No notifications found")
            --         return
            --     end
            --
            --     local entries = {}
            --     for _, notification in ipairs(notifications) do
            --         table.insert(entries, {
            --             value = notification.msg,
            --             ordinal = notification.msg,
            --             display = notification.msg,
            --         })
            --         print(notification.msg)
            --     end
            --
            --     require('telescope.pickers').new({}, {
            --         prompt_title = 'Notifications',
            --         finder = require('telescope.finders').new_table {
            --             results = entries,
            --             entry_maker = function(entry)
            --                 return {
            --                     value = entry.value,
            --                     display = entry.display,
            --                     ordinal = entry.ordinal,
            --                 }
            --             end,
            --         },
            --         sorter = require('telescope.config').values.generic_sorter({}),
            --     }):find()
            -- end
            --
            -- vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>lua show_notifications_with_telescope()<CR>', { noremap = true, silent = true, desc = "Show Notifications with Telescope" })

            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        -- '--color=never',
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
            telescope.load_extension("fzf")
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
