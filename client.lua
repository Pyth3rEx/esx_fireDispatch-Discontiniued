local fireHornLocation = {
  { x = 1194.27, y = -1464.01, z = 36.65, name = "El Burro Station"},
  { x = 206.5, y = -1339.75, z = 31.59, name = "Davis Station"},
}

--[[
RegisterCommand('spawnFire', function(source, args, rawCommand)
  spawnFire()
end, false)


Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/fireAlarm', 'send the fireDispatch main function', { {name='station number', help="the station's number"} })
end)
--]]

RegisterNetEvent("triggerSound")
AddEventHandler("triggerSound", function()

  local plyCoords = GetEntityCoords(GetPlayerPed(-1))

  ShowNotification("You have triggered the ~r~alarm~w~!")

  for i = 1, #fireHornLocation, 1 do
    ShowNotification(fireHornLocation[i].name.." responding!")
    --TriggerClientEvent("chatMessage", "[Dispatch]", {255,0,0}, fireHornLocation[i].name.." responding!")
    
    --[[
    local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, fireHornLcation[i].x, fireHornLocation[i].y, fireHornLocation[i].z);


    if(distance < 500.0) then
      PlaySoundFromCoord(-1, "scanner_alarm_os", fireHornLocation[i].x, fireHornLocation[i].y, fireHornLocation[i].z, "dlc_xm_iaa_player_facility_sounds", true, 500, false)
    end
    --]]
    
  end
end)

function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0,1)
end