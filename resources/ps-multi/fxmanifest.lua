fx_version 'cerulean'
game 'gta5'

description 'Slothville Multicharacter'
author 'jay'
version '0.0.1'

shared_script '@ox_lib/init.lua'
shared_script 'init.lua'

ui_page {
    'ui/index.html'
}

files {
    'ui/index.html',
    'ui/script.js',
    'ui/style.css',
    'ui/*',
    'ui/fonts/*',
    'ui/img/*',

    'modules/**/client.lua',
    'shared/config.lua',
    'client.lua',
}

lua54 'yes'