--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local pantingSound
local curPlayingPanting
local lastSoundLevel = 0

local BreathingSound = Sound( "perp2.5/breathing.mp3" )
local DurationOfBreath = SoundDuration( BreathingSound )

LEAVE_DIALOG = function() GAMEMODE.DialogPanel:Hide() end

timer.Create( "ManageSprint", 0.2, 0, function()
	if IsValid( LocalPlayer() ) then
		
		if not GAMEMODE.Options_MuteLocalBreath:GetBool() and LocalPlayer():Alive() and LocalPlayer:GetNWFloat("Stamina") and LocalPlayer:GetNWFloat("Stamina") <= 25 then
			if not pantingSound then
				pantingSound = CreateSound( LocalPlayer(), BreathingSound )
			end
			if not curPlayingPanting or curPlayingPanting <= CurTime() then
				curPlayingPanting = CurTime() + DurationOfBreath

				pantingSound:Stop()
				pantingSound:Play()
			end
			local soundLevel = 1 - ( LocalPlayer:GetNWFloat("Stamina") / 25 )
			if soundLevel ~= lastSoundLevel then
				pantingSound:ChangeVolume( soundLevel, 1 )
			end
		elseif pantingSound and curPlayingPanting then
			pantingSound:Stop()
			curPlayingPanting = nil
			lastSoundLevel = 0
		end
	end
	
	for _, v in pairs( player.GetHumans() ) do
		if LocalPlayer() and v:GetPos():Distance( LocalPlayer():GetPos() ) < 300 and LocalPlayer() ~= v then
			if v:GetGNWVar( "tired" ) then
				if not v.pantingSound then
					v.pantingSound = CreateSound( v, BreathingSound )
				end
				if not v.curPlayingPanting or v.curPlayingPanting <= CurTime() then
					v.curPlayingPanting = CurTime() + DurationOfBreath
					
					v.pantingSound:Stop()
					v.pantingSound:Play()
				end
				local soundLevel = 1 - ( v:GetNWFloat("Stamina") / 25 )
				if soundLevel ~= lastSoundLevel then
					pantingSound:ChangeVolume( soundLevel, 1 )
				end
			elseif v.pantingSound then
				v.pantingSound:Stop()
				v.pantingSound = nil
			end
		end
	end
end )

function ENTITY:IsVehicle()
	if not IsValid( self ) then return end

	return self:GetClass() == "prop_vehicle_jeep"
end

function SpeedText( MPH, inner )
	local MPH = MPH

	if inner then
		if MPH then
			if GAMEMODE.Options_EuroStuff:GetBool() then return math.Round( MPH * 1.609344 ) .. " KPH" end
			return MPH .. " MPH"
		else
			Msg("Setting inner city speed limit because GNWVars broke...\n");
			return "25 MPH"
		end
	else
		if MPH then
			if GAMEMODE.Options_EuroStuff:GetBool() then return math.Round( MPH * 1.609344 ) .. " KPH" end
			return MPH .. " MPH"
		else
			Msg("Setting outter city speed limit because GNWVars broke...\n"); 
			return "55 MPH"
		end
	end
end

function util.IsInWorld( point )
	local trTable = {}
	trTable.start = point
	trTable.endpos = Vector( 0, 0, 1 )
	trTable.mask = SOLID_BRUSHONLY
	
	local tr = util.TraceLine( trTable )
	
	return not tr.StartSolid
end

net.Receive( "perp2_mayor_info", function()
	GAMEMODE.CityBudget 				= net.ReadInt(32)
	GAMEMODE.CityBudget_LastIncome 		= net.ReadInt(16)
	GAMEMODE.CityBudget_LastExpenses 	= net.ReadInt(16)
end )

net.Receive( "SendWagesToClients", function()
	GAMEMODE.JobWages 					= net.ReadTable()
	local newmax = net.ReadTable()
	for k, v in pairs(newmax or {}) do
		GAMEMODE.MaxJobs[k] = v
	end
	local newmax = net.ReadTable()
	for k, v in pairs(newmax or {}) do
		GAMEMODE.MaxVehicles[k] = v
	end
	GAMEMODE.MayorLaws = net.ReadString()
end )

net.Receive( "SendJobMaxesToClients", function()
	local newmax = net.ReadTable()
	for k, v in pairs(newmax) do
		GAMEMODE.MaxJobs[k] = v
	end
end )

net.Receive( "SendVehicleMaxesToClients", function()
	local newmax = net.ReadTable()
	for k, v in pairs(newmax) do
		GAMEMODE.MaxVehicles[k] = v
	end
end )

net.Receive( "SendMayorLaws", function()
	GAMEMODE.MayorLaws = net.ReadString()
end )

net.Receive( "perp_sendcollectables", function()
	LocalPlayer()["PERP_Collectables"] = net.ReadTable()
end)

function PLAYER:HasCollectable(collectable,id)
	if not self["PERP_Collectables"] then return false end
	if not self["PERP_Collectables"][collectable] then return false end
	return self["PERP_Collectables"][collectable][id] or false
end