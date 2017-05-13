--
--  This module mainly implement the chooser functionality.
--      1. iTunes Control
--      2. Lock Screen
--

local general = require("general");
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init")

local _M = {};

local function getChoices()
    return {
        -- iTunes Control Part --
        {
            text = hs.itunes.isPlaying() and "Pause" or "Play",
            subText = hs.itunes.getCurrentTrack() and "Current Playing : " .. hs.itunes.getCurrentTrack() or "Start Now",
            index = 1
        },
        {
            text = "Next",
            index = 2
        },
        {
            text = "Previous",
            index = 3
        },
        -- Lock Screen Part --
        {
            text = "Lock Screen",
            index = 4
        }
    }
end

local actions = {
    -- iTunes Control Part --
    hs.itunes.playpause,
    hs.itunes.next,
    hs.itunes.previous,
    -- Lock Screen Part --
    hs.caffeinate.systemSleep
}

local chooser = hs.chooser.new(function(choice)
    if not choice then return end
    actions[choice.index]()
end)

chooser:queryChangedCallback(function(query_string)
    --TODO : filter choices according to the query_string
    chooser:choices(getChoices())
end)

hs.hotkey.bind({"alt"}, "S", nil, function() chooser:show() end)


general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done")
return _M;
