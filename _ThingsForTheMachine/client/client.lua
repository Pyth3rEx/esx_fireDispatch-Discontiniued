--[[ ----------------------------------------------------------------------------------------------------
| Script: esx_fireDispatch
| Author: Pyth3rEx
|
| File: clientFunction/client.lua
| Description: This file contains the commands to be sent out to the function files
--]] ----------------------------------------------------------------------------------------------------

------------------------------           ------------------------------
------------------------------  Commands ------------------------------
------------------------------           ------------------------------

RegisterCommand("startFire", function()
    print("Requested fireSpawner:spawnFire")
    TriggerClientEvent("fireSpawner:spawnFire", -1)
end, false)

RegisterCommand("dbug", function()
    local i = math.random(#Config.Locations["fireSpawnLocation"]) -- Choses a random spawn location
    TriggerServerEvent("fireSpawnSync:syncFire", i); -- sends sync requests
    print("Sent Sync request...")
end, false)