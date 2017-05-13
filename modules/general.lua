--
--  This module defines some frequently used variables and  functions.
--

local _M = {};

function _M.printM(module_name, label)
    print("\n\n[" .. module_name .. "->" .. label .. "]\n\n")
end

_M.config_path = os.getenv("HOME") .. "/.hammerspoon/"

_M.main_screen = hs.screen.mainScreen()
_M.full_frame = _M.main_screen:fullFrame()

function _M.CreateBackgroundText(frame, string, font_size, color)
    local text = hs.drawing.text(frame, hs.styledtext.ansi(string, {font={size=font_size}, color = color}))
    text:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    text:setLevel(hs.drawing.windowLevels.desktop)
    text:show()
    return text
end

function _M.CreateBackgroundImage(frame, image_path)
    local image = hs.drawing.image(frame, image_path)
    image:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    image:setLevel(hs.drawing.windowLevels.desktop)
    image:show()
    return image
end

return _M;
