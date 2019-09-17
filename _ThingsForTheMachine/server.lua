RegisterServerEvent("fireManager:syncFire")
AddEventHandler("fireManager:syncFire", function(i)
  --local RNDi = math.random(#fireSpawnLocation) -- Choses a random spawn locatio
  TriggerClientEvent("syncCallback", -1, i) -- Asks every client to spawn fire
end)

RegisterServerEvent("fireManager:syncSpread")
AddEventHandler("fireManager:syncSpread", function(x,y,z)
  TriggerClientEvent("spreadCallback", -1, x, y, z)
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