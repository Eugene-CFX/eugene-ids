fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'eugene-ids'
author 'eugene'
version '1.0.1'
description 'player ids | Please do not try to sell this lol'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/tags.lua',
    'client/display.lua',
    'client/main.lua'
}
