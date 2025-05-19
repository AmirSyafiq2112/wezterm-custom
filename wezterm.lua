local wezterm = require 'wezterm'
local commands = require 'commands'
local constants = require 'constants'

local config = wezterm.config_builder()

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.leader = { key = 'q', mods = 'ALT', timeout_milliseconds = 2000 }

config.keys = {
  {
    mods = 'CTRL',
    key = 't',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    mods = 'CTRL',
    key = 'w',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    mods = 'CTRL',
    key = '[',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = 'CTRL',
    key = ']',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = 'LEADER',
    key = '\\',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'LEADER',
    key = '-',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'LEADER',
    key = 'h',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    mods = 'LEADER',
    key = 'l',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    mods = 'LEADER',
    key = 'k',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    mods = 'LEADER',
    key = 'j',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    mods = 'LEADER',
    key = 'LeftArrow',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    mods = 'LEADER',
    key = 'RightArrow',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    mods = 'LEADER',
    key = 'DownArrow',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  {
    mods = 'LEADER',
    key = 'UpArrow',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
}

-- Font settings
config.line_height = 1.2
config.font_size = 10

-- COLORS
config.colors = require 'cyberdream'

-- APPEARANCE
config.cursor_blink_rate = 0
-- config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = false
-- config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

wezterm.on('update-right-status', function(window, _)
  local SOLID_LEFT_ARROW = ''
  local ARROW_FOREGROUND = { Foreground = { Color = '#000' } }
  local prefix = ''

  if window:leader_is_active() then
    prefix = ' ' .. utf8.char(0x1f30a)
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = '#000' } }
  end

  window:set_left_status(wezterm.format {
    { Background = { Color = '#c6a0f6' } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  })
end)

for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i),
  })
end

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_image = constants.bg_image
config.macos_window_background_blur = 40

-- MISCELLANEOUS SETTINGS
config.max_fps = 120

-- CUSTOM COMMANDS
wezterm.on('augment-command-palette', function()
  return commands
end)

config.default_prog = { 'powershell' }

return config
