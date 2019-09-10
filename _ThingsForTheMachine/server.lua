RegisterServerEvent("fireManager:syncFire")
AddEventHandler("fireManager:syncFire", function()
  local RNDi = math.random(#fireSpawnLocation) -- Choses a random spawn locatio
  TriggerClientEvent("syncCallback", -1, RNDi) -- Asks every client to spawn fire
end)

RegisterServerEvent("fireManager:removeFire")
AddEventHandler("fireManager:removeFire", function()
  TriggerClientEvent("fireRemover", -1)
end)

RegisterServerEvent("fireManager:remvoeBlip")
AddEventHandler("fireManager:remvoeBlip", function()
  TriggerClientEvent("blipRemover", -1)
end)

RegisterServerEvent("potato:syncedAlarm")
AddEventHandler("potato:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)

RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)