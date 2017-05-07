-- collectgarbage()

hs.hotkey.bind({"alt"}, "R", nil, hs.reload) 
require("general")
require("chooser")
require("menu_bar")
require("todo_list")


------------ alt + T => Show Time  -----------------------

local function ShowTime()
    if time_draw == nil then
        local full_frame = general.full_frame
        local time_str = hs.styledtext.new(os.date("%H:%M"),{font={name="Impact",size=120},color={red=255/255,blue=0/255,green=0/255,alpha=1},paragraphStyle={alignment="center"}})
        local time_frame = hs.geometry.rect((full_frame.w-300)/2,(full_frame.h-200)/2,300,150)
        time_draw = hs.drawing.text(time_frame,time_str)
        time_draw:setLevel(hs.drawing.windowLevels.overlay)
        time_draw:show()
        if ttimer == nil then
            ttimer = hs.timer.doAfter(4, function() time_draw:delete() time_draw=nil end)
        else
            ttimer:start()
        end
    else
        ttimer:stop()
        time_draw:delete()
        time_draw=nil
    end
end
hs.hotkey.bind({"alt"}, "T", nil, ShowTime)

hs.alert("All Loaded !")
