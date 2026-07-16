Tags = {}

---@enum GamerTagComponent
local comp = { name = 0, audio = 4 }

---@class TagRow
---@field tag integer
---@field ped integer
---@field label string
---@field visible? boolean
---@field talking? boolean

---@type table<integer, TagRow>
local active = {}

---@param player integer
---@return string
local function buildLabel(player)
    local name = GetPlayerName(player)
    if not name or name == '' then name = 'Unknown' end
    if #name > 75 then name = name:sub(1, 75) end
    return ('%s [%d]'):format(name, GetPlayerServerId(player))
end

---@param player integer
---@return boolean
local function isTalking(player)
    if player == cache.playerId or not MumbleIsConnected() then return false end
    return NetworkIsPlayerTalking(player)
end

---@param ped integer
---@return boolean
local function hasLos(ped)
    if Config.showThroughWalls then return true end
    return cache.ped and cache.ped ~= 0 and HasEntityClearLosToEntity(cache.ped, ped, 1)
end

---@param serverId integer
local function remove(serverId)
    local row = active[serverId]
    if not row then return end
    if IsMpGamerTagActive(row.tag) then RemoveMpGamerTag(row.tag) end
    active[serverId] = nil
end

---@param row TagRow
---@param player integer
---@param visible boolean
local function drawTag(row, player, visible)
    local talk = visible and isTalking(player)
    if row.visible == visible and row.talking == talk then return end

    row.visible = visible
    row.talking = talk

    if not visible then
        SetMpGamerTagVisibility(row.tag, comp.name, false)
        SetMpGamerTagVisibility(row.tag, comp.audio, false)
        return
    end

    SetMpGamerTagVisibility(row.tag, comp.name, true)
    SetMpGamerTagAlpha(row.tag, comp.audio, 255)
    SetMpGamerTagVisibility(row.tag, comp.audio, talk)
    SetMpGamerTagColour(row.tag, comp.audio, talk and Config.talkingHudColour or 0)
    SetMpGamerTagColour(row.tag, comp.name, talk and Config.talkingHudColour or 0)
end

---@param serverId integer
---@param player integer
---@param ped integer
---@return TagRow
local function getTag(serverId, player, ped)
    local text = buildLabel(player)
    local row = active[serverId]

    if row and (row.ped ~= ped or not IsMpGamerTagActive(row.tag) or row.label ~= text) then
        remove(serverId)
        row = nil
    end

    if not row then
        row = { tag = CreateMpGamerTag(ped, text, false, false, '', 0), ped = ped, label = text }
        active[serverId] = row
    end

    return row
end

---@return boolean
function Tags.hasAny()
    return next(active) ~= nil
end

function Tags.clear()
    for serverId in pairs(active) do remove(serverId) end
end

function Tags.refresh()
    local origin = GetEntityCoords(cache.ped)
    local maxDist = Config.distance
    local seen = {}

    for _, player in ipairs(GetActivePlayers()) do
        if player ~= cache.playerId then
            local ped = GetPlayerPed(player)
            if ped ~= 0 and DoesEntityExist(ped) and #(origin - GetEntityCoords(ped)) <= maxDist then
                local serverId = GetPlayerServerId(player)
                seen[serverId] = true
                drawTag(getTag(serverId, player, ped), player, hasLos(ped))
            end
        end
    end

    for serverId in pairs(active) do
        if not seen[serverId] then remove(serverId) end
    end
end
