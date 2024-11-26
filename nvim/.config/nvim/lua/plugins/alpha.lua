return {
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()

        local alpha = require("alpha")
        local olddashboard = require("alpha.themes.dashboard")
        local dashboard = require("alpha.themes.theta")

        -- Define a custom highlight group for the header
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#b4befe", bold = true }) -- Example: Lavender

        -- Set header
        dashboard.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ "
        }

        dashboard.buttons.val = {
            olddashboard.button("nf", "  [n]ew [f]ile", [[<cmd>ene<CR>]]),
            olddashboard.button("bf", "  [b]rowse [f]iles", [[<cmd>Neotree toggle<CR>]]),
            olddashboard.button("ff", "  [f]ind [f]ile", [[<cmd>Telescope find_files<CR>]]),
            olddashboard.button("fg", "  [f]ind [g]rep", [[<cmd>Telescope live_grep<CR>]]),
            olddashboard.button("fo", "  [f]ind [o]ldfiles", [[<cmd>Telescope oldfiles<CR>]]),
            olddashboard.button("up", "󰊳  [u]pdate [p]lugins", [[<cmd>Lazy sync<CR>]]),
            olddashboard.button("lt", "  [l]anguage [t]ools", [[<cmd>Mason<CR>]]),
            olddashboard.button("q", "  [q]uit", [[<cmd>qa<CR>]])
        }

        -- Assign the highlight group to the header
        dashboard.header.opts = {
            position = "center",
            hl = "AlphaHeader"
        }

        alpha.setup(dashboard.config)
    end
}