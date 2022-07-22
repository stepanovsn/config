---------------------------
-- Regular awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")

local theme = {}

-- Main default settings
theme.font          = "Roboto 12"
theme.bg_normal     = "#282e38"
theme.fg_normal     = "#c0c7d1"

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(2)
theme.border_normal = "#343d4d"
theme.border_focus  = "#548abf"

-- Wibar settings
theme.wibar_bg     = "#282e38cc"

-- Taglist settings
theme.taglist_fg_focus = "#d8dde6"
theme.taglist_bg_focus = "#404c61"

-- Tasklist settings
theme.tasklist_fg_focus = "#d8dde6"
theme.tasklist_bg_focus = "#404c61"
theme.tasklist_fg_minimize = "#757a82"

-- Menu settings
theme.menu_font = "Roboto 14"
theme.menu_height = dpi(28)
theme.menu_width = dpi(700)
theme.menu_bg_focus = "#343d4d"
theme.menu_fg_focus = "#c0c7d1"
theme.menu_bg_normal = "#232830"
theme.menu_fg_normal = "#a0a6b0"

return theme
