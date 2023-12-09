lib.addCommand('group.admin', 'revive', function(source, args)
    TriggerClientEvent("death:revive", tonumber(args.target) or args.target)
end, {'target'})

RegisterNetEvent('death:LoseInvItems', function()
    exports.ox_inventory.Clear(source)
end)