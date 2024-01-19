---------------------------
-- Regular awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local awful = require("awful")
local themes_path = awful.util.get_configuration_dir() .. "/themes/"

local theme = {}

-- Main default settings
theme.font          = "Roboto 12"
theme.bg_normal     = "#1b1b1b"
theme.fg_normal     = "#ced4de"

--theme.useless_gap   = dpi(6)
theme.border_width  = dpi(1)
theme.border_normal = "#40444a"
theme.border_focus  = "#516d99"

-- Wibar settings
theme.wibar_bg     = "#272929"

-- Taglist settings
theme.taglist_fg_focus = "#ced4de"
theme.taglist_bg_focus = "#40444a"

-- Tasklist settings
theme.tasklist_fg_focus = "#ced4de"
theme.tasklist_bg_focus = "#40444a"
theme.tasklist_fg_normal = "#a0a6b0"
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_fg_minimize = "#6c7075"
theme.tasklist_bg_minimize = "#00000000"

-- Menu settings
theme.menu_font = "Roboto 14"
theme.menu_height = dpi(28)
theme.menu_width = dpi(700)
theme.menu_bg_focus = "#40444a"
theme.menu_fg_focus = "#ced4de"
theme.menu_bg_normal = "#272929"
theme.menu_fg_normal = "#a0a6b0"

theme.layout_fairv = themes_path .. "icons/pure/layout/fairv.png"
theme.layout_max = themes_path .. "icons/pure/layout/max.png"

return theme
