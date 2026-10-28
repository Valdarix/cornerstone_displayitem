fx_version 'cerulean'
game 'gta5'

author 'Cornerstone Scripts'
name 'Cornerstone - Display Item'
description 'Shows the picture of an inventory item on the player screen for a few seconds when another script asks for it, as long as the player carries that item.'
version '0.0.4'

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

escrow_ignore {
    'config/config.lua',
}

dependencies {
    'ox_inventory'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
