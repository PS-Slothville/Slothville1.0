fx_version 'adamant'

game 'gta5'
lua54 'yes'

shared_scripts {
    -- Any Extras from other scripts
    -- '@jay-dev-build/cl_init.lua',
    -- Load all world sync scripts
    'config.lua',
    'shared/sh_*.lua'
}

client_scripts {
    -- Any Extras from other scripts
    -- '@jay-dev-build/cl_init.lua',
    -- Load all world sync scripts
    'client/cl_*.lua'
}
server_scripts {
    -- Any Extras from other scripts
    -- '@jay-dev-build/sv_init.lua',
    -- Load all world sync scripts
    'server/sv_*.lua'
}