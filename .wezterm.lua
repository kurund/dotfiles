-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'
-- config.color_scheme = 'Ayu Dark (Gogh)'
-- config.color_scheme = 'Ayu Mirage'
config.color_scheme = "Dracula (Official)"

-- config.font = wezterm.font 'Fira Code'
-- config.font = wezterm.font 'Cousine Nerd Font Mono'
config.font = wezterm.font("Dank Mano")

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
})

config.font_size = 14.0

config.window_background_opacity = 0.97

-- and finally, return the configuration to wezterm
return config
