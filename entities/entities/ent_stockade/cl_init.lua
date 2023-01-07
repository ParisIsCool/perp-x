include('shared.lua')

function ENT:Initialize()
end

function ENT:Think()
    local dlight = DynamicLight( LocalPlayer():EntIndex() )
    if ( dlight ) then
        dlight.pos = self:GetPos() + Vector(0,100,100)
        dlight.dir = self:GetPos() + Vector(0,0,0)
        dlight.r = 255
        dlight.g = 255
        dlight.b = 255
        dlight.brightness = 7
        dlight.Decay = 1000
        dlight.Size = 512
        dlight.DieTime = CurTime() + 1
    end
end


function ENT:Draw()
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*-37)+ (self:GetAngles():Up()*67), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*37)+ (self:GetAngles():Up()*67), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*-37)+ (self:GetAngles():Up()*28), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*37)+ (self:GetAngles():Up()*28), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*37)+ (self:GetAngles():Up()*19), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*-128) + (self:GetAngles():Right()*-37)+ (self:GetAngles():Up()*19), 10, Color(255,10,10,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*112) + (self:GetAngles():Right()*-35)+ (self:GetAngles():Up()*17), 20, Color(255,255,255,255), false)
    draw.VectorSprite(self:GetPos() + (self:GetAngles():Forward()*112) + (self:GetAngles():Right()*35)+ (self:GetAngles():Up()*17), 20, Color(255,255,255,255), false)
    self:DrawModel()
end

local toDraw3d = {}
local sprites3d = 0

local toDraw2d = {}
local sprites2d = 0

local material = Material("sprites/glow04_noz_gmod")

function draw.VectorSprite(position, size, color, constantSize)
	if (not isvector(position)) then
		error("bad argument #1 to draw.DrawVectorSprite (Vector expected, got " .. type(position) .. ")")
	end

	if (not isnumber(size)) then
		error("bad argument #2 to draw.DrawVectorSprite (number expected, got " .. type(size) .. ")")
	end

	if (not IsColor(color)) then
		error("bad argument #3 to draw.DrawVectorSprite (Color expected, got " .. type(color) .. ")")
	end

	local tbl = {position, size, color}

	if (constantSize) then
		sprites2d = sprites2d + 1
		toDraw2d[sprites2d] = tbl
	else
		sprites3d = sprites3d + 1
		toDraw3d[sprites3d] = tbl
	end
end

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
hook.Add("PreDrawEffects", "draw.VectorSprite", function()
	if (sprites3d ~= 0) then
		render_SetMaterial(material)

		for i = 1, sprites3d do
			local info = toDraw3d[i]
			toDraw3d[i] = nil -- Clear the table every frame

			render_DrawSprite(info[1], info[2], info[2], info[3])
		end

		sprites3d = 0
	end
end)

local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawTexturedRect = surface.DrawTexturedRect
hook.Add("DrawOverlay", "draw.VectorSprite", function()
	if (sprites2d ~= 0) then
		surface_SetMaterial(material)

		for i = 1, sprites2d do
			local info = toDraw2d[i]
			toDraw2d[i] = nil

			local pos2d = info[1]:ToScreen()

			if pos2d.visible then
				surface_SetDrawColor(info[3])
				surface_DrawTexturedRect(pos2d.x, pos2d.y, info[2], info[2])
			end
		end

		sprites2d = 0
	end
end)

local circle = Material("hud/circle.png")
hook.Add("PostDrawTranslucentRenderables", "WaypointSystemStockade", function() -- Add Material to content + set green or some shit
    if LocalPlayer():Team() != TEAM_BANK_SECURITY then return end
    if not IsValid(LocalPlayer():GetNWEntity("MoneyPickedUp")) then return end
    cam.Start3D2D( LocalPlayer():GetNWEntity("MoneyPickedUp"):GetNWVector("VaultPoint") + Vector(0,0,3), Angle(0,90,0), 0.07 )
    surface.SetDrawColor(112, 255, 146, Alpha)
    surface.SetMaterial(circle)
    surface.DrawTexturedRect(-200, -200, 400, 400)
    cam.End3D2D()
end)

local Alpha = 255
hook.Add("HUDPaint", "WaypointSystemStockade", function()
    
    if not IsValid(LocalPlayer():GetNWEntity("MoneyPickedUp")) then return end

    local vector = LocalPlayer():GetNWEntity("MoneyPickedUp"):GetNWVector("VaultPoint")

    local dist = vector:Distance(LocalPlayer():GetPos())
    local FadePoint = 400
    local RealDist = 200

    if (dist > RealDist) then
        Alpha = 255
        if (dist >= RealDist) then
            local moreDist = FadePoint - dist
            local percOff = ((moreDist / (FadePoint - RealDist)) * -1) + 1
            Alpha = math.floor(255 * percOff)
        end
    end

    local pos = vector:ToScreen()
    draw.RoundedBox(4, pos.x-1, pos.y-50, 2, 50, Color(112, 255, 146, Alpha))
    draw.SimpleText(string.Comma(math.Round(dist/100)) .. "m", "MainFont", pos.x, pos.y-55, Color(255,255,255,Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

end)