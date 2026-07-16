---@alias DisplayMode 'toggle' | 'hold'

---@class Config
---@field distance number # range in meters
---@field keybind string # default key, rebindable in the FiveM key bindings menu
---@field command string # chat command that toggles the display
---@field displayMode DisplayMode # toggle with one press, or show only while held
---@field showThroughWalls boolean # show tags through walls
---@field refreshInterval integer # milliseconds between ID refreshes
---@field talkingHudColour integer # hud color index shown while a player talks
Config = {
    distance = 25.0,
    keybind = 'HOME',
    command = 'ids',
    displayMode = 'toggle',
    showThroughWalls = false,
    refreshInterval = 250,
    talkingHudColour = 18
}

-- geeg
