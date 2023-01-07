--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

surface.CreateFont( "perp_license_plates", {
	font = "Roboto Bold",
	size = 65,
	weight = 1000,
	--antialias = true,
	shadow = true,
})

local Plates = {
    Material( "paris/plates/newyork1.png" ),
    Material( "paris/plates/newyork2.png" ),
    Material( "paris/plates/newyork3.png" ),
    Material( "paris/plates/newyork4.png" ),
}
local PlatesColors = {
    Color(3, 41, 89),
    Color(3, 41, 89),
    Color(3, 41, 89),
    Color(232, 178, 88),
}

local w, h = 128*2, 65*2
local textcolor = Color(3, 41, 89)
hook.Add("PostDrawTranslucentRenderables", "perpx_license_plates", function( bDrawingDepth, bDrawingSkybox, isDraw3DSkybox ) 
    surface.SetDrawColor(255,255,255,255)
    for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do

        local vT = v:GetGNWVar( "vehicleTable" )
        if vT and vT.PlatePos then
            local plate = v:GetGNWVar("License_Plate")
            if not istable(plate) then continue end
            for _, p in pairs(vT.PlatePos) do
                cam.Start3D2D( 
                    v:LocalToWorld( p[1] ), 
                    v:LocalToWorldAngles( p[3] ), 
                    p[2]*0.5
                )
                surface.SetMaterial( Plates[plate.Plate] )
                surface.DrawTexturedRect(w*-0.5,h*-0.5,w,h)
                draw.SimpleText(plate.Text,"perp_license_plates",0,0,PlatesColors[plate.Plate],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                cam.End3D2D()
            end
        end

    end
end)