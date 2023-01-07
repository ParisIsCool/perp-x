--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

PROPERTY_DATABASE = PROPERTY_DATABASE or {}

PERP_DoorData = {
	["IsPoliceDoor"] = 				{t="Municipal Government",c=Color(255, 255, 255),o=Color(255, 0, 0),o2=Color(0, 0, 255),g="policeDoors"},
	["IsFireDoor"] = 				{t="Fire Department",c=Color(255, 255, 255),o=Color(255, 0, 0),o2=Color(255, 102, 0),g="fireDoors"},
	["IsNationalGuardDoor"] = 		{t="National Guard",c=Color(255, 255, 255),o=Color(255, 0, 0),g="nationalGuardDoor"},
	["IsCivilDoor"] = 				{t="Civil Services",c=Color(255, 255, 255),o=Color(0, 119, 255),g="civilDoors"},
	["IsClubDoor"] = 				{t="Club",c=Color(255, 255, 255),o=Color(255, 0, 0),g="clubDoors"},
	["IsRealtorOfficeDoor"] = 		{t="Realtor Office",c=Color(255, 255, 255),o=Color(255, 0, 0),g="RealtorOfficeDoors"},
	["IsBPShopDoor"] = 				{t="7-Twelve",c=Color(255, 255, 255),o=Color(43, 99, 204),g="BPShopDoors"},
	["IsGasShopDoor"] = 			{t="Gas Station",c=Color(255, 255, 255),o=Color(43, 99, 204),g="GasShopDoor"},
	["IsFCStoreDoor"] = 			{t="Urban Outfits",c=Color(255, 255, 255),o=Color(201, 61, 189),g="FCStoreDoors"},
	["IsCasinoDoor"] = 				{t="Casino",c=Color(255, 255, 255),o=Color(255, 0, 0),g="CasinoDoors"},
	["IsRockfordCustoms"] = 		{t="Rockford Customs",c=Color(255, 255, 255),o=Color(255, 0, 0),g="RockfordCustoms"},
	["IsTidesHotelDoor"] = 			{t="Tides Hotel",c=Color(255, 255, 255),o=Color(255, 0, 0),g="TidesHotelDoors"},
	["IsShopsDoor"] = 				{t="Hardware Shop",c=Color(255, 255, 255),o=Color(48, 202, 61),g="ShopsDoors"},
	["IsHospitalDoor"] = 			{t="Hospital",c=Color(255, 255, 255),o=Color(255, 0, 0),g="HospitalDoors"},
	["IsApartments1Door"] = 		{t="Mesa Apt. 1",c=Color(255, 255, 255),o=Color(255, 0, 0),g="Apartments1Doors"},
	["IsApartments2Door"] = 		{t="Mesa Apt. 2",c=Color(255, 255, 255),o=Color(255, 0, 0),g="Apartments2Doors"},
	["IsUnionSqApartmentDoor"] = 	{t="Union Square Apartments",c=Color(255, 255, 255),o=Color(221, 99, 99),g="UnionSqDoors"},
	["IsWorldCorpDoor"] = 			{t="World Corp.",c=Color(255, 255, 255),o=Color(51, 160, 211),g="WorldCorpDoors"},
	["IsLaGrandeDoor"] = 			{t="Le Grande Hotel",c=Color(255, 255, 255),o=Color(111, 0, 255),g="LaGrandeDoors"},
	["IsMotelDoor"] = 				{t="Motel Reception",c=Color(255, 255, 255),o=Color(217, 255, 0),g="MotelReceptionDoors"},
	["IsCarDealerDoor"] = 			{t="Car Dealership",c=Color(255, 255, 255),o=Color(255, 0, 255),g="CarDealerDoors"},
	["IsGovermentCenterDoor"] = 	{t="Government Center",c=Color(255, 255, 255),o=Color(255, 0, 0),g="GovermentCenterDoors"},
	["IsJailsDoor"] = 				{t="Municipal Government - Jails",c=Color(255, 255, 255),o=Color(255, 0, 0),g="JailsDoors"},
	["IsRoadCrewDoor"] = 			{t="Gateway Tire & Service Center",c=Color(255, 255, 255),o=Color(255, 94, 0),g="RoadCrewDoors"},
	["IsBankDoor"] = 				{t="Bank",c=Color(255, 255, 255),o=Color(255, 0, 0),g="BankDoor"},
	["IsBusDoor"] = 				{t="Rockford Transit Authority",c=Color(255, 255, 255),o=Color(255, 0, 0),g="BusDoor"},
	["IsHardwareStoreDoor"] =		{t="Hardware Store",c=Color(255, 255, 255),o=Color(54, 241, 170),g="HardwareStoreDoors"},
	["Unknown"] = 					{t="",c=Color(255, 255, 255),o=Color(0, 0, 0)},
	["IsEmptyDoor"] = 				{t="",c=Color(255, 255, 255),o=Color(0, 0, 0),g="emptyDoor"},
}

