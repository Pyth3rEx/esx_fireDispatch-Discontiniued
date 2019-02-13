RegisterServerEvent("potato:syncFire")
AddEventHandler("potato:syncFire", function()
  TriggerClientEvent("syncCallback", -1) -- Asks every client to spawn fire
end)


RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)
RegisterServerEvent("potato:syncedAlarm")
AddEventHandler("potato:syncedAlarm", function()
  TriggerClientEvent("triggerSound", source)
end)