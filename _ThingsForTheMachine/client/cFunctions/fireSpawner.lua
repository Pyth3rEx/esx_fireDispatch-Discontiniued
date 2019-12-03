--[[ ----------------------------------------------------------------------------------------------------
| Script: esx_fireDispatch
| Author: Pyth3rEx
|
| File: clientFunction/cFunctions/fireSpawner.lua
| Description: Responsible of starting the fire
--]] ----------------------------------------------------------------------------------------------------

RegisterNetEvent("fireSpawner:spawnFire")
AddEventHandler("fireSpawner:spawnFire", function()
    print("starting fire...")
    local i = math.random(#Config.Locations["fireSpawnLocation"]) -- Choses a random spawn location
    TriggerServerEvent("fireSpawnSync:syncFire", i); -- sends sync requests
)

RegisterNetEvent("fireSpawner:syncCallback")
AddEventHandler("fireSpawner:syncCallback", function(i)
  -- particles stuff, don't touch that
  if not HasNamedPtfxAssetLoaded("core") then
    RequestNamedPtfxAsset("core")
      while not HasNamedPtfxAssetLoaded("core") do
        Wait(1)
      end
  end
  SetPtfxAssetNextCall("core")
  -- you have left area 51 of this code


  -- Makes fire
    if(fireSpawnLocation[i].id == 0) then
      --Add car fire here
    else
      --Make non-car fire
      scriptData.fires = StartScriptFire(fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-1, 25, fireSpawnLocation[i].isFuel) --spawn fire

      local rmd = math.random(2) -- Gets random number between 1 and 2
      if rmd == 1 then
        table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_h_fire", fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false))  
        table.insert(scriptData.firePositionsX, fireSpawnLocation[i].x) -- stores X
        table.insert(scriptData.firePositionsY, fireSpawnLocation[i].y) -- stores Y
        table.insert(scriptData.firePositionsZ, fireSpawnLocation[i].z-0.7) -- stores Z
      else
        table.insert(scriptData.particles, StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z-0.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false)) 
        table.insert(scriptData.firePositionsX, fireSpawnLocation[i].x) -- stores X
        table.insert(scriptData.firePositionsY, fireSpawnLocation[i].y) -- stores Y
        table.insert(scriptData.firePositionsZ, fireSpawnLocation[i].z-0.7) -- stores Z
      end
    end
  -- Stops making fires
end)