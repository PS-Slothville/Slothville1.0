fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
games        { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Slothville Framework'
author 'Project Sloth'
version '0.0.1'

ui_page {
    'web/index.html'
}

shared_scripts {
    -- Any Extras from other scripts
    -- '@jay-dev-build/cl_init.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/cl_main.lua',
    'client/modules/cl_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/modules/sv_*.lua',
}