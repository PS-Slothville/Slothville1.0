---
--- Wicked Multicharacter by Wicked RedM
--- The Wicked framework and its resources are still under heavy development.
--- Bugs and missing features are expected.
---

Wicked = exports['wicked-core']:GetObject()

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