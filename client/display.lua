Display = {}

local commandOn = false
local keyHeld = false

---@return boolean
function Display.active()
    return commandOn or keyHeld
end

function Display.holdKey()
    keyHeld = true
end

function Display.releaseKey()
    keyHeld = false
end

function Display.reset()
    commandOn = false
    keyHeld = false
end

function Display.toggle()
    commandOn = not commandOn

    if commandOn then
        Tags.refresh()
    elseif Tags.hasAny() then
        Tags.clear()
    end

    lib.notify({
        title = 'Player IDs',
        description = commandOn and 'IDs on.' or 'IDs off.',
        type = 'inform',
    })
end
