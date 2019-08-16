------------------------------           ------------------------------
------------------------------ Variables ------------------------------
------------------------------           ------------------------------

local fireHornLocation = {
  { x = 216.85, y = -1648.05, z = 30.72, name = "Davis Station"},
  { x = 1194.27, y = -1464.01, z = 36.65, name = "El Burro Station"},
  { x = -634.79, y = -124.02, z = 39.01, name = "Rockford Hills Station"},
  { x = -379.34, y = 6118.42, z = 31.85, name = "Paleto Fire Station"},
  { x = 1691.79, y = 3584.92, z = 36.6, name = "Sandy Shores Fire Station"},
  { x = -1030.88, y = -2374.77, z = 20.61, name = "Los Santos Airport Fire Station"},
  { x = -1189.27, y = -1784.38, z = 15.62, name = "Vespucci Beach LifeGuard Station"},
}

local fireSpawnLocation = {
  { x = 1161.0, y = -1450.53, z = 34.72, name = "El Burro Station - Testing Fire 1", id = 1, isFuel = false}, --fire // id = type of fire
  { x = 1161.0, y = -1440.53, z = 34.72, name = "El Burro Station - Testing Fire 2", id = 1, isFuel = false}, --fire // id = type of fire
}

local fireBlips = { -- Blips used to show fire location
}

------------------------------          ------------------------------
------------------------------ Dispatch ------------------------------
------------------------------          ------------------------------
RegisterNetEvent("triggerSound")
AddEventHandler("triggerSound", function()
  local plX, plY, plZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) --Gets player XYZ
  local nearestStation

  for i = 1, #fireHornLocation, 1 do

    local distDiff = Vdist(plX, plY, plZ, fireHornLocation[i].x, fireHornLocation[i].y, fireHornLocation[i].z) --Gets distance between player and firestation[i]
    local nearestStationDiff

    if nearestStation == nil then --if there is no nearest station yet (first run) then...
      nearestStation = i
      nearestStationDiff = Vdist(plX, plY, plZ, fireHornLocation[i].x, fireHornLocation[i].y, fireHornLocation[i].z) --Gets distance between player and firestation[i]
    else -- if there already a value attached to "nearestStation"
      nearestStationDiff = Vdist(plX, plY, plZ, fireHornLocation[nearestStation].x, fireHornLocation[nearestStation].y, fireHornLocation[nearestStation].z) --Gets distance between player and nearest station so far
    end

    if distDiff <= nearestStationDiff then -- if new station is the closest yet
      nearestStation = i -- assign new closest station
    end
  end


  ---- PLAYING THE SOUND IN A RIDDM
  for i = 1, 10, 1 do -- repeat to make it sound like an alarm
    for i = 1, 10, 1 do -- used to make it louder
      PlaySoundFromCoord(i, "scanner_alarm_os", fireHornLocation[nearestStation].x, fireHornLocation[nearestStation].y, fireHornLocation[nearestStation].z, "dlc_xm_iaa_player_facility_sounds", 1, 500, 0) --Plays sound from nearest station
    end
    Wait(1000)
  end
  Wait(1000)
  for i = 1, 3, 1 do -- repeat to make it sound like an alarm
    for i = 1, 10, 1 do -- used to make it louder
      PlaySoundFromCoord(i, "scanner_alarm_os", fireHornLocation[nearestStation].x, fireHornLocation[nearestStation].y, fireHornLocation[nearestStation].z, "dlc_xm_iaa_player_facility_sounds", 1, 500, 0) --Plays sound from nearest station
    end
    Wait(2000)
  end
end)

------------------------------      ------------------------------
------------------------------ Fire ------------------------------
------------------------------      ------------------------------

---------------------------- Commands ----------------------------
RegisterCommand("startFire", function(source, args, rawCommand)
  TriggerServerEvent("fireManager:syncFire", source); -- sends sync requests
end, false)

RegisterCommand("stopFires", function()
  TriggerServerEvent("fireManager:removeFire", source);
end, false)

