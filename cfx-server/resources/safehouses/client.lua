-- Configure the coordinates where the safehouses are located.
local safehouses = {
   { x=-952.35943603516, y= -1077.5021972656, z=2.6772258281708},
   { x=-59.124889373779, y= -616.55456542969, z=37.356777191162},
   { x=-255.05390930176, y= -943.32885742188, z=31.219989776611},
   { x=-771.79888916016, y= 351.59423828125, z=87.998191833496},
 }

-- Create blips on the map for all the safehouses
for _, safehouse in pairs(safehouses) do
  safehouse.blip = AddBlipForCoord(safehouse.x, safehouse.y, safehouse.z)
  SetBlipSprite(safehouse.blip, 350);
  SetBlipAsShortRange(safehouse.blip, true);
end
