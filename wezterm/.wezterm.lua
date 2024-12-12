local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("JetBrainsMonoNL Nerd Font")

config.color_scheme = "Catppuccin Mocha"
-- config.window_background_opacity = 0.75

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.default_cursor_style = "SteadyUnderline"
config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}

-- config.window_padding = {
--     left = 2,
--     right = 0,
--     top = 0,
--     bottom = 0,
-- }

return config
