fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Itemized showing badge'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/cl_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/sv_*.lua',
}

ui_page 'html/index.html'

files {
	'html/*',
}