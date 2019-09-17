RegisterServerEvent("fireManager:syncFire")
AddEventHandler("fireManager:syncFire", function(i)
  --local RNDi = math.random(#fireSpawnLocation) -- Choses a random spawn locatio
  TriggerClientEvent("syncCallback", -1, i) -- Asks every client to spawn fire
end)

-- Server Events

RegisterServerEvent("fireManager:removeFire")
AddEventHandler("fireManager:removeFire", function()
  TriggerClientEvent("fireRemover", -1)
end)

RegisterServerEvent("fireManager:removeBlip")
AddEventHandler("fireManager:removeBlip", function()
  TriggerClientEvent("blipRemover", -1)
end)

RegisterServerEvent("potato:syncedAlarm")
AddEventHandler("potato:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)

-- Commands

RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)

--RegisterCommand("startFire", function(source, args, rawCommand)
--  local RNDi = math.random(#fireSpawnLocation) -- Choses a random spawn locatio
--  TriggerClientEvent("syncCallback", -1, RNDi) -- Asks every client to spawn fire
--end, false)