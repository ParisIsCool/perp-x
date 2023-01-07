--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


include( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

SWEP.BreakSelfChance 		= 10
SWEP.PercentChance 			= 10

SWEP.BreakSelfChanceArrested 		= 10
SWEP.PercentChanceArrested 			= 25

util.AddNetworkString("perp_house_alarm")
function SWEP:TryToBatterDoor( Target )
	Target:EmitSound( self.BatterSound )

	timer.Simple( 1.5, function()
		if not IsValid( self ) then return end
		if not IsValid( Target ) then return end
		
		local Door = Target:GetPropertyTable()
		local Owner = Target:GetTrueOwner()
		
		local Randomness = math.random( 1, 100 )

		if Randomness <= self.BreakSelfChance then
			Target:EmitSound( self.BreakSound )
			self.Owner:Notify( "Your lock pick broke!" )
			self.Owner:RemoveEquipped( EQUIP_SIDE )
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then		
			Target:Fire( "unlock", "", 0 )
			Target:Fire( "open", "", .5 )

			self.Owner:GiveExperience( SKILL_LOCK_PICKING, 25 )
			self.Owner:AddProgress(32, 1)

			self.Owner:Notify( "Door lockpicked!" )

			if IsValid( Owner ) then
				Log( Format( "%s(%s) lock picked %s(%s)'s door %s", self.Owner:Nick(), self.Owner:GetRPName(), Owner:Nick(), Owner:GetRPName(), Door.Name or "N/A" ), Color( 255, 0, 0 ) )

				local Log = Format( "%s(%s)<%s> lock picked %s(%s)<%s>'s door %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), Owner:Nick(), Owner:GetRPName(), Owner:SteamID(), Door.Name or "N/A" )
				GAMEMODE:Log( "lockpicks", Log )

				GAMEMODE:LogToAdmins("Misc",{
					text = self.Owner:GetRPName() .. " ["..self.Owner:SteamID().."] lockpicked door of " .. Owner:GetRPName() .. " ["..Owner:SteamID().."] " ,
					position = self.Owner:GetPos(),
					victimposition = Owner:GetPos(),
					player = self.Owner:SteamID(),
					victim = Owner:SteamID(),
					location = self.Owner:GetZoneName(),
				})

			end
		end

		local GroupTable = Target:GetPropertyTable()

		if GroupTable then
			local Group = GroupTable.ID
			
			if GAMEMODE.HouseAlarms[ Group ] and ( not Target.LastSirenPlay or Target.LastSirenPlay + 30 < CurTime() ) and IsValid( Owner ) then
				local recipient = RecipientFilter()
					recipient:AddPVS( Target:GetPos() )

				net.Start( "perp_house_alarm" )
				net.WriteEntity( Target )
				net.Send(recipient)
				
				--radar.AddAlertTeam( Target:EntIndex() .. "HouseAlarm", { TEAM_FIREMAN, TEAM_MAYOR, TEAM_PARAMEDIC, TEAM_SWAT }, Target:GetPos(), "Burglar Alarm!!", Color( 255, 255, 0, 200 ) )
				timer.Simple( 28, function()
					--radar.RemoveAlert( Target:EntIndex() .. "HouseAlarm" )
				end )
				
				Target.LastSirenPlay = CurTime()
				
				local lifeAlertZone = Target:GetZoneName()
				
				if lifeAlertZone then
					GAMEMODE:PlayerSay( Target:GetDoorOwner(), "/911 [Burglar Alarm] A break in has occured at " .. lifeAlertZone .. ". Police requested.", true, false, true )
				end
			end
		end
	end )
end

function SWEP:TryToBatterVehicle( Target )
//	return self.Owner:Notify( "Lockpicking vehicles has been disabled." )

	Target:EmitSound( self.BatterSound )
	
	timer.Simple( 1.5, function()
		if not self then return end
		if not IsValid( Target ) then return end

		local Randomness = math.random( 1, 100 )

		if Randomness <= self.BreakSelfChance then
			Target:EmitSound( self.BreakSound )
			self.Owner:Notify( "Your lock pick broke!" )
			self.Owner:RemoveEquipped( EQUIP_SIDE )
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then		
			Target:Fire( "unlock", "", 0 )
			Target:Fire( "open", "", .5 )

			self.Owner:GiveExperience( SKILL_LOCK_PICKING, 25 )

			local CarOwner = Target:GetTrueOwner()
			CarOwner.StolenCarTimeLimit = CurTime() + 180;
			
			self.Owner:Notify( "Vehicle lockpicked!" )
			self.Owner.StolenCar = Target;
			
			local Owner = Target:GetTrueOwner()
			local VehicleTable = Target.vehicleTable

			if IsValid( Owner ) then
				Log( Format( "%s(%s) lock picked %s(%s)'s %s", self.Owner:Nick(), self.Owner:GetRPName(), Owner:Nick(), Owner:GetRPName(), VehicleTable.Name or "N/A" ), Color( 255, 0, 0 ) )

				GAMEMODE:LogToAdmins("Misc",{
					text = self.Owner:GetRPName() .. " ["..self.Owner:SteamID().."] lockpicked " .. Owner:GetRPName() .. " ["..Owner:SteamID().."] " .. VehicleTable.Name or "N/A" ,
					position = self.Owner:GetPos(),
					victimposition = Owner:GetPos(),
					player = self.Owner:SteamID(),
					victim = Owner:SteamID(),
					location = self.Owner:GetZoneName(),
				})
				
				local folderdate, timedate = GAMEMODE:GetLogDate()
				local format = Format( "%s(%s)<%s> lock picked %s(%s)<%s>'s %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), Owner:Nick(), Owner:GetRPName(), Owner:SteamID(), VehicleTable.Name or "N/A" )
				file.Append( Format( "perp_logs/%s/lockpicks.txt", folderdate ), Format( "[%s] %s\n", timedate, format ) )
			end
		end
	end )
end

function SWEP:TryToBatterArrestee()
//	return self.Owner:Notify( "Lockpicking handcuffs has been disabled." )

	local EyeTrace = self.Owner:GetEyeTrace()

	EyeTrace.Entity:EmitSound( self.BatterSound )
	
	--self.Owner:Notify( "Attempting lockpick of handcuffs (2)" )
	
	timer.Simple( 1.5, function()
		--if not self then return end
		--if not IsValid( EyeTrace ) then return end

		--self.Owner:Notify( "Attempting lockpick of handcuffs (2.5)" )

		--local Randomness = math.random( 1, 100 ) //original for doors and cars
		local Randomness = math.random( 1, 55 ) //lockpicking handcuffs! (lets make it a bit easier ...)
		
		if Randomness <= self.BreakSelfChanceArrested then
			EyeTrace.Entity:EmitSound( self.BreakSound )
			self.Owner:Notify( "Your lock pick broke!" )
			self.Owner:RemoveEquipped( EQUIP_SIDE )
			
		elseif Randomness <= self.BreakSelfChanceArrested + self.PercentChanceArrested then
			
			self.Owner:GiveExperience( SKILL_LOCK_PICKING, 25 )

			if CLIENT then return end

			local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
			if Distance > 75 then return end

			local Victim = EyeTrace.Entity
			if not IsValid( Victim ) or not Victim:IsPlayer() then return end

			if not Victim.CurrentlyArrested then return end

			Log( Format( "%s(%s) broke %s(%s) out of handcuffs", self.Owner:Nick(), self.Owner:GetRPName(), Victim:Nick(), Victim:GetRPName() ), Color( 0, 191, 255 ) )
			
			local Log = Format( "%s(%s)<%s> lock picked handcuffs of %s(%s)<%s>'s at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), Victim:Nick(), Victim:GetRPName(), Victim:SteamID(), Victim:GetZoneName() )
			GAMEMODE:Log( "released", Log )

			self.Owner:Notify( "You have broke " .. Victim:GetRPName() .. " out of handcuffs!" )
			Victim:Notify( "You have been broken out of your handcuffs!" )
			
			Victim:UnArrest()
			Victim:SetNWBool("isPlayerArrested", false)
		end
	end )
end

local BlockedDoors = {
	Entity(608),
	Entity(607),
	Entity(594),
	Entity(595),
}

function SWEP:PrimaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()
    if not IsValid( EyeTrace.Entity ) then return end
    
	self.PercentChance = 10 + self.Owner:GetSkillLevel( SKILL_LOCK_PICKING ) * 2
    self.BreakSelfChance = 10 - self.Owner:GetSkillLevel( SKILL_LOCK_PICKING )
    
	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return end

	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
	
	if EyeTrace.Entity:IsDoor() then

		if table.HasValue(BlockedDoors, EyeTrace.Entity) then return end
		if self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return self.Owner:Notify( "Use your keys." ) end
		if not EyeTrace.Entity:GetSaveTable().m_bLocked then EyeTrace.Entity:Fire( "open", "", .5 ) end
		if EyeTrace.Entity:GetTrueOwner():GetNWInt("unraidable_until") and os.time() < EyeTrace.Entity:GetTrueOwner():GetNWInt("unraidable_until") then return self.Owner:Notify( "This person is not raidable." ) end

		self:TryToBatterDoor( EyeTrace.Entity )
		
	elseif EyeTrace.Entity:IsVehicle() and IsValid( EyeTrace.Entity.Owner ) and EyeTrace.Entity:GetClass() == "prop_vehicle_jeep" then
	
		if self.Owner:CanManipulateDoor( EyeTrace.Entity ) then return self.Owner:Notify( "Use your keys." ) end
		if IsValid( EyeTrace.Entity:GetDriver() ) then return self.Owner:Notify( "You can't lockpick a car with a driver in it..." ) end
		if not EyeTrace.Entity:GetSaveTable().VehicleLocked then return self.Owner:Notify( "The vehicle is already unlocked." ) end

		local VehicleOwner = EyeTrace.Entity.Owner
		local VehicleTable = EyeTrace.Entity.vehicleTable

		if VehicleTable.RequiredClass then return self.Owner:Notify( "[Car Alarm] You can't break into a government vehicle." ) end
		
		if not IsValid( VehicleOwner ) or not VehicleOwner.Vehicles or not VehicleOwner.Vehicles[ VehicleTable.ID ] then return end
		
		local AntiTheft = VehicleOwner.Vehicles[ VehicleTable.ID ].AntiTheft or 0

		if AntiTheft ~= 0 then
			EyeTrace.Entity:EmitSound( self.BatterSound )

			if not EyeTrace.Entity.TempAlarmDisable or EyeTrace.Entity.TempAlarmDisable < CurTime() then
				if EyeTrace.Entity.AlarmEntity then
					if EyeTrace.Entity.AlarmPos < CurTime() then
						EyeTrace.Entity.AlarmEntity:Stop()
						EyeTrace.Entity.AlarmEntity:Play()
						EyeTrace.Entity.AlarmWentOff = os.time()
						EyeTrace.Entity.AlarmPos = CurTime() + 23
					end
				end
			end
			
			--radar.AddAlertTeam( EyeTrace.Entity:EntIndex() .. "CarAlarm", { TEAM_FIREMAN, TEAM_MAYOR, TEAM_PARAMEDIC, TEAM_SWAT }, EyeTrace.Entity:GetPos(), "Car Alarm!!", Color( 255, 255, 0, 200 ) )
			timer.Simple( 28, function()
				--radar.RemoveAlert( EyeTrace.Entity:EntIndex() .. "CarAlarm" )
			end )

            VehicleOwner:Notify( "[Car Alarm] Someone attempted to break into your vehicle!" )
            
            if VehicleOwner:IsVIP() then
                self.PercentChance = 7 + ( self.Owner:GetSkillLevel( SKILL_LOCK_PICKING ) * 1.5 )
                self.BreakSelfChance = (15 * 1.2) - self.Owner:GetSkillLevel( SKILL_LOCK_PICKING )
            elseif VehicleOwner:IsGoldVIP() then
                self.PercentChance = 5 + ( self.Owner:GetSkillLevel( SKILL_LOCK_PICKING ) * 1 )
                self.BreakSelfChance = (20 * 1.4) - self.Owner:GetSkillLevel( SKILL_LOCK_PICKING )
            end

            self:TryToBatterVehicle( EyeTrace.Entity )
		    self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
            self.Weapon:SetNextSecondaryFire( CurTime() + 3 )

            return
		end
		
		self:TryToBatterVehicle( EyeTrace.Entity )

		self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
		
	elseif EyeTrace.Entity:IsPlayer() then
	
		local Victim = EyeTrace.Entity
		if not IsValid( Victim ) or not Victim:IsPlayer() then return end
	
		if not Victim.CurrentlyArrested then return end

		--self.Owner:Notify( "Attempting lockpick of handcuffs (1)" )

		self:TryToBatterArrestee( EyeTrace.Entity )

		self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
		self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
		
	end

end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end