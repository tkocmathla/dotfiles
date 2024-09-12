local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'

config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'r',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ReloadConfiguration,
  },
}

return config
