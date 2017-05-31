-- collectgarbage()

hs.hotkey.bind({"alt"}, "R", nil, hs.reload);
hs.hotkey.bind({"alt"}, "A", nil, function() hs.alert(hs.application.frontmostApplication()) end);





package.path = package.path .. ';modules/?.lua'
require("chooser")
require("caffeinate")
require("msg_board")
--require("relax_eyes")
require("show_time")
--require("record_your_days")
hs.alert("All Loaded !")
