RegisterCommand("fireAlarm", function(source, args, rawCommand)
  TriggerClientEvent("triggerSound", source)
end, false)

RegisterCommand("startFire", function(source, args, rawCommand)
  spawnFire()
end, false)

-- FIRE FUNCTIONS
local fireSpawnLocation = {
  { x = 1194.33, y = -1449.03, z = 35.16, name = "El Burro Station"}, --fire
}