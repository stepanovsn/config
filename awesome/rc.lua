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

-- For notification, use:
-- naughty.notify({text='some message'})
-- naughty.notify({text=some_string})
-- naughty.notify({text=tostring(some_number)})
-- naughty.notify({text=tostring(#some_array)})  -- for array w/o holes

-- xrandr to handle multiple monitors
local xrandr = require("xrandr")

-- Battery info
bat_percent = 0
bat_percent_prev = 0
bat_percent_critical = 5
bat_charging = false
function update_bat_percent()
    local fd = io.popen("upower -i `upower -e | grep 'BAT'` | grep 'percentage' | awk '{print $NF}' | cut -d '%' -f 1")
    bat_percent = tonumber(fd:read("*l"))
    fd:close()

    local fd = io.popen("upower -i `upower -e | grep 'BAT'` | grep 'state' | awk '{print $NF}'")
    bat_state = fd:read("*l")
    fd:close()

    if (bat_percent_prev ~= 0 and bat_percent_prev ~= bat_percent) then
        if (bat_percent_prev <= bat_percent_critical and bat_percent > bat_percent_critical) then
            awesome.restart()
        elseif (bat_percent_prev > bat_percent_critical and bat_percent <= bat_percent_critical) then
            awesome.restart()
        elseif (bat_percent < bat_percent_prev and bat_percent <= bat_percent_critical) then
            naughty.notify({text='Critical charge level'})
        end
    end

    bat_percent_prev = bat_percent

    if bat_state == "charging" then
        bat_charging = true
    else
        bat_charging = false
    end
end
update_bat_percent()

-- Bluetooth widget
function update_bt_widget(widget)
    local fd = io.popen("bluetoothctl devices Connected | cut -d' ' -f 3-")
    local bt = fd:read("*all")
    fd:close()

    if (bt ~= nil and bt ~= '') then
        device = bt:sub(1, -2)

        local max_device_len = 14
        if string.len(device) > max_device_len then
            device = string.sub(device, 1, max_device_len - 2) .. '..'
        end

        widget:set_markup('<span color="#6c7075">Blu: </span><span color="#4aa881">' .. device .. '</span>')
    else
        widget:set_markup('')
    end
end

bt_widget = wibox.widget.textbox()
bt_widget.font = "Roboto 12"
update_bt_widget(bt_widget)

-- Volume widget
function update_volume_widget(widget)
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = string.format("% 3d", string.match(status, "(%d?%d?%d)%%"))
    status = string.match(status, "%[(o[^%]]*)%]")
    if string.find(status, "on", 1, true) then
        widget:set_markup('<span color="#6c7075">Vol: </span>' .. volume)
    else
        widget:set_markup('<span color="#6c7075">Vol: </span><span color="#bd5b5b">Mute</span>')
    end
end

volume_widget = wibox.widget.textbox()
volume_widget.font = "Roboto 12"
update_volume_widget(volume_widget)

-- Battery widget
function update_battery_widget(widget)
    if bat_charging == true then
        widget:set_markup('<span color="#6c7075">Bat: </span><span color="#4aa881">' .. bat_percent .. '</span>')
    elseif bat_percent < 20 then
        widget:set_markup('<span color="#6c7075">Bat: </span><span color="#bd5b5b">' .. bat_percent .. '</span>')
    elseif bat_percent < 40 then
        widget:set_markup('<span color="#6c7075">Bat: </span><span color="#cfac67">' .. bat_percent .. '</span>')
    else
        widget:set_markup('<span color="#6c7075">Bat: </span>' .. bat_percent)
    end
end

battery_widget = wibox.widget.textbox()
battery_widget.font = "Roboto 12"
update_battery_widget(battery_widget)

-- Network widget
function update_network_widget(widget)
    local fd = io.popen("nmcli -t -f STATE general")
    local status = fd:read("*l")
    fd:close()

    if status == "connected" then
        local fd = io.popen("nmcli -t -f NAME c show --active | head -n 1")
        name = fd:read("*l")
        fd:close()

        local max_name_len = 14
        if string.len(name) > max_name_len then
            name = string.sub(name, 1, max_name_len - 2) .. '..'
        end

        widget:set_markup('<span color="#6c7075">Net: </span>' .. name)
    else
        widget:set_markup('<span color="#6c7075">Net: </span><span color="#bd5b5b">Disconnected</span>')
    end
end

network_widget = wibox.widget.textbox()
network_widget.font = "Roboto 12"
update_network_widget(network_widget)

-- Language widget
function update_lang_widget(widget)
    local fd = io.popen("xkblayout-state print \"%s\"")
    local lang = fd:read("*l")
    fd:close()

    if lang == "us" then
        widget:set_markup('<span color="#6c7075">Lan: </span>Eng')
    elseif lang == "ru" then
        widget:set_markup('<span color="#6c7075">Lan: </span>Rus')
    else
        widget:set_markup('<span color="#6c7075">Lan: </span>' .. lang)
    end
end

lang_widget = wibox.widget.textbox()
lang_widget.font = "Roboto 12"
update_lang_widget(lang_widget)

-- Language widget
function update_lang_widget(widget)
    local fd = io.popen("xkblayout-state print \"%s\"")
    local lang = fd:read("*l")
    fd:close()

    if lang == "us" then
        widget:set_markup('<span color="#6c7075">Lan: </span>Eng')
    elseif lang == "ru" then
        widget:set_markup('<span color="#6c7075">Lan: </span>Rus')
    else
        widget:set_markup('<span color="#6c7075">Lan: </span>' .. lang)
    end
end

lang_widget = wibox.widget.textbox()
lang_widget.font = "Roboto 12"
update_lang_widget(lang_widget)

-- Date widget
function update_date_widget(widget)
    local fd = io.popen("date '+%b %-d, %a'")
    local datetime = fd:read("*l")
    fd:close()

    widget:set_markup('<span color="#6c7075">Dat: </span>' .. datetime)
end

date_widget = wibox.widget.textbox()
date_widget.font = "Roboto 12"
update_date_widget(date_widget)

-- Time widget
function update_time_widget(widget)
    local fd = io.popen("date '+%-H:%M'")
    local datetime = fd:read("*l")
    fd:close()

    widget:set_markup('<span color="#6c7075">Tim: </span>' .. datetime)
end

time_widget = wibox.widget.textbox()
time_widget.font = "Roboto 12"
update_time_widget(time_widget)

-- Common widget timer
common_sec_timer = timer({ timeout = 1 })
common_sec_timer:connect_signal("timeout",
    function ()
        update_bat_percent()

        update_battery_widget(battery_widget)
        update_bt_widget(bt_widget)
        update_network_widget(network_widget)
        update_date_widget(date_widget)
    end)
common_sec_timer:start()

common_200_ms_timer = timer({ timeout = 0.2 })
common_200_ms_timer:connect_signal("timeout",
    function ()
        update_volume_widget(volume_widget)
        update_lang_widget(lang_widget)
        update_time_widget(time_widget)
    end)
common_200_ms_timer:start()

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
if bat_percent <= bat_percent_critical then
    beautiful.init(gears.filesystem.get_dir("config") .. "themes/pure_red.lua")
else
    beautiful.init(gears.filesystem.get_dir("config") .. "themes/pure.lua")
end

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
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --awful.layout.suit.floating,
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
            width = 180,
            widget = wibox.container.constraint,
        }
    }
    local mylayoutbox = awful.widget.layoutbox(s)

    -- Create the wibox
    s.mywibox = awful.wibar(
        {
            position = "top",
            screen = s,
            visible = true,
            height = 32,
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
                    --right = 18,
                    --widget = wibox.container.margin
                --},
                {
                    {
                        widget = bt_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = battery_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = volume_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = network_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = lang_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = date_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    {
                        widget = time_widget
                    },
                    right = 18,
                    widget = wibox.container.margin
                },
                {
                    mylayoutbox,
                    right = 18,
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
    -- Open Chromium
    awful.key({ modkey}, "F2", function () awful.spawn("chromium") end),
    -- Open Telegram
    awful.key({ modkey}, "F3", function () awful.spawn("telegram-desktop") end),
    -- Open Thunar
    awful.key({ modkey}, "F5", function () awful.spawn("thunar") end),
    -- Reload awesome
    awful.key({ modkey, "Control" }, "r", function ()
        xrandr.disable_disconnected_outputs()
        awful.util.spawn_with_shell("~/.fehbg")
        awesome.restart()
    end),
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

    -- Go to left screen
    awful.key({ modkey }, "i", function () awful.screen.focus_bydirection("left") end),
    -- Go to right screen
    awful.key({ modkey }, "o", function () awful.screen.focus_bydirection("right") end),

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
          end),

    -- Make a screenshot
    awful.key({ modkey }, "s",
        function()
            awful.util.spawn_with_shell("scrot -q 100 ~/screenshots/%Y-%m-%d_%H:%M:%S.jpg")
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
    -- Move to left screen
    awful.key({ modkey, "Shift"}, "i",
        function (c)
            local leftScreen = c.screen:get_next_in_direction("left")
            if leftScreen then
                c:move_to_screen(leftScreen.index)
            end
        end),
    -- Move to right screen
    awful.key({ modkey, "Shift"}, "o",
        function (c)
            local rightScreen = c.screen:get_next_in_direction("right")
            if rightScreen then
                c:move_to_screen(rightScreen.index)
            end
        end),
    -- Move to right tag
    awful.key({ modkey, "Shift"   }, "l",
        function (c)
            local new_tag_index = math.fmod(c.first_tag.index, 3) + 1
            local tag = awful.screen.focused().tags[new_tag_index]
            c:move_to_tag(tag)
            awful.tag.viewnext()
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
            awful.tag.viewprev()
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
                     size_hints_honor = false,
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

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    local max_layout = s.selected_tag.layout == awful.layout.suit.max
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or max_layout or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width -- your border width
        end
    end
end)
