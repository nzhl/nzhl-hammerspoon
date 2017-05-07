--
--  This module mainly define some general used tool functions that will be used by other specific modules.
--

general = {}

general.config_path = os.getenv("HOME") .. "/.hammerspoon/"


general.main_screen = hs.screen.mainScreen()
general.full_frame = general.main_screen:fullFrame()

function general.CreateBackgroundText(frame, string, font_size, color)
    local text = hs.drawing.text(frame, hs.styledtext.ansi(string, {font={size=font_size}, color = color}))
    text:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    text:setLevel(hs.drawing.windowLevels.desktop)
    text:show()
    return text
end

function general.CreateBackgroundImage(frame, image_path)
    local image = hs.drawing.image(frame, image_path)
    image:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    image:setLevel(hs.drawing.windowLevels.desktop)
    image:show()
    return image
end

