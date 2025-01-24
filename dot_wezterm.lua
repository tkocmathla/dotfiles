local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Catppuccin Frappe'

config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'c', mods = 'LEADER', action = act.SpawnCommandInNewTab { args = { 'nvim', wezterm.home_dir .. '/.wezterm.lua' }}},

  -- Override accidental shift+space and shift+enter so we get the keypress instead of `;2u'
  { key = ' ', mods = 'SHIFT', action = act.SendKey{key=' '}},
  { key = 'Enter', mods = 'SHIFT', action = act.SendKey{key='Enter'}},

  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },

  -- Pane selection
  { key = 'a', mods = 'LEADER', action = act.PaneSelect },
  { key = 'o', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- Pane resizing
  { key = 'h', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Left', 5 }},
  { key = 'j', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Down', 5 }},
  { key = 'k', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Up', 5 }},
  { key = 'l', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Right', 5 }},
}

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.scrollback_lines = 10000

return config
