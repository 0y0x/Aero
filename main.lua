local BASE_URL = "https://raw.githubusercontent.com/0y0x/Aero/refs/heads/main/"

local Games = {
    [286090429] = "games/arsenal.lua",
}

local ScriptURL = Games[game.PlaceId] or "universal.lua"

local Success, Source = pcall(function()
    return game:HttpGet(BASE_URL .. ScriptURL)
end)

if not Success then
    warn("[Aero] Failed to load script: " .. tostring(Source))
    return
end

local Script, Error = loadstring(Source)

if not Script then
    warn("[Aero] Failed to compile script: " .. tostring(Error))
    return
end

local Success, Error = pcall(Script)

if not Success then
    warn("[Aero] Script error: " .. tostring(Error))
end
