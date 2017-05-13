-- collectgarbage()

hs.hotkey.bind({"alt"}, "R", nil, hs.reload);

package.path = package.path .. ';modules/?.lua'
require("chooser")
require("caffeinate")
require("msg_board")
require("relax_eyes")
hs.alert("All Loaded !")
