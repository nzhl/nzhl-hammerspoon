print("\n\n*** todo_list  ...  ***\n\n")

require("general")

todo = {}

------------- title -------------------------

local kTitleWidth = 200
local kTitleHeight = 30

local kTitleStartX = general.full_frame.w - 400
local kTitleStartY = 100

local title_frame = hs.geometry.rect(kTitleStartX, kTitleStartY, kTitleWidth, kTitleHeight)
todo.title_text = general.CreateBackgroundText(title_frame, "说出你的故事 :", 24, {red = 209/255, green = 58/255, blue = 130/255})

--------------------- content ------------------

local kTodoWidth = 300
local kTodoHeight = 400

local kTodoStartX = general.full_frame.w - 300
local kTodoStartY = 150

local todo_frame = hs.geometry.rect(kTodoStartX, kTodoStartY, kTodoWidth, kTodoHeight)
local function GetTodoList()
    return hs.execute("cat " .. general.config_path .. "todo.txt")
end
todo.todo = general.CreateBackgroundText(todo_frame, GetTodoList(), 20, {red = 0, green = 0, blue = 1})

local function UpdateTodoList()
    todo.todo:setText(GetTodoList())
end

todo.path_watcher = hs.pathwatcher.new(general.config_path .. "todo.txt", UpdateTodoList):start()

print("\n\n*** todo_list loaded ... ***\n\n")
