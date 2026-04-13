local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.window_decorations = "RESIZE"
--config.enable_tab_bar = false
--config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold" })
config.font_size = 13
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.colors = {
    foreground = "#CBE0F0",
    background = "#011423",
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#CBE0F0",
    ansi = {
        "#214969", "#E52E2E", "#44FFB1", "#FFE073",
        "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7"
    },
    brights = {
        "#214969", "#E52E2E", "#44FFB1", "#FFE073",
        "#A277FF", "#a277ff", "#24EAF7", "#24EAF7"
    },
}

return config
