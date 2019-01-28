------------------------------ Variables
local fireHornLocation = {
  { x = 216.85, y = -1648.05, z = 30.72, name = "Davis Station"},
  { x = 1194.27, y = -1464.01, z = 36.65, name = "El Burro Station"},
  { x = -634.79, y = -124.02, z = 39.01, name = "Rockford Hills Station"},
}

local fireSpawnLocation = {
  { x = 1164.35, y = -1463.6, z = 34.84, name = "El Burro Station", id = 1, isFuel = false}, --fire // id = type of fire
}
------------------------------ Dispatch
RegisterNetEvent("triggerSound")
AddEventHandler("triggerSound", function()
  ShowNotification("You have triggered the ~r~alarm~w~!")
  local plX, plY, plZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) --Gets player XYZ
  local nearestStation

  for i = 1, #fireHornLocation, 1 do
    ShowNotification(fireHornLocation[i].name.." responding!")

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
      print(nearestStation)
    end
  end
  PlaySoundFromCoord(i, "scanner_alarm_os", fireHornLocation[nearestStation].x, fireHornLocation[nearestStation].y, fireHornLocation[nearestStation].z, "dlc_xm_iaa_player_facility_sounds", 1, 500, 0) --Plays sound from nearest station
end)

------------------------------ Fire
RegisterCommand("startFire", function(source, args, rawCommand)
  spawnFire()
end, false)

function spawnFire()
  local i = math.random(#fireSpawnLocation)

  local model = GetHashKey("buccaneer")
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end

  if(fireSpawnLocation[i].id == 0) then
    CreateVehicle(model,fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z, 0.0, true, false)--Spawns vehicle
    StartScriptFire(fireSpawnLocation[i].x, fireSpawnLocation[i].y-1, fireSpawnLocation[i].z, 25, fireSpawnLocation[i].isFuel) --spawn fire
  else
    StartScriptFire(fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z, 25, fireSpawnLocation[i].isFuel) --spawn fire
  end
end

------------------------------ Seperate functions

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0,1)
end