RegisterCommand("stopCallout", function()
  TriggerServerEvent("fireManager:remvoeBlip", source);
end,false)

RegisterNetEvent("fireRemover")
AddEventHandler("fireRemover", function()
  for i = 1, #scriptData.firePositionsX, 1 do
    RemoveScriptFire(scriptData.fires[i])
    RemoveParticleFx(scriptData.particles[i], true)
  end
end)
------------------------------ END ------------------------------

RegisterNetEvent("blipRemover") -- Hides blip byu putting their alpha to 0 (temporary solution)
AddEventHandler("blipRemover", function()
  for i = 1, #fireBlips, 1 do
    SetBlipAlpha(fireBlips[i], 0)
  end
end)

RegisterNetEvent("syncCallback")
AddEventHandler("syncCallback", function()
  TriggerServerEvent("potato:syncedAlarm") -- Starts fire alarm
  local i = math.random(#fireSpawnLocation) -- Choses a random spawn location

  -- Used for calls wich a vehicle:
  local model = GetHashKey("buccaneer") -- Get car's hash
  RequestModel(model) -- Car spawing stuff
  
  -- Stuff to avoid crash
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
  end
  

  -- particles stuff, don't touch that
  if not HasNamedPtfxAssetLoaded("core") then
    RequestNamedPtfxAsset("core")
      while not HasNamedPtfxAssetLoaded("core") do
        Wait(1)
      end
  end
  SetPtfxAssetNextCall("core")


  -- Makes fire
    if(fireSpawnLocation[i].id == 0) then
      --Add car fire here
    else
      --Make non-car fire
      scriptData.fires = StartScriptFire(fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-1, 25, fireSpawnLocation[i].isFuel) --spawn fire

      local rmd = math.random(2) -- Gets random number between 1 and 2
      if rmd == 1 then
        table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_h_fire", fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false))  
        table.insert(scriptData.firePositionsX, fireSpawnLocation[i].x) -- stores X
        table.insert(scriptData.firePositionsY, fireSpawnLocation[i].y) -- stores Y
        table.insert(scriptData.firePositionsZ, fireSpawnLocation[i].z-0.7) -- stores Z
      else
        table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false)) 
        table.insert(scriptData.firePositionsX, fireSpawnLocation[i].x) -- stores X
        table.insert(scriptData.firePositionsY, fireSpawnLocation[i].y) -- stores Y
        table.insert(scriptData.firePositionsZ, fireSpawnLocation[i].z-0.7) -- stores Z
      end
    end
  -- Stops making fires

  -- Create marker on map
    if(Config.Display["allowGPS"] == true) then
      local newFireBlip = AddBlipForCoord(fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z) -- Makes the blip

      fireBlips[i] = newFireBlip -- 'create' blip to array

      SetBlipAlpha(fireBlips[i], 10000)
      SetBlipSprite(fireBlips[i], 648)
      SetBlipColour(fireBlips[i], 1)
      blipName = "Fire Callout"
      SetBlipNameFromTextFile(blip, blipName)
      SetBlipAsShortRange(blip, false)

      fireBlips[i] = newFireBlip -- Save blip to array
    end
end)

Citizen.CreateThread(function()

  -- Stuff for particles
  if not HasNamedPtfxAssetLoaded("core") then
  RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
      Wait(1)
    end
  end

  while true do
    -- Handeling spreading of fires
    Wait(1000)
    if #scriptData.firePositionsX == 0 then
    else
      for i=1, #scriptData.firePositionsX, 1 do
        local isFirePresent = GetNumberOfFiresInRange(scriptData.firePositionsX[i], scriptData.firePositionsY[i], scriptData.firePositionsZ[i], 1)

        if isFirePresent ~= 0 then
          --Deal with fire spreading
        else
          RemoveParticleFx(scriptData.particles[i], true)
        end
      end
    end
  end
end)

------------------------------                    ------------------------------
------------------------------ Seperate functions ------------------------------
------------------------------                    ------------------------------

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0,1)
end