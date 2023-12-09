fx_version 'adamant'
game 'gta5'
lua54 'yes'
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}
client_scripts {
    'client/cl_*.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}