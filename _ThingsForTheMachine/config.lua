Config = {}

Config.Display = {

allowGPS = true, -- Display callouts on the GPS
GPStimeout = 100, -- Timer before blip gets removed from GPS

}

Config.Locations = {
    fireHornLocation = {
        { x = 216.85, y = -1648.05, z = 30.72, name = "Davis Station"},
        { x = 1194.27, y = -1464.01, z = 36.65, name = "El Burro Station"},
        { x = -634.79, y = -124.02, z = 39.01, name = "Rockford Hills Station"},
        { x = -379.34, y = 6118.42, z = 31.85, name = "Paleto Fire Station"},
        { x = 1691.79, y = 3584.92, z = 36.6, name = "Sandy Shores Fire Station"},
        { x = -1030.88, y = -2374.77, z = 20.61, name = "Los Santos Airport Fire Station"},
        { x = -1189.27, y = -1784.38, z = 15.62, name = "Vespucci Beach LifeGuard Station"},
    },
    fireSpawnLocation = {
        { x = 1161.0, y = -1450.53, z = 34.72, name = "El Burro Station - Testing Fire 1", id = 1, isFuel = false}, --fire // id = type of fire
        { x = 1161.0, y = -1440.53, z = 34.72, name = "El Burro Station - Testing Fire 2", id = 1, isFuel = false}, --fire // id = type of fire
    },
    fireBlips = { -- Blips used to show fire location
    },
}

Config.Fire = {

randomStart = false, -- Set to true if you want fires to randomly spawn
randomTime = 2100, -- Timer before starting fires (in s)
fireSpreadChance = 10, -- Out of 100 chances, how many lead to fire spreading?

}

Config.Misc = {

infiniteExtinguisher = true, -- Set to true if you want fire extinguisher to automaticaly refill after use
sendNoification = true, -- Set to true if you wish te recive notifications about fires starting

}
-- {prm1,prm2,prm3...}