for index, doordata in pairs(PERP_DoorData) do
	if not doordata.g then continue end
	local function CheckDoor(ent)
		if CLIENT and not IsValid(ent) then ent = LocalPlayer():GetEyeTrace().Entity end
		if not ent:IsDoor() then return end
	
		for _, v in pairs( _G[doordata.g] or {} ) do
			if v[1]:Distance( ent:GetPos() ) < 50 and v[2] == ent:GetModel() then
				return true
			end
		end
	end
	ENTITY[index] = CheckDoor
end

function GM:RegisterProperty( PropertyTable )
	if not PROPERTY_DATABASE[ PropertyTable.ID ] then
		--Msg( "\t-> Loaded " .. PropertyTable.Name .. "\n" )
	end

	if CLIENT then
		if game.GetMap():lower() == 'rp_evocity2_v3p' or 'rp_rockford_v2b' or 'rp_florida_v2' then
			PropertyTable.Texture = Material("paris/" .. game.GetMap() .. "/" .. PropertyTable.Image .. ".png")
		else
			PropertyTable.Texture = surface.GetTextureID( "paris/" .. game.GetMap() .. "/" .. PropertyTable.Image )
		end
	else
		for _, v in pairs( PropertyTable.Doors ) do
			if type( v ) ~= "table" then
				--PERP1 system
				for _, ent in pairs( ents.FindInSphere( v, 50 ) ) do
					if ent:IsDoor() then
						ent:Fire( "lock", "", 0 )
					end
				end
			else
				--PERP2 system
				for _, ent in pairs( ents.FindInSphere( v[1], 50) ) do
					if ent:IsDoor() and ent:GetModel() == v[2] then
						ent:Fire( "lock", "", 0 )
					end
				end
			end
		end
	end

	PROPERTY_DATABASE[ PropertyTable.ID ] = PropertyTable
end

function PLAYER:CanManipulateDoor( door )
	if ( self:Team() == TEAM_POLICE or self:Team() == TEAM_DISPATCHER or self:Team() == TEAM_CHIEF or self:Team() == TEAM_FBI or self:Team() == TEAM_DETECTIVE or self:Team() == TEAM_SWAT or self:Team() == TEAM_MAYOR or self:Team() == TEAM_SECRET_SERVICE ) and door:IsPoliceDoor() then return true end
	if ( self:Team() == TEAM_FIRECHIEF or self:Team() == TEAM_FIREMAN ) and door:IsFireDoor() then return true end
	if ( self:Team() == TEAM_FBI ) and door:IsBPShopDoor() then return true end
	if ( self:Team() == TEAM_POLICE or self:Team() == TEAM_CHIEF or self:Team() == TEAM_FBI or self:Team() == TEAM_DETECTIVE or self:Team() == TEAM_SWAT or self:Team() == TEAM_FIREMAN or self:Team() == TEAM_FIRECHIEF or self:Team() == TEAM_MEDIC or self:Team() == TEAM_MAYOR or self:Team() == TEAM_SECRET_SERVICE  ) and door:IsCivilDoor() then return true end
	if ( self:Team() == TEAM_MEDIC ) and door:IsHospitalDoor() then return true end
	if ( self:Team() == TEAM_BANK_SECURITY ) and door:IsBankDoor() then return true end
	if ( self:Team() == TEAM_ROADSERVICE ) and door:IsRoadCrewDoor() then return true end

	if not door:IsDoor() and not door:IsVehicle() then return end

	local doorOwner = door:GetTrueOwner()
	if not doorOwner or not IsValid( doorOwner ) or not doorOwner:IsPlayer() then return end

	if self == doorOwner or doorOwner:HasBuddy( self ) then return true end
