do
    require 'shared.config'

    if IsDuplicityVersion() then
        -- Server Modules
        require 'server'
    else
        -- Client Modules
        require 'client'
        require 'modules.camera.client'
        require 'modules.peds.client'
    end
end