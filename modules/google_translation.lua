--
--  This module mainly implement the google translation service.
--

local general = require("general");
general.printM(debug.getinfo(1).source:match(".*/(.*)"), "init")

local _M = {};

local DETECT_URL = 
    "https://translation.googleapis.com/language/translate/v2/detect" ..
    "?q=%s&key=%s"
local TRANSLATE_URL = 
    "https://translation.googleapis.com/language/translate/v2" ..
    "?q=%s&target=%s&key=%s"
-- local WEB_URL = "https://translate.google.com/#%s/%s/%s"
local WEB_URL = "http://dict.youdao.com/search?q=%s&keyfrom=fanyi.smartResult"
local API_KEY = "AIzaSyBp1uK0d8tjnwsAPVLO3VillYipV54ojfY"



local translator = hs.chooser.new(function(choice)
    if not choice then return end
    url = string.format(WEB_URL, hs.http.encodeForQuery(choice.keyword))
    hs.execute("open " .. url)
end)

translator:queryChangedCallback(function(query_string)
    if query_string == "" then
        return
    end

    status, content = hs.http.asyncPost(
        string.format(DETECT_URL, hs.http.encodeForQuery(query_string),
                      API_KEY),
        nil,
        nil,
        function(status, content, header)
            if status ~= 200 then
                source = nil
            else
                json = hs.json.decode(content)
                source = json.data.detections[1][1].language
            end
            if source ~= "zh-CN" then
                target = "zh"
            else
                target = "en"
            end
            status, content = hs.http.asyncGet(
                string.format(TRANSLATE_URL,
                              hs.http.encodeForQuery(query_string),
                              target, API_KEY),
                nil,
                function(status, content, header)
                    if status ~= 200 then
                        list = {
                            {
                                index = 1,
                                text = "Result Not Found",
                                source = source,
                                target = target,
                                keyword = query_string
                            }
                        }
                    else
                        json = hs.json.decode(content)
                        list = {
                            {
                                index = 1,
                                text = json.data.translations[1].translatedText,
                                source = source,
                                target = target,
                                keyword = query_string
                            }
                        }
                    end
                    translator:choices(list)
                end
            )
        end
    )
end)

hs.hotkey.bind({"shift"}, "space", nil, function() translator:show() end)


general.printM(debug.getinfo(1).source:match(".*/(.*)"), "done")
return _M;
