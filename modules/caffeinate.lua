--
--  This module mainly implement the menu bar caffeinate,
--  default behavior is keep screen on, click to toggle it.
--

local general = require("general")
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init")
local _M = {}

------------------------  screen always on -----------------------

hs.caffeinate.set("displayIdle", true)

_M.caffeinate = hs.menubar.new()
_M.caffeinate:setTitle("☕️")

local isOn = true
_M.caffeinate:setClickCallback(function ()
    if isOn then 
        isOn= false
        hs.caffeinate.set("displayIdle", false)
        _M.caffeinate:setTitle("✘ ");
    else
        isOn= true
        hs.caffeinate.set("displayIdle", true)
    _M.caffeinate:setTitle("☕️");
    end
end)

general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done")
return _M;
