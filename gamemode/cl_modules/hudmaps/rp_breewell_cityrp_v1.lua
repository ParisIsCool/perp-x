local HUDMAP = {}
HUDMAP.Map = "rp_breewell_cityrp_v1"
HUDMAP.Material = "paris/maps/rp_breewell_cityrp_v1"
HUDMAP.ScaleX = 1.0527
HUDMAP.ScaleY = 1.0472
HUDMAP.Translate = Vector(200,-60,0)
HUDMAP.Zoom = 0.7

paris = paris or {}                     // Register Prep
if !paris.HUDMaps then
    paris.HUDMaps = {}
end
paris.HUDMaps[HUDMAP.Map] = HUDMAP      // Registers the hudmap


MsgC( Color(200,110,255), "Loading HUD Map ", Color(255,255,255), "> " .. HUDMAP.Map .. " \n")