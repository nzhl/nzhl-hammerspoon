local general = require("general");
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init");
local _M = {};


local apps = {}

local current_app = nil;
local time_start = nil;

-- find the top three time-consuming app
local function getText()
    if not apps then return end;
    local topThree = {};
    for k, v in pairs(apps) do
        if #topThree < 3 then
            table.insert(topThree, {k,v});
        else
            table.sort(topThree, function(left, right)
                return left[2] > right[2];
            end);
            if v > topThree[3][2] then
                topThree[3] = {k, v};
            end
        end
    end
    table.sort(topThree, function(left, right)
        return left[2] > right[2];
    end);
    local text = "";
    for k, v in ipairs(topThree) do
        text = text .. v[1] .. " : " .. math.floor(v[2] / 60) .. " min ".. math.floor(v[2] % 60) .. " sec\n"
    end
    return text;
end

local x = general.full_frame.w - 400;
local y = 350;
local w = 300;
local h = 200;
local frame = hs.geometry.rect(x, y, w, h);
_M.infoBox = general.CreateBackgroundText(frame, getText(), 16, {red = 0, green = 30, blue = 0});

_M.appWatcher = hs.application.watcher.new(function(name, event_type, app)
    local current_time = hs.timer.localTime();
    if event_type == hs.application.watcher.activated then
        if current_app then
            if apps[current_app] then
                apps[current_app] = apps[current_app] + current_time - time_start;
            else
                apps[current_app] = current_time - time_start;
            end
        end
        current_app = name;
        time_start = current_time;
        _M.infoBox:setText(getText());
    end
end):start();


general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done");
return _M;
