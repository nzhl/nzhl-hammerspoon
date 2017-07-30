--
--  This module defines some frequently used variables and functions.
--

local _M = {};

function _M.printM(module_name, status)
    print("\n\n[" .. module_name .. "->" .. status .. "]\n\n")
end

_M.config_path = os.getenv("HOME") .. "/.hammerspoon/"

_M.main_screen = hs.screen.mainScreen()
_M.full_frame = _M.main_screen:fullFrame()


return _M;
