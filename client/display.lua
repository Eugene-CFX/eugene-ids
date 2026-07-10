Display = {}

local commandOn = false
local keyHeld = false

function Display.active()
    return commandOn or keyHeld
end

function Display.setKey(on)
    keyHeld = on
end

function Display.reset()
    commandOn = false
    keyHeld = false
end

function Display.toggle(notify)
    commandOn = not commandOn

    if commandOn then
        Tags.refresh()
    elseif Tags.hasAny() then
        Tags.clear()
    end

    if not notify then return end

    lib.notify({
        title = 'Player IDs',
        description = commandOn and 'IDs on.' or 'IDs off.',
        type = 'inform',
    })
end
