RegisterServerEvent("potato:syncFire")
AddEventHandler("potato:syncFire", function()
  TriggerClientEvent("syncCallback", -1) -- Asks every client to spawn fire
end)


RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)

RegisterServerEvent("potato:worldOnFire")
AddEventHandler("potato:worldOnFire", function()
  TriggerClientEvent("callbackFireWorld", -1)
end)