-- Dynamic Conquest
-- Created by Kyle Escobar

local packagepath = "A:\\Projects\\DCS\\Missions\\dynamic_conquest\\"
--local packagepath = "C:\\Users\\Administrator\\Saved Games\\DCS.openbeta\\Missions\\dynamic_conquest\\dynamic_conquest\\"
farpsModule = assert(loadfile(packagepath .. "farps.lua"))

-- Global Vars

red_sams = { "Red Armor 1", "Red Armor 2", "Red Armor 3", "Red Armor 4", "Red Armor 5", "Red Strela 1", "Red Strela 2", "Red AAA 1", "Red AAA 2", "Red AAA 3", "Red Tung", "Red Osa", "Red Tor", "Red SA-6 1"}
blue_sams = { "Blue Armor 1" }
blue_airbase = AIRBASE:FindByName("Vaziani")

-- End Global Vars

-- Module Defs

farpsModule()

-- End Module Defs

-- Functionals

farps = {
  objFarp:New{name = "Khashuri", owner = "Red", groundSpawnZone = ZONE:New("Khashuri Ground Spawn"), maxUnits = 10},
  objFarp:New{name = "Chiatura", owner = "Red", groundSpawnZone = ZONE:New("Chiatura Ground Spawn"), maxUnits = 10},
  objFarp:New{name = "Tskhinvali", owner = "Red", groundSpawnZone = ZONE:New("Tskhinvali Ground Spawn"), maxUnits = 15}
}

-- End Functionals

-- Main
function main()

-- Init farps
  for index,indexFarp in pairs(farps) do
    init_farp(indexFarp, index)
  end

end

main()