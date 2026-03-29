local wezterm = require "wezterm"

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
  options = {
    theme = "Dracula (Official)",
  }
})

config = {
  automatically_reload_config = true,
  enable_tab_bar = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingUnderline",
  color_scheme = "Dracula (Official)",
  hide_mouse_cursor_when_typing = false,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = true,
  show_tab_index_in_tab_bar = false,
  show_tabs_in_tab_bar = true,
  switch_to_last_active_tab_when_closing_tab = false,
  tab_and_split_indices_are_zero_based = false,
  tab_bar_at_bottom = true,
  tab_max_width = 30,
  adjust_window_size_when_changing_font_size = false,
  font = wezterm.font("FiraCode Nerd Font", {weight=450, stretch="Normal", style="Normal"}),
  font_size = 20,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  cursor_thickness = 5,
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "EaseIn",
  cursor_blink_ease_out = "EaseOut",
  enable_scroll_bar = true,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  keys = {
    { mods = "OPT", key = "LeftArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "b" }) },
    { mods = "OPT", key = "RightArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "f" }) },
    { mods = "CMD", key = "LeftArrow", action = wezterm.action.SendKey({ mods = "CTRL", key = "a" }) },
    { mods = "CMD", key = "RightArrow", action = wezterm.action.SendKey({ mods = "CTRL", key = "e" }) },
  },
}

return config
