--
--  This file mainly implement the chooser functionality.
--      1. iTunes Control
--      2. Lock Screen
--

print("\n\n*** Chooser init ...  ***\n\n")

chooser = {}


local choices = {
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

local actions = {
    -- iTunes Control Part --
    hs.itunes.playpause,
    hs.itunes.next,
    hs.itunes.previous,
    -- Lock Screen Part --
    hs.caffeinate.systemSleep
}

chooser.chooser = hs.chooser.new(function(choice)
    if not choice then return end
    actions[choice.index]()
end)

chooser.chooser:queryChangedCallback(function(query_string)
    --TODO : filter choices according to the query_string
    chooser.chooser:choices(choices)
end)

hs.hotkey.bind({"alt"}, "S", nil, function() chooser:show() end)

print("\n\n*** Chooser loaded ... ***\n\n")
