-- local QBCore = exports['qb-core']:GetCoreObject()

exports('badge', function(event, item, inventory, slot, data)
  local source = inventory.id
  local metadata = inventory.items[slot].metadata
  local playerCoords = GetEntityCoords(GetPlayerPed(source))
  TriggerClientEvent('silent_badge:client:ShowBadgeAnimation', source)
  for _,v in ipairs(GetPlayers()) do
    if #(playerCoords - GetEntityCoords(GetPlayerPed(v))) < Config.DisplayDistance then
      TriggerClientEvent('silent_badge:client:ShowBadgeUI', v, metadata)
    end
  end
  if event == 'usingItem' then

  elseif event == 'usedItem' then

  elseif event == 'buying' then
    
  end
end)

function getProfileURL(charid)
  return 'https://cdn.discordapp.com/attachments/990268889587925062/1075341786307891200/image.png'
  -- local row = MySQL.single.await('SELECT mugshot FROM mdt_profiles WHERE citizenid = ?', {citizenid})
  -- if row then
  --     return row.mugshot
  -- else
  --     return nil
  -- end
end

RegisterNetEvent('silent_badge:server:getBadge', function()
  local player = Ox.GetPlayer(source)
  if not player then return end
  local inService = player.get('inService')
  if not inService then return end

  local group = player.getGroup(inService)
  local label = GlobalState['group.police'].grades[group]

  local firstName = player.firstname or 'John'
  local lastName = player.lastname or 'Doe'
  local badgeNumber = player.get("callsign")
  local imgurl = getProfileURL(player.charid)

  local metadata = {
    type = ("%s"):format(player.name),
    description = ('Badge Number: %s\nLabel: %s'):format(badgeNumber,label),
    info = {
      firstName = firstName,
      lastName = lastName,
      jobName = label,
      badgeNumber = badgeNumber,
      badgeImage = inService,
      portraitImage = imgurl or ""
    }
  }

  local success, response = exports.ox_inventory:AddItem(source, 'badge', 1, metadata)
  if success then
    TriggerClientEvent('ox_lib:notify', source, {
      type = 'inform',
      description = "You grabbed a new badge"
  })
  end

end)