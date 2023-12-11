local BadgeZones = {
  [1] = vec3(439.44049072266, -988.34777832031, 31.127889633179),
}

for i = 1, #BadgeZones do
  exports.ox_target:addSphereZone({
      coords = BadgeZones[i],
      radius = 1,
      debug = drawZones,
      options = {
          {
              name = 'police_badge',
              serverEvent = 'silent_badge:server:getBadge',
              icon = 'fa-regular fa-badge-sheriff',
              label = 'Grab Badge',
              distance = 1.0,
          }
      }
  })
end


local haveShownBadge = false

local function showBadgeUI(metadata)
  if not metadata or not metadata.info then
    haveShownBadge = false
    return 
  end
  -- Send message to svelte event handler
  SendNUIMessage({ 
    action = "open",
    data = {
      badgeImage = metadata.info.badgeImage or "police",
      portraitImage = metadata.info.portraitImage or "https://i.imgur.com/vCHcKtp.png",
      jobName = metadata.info.jobName or "Police",
      firstName = metadata.info.firstName or "John",
      lastName = metadata.info.lastName or "Doe",
      badgeNumber = metadata.info.badgeNumber or 523,
      showDuration = 5000,
    }
  })
end

local function showBadgeAnimation()
  local model = `prop_fib_badge`
  local anim = { dictionary = "paper_1_rcm_alt1-9", animation = "player_one_dual-9" }
  RequestModel(model)
  while not HasModelLoaded(model) do
      RequestModel(model)
      Wait(10)
  end
  RequestAnimDict(anim.dictionary)
  while not HasAnimDictLoaded(anim.dictionary) do
      Wait(100)
  end
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local badgeProp = CreateObject(model, coords.x, coords.y, coords.z + 0.2, true, true, true)
  local boneIndex = GetPedBoneIndex(ped, 28422)
  
  AttachEntityToEntity(badgeProp, ped, boneIndex, 0.15, 0.030, -0.025, 90.0, -1.90, 140.0, true, true, false, true, 1, true)
  TaskPlayAnim(ped, anim.dictionary, anim.animation, 8.0, -8, 10.0, 49, 0, 0, 0, 0)
  Wait(3000)
  ClearPedSecondaryTask(ped)
  DeleteObject(badgeProp)
end

RegisterNetEvent('silent_badge:client:ShowBadgeAnimation', function()
  if haveShownBadge then return end

  showBadgeAnimation()
end)

RegisterNetEvent('silent_badge:client:ShowBadgeUI', function(item)
  if haveShownBadge then return end

  haveShownBadge = true
  showBadgeUI(item)
end)

RegisterNUICallback('closeUI', function(_, cb)
  cb('ok')
  haveShownBadge = false
end)