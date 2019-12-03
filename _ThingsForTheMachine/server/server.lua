--[[ ----------------------------------------------------------------------------------------------------
| Script: esx_fireDispatch
| Author: Pyth3rEx
|
| File: serverFunction/server.lua
| Description:
--]] ----------------------------------------------------------------------------------------------------

RegisterServerEvent("fireSpawnSync:syncFire")
AddEventHandler("fireSpawnSync:syncFire", function(i)
    print("starting fire...")
    TriggerClientEvent("fireSpawner:syncCallback", -1, i) -- Asks every client to spawn fire
end)