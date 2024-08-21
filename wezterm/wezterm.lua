local wezterm = require("wezterm")
config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    window_decorations = "RESIZE",
    --enable_tab_bar = false,
    --window_close_confirmation = "NeverPrompt",
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 700,
    use_fancy_tab_bar = true,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,

    window_frame = {
        inactive_titlebar_bg = "none",
        active_titlebar_bg = "none",
    },


    font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold"}),
    font_size = 13,
    window_background_opacity=0.9,
    macos_window_background_blur=10,
    colors = {
    	foreground = "#CBE0F0",
    	background = "#011423",
    	cursor_bg = "#47FF9C",
    	cursor_border = "#47FF9C",
    	cursor_fg = "#011423",
    	selection_bg = "#033259",
    	selection_fg = "#CBE0F0",
    	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
    	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
    },
}

return config
