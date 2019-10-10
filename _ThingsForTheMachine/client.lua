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
  --Assigns Variables
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
RegisterCommand("startFire", function()
  local i = math.random(#fireSpawnLocation) -- Choses a random spawn location
  TriggerServerEvent("fireManager:syncFire", i); -- sends sync requests
end, false)

RegisterCommand("stopFires", function()
  TriggerServerEvent("fireManager:removeFire", source);
  TriggerServerEvent("fireManager:removeBlip", source);
end, false)

RegisterCommand("stopCallout", function()
  TriggerServerEvent("fireManager:removeBlip", source);
end,false)

RegisterNetEvent("fireRemover")
AddEventHandler("fireRemover", function()
  for i = 1, #scriptData.firePositionsX, 1 do
    if scriptData.fires[i] == nil then
      --do nothing
    else
      RemoveScriptFire(scriptData.fires[i])
    end
    RemoveParticleFx(scriptData.particles[i], true)
  end
end)

RegisterNetEvent("blipRemover") -- Hides blip by putting their alpha to 0 (temporary solution)
AddEventHandler("blipRemover", function()
  for i = 1, #fireBlips, 1 do
    SetBlipAlpha(fireBlips[i], 0)
  end
end)
------------------------------ END ------------------------------

RegisterNetEvent("syncCallback")
AddEventHandler("syncCallback", function(i)
  TriggerServerEvent("potato:syncedAlarm") -- Starts fire alarm

  --Send a notification
  if(Config.Misc["sendNoification"] == true) then
    TriggerEvent("chatMessage",  "[FIRE DISPATCH]", {255,0,0}, "A fire has broken out @ " .. fireSpawnLocation[i].name)
  end

  --WARNING!!!!! The following part (for vehicles) need to be moved to server.lua to avoir sync issues
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
  -- you have left area 51 of this code


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

-- The following net event is the same as the above but for handeling fire spreading
RegisterNetEvent("spreadCallback")
AddEventHandler("spreadCallback", function(x,y,z)
  
  
  -- Checks for ground level
  z = 0
  repeat
    Wait(0)
    ground,NewZ = GetGroundZFor_3dCoord(x,y,z,1)
    if not ground then
      z = z + 0.1
    end
  until ground
  z = NewZ

  -- Spawns the spreaded fires
  scriptData.fires = StartScriptFire(x, y, z, 25, false) --spawn fire StartScriptFire(X, Y, Z, maxChildren, isGasFire)
  local rmd = math.random(2) -- Gets random number between 1 and 2
  print('spreading...')
  if rmd == 1 then
    table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_h_fire", x, y, z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false))  
    table.insert(scriptData.firePositionsX, x) -- stores X
    table.insert(scriptData.firePositionsY, y) -- stores Y
    table.insert(scriptData.firePositionsZ, z-0.7) -- stores Z
  else
    table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", x, y, z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false))
    table.insert(scriptData.firePositionsX, x) -- stores X
    table.insert(scriptData.firePositionsY, y) -- stores Y
    table.insert(scriptData.firePositionsZ, z-0.7) -- stores Z
  end
  -- End spawning spreaded fires
end)


---------------------                       ---------------------
--------------------- ENDLESS LOOP OF DEATH ---------------------
---------------------                       ---------------------

Citizen.CreateThread(function()

  -- Stuff for particles
  if not HasNamedPtfxAssetLoaded("core") then
  RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
      Wait(1)
    end
  end

  local iTimer = Config.Display["GPStimeout"] -- Sets timer value to value choses in Config file
  while true do
    Wait(1000)

    -- Makes sure everyone has infinite fire extinguishers (if config is set to that)
    if(Config.Misc["infiniteExtinguisher"] == true) then
      local fireAmmo = GetAmmoInPedWeapon(PlayerPedId(), 101631238)
      if fireAmmo <= 100 then -- Makes sure your computer dosn't explode
        GiveWeaponToPed(PlayerPedId(), 101631238, 20000, false, false)
      end
    end

    -- fIrE cLoCk UwU
    if(Config.Fire["randomStart"] == true) then
      -- Fire countdown
      local fireTimer = Config.Fire["randomTime"]
      print (fireTimer)

      local trueCheck = true
      while trueCheck == true do
        Wait(1000)
        if fireTimer > 0 then
          -- the 'Wait 1 second' part is above (right under the whileTrue loop)
          fireTimer = fireTimer - 1 -- Removes 1 loop
        else
          local i = math.random(#fireSpawnLocation) -- Choses a random spawn location
          TriggerServerEvent("fireManager:syncFire", i); -- sends sync requests
          trueCheck = false
        end
      end
    end

    if #scriptData.firePositionsX == 0 then
    else
      for i=1, #scriptData.firePositionsX, 1 do
        local isFirePresent = GetNumberOfFiresInRange(scriptData.firePositionsX[i], scriptData.firePositionsY[i], scriptData.firePositionsZ[i], 1)

        if isFirePresent ~= 0 then

          -- Handeling spreading of fires
          local rmdSpread = math.random(100)
          if rmdSpread <=	Config.Fire["fireSpreadChance"] then
            --Spread fire

              -- Chose X, Y and Z and launch the synced fire spawning (like fireManager:syncFire) sending X,Y,Z via function return
            local rdmFireSpot = math.random(#scriptData.firePositionsX)
            local x = scriptData.firePositionsX[rdmFireSpot]
            local y = scriptData.firePositionsY[rdmFireSpot]
            local z = scriptData.firePositionsZ[rdmFireSpot]

            local xSpread = math.random(-5,5)
            local ySpread = math.random(-5,5)

            local newX = x + xSpread
            local newY = y + ySpread
            x = newX
            y = newY
            TriggerServerEvent("fireManager:syncSpread",x,y,z)
          else
            -- Don't spread fire
          end

        else
          RemoveParticleFx(scriptData.particles[i], true)
        end

        -- GPS Blip countdown
        if iTimer > 0 then
          -- the 'Wait 1 second' part is above (right under the whileTrue loop)
          iTimer = iTimer - 1 -- Removes 1 loop
        else
          SetBlipAlpha(fireBlips[i], 0) -- Turn blip transparent
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