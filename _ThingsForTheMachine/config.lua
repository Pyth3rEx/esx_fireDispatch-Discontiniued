Config = {}

Config.Display = {

allowGPS = true, -- Display callouts on the GPS
GPStimeout = 100, -- Timer before blip gets removed from GPS

}

Config.Fire = {

randomStart = false, -- Set to true if you want fires to randomly spawn
randomTime = 50000, -- Timer before starting fires (in ms)
fireSpreadChance = 1, -- Out of 100 chances, how many lead to fire spreading?

}

Config.Misc = {

infiniteExtinguisher = true, -- Set to true if you want fire extinguisher to automaticaly refill after use
sendNoification = true, -- Set to true if you wish te recive notifications about fires starting

}
-- {prm1,prm2,prm3...}