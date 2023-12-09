InternalConfig = {}
InternalConfig.MaxPlayers                       = GetConvarInt('sv_maxClients', 48)
InternalConfig.DefaultPosition                  = vector3(0.0,0.0,0.0)
InternalConfig.CidLength                        = 8
InternalConfig.DeploymentType                   = "dev" -- dev, prod

InternalConfig.Player = {}
InternalConfig.Player.StartingCash              = 500
InternalConfig.Player.StartingBank              = 5000
InternalConfig.Player.UpdateRate                = 5             -- Minutes
InternalConfig.Player.StatusRate                = 5000          -- Seconds
InternalConfig.Player.HungerRate                = 4.2           -- Rate at which hunger increases.
InternalConfig.Player.ThirstRate                = 3.8           -- Rate at which thirst increases.
InternalConfig.Player.CanLogout                 = true          -- Set to false to disable the ability to logout.

-----------------------------------------------------------------------------------------
--------------------------------------  Global Config  ----------------------------------
-----------------------------------------------------------------------------------------

GlobalState.DeploymentType                      = InternalConfig.DeploymentType

GlobalState.FrameworkConfig = InternalConfig