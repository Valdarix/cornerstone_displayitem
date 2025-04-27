fx_version 'cerulean'
game 'gta5'

author 'ValdarixGames'
description 'Simple script to display item images on the players screen for 5 seconds.'
version '0.0.2a'

client_script 'client/client.lua'
server_script 'server/server.lua'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua'
}

files {
    'html/index.html'
}

dependencies {
    'ox_inventory'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
