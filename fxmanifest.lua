fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'eugene-ids'
author 'eugene'
description 'player ids | Please do not try to sell this lol | Geeg'

dependencies {'pma-voice'}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/tags.lua',
    'client/display.lua',
    'client/main.lua'
}
