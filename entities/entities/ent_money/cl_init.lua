include('shared.lua')

function ENT:Initialize()
end

function ENT:Think()

end

local color = Color( 255, 255, 255 )

hook.Add( "PreDrawHalos", "AddPropHalos", function()
    local e = LocalPlayer():GetEyeTrace().Entity
    if IsValid(e) and e:GetClass() == "ent_money" then
	    --halo.Add( {e}, color, 5, 5, 2 )
    end
end )

-- Draw some 3D text
local function Draw3DText( pos, ang, scale, text, flipView, col )
	if ( flipView ) then
		-- Flip the angle 180 degrees around the UP axis
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end

	cam.Start3D2D( pos, ang, scale )
		-- Actually draw the text. Customize this to your liking.
		draw.DrawText( text, "Default", 0, 0, col, TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	-- Draw the model
	self:DrawModel()

	-- The text to display
	local text = "$" .. string.Comma(self:GetNWInt("Worth"))

	-- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 10 + math.sin(CurTime()*5) )

	-- The angle
	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	-- Draw front
	Draw3DText( pos, ang, 0.2, text, false, Color(112, 255, 146 ) )
	-- DrawDraw3DTextback
	Draw3DText( pos, ang, 0.2, text, true, Color(112, 255, 146 ) )





    if self:GetNWInt( 'IsDirty' ) then

        local dirtyTimer = self:GetNWInt( 'DirtyTimer' )
        local dirtyTimerText = string.FormattedTime( dirtyTimer, "%02i:%02i" )
        if( dirtyTimer <= 0 ) then dirtyTimerText = "CLEANED" end 

        local mins, maxs = self:GetModelBounds()
        local pos = self:GetPos() + Vector( 0, 0, maxs.z + 20 + math.sin(CurTime()*5) )

        local ang = Angle( 0, SysTime() * 100 % 360, 90 )

        Draw3DText( pos, ang, 0.2, dirtyTimerText, false, Color(255, 81, 81) )

        Draw3DText( pos, ang, 0.2, dirtyTimerText, true, Color(255, 81, 81) )
    end
end