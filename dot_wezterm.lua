local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

local config = wezterm.config_builder()

config.font_size = 14
config.color_scheme = 'Catppuccin Frappe'
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000
config.warn_about_missing_glyphs = false

config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'c', mods = 'LEADER', action = act.SpawnCommandInNewTab { args = { 'nvim', wezterm.home_dir .. '/.wezterm.lua' }}},

  -- Override accidental shift+space and shift+enter so we get the keypress instead of `;2u'
  { key = ' ', mods = 'SHIFT', action = act.SendKey{key=' '}},
  { key = 'Enter', mods = 'SHIFT', action = act.SendKey{key='Enter'}},

  -- General
  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },

  -- Pane selection
  { key = 'a', mods = 'LEADER', action = act.PaneSelect },
  { key = 'o', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Prev' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Next' },

  -- Pane resizing
  { key = 'h', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Left', 5 }},
  { key = 'j', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Down', 5 }},
  { key = 'k', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Up', 5 }},
  { key = 'l', mods = 'CTRL|SHIFT|ALT', action = act.AdjustPaneSize { 'Right', 5 }},

  -- Tab movement
  { key = '[', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.MoveTabRelative(1) },

  -- Interactively rename current tab
  -- https://wezterm.org/config/lua/keyassignment/PromptInputLine.html#example-of-interactively-renaming-the-current-tab
  {
    key = 'n',
    mods = 'CTRL|SHIFT|ALT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- Adds a bell icon to the tab title when unseen output is detected.
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab.tab_title
    if title == "" then
      title = tab.active_pane.title
    end

    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
    if has_unseen_output then
      return {{ Text = '\u{f0a2}  ' .. title .. ' ' }}
    end

    return title
  end
)

return config
