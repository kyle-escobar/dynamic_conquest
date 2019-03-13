objFarp = {}
function objFarp:New(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end

function init_farp(obj, index)
  local farpCol = nil
  local sams = nil
  
  if obj.owner == "Red" then
    farpCol = coalition.side.RED
    sams = red_sams
  else
    farpCol = coalition.side.BLUE
    sams = blue_sams
  end
  
  local randUnits = math.random(5,obj.maxUnits)
  
  obj.sams = SPAWN:NewWithAlias(obj.owner .. " Armor 1",obj.owner .. " Ground SAM " .. index)
      :InitLimit(randUnits, randUnits)
      :InitRandomizeTemplate(sams)
      :InitRandomizeZones({obj.groundSpawnZone})
      :SpawnScheduled(0.25,0)
  
  obj.captureObject = ZONE_CAPTURE_COALITION:New(obj.groundSpawnZone,farpCol)
  
  function obj.captureObject:OnEnterGuarded(From, Event, To)
    if From ~= To then
      local col = self:GetCoalition()
      
      if col == coalition.side.BLUE then
        self:Smoke(SMOKECOLOR.Blue)
      else
        obj.captureObject:Smoke(SMOKECOLOR.Red)
      end
      
    end
  end
  
  function obj.captureObject:OnEnterEmpty()
    obj.captureObject:Smoke(SMOKECOLOR.Green)
    MESSAGE:New(obj.name .. " Farp is vulrable! Sending helicopter to capture the farp!",30,"CAPTURE"):ToCoalition(coalition.side.BLUE)
    
    -- Spawn Heli
    local wp = {}
    wp[1] = obj.groundSpawnZone:GetCoordinate():WaypointAirLanding()
    
    obj.captureHeli = SPAWN:NewWithAlias("Blue Capture Heli","Blue " .. obj.name .. " Capture Heli " .. index)
      :InitRandomizeZones({obj.groundSpawnZone}, 1)
      :Spawn()
    obj.captureHeli:Route(wp)
  end
  
  function obj.captureObject:OnEnterAttacked()
    obj.captureObject:Smoke(SMOKECOLOR.Orange)
    obj.owner = self:GetCoalition()
  end
  
  function obj.captureObject:OnEnterCaptured()
    if obj.owner == "Red" then
      obj.owner = "Blue"
      obj.captureObject:Smoke(SMOKECOLOR.Blue)
    else
      obj.owner = "Red"
      obj.captureObject:Smoke(SMOKECOLOR.RED)
    end
    MESSAGE:New(obj.name .. " Farp has been captured! It is now owned by " .. obj.owner .. "!",30,"CAPTURE"):ToCoalition(coalition.side.BLUE)
    farps[index] = obj
    self:Smoke(nil)
    obj.captureHeli:Destroy()
    self:__Guard(1)
    init_farp(obj,index)
  end
  
  obj.captureObject:__Guard(1)
  obj.captureObject:Start(1,30)
  
end