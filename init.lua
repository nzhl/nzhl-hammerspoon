-- collectgarbage()

hs.hotkey.bind({"alt"}, "R", nil, hs.reload);


package.path = package.path .. ';' .. hs.configdir .. '/modules/?.lua'
require("google_translation")
require("caffeinate")
hs.alert("All Loaded !")
