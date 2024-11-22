return {
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()

        local alpha = require("alpha")
        local olddashboard = require("alpha.themes.dashboard")
        local dashboard = require("alpha.themes.theta")
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
            olddashboard.button("n", "  [n]ew file", [[<cmd>ene<CR>]]),
            olddashboard.button("ff", "  [f]ind [f]ile", [[<cmd>Telescope find_files<CR>]]),
            olddashboard.button("fg", "  [f]ind [g]rep", [[<cmd>Telescope live_grep<CR>]]),
            olddashboard.button("u", "  [u]pdate plugins", [[<cmd>Lazy sync<CR>]]),
            olddashboard.button("i", "  [i]nstall language tools", [[<cmd>Mason<CR>]]),
            olddashboard.button("q", "X  [q]uit", [[<cmd>qa<CR>]])
        }

        alpha.setup(dashboard.config)
    end
}
