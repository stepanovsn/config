-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- xrandr to handle multiple monitors
local xrandr = require("xrandr")

-- Volume widget
function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = string.format("% 3d", string.match(status, "(%d?%d?%d)%%"))
   status = string.match(status, "%[(o[^%]]*)%]")
   if string.find(status, "on", 1, true) then
       volume = volume .. "%"
   else
       volume = "M"
   end

   widget:set_markup(volume)
end

volumewidget = wibox.widget.textbox()
volumewidget.font = "Roboto 12"
update_volume(volumewidget)

volumetimer = timer({ timeout = 0.2 })
volumetimer:connect_signal("timeout", function () update_volume(volumewidget) end)
volumetimer:start()

-- Battery widget
function update_battery(widget)
   local fd = io.popen("upower -i `upower -e | grep 'BAT'` | grep 'percentage' | awk '{print $NF}' | cut -d '%' -f 1")
   local percent = tonumber(fd:read("*l"))
   if percent < 20 then
       widget:set_markup('<span color="#bd5b5b">' .. percent .. '%</span>')
   elseif percent < 50 then
       widget:set_markup('<span color="#ebcb8b">' .. percent .. '%</span>')
   else
       widget:set_markup(percent .. "%")
   end
   fd:close()
end

batterywidget = wibox.widget.textbox()
batterywidget.font = "Roboto 12"
update_battery(batterywidget)

batterytimer = timer({ timeout = 5 })
batterytimer:connect_signal("timeout", function () update_battery(batterywidget) end)
batterytimer:start()

-- Network widget
function update_network(widget)
   local fd = io.popen("nmcli -t -f STATE general")
   if fd:read("*l") == "connected" then
       widget:set_markup("con")
   else
       widget:set_markup("dis")
   end
   fd:close()
end

networkwidget = wibox.widget.textbox()
networkwidget.font = "Roboto 12"
update_network(networkwidget)

networktimer = timer({ timeout = 1 })
networktimer:connect_signal("timeout", function () update_network(networkwidget) end)
networktimer:start()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

lockscreen = function() awful.util.spawn("slock") end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_dir("config") .. "themes/regular/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.floating,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Open terminal", terminal },
                                    { "Lock", lockscreen }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 16,
                right = 16,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout  = { layout = wibox.layout.fixed.horizontal },
        widget_template =
        {
            {
                {
                    {
                        {
                            id     = "text_role",
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left  = 14,
                    right = 14,
                    widget = wibox.container.margin
                },
                id     = "background_role",
                widget = wibox.container.background,
            },
            strategy = max,
            width = 300,
            widget = wibox.container.constraint,
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar(
        {
            position = "top",
            screen = s,
            visible = true,
        })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist,
        {
            {
                --{
                    --{
                        --widget = wibox.widget.systray()
                    --},
                    --right = 24,
                    --widget = wibox.container.margin
                --},
                {
                    {
                        widget = batterywidget
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = volumewidget
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = networkwidget
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = awful.widget.keyboardlayout()
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                {
                    {
                        format = "%b %e, %a",
                        widget = wibox.widget.textclock()
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                {
                    {
                        format = "%R",
                        widget = wibox.widget.textclock()
                    },
                    right = 24,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left = 48,
            widget = wibox.container.margin
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- Key bindings
globalkeys = gears.table.join(
    -- Open terminal
    awful.key({ modkey}, "Return", function () awful.spawn(terminal) end),
    -- Open Firefox
    awful.key({ modkey}, "F1", function () awful.spawn("firefox") end),
    -- Open Telegram
    awful.key({ modkey}, "F2", function () awful.spawn("telegram-desktop") end),
    -- Reload awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    -- Quit awesome
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    -- Go to left tag
    awful.key({ modkey}, "h", awful.tag.viewprev),
    -- Go to right tag
    awful.key({ modkey}, "l", awful.tag.viewnext),
    -- Go to previous tag
    awful.key({ modkey}, "Escape", lockscreen),

    -- Focus next client
    awful.key({ modkey}, "j", function () awful.client.focus.byidx( 1) end),
    -- Focus previous client
    awful.key({ modkey}, "k", function () awful.client.focus.byidx(-1) end),
    -- Swap with next client
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1) end),
    -- Swap with previous client
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1) end),

    -- Go to next screen
    awful.key({ modkey }, "i", function () awful.screen.focus_relative( 1) end),

    -- Switch to next layout
    awful.key({ modkey}, "space", function () awful.layout.inc(1) end),
    -- Switch to previous layout
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end),

    -- Focus restored client
    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal( "request::activate", "key.unminimize", {raise = true})
            end
        end),

    -- Show clients
    awful.key({ modkey }, "Tab",
        function ()
            clients = {}
            for i, c in pairs(client.get()) do
                clients[i] =
                {
                    c.name,
                    function()
                        c.first_tag:view_only()
                        client.focus = c
                    end
                }
            end
            awful.menu(clients):show()
        end),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Handle multiple monitors
    awful.key({ modkey }, "d", function() xrandr.xrandr() end),

    -- Toggle wibox visibility
    awful.key({ modkey }, "b",
          function ()
              myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
          end)
)

clientkeys = gears.table.join(
    -- Minimize
    awful.key({ modkey}, "n", function (c) c.minimized = true end),
    -- Maximize
    awful.key({ modkey}, "m", function (c) c.maximized = not c.maximized c:raise() end),
    -- Make fullscreen
    awful.key({ modkey}, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
    -- Kill
    awful.key({ modkey, "Shift"   }, "c", function (c) c:kill() end),
    -- Toggle floating
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    -- Move to another screen
    awful.key({ modkey}, "o", function (c) c:move_to_screen() end),
    -- Move to right tag
    awful.key({ modkey, "Shift"   }, "l",
        function (c)
            local new_tag_index = math.fmod(c.first_tag.index, 3) + 1
            local tag = awful.screen.focused().tags[new_tag_index]
            c:move_to_tag(tag)
        end),
    -- Move to left tag
    awful.key({ modkey, "Shift"   }, "h",
        function (c)
            local new_tag_index = c.first_tag.index - 1
            if new_tag_index == 0 then
                new_tag_index = 3
            end
            local tag = awful.screen.focused().tags[new_tag_index]
            c:move_to_tag(tag)
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