end

function PLAYER:CanManipulateCopDoor( door )
	if ( self:Team() == TEAM_POLICE or self:Team() == TEAM_DISPATCHER or self:Team() == TEAM_CHIEF or self:Team() == TEAM_FBI or self:Team() == TEAM_DETECTIVE or self:Team() == TEAM_SWAT or self:Team() == TEAM_MAYOR or self:Team() == TEAM_SECRET_SERVICE ) and door:IsPoliceDoor() then return true end
	if ( self:Team() == TEAM_FIRECHIEF or self:Team() == TEAM_FIREMAN ) and door:IsFireDoor() then return true end
	if ( self:Team() == TEAM_FBI ) and door:IsBPShopDoor() then return true end
	if ( self:Team() == TEAM_POLICE or self:Team() == TEAM_CHIEF or self:Team() == TEAM_FBI or self:Team() == TEAM_DETECTIVE or self:Team() == TEAM_SWAT or self:Team() == TEAM_FIREMAN or self:Team() == TEAM_FIRECHIEF or self:Team() == TEAM_MEDIC or self:Team() == TEAM_MAYOR or self:Team() == TEAM_SECRET_SERVICE  ) and door:IsCivilDoor() then return true end
	if ( self:Team() == TEAM_MEDIC ) and door:IsHospitalDoor() then return true end

	if ( self:Team() == TEAM_ROADSERVICE ) and door:IsRoadCrewDoor() then return true end

	if not door:IsDoor() and not door:IsVehicle() then return end

	local doorOwner = door:GetTrueOwner()
	if not doorOwner or not IsValid( doorOwner ) or not doorOwner:IsPlayer() then return end
	

	if self == doorOwner then return true end
end

function ENTITY:IsDoor()
	return string.find( self:GetClass(), "door" ) and self:GetClass() ~= "item_doorbuster"
end

local doorAssosiations = {}
function ENTITY:GetPropertyTable()
	if CLIENT and not IsValid(self) then self = LocalPlayer():GetEyeTrace().Entity end
	if not self:IsDoor() then return end

	if not doorAssosiations[ self:EntIndex() ] then
		for k, v in pairs( PROPERTY_DATABASE ) do
			for _, doorInfo in pairs( v.Doors ) do
				if type( doorInfo ) ~= "table" then
					--PERP1 system
					if doorInfo:Distance( self:GetPos() ) < 50 then
						doorAssosiations[ self:EntIndex() ] = k
					end
				else
					--PERPX system
					if doorInfo[1]:Distance( self:GetPos() ) < 50 and self:GetModel() == doorInfo[2] then
						doorAssosiations[ self:EntIndex() ] = k
					end
				end
			end
		end
	end

	return PROPERTY_DATABASE[ doorAssosiations[ self:EntIndex() ] ]
end

function ENTITY:GetTrueOwner()
	if not self:IsVehicle() and not self:IsDoor() then return end

	if self:IsDoor() then
		if self:GetPropertyTable() then
			return GetGNWVar( "p_" .. self:GetPropertyTable().ID )
		else
			return
		end
	end

	return self:GetGNWVar( "Owner" ) and Entity( self:GetGNWVar( "Owner" ) ) or NULL
end

ENTITY.GetDoorOwner = ENTITY.GetTrueOwner
ENTITY.GetVehicleOwner = ENTITY.GetTrueOwner
ENTITY.GetCarOwner = ENTITY.GetTrueOwner