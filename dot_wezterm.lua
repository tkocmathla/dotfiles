local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'

config.keys = {
  {
    -- System76 LemurPro laptop "PgUp" key
    key = 'raw:104',
    mods = 'NONE',
    action = wezterm.action.SendKey { key = 'PageUp' },
  },
  {
    -- System76 LemurPro laptop "PgDn" key
    key = 'raw:109',
    mods = 'NONE',
    action = wezterm.action.SendKey { key = 'PageDown' },
  },
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
