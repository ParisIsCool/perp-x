--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GradientRight = Material("paris/gradient_right.png")
GradientLeft = Material( "materials/gui/GradientLeft.png" )
local gradup = Material( "gui/gradient_up" )
local graddown = Material( "gui/gradient_down" )

function GradientUp(x,y,w,h,r,g,b,a)
    surface.SetDrawColor( r,g,b,a )
    surface.SetMaterial( gradup )
    surface.DrawTexturedRect( x, y, w, h )
end
function GradientDown(x,y,w,h,r,g,b,a)
    surface.SetDrawColor( r,g,b,a )
    surface.SetMaterial( graddown )
    surface.DrawTexturedRect( x, y, w, h )
end

concommand.Add("getdoorinfo", function(ply,cmd,args)
    local e = ply:GetEyeTrace().Entity
    if not IsValid(e) and not e:IsWorld() then return end
    local p = e:GetPos()
    SetClipboardText("    {Vector("..p.x..","..p.y..","..p.z.."),\""..e:GetModel().."\"},")
end)

concommand.Add("getvector", function(ply,cmd,args)
    local p = ply:GetEyeTrace().HitPos
    SetClipboardText(Format("\tVector(%i,%i,%i),",p.x,p.y,p.z))
end)

concommand.Add("addvector", function(ply,cmd,args)
    local p = ply:GetPos()
    SetClipboardText(Format("\tVector(%i,%i,%i),",p.x,p.y,p.z))
end)

concommand.Add("getclass", function(ply,cmd,args)
    local p = ply:GetEyeTrace().Entity:GetClass()
    SetClipboardText(p)
end)


concommand.Add("addangle", function(ply,cmd,args)
    local a = ply:EyeAngles()
    SetClipboardText(Format("\tAngle(%i,%i,%i),",a.p,a.y,a.r))
end)

concommand.Add("getposandangle", function(ply,cmd,args)
    local p = ply:GetPos()
    local a = ply:GetAngles()
    SetClipboardText(Format("\t{pos=Vector(%i,%i,%i),ang=Angle(%i,%i,%i)},\n",p.x,p.y,p.z,a.p,a.y,a.r))
end)

local ct = ""
concommand.Add("getposandanglecb", function(ply,cmd,args)
    local p = ply:GetPos()
    local a = ply:GetAngles()
    ct = ct .. Format("\t{pos=Vector(%i,%i,%i),ang=Angle(%i,%i,%i)},\n",p.x,p.y,p.z,a.p,a.y,a.r)
    SetClipboardText(ct)
end)

local doors = {}
concommand.Add("getdoorinfocb", function(ply,cmd,args)
    local e = ply:GetEyeTrace().Entity
    if not IsValid(e) or e:IsWorld() then return end
    local p = e:GetPos()
    table.insert(doors,e)
    --ct = ct .. Format("\t{model=\""..e:GetModel().."\",pos=Vector("..p.x..","..p.y..","..p.z..")},\n")
    --ct = ct .. Format("\t{Vector("..p.x..","..p.y..","..p.z.."),\""..e:GetModel().."\"},\n")
    ct = ct .. Format("{Vector("..p.x..","..p.y..","..p.z.."),\""..e:GetModel().."\"},")
    SetClipboardText(ct)
end)

concommand.Add("getmodelcb", function(ply,cmd,args)
    local e = ply:GetEyeTrace().Entity
    if not IsValid(e) or e:IsWorld() then return end
    ct = ct .. Format('\t"%s",\n',e:GetModel())
    SetClipboardText(ct)
end)

concommand.Add("clearclipboard", function(ply,cmd,args)
    ct = ""
    doors = {}
    SetClipboardText(ct)
end)

local color_red = Color( 255, 0, 0 )

hook.Add( "PreDrawHalos", "DoorToolHalos", function()
	halo.Add( doors, color_red, 5, 5, 2 )
end )

concommand.Add("alignplayertoaxis", function()
    local a = LocalPlayer():GetAngles()
    a.p = math.Round(a.p / 90) * 90
    a.y = math.Round(a.y / 90) * 90
    a.r = math.Round(a.r / 90) * 90
    LocalPlayer():SetEyeAngles(a)
end)


concommand.Add("getentposandangle", function(ply,cmd,args)
    local e = ply:GetEyeTrace().Entity 
    if not IsValid(e) then return end
    local p = e:GetPos()
    local a = e:GetAngles()
    SetClipboardText(Format("\t{pos=Vector(%i,%i,%i),ang=Angle(%i,%i,%i)},\n",p.x,p.y,p.z,a.p,a.y,a.r))
end)