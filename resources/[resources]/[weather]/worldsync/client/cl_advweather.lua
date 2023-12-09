CreateThread(function()
    while true do
        if GlobalState.AlwaysSnow then
            ForceSnowPass(GlobalState.AlwaysSnow)
            SetForceVehicleTrails(GlobalState.AlwaysSnow)
            SetForcePedFootstepsTracks(GlobalState.AlwaysSnow)
            if not HasNamedPtfxAssetLoaded("core_snow") then
                RequestNamedPtfxAsset("core_snow")

                while not HasNamedPtfxAssetLoaded("core_snow") do
                    Wait(0)
                end
            end

            UseParticleFxAssetNextCall("core_snow")
        else
            RemoveNamedPtfxAsset("core_snow")
        end

        Wait(1000)
    end
end)

RegisterCommand("lightning", function()
    ForceLightningFlash()
end)