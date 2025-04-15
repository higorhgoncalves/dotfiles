return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = "*",
        build = "make",

        -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        -- version = false,

        opts = {
            provider = "copilot",
            copilot = {
                model = "claude-3.7-sonnet"
            },
            auto_suggestions_provider = "copilot",
            behaviour = {
                auto_suggestions = false, -- Experimental stage
            },
            file_selector = {
                provider = "snacks",
            },
            mappings = {
                diff = {
                    ours = "co",
                    theirs = "ct",
                    all_theirs = "ca",
                    both = "cb",
                    cursor = "cc",
                    next = "]x",
                    prev = "[x",
                },
                suggestion = {
                    accept = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                jump = {
                    next = "]]",
                    prev = "[[",
                },
                submit = {
                    normal = "<CR>",
                    insert = "<C-s>",
                },
                sidebar = {
                    apply_all = "A",
                    apply_cursor = "a",
                    switch_windows = "<Tab>",
                    reverse_switch_windows = "<S-Tab>",
                },
            },
            suggestion = {
                debounce = 400,
            },
        },
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "folke/snacks.nvim",
            "github/copilot.vim",
            -- "zbirenbaum/copilot.lua",
            -- "github/copilot.vim",
            -- {
            --     -- support for image pasting
            --     "HakonHarnes/img-clip.nvim",
            --     event = "VeryLazy",
            --     opts = {
            --         -- recommended settings
            --         default = {
            --             embed_image_as_base64 = false,
            --             prompt_for_file_name = false,
            --             drag_and_drop = {
            --                 insert_mode = true,
            --             },
            --             -- required for Windows users
            --             use_absolute_path = true,
            --         },
            --     },
            -- },
        },
    }
}
