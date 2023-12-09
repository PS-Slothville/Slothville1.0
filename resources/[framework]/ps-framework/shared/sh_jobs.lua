InternalShared = InternalShared or {}

-- For permission information see the README or config of the corresponding job resource.

InternalShared.Jobs = {
    ["police"] = {
        Label = "Police",
        BossMenus = {
            vector3(-278.3653, 806.05792, 119.38008),
        },
        Ranks = {
            [1] = {
                Label = "Recruit",
                Salary = 100,
                Permissions = {
                    "police:general", "police:mdt", "police:lockers"
                }
            },
            [2] = {
                Label = "Sergeant",
                Salary = 150,
                Permissions = {
                    "police:general", "police:mdt", "police:lockers"
                }
            },
            [3] = {
                Label = "Lieutenant",
                Salary = 200,
                Permissions = {
                    "police:general", "police:mdt", "police:lockers"
                }
            },
            [4] = {
                Label = "Captain",
                Salary = 250,
                Permissions = {
                    "police:general", "police:mdt", "police:lockers", "police:bossmenu"
                }
            },
            [5] = {
                Label = "Chief",
                Salary = 300,
                Permissions = {
                    "police:general", "police:mdt", "police:lockers", "police:bossmenu"
                }
            }
        }
    },
}

GlobalState.SharedJobs = InternalShared.Jobs

exports('HasJobPermission', function(jobName, rank, permission)
    if InternalShared.Jobs[jobName] and InternalShared.Jobs[jobName].Ranks[rank] and InternalShared.Jobs[jobName].Ranks[rank].Permissions then
        for _, perm in pairs(InternalShared.Jobs[jobName].Ranks[rank].Permissions) do
            if perm == permission then
                return true
            end
        end
    end
    return false
end)