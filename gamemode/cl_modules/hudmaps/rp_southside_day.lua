local HUDMAP = {}
HUDMAP.Map = "rp_southside_day"
HUDMAP.Material = "models/paris/rp_southside/rp_southside"
HUDMAP.PlanarScale = 794
HUDMAP.Translate = Vector(0,-11,0) // Never do Z
HUDMAP.Zoom = 0.9

paris = paris or {}                     // Register Prep
if !paris.HUDMaps then
    paris.HUDMaps = {}
end
paris.HUDMaps[HUDMAP.Map] = HUDMAP      // Registers the hudmap


MsgC( Color(200,110,255), "Loading HUD Map ", Color(255,255,255), "> " .. HUDMAP.Map .. " \n")