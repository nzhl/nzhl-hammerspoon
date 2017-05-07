print("\n\n*** Menu bar init ...  ***\n\n")

require("general")

menu_bar = {}

------------------------  screen always on -----------------------

hs.caffeinate.set("displayIdle", true)
menu_bar.caffeinate = hs.menubar.new()
menu_bar.caffeinate:setTitle("☕️")

local isOn = true
menu_bar.caffeinate:setClickCallback(function ()
    if isOn then 
        isOn= false
        hs.caffeinate.set("displayIdle", false)
        menu_bar.caffeinate:setTitle("✘ ");
    else
        isOn= true
        hs.caffeinate.set("displayIdle", true)
        menu_bar.caffeinate:setTitle("☕️");
    end
end
)


----------------- timer ----------------------------------

local alreadyStart = false 

local function SetTimer(minutes)
    alreadyStart = true
    seconds_left = minutes * 60
    menu_bar.timer_timer = hs.timer.doUntil(
    function()
        if seconds_left == 0 then
            local notify = hs.notify.new(nil, {title="TIME OVER"})
            notify:setIdImage(general.config_path .. "resources/timer.png")
            notify:send()
            menu_bar.timer:setTitle("⏱")
            alreadyStart = false
            return true
        end
    end,
    function()
        seconds_left = seconds_left - 1
        menu_bar.timer:setTitle("⏱ " ..
        (math.floor(seconds_left / 60) < 10 and "0" .. math.floor(seconds_left / 60) or math.floor(seconds_left / 60)) 
        .. ":" .. (math.floor(seconds_left % 60) < 10 and "0" .. math.floor(seconds_left % 60) or math.floor(seconds_left % 60)))
    end,
    1)
end



local function GetMenu()
    if not alreadyStart then
        return {
            {title = "15 minutes", fn = function() SetTimer(15) end},
            {title = "30 minutes", fn = function() SetTimer(30) end},
            {title = "45 minutes", fn = function() SetTimer(45) end},
            {title = "60 minutes", fn = function() SetTimer(60) end}
        }
    else
        return {}
    end
end

menu_bar.timer = hs.menubar.new()
menu_bar.timer:setTitle("⏱")
menu_bar.timer:setMenu(GetMenu)

print("\n\n*** Menu bar loaded ... ***\n\n")
