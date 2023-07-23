--[[
  Downloads Wojbie's BigFont API and adds it to the sandbox's enviroment.
]]--

if not fs.exists("/libs/bigfont.lua") then
    local bf_req = http.get("https://pastebin.com/raw/3LfWxRWh")
    local bf_code = bf_req.readAll()
    bf_req.close()

    local bf_file = fs.open("/libs/bigfont.lua", "w")
    bf_file.write(bf_code)
    bf_file.close()
end

_G.qs_env.bigfont = require("/libs/bigfont")