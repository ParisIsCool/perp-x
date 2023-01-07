--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local MAX_AIR 		= 300
local DRAIN_RATE	= 0.5
local FILL_RATE		= 0.7

hook.Add( "EntityTakeDamage", "AirDamage", function( Player, Info )
	local Vehicle

	if Player:IsVehicle() then
		Vehicle = Player
		Player = Vehicle:GetDriver()
	elseif Player:IsPlayer() then
		Vehicle = Player:GetVehicle()
	end

	if IsValid( Player ) and Player:IsPlayer() and not IsValid( Vehicle ) then
		if Player:WaterLevel() >= 3 and ( Player.BAir and Player.BAir < 50 ) then
			Info:SetDamageType( DMG_DROWN )
		end
	end
end )

timer.Create("isSwimming", 10, 0, function()
        for _, v in pairs( player.GetHumans() ) do
            if v:WaterLevel() >= 2 then
	    		-- add swimming skill
        		v:GiveExperience(SKILL_SWIMMING, 1)
            end
        end
end)

hook.Add( "Tick", "MonitorDrowning", function()
	for _, v in pairs( player.GetHumans() ) do
		local Vehicle = v:GetVehicle()
		if v:Alive() then
			if not v.BAir then
				v.BAir = MAX_AIR
			end
			if ( IsValid( Vehicle ) and Vehicle:WaterLevel() or v:WaterLevel() ) >= 3 then
				if v.BAir >= 0 then
					v.BAir = v.BAir - DRAIN_RATE
				end
				
				if v.BAir < 10 then
					local CurTime = CurTime()
					if not v.UH_WaterTimer then
						v.UH_WaterTimer = CurTime + 0.1
					end
					
					if v.UH_WaterTimer <= CurTime then
						v.UH_WaterTimer = CurTime + 0.9
						if IsValid( Vehicle ) and Vehicle:GetClass() == "prop_vehicle_jeep" then
							Vehicle:TakeDamage( 10 )
						else
							v:TakeDamage( 10 )
						end
					end
				end
				
			else --Above water
				if v.BAir < MAX_AIR then
					v.BAir = v.BAir + FILL_RATE
				end
			end
		else
			if v.BAir ~= MAX_AIR then
				v.BAir = nil --Reset, death
			end
		end
	end
end )