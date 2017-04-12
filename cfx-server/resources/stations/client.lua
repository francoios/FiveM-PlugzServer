Citizen.CreateThread(function()
-- Configure the coordinates where the police stations are located.
local locations = {
   { X= 425.130, Y= -979.558, Z= 30.711},
   -- County
   { X= 1859.234, Y= 3678.742, Z= 33.690},
   -- Sandy shore
   { X= -438.862, Y= 6020.768, Z= 31.490},
 }

  -- Parked vehicles.
  --local vehicles = {
    -- Downtown
   -- {Model= "police", X= 407.912, Y= -979.791 , Z= 29.269, A= 228.585},
   -- {Model= "police3", X= 408.670, Y= -998.632 , Z= 29.266, A= 222.109},
   -- {Model= "police4", X= 435.063, Y= -1026.608 , Z= 28.849, A= 3.018},
    -- County
    --{Model= "sheriff", X= 1847.280, Y= 3672.022, Z= 33.699, A= 45.975},
   -- {Model= "sheriff", X= 1851.158, Y= 3673.244, Z= 33.565, A= 32.445},
   -- {Model= "policeb", X= 1853.746, Y= 3676.360, Z= 33.774, A= 210.721},
    -- Sandy shore
   -- {Model= "policet", X= -482.982, Y= 6024.920, Z= 31.341, A= 53.876},
   -- {Model= "sheriff", X= -479.852, Y= 6028.391, Z= 31.341, A= 47.304},
   -- {Model= "sheriff", X= -476.057, Y= 6031.708, Z= 31.341, A= 40.971},
   -- {Model= "policeb", X= -472.620, Y= 6035.403, Z= 31.341, A= 42.570},
   -- {Model= "polmav", X= -475.924, Y= 5987.338, Z= 31.337, A= 322.241},
  --}


-- Create blips on the map
for _, station in pairs(locations) do
  station.blip = AddBlipForCoord(station.X, station.Y, station.Z)
  SetBlipSprite(station.blip, 60);
  SetBlipAsShortRange(station.blip, true);
end

 -- Spawn the police cars
 for _, item in pairs(vehicles) do
   RequestModel(GetHashKey(item.Model));
   while not HasModelLoaded(GetHashKey(item.Model)) do
     RequestModel(GetHashKey(item.Model));
     Wait(1);
  end

 --	vehicle = CreateVehicle(GetHashKey(item.Model), item.X, item.Y, item.Z, item.A, false, false)
 --	SetVehicleOnGroundProperly(vehicle)
 --end
end)
