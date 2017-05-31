--  This file mainly defined the left desktop should shows.

local general = require("general");
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init")
local _M = {};


------------- title -------------------------

local kTitleWidth = 200
local kTitleHeight = 30

local kTitleStartX = general.full_frame.w - 400
local kTitleStartY = 100

local title_frame = hs.geometry.rect(kTitleStartX, kTitleStartY, kTitleWidth, kTitleHeight)
_M.title_text = general.CreateBackgroundText(title_frame, "说出你的故事 :", 24, {red = 209/255, green = 58/255, blue = 130/255})

--------------------- content ------------------

local kTodoWidth = 300
local kTodoHeight = 200

local kTodoStartX = general.full_frame.w - 300
local kTodoStartY = 150

local todo_frame = hs.geometry.rect(kTodoStartX, kTodoStartY, kTodoWidth, kTodoHeight)
local function GetTodoList()
    return hs.execute("cat " .. general.config_path .. "todo.txt")
end
_M.todo = general.CreateBackgroundText(todo_frame, GetTodoList(), 20, {red = 0, green = 0, blue = 1})

local function UpdateTodoList()
    _M.todo:setText(GetTodoList())
end

_M.path_watcher = hs.pathwatcher.new(general.config_path .. "todo.txt", UpdateTodoList):start()

--------------------  image ----------------

local image_frame = hs.geometry.rect(general.full_frame.w - 600, general.full_frame.h - 300, 600, 400);
_M.image = general.CreateBackgroundImage(image_frame, general.config_path .. "resources/timetable.png")
_M.image:show();

general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done")
return _M;
