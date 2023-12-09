InternalShared = InternalShared or {}

-- For permission information see the README or config of the corresponding job resource.

InternalShared.Gangs = {
    ["none"] = {
        Label = "No Gang",
        -- BossMenus = {
        --     vector3(-278.3653, 806.05792, 119.38008),
        -- },
        Ranks = {
            [1] = {
                Label = "Unaffiliated",
                Permissions = {
                    -- "gang:general"
                }
            },
        }
    },
}

-- GlobalState.SharedGangs = InternalShared.Gangs

-- exports('HasGangPermission', function(gangName, rank, permission)
--     if InternalShared.Gangs[jobName] and InternalShared.Gangs[jobName].Ranks[rank] and InternalShared.Gangs[jobName].Ranks[rank].Permissions then
--         for _, perm in pairs(InternalShared.Gangs[jobName].Ranks[rank].Permissions) do
--             if perm == permission then
--                 return true
--             end
--         end
--     end
--     return false
-- end)