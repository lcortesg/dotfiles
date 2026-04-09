local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Frappe"
    else
        return "Catppuccin Latte"
    end
end

local function tab_colors_for_scheme(scheme)
    if scheme == "Catppuccin Frappe" then
        return {
            background = "#303446", -- base

            active_tab = {
                bg_color = "#ca9ee6", -- mauve
                fg_color = "#232634", -- crust
            },

            inactive_tab = {
                bg_color = "#414559", -- surface0
                fg_color = "#c6d0f5", -- text
            },

            new_tab = {
                bg_color = "#414559",
                fg_color = "#a5adce", -- subtext0
            },
        }
    else
        return {
            background = "#eff1f5", -- base

            active_tab = {
                bg_color = "#8839ef", -- mauve
                fg_color = "#e6e9ef", -- crust
            },

            inactive_tab = {
                bg_color = "#ccd0da", -- surface0
                fg_color = "#4c4f69", -- text
            },

            new_tab = {
                bg_color = "#ccd0da",
                fg_color = "#6c6f85", -- subtext0
            },
        }
    end
end

-- detect appearance safely
local appearance = wezterm.gui and wezterm.gui.get_appearance() or "Dark"
local scheme = scheme_for_appearance(appearance)

config.color_scheme = scheme

config.automatically_reload_config = true
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.enable_tab_bar = true
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Bold" })
config.font_size = 13
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

-- ✅ Catppuccin-matched tabs
config.colors = {
    tab_bar = tab_colors_for_scheme(scheme),
}

config.window_padding = {
    top = 60,
    left = 6,
    right = 6,
    bottom = 6,
}

return config
