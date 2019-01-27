RegisterCommand("fireAlarm", function(source, args, rawCommand)
    TriggerClientEvent("triggerSound", source)
end, false)

--[[
--- FIRE FUNCTIONS

local fireSpawnLocation = {
  { x = 1194.33, y = -1449.03, z = 35.16, name = "El Burro Station"},
}

function spawnFire()
  local i = math.random(#fireSpawnLocation) --Gets random number between 1 and the number of entities in array
  TriggerEvent("chatMessage", "[TestingBot]", {255,0,0}, i)
  StartScriptFire(fireSpawnLocation[i].x, fireSpawnLocation[i].y, fireSpawnLocation[i].z, 25, 1) --spawn fire
  TriggerEvent("chatMessage", "[TestingBot]", {255,0,0}, "Fire has spawned at" .. fireSpawnLocation[i].name .. "!")
end
--]]
