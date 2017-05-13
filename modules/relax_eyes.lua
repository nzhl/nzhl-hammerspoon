--
--  This module mainly used to relax my eyes.
--  Change the variable `relax_interval` to set your working interval (unit: minute).
--
local general = require("general");
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init");
local _M = {};

local relax_interval = 45;
local seconds_left = relax_interval * 60;

_M.relax_widget = hs.menubar.new();

_M.timer = hs.timer.doEvery(1, function()
    if seconds_left == 0 then
        hs.caffeinate.systemSleep();
        return;
    elseif seconds_left == 10 then
        hs.alert("10s Left To Relax Yourself !");
    end
    seconds_left = seconds_left - 1;
    _M.relax_widget:setTitle("⏱ " .. (math.floor(seconds_left / 60) < 10 and "0" .. math.floor(seconds_left / 60) or math.floor(seconds_left / 60))
    .. ":" .. (math.floor(seconds_left % 60) < 10 and "0" .. math.floor(seconds_left % 60) or math.floor(seconds_left % 60)));
end):start();

_M.watcher = hs.caffeinate.watcher.new(function(screen_event)
    if screen_event == hs.caffeinate.watcher.screensDidUnlock then
        _M.timer:start();
    elseif screen_event == hs.caffeinate.watcher.screensDidLock then
        seconds_left = relax_interval * 60;
        _M.timer:stop();
    end
end):start();

general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done")
return _M;
