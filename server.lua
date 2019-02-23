RegisterServerEvent("fireManager:syncFire")
AddEventHandler("fireManager:syncFire", function()
  TriggerClientEvent("syncCallback", -1) -- Asks every client to spawn fire
end)

RegisterServerEvent("fireManager:removeFire")
AddEventHandler("fireManager:removeFire", function()
  TriggerClientEvent("fireRemover", -1)
end)


RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)

RegisterServerEvent("potato:syncedAlarm")
AddEventHandler("potato:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)