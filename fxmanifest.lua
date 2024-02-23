fx_version 'cerulean'
game 'gta5'
description 'test '
version '1.0.0'
lua54 'yes'

shared_scripts { '@es_extended/imports.lua', '@ox_lib/init.lua' }

server_scripts {
   '@es_extended/locale.lua',
   'shared/Config.lua',
   'server/*.lua'
}

client_scripts {
   '@es_extended/locale.lua',
   'shared/Config.lua',
   'client/*.lua',
}

