local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Catppuccin Frappe'

config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },
  { key = 'a', mods = 'LEADER', action = act.PaneSelect },
  { key = 'o', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = 'c', mods = 'LEADER', action = act.SpawnCommandInNewTab { args = { 'nvim', wezterm.home_dir .. '/.wezterm.lua' }}},
}

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

return config
