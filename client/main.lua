if not lib then
    return print('^1[eugene-ids]^0 ox_lib must be started before this resource.')
end

SetMpGamerTagsVisibleDistance(Config.distance)

local hold = Config.displayMode == 'hold'

CreateThread(function()
    while true do
        if Display.active() then
            Tags.refresh()
            Wait(Config.refreshInterval)
        elseif Tags.hasAny() then
            Tags.clear()
            Wait(Config.refreshInterval)
        else
            Wait(500)
        end
    end
end)

lib.addKeybind({
    name = 'eugene_ids',
    description = 'Show player IDs',
    defaultKey = Config.keybind,
    onPressed = function()
        if hold then
            Display.setKey(true)
            Tags.refresh()
            return
        end
        Display.toggle(true)
    end,
    onReleased = function()
        if not hold then return end
        Display.setKey(false)
        if not Display.active() and Tags.hasAny() then Tags.clear() end
    end,
})

RegisterCommand(Config.command, function()
    Display.toggle(true)
end, false)

TriggerEvent('chat:addSuggestion', '/' .. Config.command, 'toggle ids')

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Display.reset()
    Tags.clear()
end)
