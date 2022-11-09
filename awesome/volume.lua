local wibox = require("wibox")
local awful = require("awful")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
volume_widget.font = "Roboto 12"

function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = string.format("% 3d", string.match(status, "(%d?%d?%d)%%"))
   status = string.match(status, "%[(o[^%]]*)%]")
   if string.find(status, "on", 1, true) then
       widget:set_markup(volume .. "%")
   else
       widget:set_markup("M")
   end

end

update_volume(volume_widget)

mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
mytimer:start()
