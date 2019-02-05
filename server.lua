RegisterServerEvent("potato:syncFire")
AddEventHandler("potato:syncFire", function()
  TriggerClientEvent("syncCallback", -1) -- Asks every client to spawn fire
end)