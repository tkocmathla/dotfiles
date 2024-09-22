local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Catppuccin Frappe'

config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|CTRL',
    action = act.ToggleFullScreen,
  },
  {
    key = 'r',
    mods = 'SHIFT|CTRL',
    action = act.ReloadConfiguration,
  },
  {
    key = 'a',
    mods = 'SHIFT|CTRL',
    action = act.PaneSelect,
  }
}

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

return config
