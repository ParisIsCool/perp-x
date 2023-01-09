--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

/*************************************************
	Function PLAYER:LoadVehicles()
	Job: Initalize the players vehicles from the database.
*************************************************/

util.AddNetworkString("perp_vehicle_init")
util.AddNetworkString("perp_vehicle_clear")
function PLAYER:LoadVehicles()
	self.Vehicles = {}

	net.Start( "perp_vehicle_clear" ) net.Send(self)
	tmysql.query( Format( Query( "LOADVEHICLES" ), self.PERPID ), function( Results, Status, ErrorMsg )
		for _, v in pairs( Results ) do
			local db = VEHICLE_DATABASE[ v[ "car_id" ] ]
			if not db then ErrorNoHalt( Format( "%s<%s> IP: %s has vehicle ID %s which does not exist\n", self:Nick(), self:SteamID(), self:IPAddress(), v[ "car_id" ] ) ) continue end

			self.Vehicles[ v[ "car_id" ] ] = {
				PaintID = tonumber( v[ "paint_id" ] ),
				HeadLight = util.JSONToTable( v[ "headlight" ] ),
				UnderGlow = util.JSONToTable( v[ "underglow" ] ),
				DixieHorn = tonumber( v[ "custom_horn" ] ),
				Hydraulics = tonumber( v[ "hydraulics" ] ),
				AntiTheft = tonumber( v[ "anti-theft" ] ),
				Disabled = tonumber( v[ "disabled" ] ),
				Fuel = tonumber( v[ "fuel" ] ),
				License_Plate = util.JSONToTable( v[ "license_plate" ] ),
				Engine = tonumber(v[ "engine" ]),
				Turbo = tonumber(v[ "turbo" ]),
			}

			net.Start( "perp_vehicle_init" )
				net.WriteString( v[ "car_id" ] )
				net.WriteInt( v[ "paint_id" ], 16 )
				net.WriteString( v[ "headlight" ] )
				net.WriteString( (v[ "underglow" ]))
				net.WriteInt( v[ "custom_horn" ], 16 )
				net.WriteInt( v[ "hydraulics" ], 16 )
				net.WriteInt( v[ "anti-theft" ], 16 )
				net.WriteInt( v[ "disabled" ], 16 )
				net.WriteString( v[ "license_plate" ] )
				net.WriteInt( v[ "engine" ], 16 )
				net.WriteInt( v[ "turbo" ], 16 )

				if v[ "rgb_colour" ] and v[ "rgb_colour" ] ~= "" then
					net.WriteString( v[ "rgb_colour" ] )
					self.Vehicles[ v[ "car_id" ] ].RGBColour = util.JSONToTable( v[ "rgb_colour" ] )
				else
					net.WriteString( util.TableToJSON( { r = 255, g = 255, b = 255, a = 255 } ) )
				end

				if v[ "bodygroups" ] and v[ "bodygroups" ] ~= "" then
					net.WriteString( v[ "bodygroups" ] )
					self.Vehicles[ v[ "car_id" ] ].BodyGroups = util.JSONToTable( v[ "bodygroups" ] )
				end
			net.Send(self)
		end
	end, QUERY_FLAG_ASSOC )
end

util.AddNetworkString("perp_vehicle_change")
function PLAYER:ChangeVehicleAttribute(id,key,value)
	net.Start("perp_vehicle_change") 
	net.WriteString(id)
	net.WriteString(key)
	net.WriteInt(value,16)
	net.Send(self)
end

util.AddNetworkString("perp_vehicle_change_table")
function PLAYER:ChangeVehicleAttributeTable(id,key,value)
	net.Start("perp_vehicle_change_table") 
	net.WriteString(id)
	net.WriteString(key)
	net.WriteTable(value)
	net.Send(self)
end

/*************************************************
	DRIVING SKILL ADDER
*************************************************/
timer.Create( "DrivingSkill", 1, 0, function()
	for _, v in pairs( player.GetHumans() ) do
		if v:InVehicle() and v:GetVehicle():GetClass() == "prop_vehicle_jeep" then
			v.LastDrivingAllowance = v.LastDrivingAllowance or 0
			local realSpeed = v:GetVehicle():GetVelocity():Length()

			if realSpeed >= 10 and v.LastDrivingAllowance <= CurTime() then
				v:GiveExperience( SKILL_DRIVING, GAMEMODE.ExperienceForDriving )
				v.LastDrivingAllowance = CurTime() + 5
			end
		end
	end
end )

/*************************************************
	Calculates fuel consumption for all vehicles.
*************************************************/
local SpeedVars =	{
	{1, 11, 1},
	{10, 21, 2},
	{20, 31, 3},
	{30, 41, 4},
	{40, 51, 5},
	{50, 61, 6},
	{60, 91, 7},
	{90, 180, 8},
}
timer.Create('fueltimer', 1, 0, function()
	for k, v in pairs(ents.FindByClass('prop_vehicle_jeep')) do
		local Owner = v.Owner
		if not IsValid( Owner ) then continue end

		if (v:GetDriver() && v.IsRunning && !(Owner:IsGovernmentOfficial())) then
			local speed = math.Round(v:GetVelocity():Length() / 17.6)

			local fcs = v.vehicleTable.FCS or 2

			local FuelCost = 1
			for _, svars in pairs(SpeedVars) do
				if (speed > svars[1]) and (speed < svars[2]) then FuelCost = (svars[3] * fcs); end
			end

			if FuelCost > v:GetGNWVar('Fuel', 0) then FuelCost = v:GetGNWVar('Fuel', 0) end
			if (v:GetGNWVar('Fuel', 0) <= 0) then
				v.IsRunning = false
				v:Fire('turnoff', '', 0)
			end
			if (v:GetGNWVar('Fuel', 0) < FuelCost) then return; end

			v:SetGNWVar('Fuel', v:GetGNWVar('Fuel', 0) - FuelCost)
		end
	end
end)

/*************************************************
	"perp_f_a"
	Job: Allow player to add fuel to their recent vehicle
*************************************************/
util.AddNetworkString("perp_f_a")
net.Receive('perp_f_a', function(len, ply)
	if not ply:NearNPC( 200 ) then return ply:CaughtCheating( "Trying to buy fuel without being near a gas station." ) end

	if (ply:Team() != TEAM_CITIZEN) then return end

	local FuelToAdd = net.ReadInt(32)

	if (FuelToAdd < 0) then return end

	local Vehicle = ply:GetPNWVar( 'lastcar', NULL )
	local CurFuel = Vehicle:GetGNWVar('Fuel', 0)

	local CashToTake = math.Round(FuelToAdd * .03)

	if (ply:GetCash() < CashToTake) then return end
	if !(FuelToAdd || IsValid(Vehicle) || Vehicle:IsVehicle() || Vehicle.Owner:Team() == TEAM_CITIZEN) then return end

	Vehicle:SetGNWVar('Fuel', math.Clamp(FuelToAdd + CurFuel, 0, 10000))
	ply:TakeCash(CashToTake)

end)

/*************************************************
	"perp_v_sellit"
	Job: Allow player to sell a vehicle
*************************************************/
util.AddNetworkString("perp_v_sellit")
net.Receive( "perp_v_sellit", function( len, Player )
	if not Player:NearNPC( 4 ) then return Player:CaughtCheating( "Trying to sell a vehicle without being near the Car Dealer." ) end

	if Player:Team() ~= TEAM_CITIZEN then return end

	local vehicleID = net.ReadString()
	local vehicleTable = VEHICLE_DATABASE[ vehicleID ]
	if not vehicleTable then return end
	if vehicleTable.RequiredClass then return Player:CaughtCheating( "Trying to sell " .. vehicleTable.Name .. " a Class Restricted vehicle." ) end
	if not Player.Vehicles[ vehicleID ] then return Player:CaughtCheating( "Trying to sell " .. vehicleTable.Name .. " without owning it." ) end

	Player.Vehicles[ vehicleID ] = nil

	if Player.currentVehicle and Player.currentVehicle.vehicleTable == vehicleTable then Player:RemoveCar() end

	local Log = Format( "%s sold their %s for $%s", Player:Nick(), vehicleTable.Name, util.FormatNumber( vehicleTable.Cost / 2 ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:GiveBank( vehicleTable.Cost / 2, true )

	tmysql.query( Format( Query( "DELETEVEHICLE" ), Player.PERPID, vehicleTable.ID ) )

	Player:PERPSave()

	Player:Notify( Format( "You sold your %s for $%s", vehicleTable.Name, util.FormatNumber( vehicleTable.Cost * 0.5 ) ) )
end )

/*************************************************
	"perp_v_rep"
	Job: Allow player to repair their vehicle
*************************************************/
util.AddNetworkString("perp_vehicle_toggle_state")
util.AddNetworkString("perp_v_rep")
net.Receive( "perp_v_rep", function( len, Player )
	if not Player:NearNPC( 5 ) then return Player:CaughtCheating( "Trying to repair a vehicle without being near the Car Garage." ) end
	if #team.GetPlayers( TEAM_ROADSERVICE ) >= 1 then return Player:ChatPrint( "There are Road Crew on, contact them!" ) end

	local CarID = tmysql.escape(net.ReadString())

	local Car = VEHICLE_DATABASE[ CarID ]
	if not Car then return end

	if Player.Vehicles[ CarID ].Disabled ~= 1 then return end

	local iRepairCost = Car.Cost * 0.01

	if Player:GetCash() - iRepairCost < 0 then
		return Player:Notify( "You can't afford this." )
	end

	if IsValid( Player.currentVehicle ) then
		if Player.currentVehicle.vehicleTable.ID == CarID then
			Player:RemoveCar()
		end
	end

	local Log = Format( "%s repaired their %s for $%s", Player:Nick(), Car.Name, util.FormatNumber( iRepairCost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeCash( iRepairCost, true )

	Player:Notify( "Your car has been repaired" )

	GAMEMODE.NPCUsed( Player, 5 )

	net.Start( "perp_vehicle_toggle_state", Player )
		net.WriteString( CarID )
		net.WriteInt( 0, 16 )
	net.Send(Player)

	Player.Vehicles[ CarID ].Disabled = 0

	tmysql.query( Format( "UPDATE `perp_vehicles` SET `vc_persist` = '%s' WHERE `car_id`='%s' AND `id`='%s';", "{}", CarID, Player.PERPID ) )
	tmysql.query( Format( Query( "TOGGLEVEHICLE" ), 0, Player.PERPID, CarID ) )
end )

/*************************************************
	"perp2_v_hol"
	Job: Allow player to holster their vehicle
*************************************************/

util.AddNetworkString("vehicle_repair_msg")
util.AddNetworkString("vehicle_nothere_msg")
util.AddNetworkString("perp2_v_hol")
net.Receive( "perp2_v_hol", function( len, Player )
	if not Player:NearNPC( 5 ) then return Player:CaughtCheating( "Trying to holster a vehicle without being near the Car Garage." ) end
	if Player:Team() ~= TEAM_CITIZEN and Player:Team() ~= TEAM_SECRET_SERVICE and Player:Team() ~= TEAM_DISPATCHER and Player:Team() ~= TEAM_DETECTIVE then return end

	local objCar = Player.currentVehicle

	if IsValid( objCar ) then
		if ( objCar.Disabled or objCar:WaterLevel() > 0 ) and objCar.vehicleTable.ID then
			local iRepairCost = VEHICLE_DATABASE[ objCar.vehicleTable.ID ].Cost * 0.01

			net.Start( "vehicle_repair_msg" )
				net.WriteString( objCar.vehicleTable.ID )
				net.WriteInt( iRepairCost, 32 )
			net.Send(Player)

		else
			if Player:GetPos():Distance( objCar:GetPos() ) < 1000 then
				Player:RemoveCar()
			else
				net.Start( "vehicle_nothere_msg" ) net.Send(Player)
			end
		end
	end
end )

/*************************************************
	"perp_v_j"
	Job: Allow player to install/uninstall hydraulics on their vehicle
*************************************************/
util.AddNetworkString("perp_v_j")
net.Receive( "perp_v_j", function( len, Player )
	if not Player:IsVIP() then return end
	if not stalls[game.GetMap()][1]["InUse"][2] == Player then return end

	local theirVehicle = Player.currentVehicle
	if not IsValid( theirVehicle ) then return end

	if Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Hydraulics" ] == 1 then
		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Hydraulics" ] = 0
		Player:Notify( Format( "You have uninstalled your %s's hydraulics", theirVehicle.vehicleTable.Name ) )
	else
		if Player:GetCash() < COST_FOR_HYDRAULICS then return end

		local Log = Format( "%s spent $%s on hydraulics for their %s", Player:Nick(), util.FormatNumber( COST_FOR_HYDRAULICS ), theirVehicle.vehicleTable.Name )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( COST_FOR_HYDRAULICS, true )

		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Hydraulics" ] = 1

		Player:Notify( Format( "You have installed hydraulics on your %s for $%s", theirVehicle.vehicleTable.Name, util.FormatNumber( COST_FOR_HYDRAULICS ) ) )
	end

	tmysql.query( Format( Query( "CHANGEVEHICLEHYDRAULICS" ), Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Hydraulics" ], Player.PERPID, theirVehicle.vehicleTable.ID ) )

	Player:PERPSave() -- Save coz of dosh

	Player:ChangeVehicleAttribute(theirVehicle.vehicleTable.ID,"Hydraulics",Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Hydraulics" ])
	net.Start("ServiceVehicleDoneRequest") net.Send(Player)
end )

/*************************************************
	"perp_v_t"
	Job: Allow player to install/uninstall turbo on their vehicle
*************************************************/
util.AddNetworkString("perp_v_t")
net.Receive( "perp_v_t", function( len, Player )
	if not Player:IsVIP() then return end
	if not stalls[game.GetMap()][1]["InUse"][2] == Player then return end

	local theirVehicle = Player.currentVehicle
	if not IsValid( theirVehicle ) then return end

	if Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Turbo" ] == 1 then
		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Turbo" ] = 0
		Player.currentVehicle.Turbo = 0
		local params = Player.currentVehicle:GetVehicleParams()
		params.engine.horsepower = params.engine.horsepower - 50
		Player.currentVehicle:SetVehicleParams(params)
		Player:Notify( Format( "You have uninstalled your %s's turbo", theirVehicle.vehicleTable.Name ) )
	else
		if Player:GetCash() < COST_FOR_TURBO then return end

		local Log = Format( "%s spent $%s on turbo for their %s", Player:Nick(), util.FormatNumber( COST_FOR_TURBO ), theirVehicle.vehicleTable.Name )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( COST_FOR_TURBO, true )

		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Turbo" ] = 1
		Player.currentVehicle.Turbo = 1

		local params = Player.currentVehicle:GetVehicleParams()
		params.engine.horsepower = params.engine.horsepower + 50
		Player.currentVehicle:SetVehicleParams(params)

		Player:Notify( Format( "You have installed turbo on your %s for $%s", theirVehicle.vehicleTable.Name, util.FormatNumber( COST_FOR_HYDRAULICS ) ) )
	end

	tmysql.query( Format( Query( "CHANGEVEHICLETURBO" ), Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Turbo" ], Player.PERPID, theirVehicle.vehicleTable.ID ) )

	Player:PERPSave() -- Save coz of dosh

	Player:ChangeVehicleAttribute(theirVehicle.vehicleTable.ID,"Turbo",Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "Turbo" ])
	net.Start("ServiceVehicleDoneRequest") net.Send(Player)
end )

/*************************************************
	"perp_v_ata"
	Job: Allow player to install/uninstall Anti-Theft on their vehicle
*************************************************/
util.AddNetworkString("perp_v_ata")
net.Receive( "perp_v_ata", function( len, Player )
	if not Player:IsVIP() then return end
	if not stalls[game.GetMap()][1]["InUse"][2] == Player then return end

	local theirVehicle = Player.currentVehicle
	if not IsValid( theirVehicle ) then return end

	if Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "AntiTheft" ] == 1 then
		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "AntiTheft" ] = 0
		Player:Notify( Format( "You have uninstalled your %s's Anti-Theft alarm", theirVehicle.vehicleTable.Name ) )
	else
		if Player:GetCash() < 25000 then return end

		local Log = Format( "%s spent $%s on anti-theft for their %s", Player:Nick(), util.FormatNumber( 25000 ), theirVehicle.vehicleTable.Name )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( 25000, true )

		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "AntiTheft" ] = 1

		Player:Notify( Format( "You have installed an Anti-Theft system on your %s for $%s", theirVehicle.vehicleTable.Name, util.FormatNumber( 25000 ) ) )
	end

	tmysql.query( Format( Query( "CHANGEVEHICLEANTITHEFT" ), Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "AntiTheft" ], Player.PERPID, theirVehicle.vehicleTable.ID ) )

	Player:PERPSave() -- Save coz of dosh

	Player:ChangeVehicleAttribute(theirVehicle.vehicleTable.ID,"AntiTheft",Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "AntiTheft" ])
	net.Start("ServiceVehicleDoneRequest") net.Send(Player)

end )

/*************************************************
	"perp_v_uga"
	Job: Allow player to install/uninstall underglow on their vehicle
*************************************************/

util.AddNetworkString("perp_v_uga")
net.Receive( "perp_v_uga", function( len, Player )
	if not Player:IsVIP() then return end
	if not stalls[game.GetMap()][1]["InUse"][2] == Player then return end

	local theirVehicle = Player.currentVehicle

	if not IsValid( theirVehicle ) then return end

	if istable(Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "UnderGlow" ]) then
		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "UnderGlow" ] = nil

		if theirVehicle.UnderglowOn then
			for k, v in pairs( theirVehicle.Underglow ) do
				v:Remove()
			end

			theirVehicle.UnderglowOn = nil
			theirVehicle.Underglow = nil
		end

		Player:Notify( Format( "You have uninstalled your underglow lights on your %s", theirVehicle.vehicleTable.Name ) )

		Player.FreeUnderglow = nil
	else
		if Player:GetCash() < COST_FOR_UNDERGLOW then return end

		local Log = Format( "%s spent $%s on underglow installation for their %s", Player:Nick(), util.FormatNumber( COST_FOR_UNDERGLOW ), theirVehicle.vehicleTable.Name )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( COST_FOR_UNDERGLOW, true )

		Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "UnderGlow" ] = Color(255,255,255)
		Player.currentVehicle.UnderglowColor = Color(255,255,255)

		Player:ConCommand("perp_v_ug")

		Player:Notify( Format( "You have installed underglow lights on your %s for $%s", theirVehicle.vehicleTable.Name, util.FormatNumber( COST_FOR_UNDERGLOW ) ) )
		Player:Notify("To toggle underglow press T.")

		--Player.FreeUnderglow = true
	end

	tmysql.query( Format( Query( "CHANGEVEHICLEUNDERGLOW" ), util.TableToJSON(Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "UnderGlow" ]), Player.PERPID, theirVehicle.vehicleTable.ID ) )

	Player:PERPSave() -- Save coz of dosh

	Player:ChangeVehicleAttributeTable(theirVehicle.vehicleTable.ID,"UnderGlow",{Player.Vehicles[ theirVehicle.vehicleTable.ID ][ "UnderGlow" ]})
	net.Start("ServiceVehicleDoneRequest") net.Send(Player)

end )

/*************************************************
	"ServiceVehicleKeepRGBColor"
	Job: Changeing the vehicle color from the service stall
*************************************************/
util.AddNetworkString("ServiceVehicleKeepRGBColor")
net.Receive("ServiceVehicleKeepRGBColor", function(len,Player)
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == Player then
            if Player:GetCash() < 5000 then return end
            Player:TakeCash(5000)
            local col = stall.InUse[1]:GetColor()
            stall.InUse[1].OGColor = col
            local VTable = stall.InUse[1].vehicleTable
            Player.Vehicles[ VTable.ID ].RGBColour = { r = math.Clamp( col.r, 0, 255), g = math.Clamp( col.g, 0, 255), b = math.Clamp( col.b, 0, 255), a = 255 }
			Player:ChangeVehicleAttributeTable(VTable.ID,"RGBColour",{Player.Vehicles[ VTable.ID ][ "RGBColour" ]})

            local RGB 		= util.TableToJSON( Player.Vehicles[ VTable.ID ].RGBColour )

            tmysql.query( Format( Query( "CHANGEVEHICLERGB" ), RGB, Player.PERPID, VTable.ID ) )
        end
    end
end)

/*************************************************
	"ServiceVehicleKeepHLColor"
	Job: Changeing the vehicle head light color from the service stall
*************************************************/
util.AddNetworkString("ServiceVehicleKeepHLColor")
net.Receive("ServiceVehicleKeepHLColor", function(len,Player)
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == Player then
            if Player:GetCash() < 10000 then return end
            Player:TakeCash(10000)
            local col = stall.InUse[1]:VC_getOverride("HLColor")
            stall.InUse[1].OGHLColor = col
            local VTable = stall.InUse[1].vehicleTable
            Player.Vehicles[ VTable.ID ].HeadLight = { r = math.Clamp( col.r, 0, 255), g = math.Clamp( col.g, 0, 255), b = math.Clamp( col.b, 0, 255), a = 255 }
			Player:ChangeVehicleAttributeTable(VTable.ID,"HeadLight",{Player.Vehicles[ VTable.ID ][ "HeadLight" ]})

            local RGB = util.TableToJSON( Player.Vehicles[ VTable.ID ].HeadLight )

            tmysql.query( Format( Query( "CHANGEVEHICLEHLRGB" ), RGB, Player.PERPID, VTable.ID ) )
        end
    end
end)

/*************************************************
	"ServiceVehicleKeepUGColor"
	Job: Changeing the vehicle underglow color from the service stall
*************************************************/
util.AddNetworkString("ServiceVehicleKeepUGColor")
net.Receive("ServiceVehicleKeepUGColor", function(len,Player)
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == Player then
			local VTable = stall.InUse[1].vehicleTable
			if not istable(Player.Vehicles[ VTable.ID ][ "UnderGlow" ]) then return end
            if Player:GetCash() < 10000 then return end
            Player:TakeCash(10000)
            local col = stall.InUse[1].UnderglowColor
            stall.InUse[1].OGUnderglow = col
            Player.Vehicles[ VTable.ID ].UnderGlow = { r = math.Clamp( col.r, 0, 255), g = math.Clamp( col.g, 0, 255), b = math.Clamp( col.b, 0, 255), a = 255 }
			Player:ChangeVehicleAttributeTable(VTable.ID,"UnderGlow",{Player.Vehicles[ VTable.ID ][ "UnderGlow" ]})

            local RGB = util.TableToJSON( Player.Vehicles[ VTable.ID ].UnderGlow )

            tmysql.query( Format( Query( "CHANGEVEHICLEUNDERGLOW" ), RGB, Player.PERPID, VTable.ID ) )
        end
    end
end)

/*************************************************
	"ServiceVehicleKeepLicensePlate"
	Job: Changeing the vehicle license plate from the service stall
*************************************************/
util.AddNetworkString("ServiceVehicleKeepLicensePlate")
net.Receive("ServiceVehicleKeepLicensePlate", function(len,Player)
	local LP = net.ReadTable()
	local LPlate = {Text = LP.Text, Plate = LP.Plate}
    LPlate.Text = string.Left(LPlate.Text,7)
    LPlate.Text = string.upper(LPlate.Text)
    if #LPlate.Text < 1 then return end
	LPlate.Plate = math.Round(LPlate.Plate)
	if LPlate.Plate < 1 or LPlate.Plate > 4 then return end
	tmysql.query(string.format("SELECT id FROM perp_vehicles WHERE license_plate = '%s';",tmysql.escape(LPlate.Text)), function(Results)
		if #Results != 0 then return Player:Notify("License Plate Already Exists!") end
		for stallid, stall in pairs(stalls[game.GetMap()]) do
			if stall.InUse and stall.InUse[2] == Player then
				if Player:GetCash() < 7500 then return end
				Player:TakeCash(7500)
				local VTable = stall.InUse[1].vehicleTable
				stall.InUse[1]:SetGNWVar("License_Plate",LPlate)
				Player.Vehicles[ VTable.ID ].License_Plate = LPlate
				tmysql.query( Format( Query( "CHANGEVEHICLELPLATE" ), tmysql.escape(util.TableToJSON(LPlate)), Player.PERPID, VTable.ID ) )
			end
		end
	end)
end)

/*************************************************
	"ServiceVehicleChangeEngineUpgrade"
	Job: Changeing the vehicle license plate from the service stall
*************************************************/
util.AddNetworkString("ServiceVehicleChangeEngineUpgrade")
net.Receive("ServiceVehicleChangeEngineUpgrade", function(len,Player)
	local UpgradeLevel = net.ReadInt(8)
	if UpgradeLevel < 0 or UpgradeLevel > 4 then return end
	local Cost = 5000*UpgradeLevel
	if not stalls[game.GetMap()][1]["InUse"][2] == Player then return end
	if Player.Vehicles[ Player.currentVehicle.ID ].Engine == UpgradeLevel then return Player:Notify("You already have this engine upgrade!") end
	if Player:GetCash() < Cost then return end
	Player:TakeCash(Cost)
	Player.Vehicles[ Player.currentVehicle.ID ].Engine = UpgradeLevel
	Player:ChangeVehicleAttribute(Player.currentVehicle.ID,"Engine",Player.Vehicles[ Player.currentVehicle.ID ][ "Engine" ])

	tmysql.query( Format( Query( "CHANGEVEHICLEENGINE" ), UpgradeLevel, Player.PERPID, Player.currentVehicle.ID ) )
	net.Start("ServiceVehicleDoneRequest") net.Send(Player)

	-- apply it to vehicle
	local vehicle = Player.currentVehicle
	local params = vehicle:GetVehicleParams()
	params.engine.horsepower = vehicle.OGhorsepwower + 24*(UpgradeLevel or 0)
	params.engine.maxSpeed = vehicle.OGmaxSpeed + 5*(UpgradeLevel or 0)
	vehicle:SetVehicleParams(params)
end)

/*************************************************
	"perp_modify_vehicle"
	Job: Editing bodygroup/colour etc with one DPanel
*************************************************/
util.AddNetworkString("perp_modify_vehicle")
net.Receive( "perp_modify_vehicle", function( len, Player )
	if not Player:NearNPC( 25 ) then return Player:CaughtCheating( "Trying to modify their car without being near NPC." ) end

	local vehID = net.ReadString()
	local ModifyType = net.ReadString()
	local vehColor 
	local RequestedBodygroups
	if ModifyType == "save" then
		vehColor = net.ReadTable()
		RequestedBodygroups = net.ReadTable()
	end

	if not Player.Vehicles[ vehID ] then return end
	if Player:GetCash() < 10000 then return end

	local VTable = VEHICLE_DATABASE[ vehID ]
	if not VTable and not VTable.RGBColour then return Player:ChatPrint( "Invalid vehicle" ) end

	local Vehicle = Player.currentVehicle

	local GetBodygroupCar = ents.Create("prop_vehicle_jeep")
	GetBodygroupCar:SetModel(VTable.PaintJobs[1].model)
	GetBodygroupCar:SetPos(Vector(0,0,0))
	GetBodygroupCar:SetKeyValue( "vehiclescript", "scripts/vehicles/perp2_" .. VTable.Script .. ".txt" )
	GetBodygroupCar:Spawn()
	GetBodygroupCar.vehicleTable = VTable
	GetBodygroupCar.DoNot = true
	local BodyGroups = GetBodygroupCar:GetSortedBodyGroups()
	GetBodygroupCar:Remove()
	
	-- Above Gets the bodygroups, thanks facepunch making this the hardest possible.

	if ModifyType == "save" then -- save shit

		if RequestedBodygroups and Player:IsVIP() then
			for k, v in pairs( RequestedBodygroups ) do
				for _, o in pairs( BodyGroups ) do -- verify bodygroup allowed
					if o.ID == k and o.Values >= v then -- safe
						Player.Vehicles[ VTable.ID ].BodyGroups = Player.Vehicles[ VTable.ID ].BodyGroups or {}
						Player.Vehicles[ VTable.ID ].BodyGroups[ o.ID ] = v
						break
					end
				end
			end
		end

		Player.Vehicles[ VTable.ID ].RGBColour = { r = math.Clamp( vehColor.r, 0, 255), g = math.Clamp( vehColor.g, 0, 255), b = math.Clamp( vehColor.b, 0, 255), a = 255 }
		if IsValid( Vehicle ) and Vehicle.vehicleTable and Vehicle.vehicleTable.ID == vehID then
			Player.currentVehicle:SetColor( Player.Vehicles[ VTable.ID ].RGBColour )

			if Player.Vehicles[ VTable.ID ].BodyGroups then
				for k, v in pairs( Player.Vehicles[ VTable.ID ].BodyGroups ) do
					Player.currentVehicle:SetBodygroup( k, v )
				end
			end
		end

		Player:DrawViewModel( true )

		local RGB 		= util.TableToJSON( Player.Vehicles[ VTable.ID ].RGBColour )
		local BodyGroup = util.TableToJSON( Player.Vehicles[ VTable.ID ].BodyGroups or nil )

		tmysql.query( Format( Query( "CHANGEVEHICLERGBBODYGROUP" ), RGB, BodyGroup, Player.PERPID, VTable.ID ) )

		local Price = 10000

		local Log = Format( "%s spent $%s customizing their %s", Player:Nick(), util.FormatNumber( Price ), VTable.Name )
		GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

		Player:TakeCash( Price, true )

	elseif ModifyType == "start" then
		Player:DrawViewModel( true )
	elseif ModifyType == "cancel" then
		Player:DrawViewModel( false )
	end
end )

/*************************************************
	Function PLAYER:RemoveCar()
	Job: Deletes a car and a vehicle rotate
*************************************************/

function PLAYER:RemoveCar()
	if IsValid( self.VehicleRotator ) then
		self.VehicleRotator:Remove()
		self.VehicleRotator = nil
	end

	if IsValid( self.currentVehicle ) then
		if self.currentVehicle.vehicleTable then
			self:RemoveBlip("perp_vehicle_"..tostring(self.currentVehicle.vehicleTable.ID))
			if not self.currentVehicle.vehicleTable.RequiredClass and self.Vehicles[ self.currentVehicle.vehicleTable.ID ] then
				self.Vehicles[ self.currentVehicle.vehicleTable.ID ][ "Fuel" ] = self.currentVehicle:GetGNWVar( "Fuel", 5000 )
				tmysql.query( Format( Query( "VEHICLESAVEFUEL" ), self.currentVehicle:GetGNWVar( "Fuel", 5000 ), self.currentVehicle.vehicleTable.ID, self.PERPID ) )
				local percistdata = util.TableToJSON(self.currentVehicle:VC_getVehiclePersistanceData())
				if percistdata then
					tmysql.query( Format( "UPDATE `perp_vehicles` SET `vc_persist` = '%s' WHERE `car_id`='%s' AND `id`='%i';", percistdata, self.currentVehicle.vehicleTable.ID, self.PERPID ) )
				end
			end
		end

		if self.currentVehicle.AlarmEntity then
			self.currentVehicle.AlarmEntity:Stop()
		end

		self.currentVehicle:Remove()
		self.currentVehicle = nil
	end
end

local function selectVehicleSpawn( Player, vehicleID )
	local possibleLocations = {}

	for k, v in pairs( GAMEMODE.VehicleSpawnPositions ) do
		if not v[1] or VEHICLE_DATABASE[ vehicleID ].RequiredClass == v[1] then
			local canPlaceHere = true

			for _, ent in pairs( ents.FindInSphere( v[2], 100 ) ) do
				if ent:GetClass() == "prop_vehicle_jeep" then
					canPlaceHere = nil
					break
				end
			end

			if canPlaceHere then
				table.insert( possibleLocations, {v[2],v[3]} )
			end
		end
	end

	if JOB_DATABASE[Player:Team()].VehicleSpawns then
		for k, v in pairs(JOB_DATABASE[Player:Team()].VehicleSpawns) do
			local canPlaceHere = true

			for _, ent in pairs( ents.FindInSphere( v[1], 100 ) ) do
				if ent:GetClass() == "prop_vehicle_jeep" or ent:IsPlayer() then
					canPlaceHere = nil
					break
				end
			end

			if canPlaceHere then
				table.insert( possibleLocations, v )
			end
		end
	end

	if possibleLocations == 0 then return end

	local closestLocation
	local closestDist = 100000

	for _, v in pairs( possibleLocations ) do
		local dist = v[1]:Distance( Player:GetPos() )

		if dist < closestDist then
			closestLocation = v
			closestDist = dist
		end
	end

	if not closestLocation then return end

	return closestLocation
end


function GM:SpawnVehicle(Player, vehicleID, PlayerTable, override_spawn)
	Player.lastVehicleSpawn = Player.lastVehicleSpawn or 0
	if Player.lastVehicleSpawn > CurTime() then return end
	Player.lastVehicleSpawn = CurTime() + 1

	local placeToSpawn = override_spawn and override_spawn or selectVehicleSpawn( Player, vehicleID )
	if not placeToSpawn then
		return Player:Notify( "There was an error spawning your vehicle. Please try again later." )
	end

	Player:RemoveCar()

	local vehicleTable = VEHICLE_DATABASE[ vehicleID ]
	local paintJobS
	local Model = vehicleTable.WorldModel
	local Skin = vehicleTable.Skin
	if vehicleTable.PaintJobs then
		paintJobS = vehicleTable.PaintJobs[ PlayerTable[ "PaintID" ] ]
		Model = paintJobS.model
		Skin = paintJobS.skin
	end

	local newVehicle = ents.Create( "prop_vehicle_jeep" )
	newVehicle:SetModel( Model )
	newVehicle:SetSkin( Skin )
	newVehicle:SetPos( placeToSpawn[1] or Vector(0,0,0) + Vector(0, 0, 30) )
	newVehicle:SetAngles( placeToSpawn[2] or Angle(0,0,0) )
	newVehicle:SetKeyValue( "vehiclescript", vehicleTable.Script )

	newVehicle.VehicleScriptTable = util.KeyValuesToTable( file.Read(vehicleTable.Script,"GAME") or "" ) or {}
	local vs = file.Read(vehicleTable.Script,"GAME")
	local startVehicleSounds = #vs - (string.find(vs,"Vehicle_Sounds") or 0 ) + 2
	newVehicle.VehicleSounds = util.KeyValuesToTablePreserveOrder( string.Right(vs,startVehicleSounds) or "" ) or {}
	newVehicle.GearSounds = {}
	for k, v in pairs(newVehicle.VehicleSounds) do
		if v.Key == "gear" and v.Value[1].Key == "max_speed" then
			newVehicle.GearSounds[tonumber(k)] = v.Value[1].Value
		end
	end

	if not PlayerTable then PlayerTable = {} end
	local colours = PlayerTable[ "RGBColour" ]
	if colours then
		newVehicle:SetColor( colours )
	end

	if PlayerTable[ "UnderGlow" ] and istable(PlayerTable[ "UnderGlow" ]) then
		newVehicle.UnderglowColor = PlayerTable[ "UnderGlow" ]
	end

	if vehicleTable.Color then newVehicle:SetColor( vehicleTable.Color ) end

	if vehicleTable.Name then newVehicle:SetVehicleClass( vehicleTable.Name ) newVehicle.VehicleName = vehicleTable.Name end

	newVehicle:Spawn()
	newVehicle:SetSpawnEffect( true )

	GAMEMODE:LogToAdmins("Car Spawns",{
		text = Player:GetRPName() .. " ["..Player:SteamID().."] Spawned in a " .. vehicleTable.Name,
		position = newVehicle:GetPos(),
		location = Player:GetZoneName(),
		spawner = Player:SteamID()
	})
	Log( Player:GetRPName() .. " ["..Player:SteamID().."] Spawned in a " .. vehicleTable.Name .. "\n" )

	newVehicle:AddMapBlipSpecificPlayer("paris/blips/vehicle", "perp_vehicle_"..tostring(vehicleID), 25, Color(255,255,255,255), 100000, "*", false, Player)

	newVehicle.AlarmEntity = CreateSound( newVehicle, Sound( "perp2.5/car_alarm.mp3" ) )
	newVehicle.AlarmEntity:SetSoundLevel( 110 )
	newVehicle.AlarmPos = 0

	-- Precache bodygroups
	if not GAMEMODE.BodyGroupsCache[ newVehicle.Name ] then
		newVehicle:GetSortedBodyGroups()
	end

	newVehicle.headLightColor = PlayerTable[ "HeadLight" ] or {1}

	if VCMod1 then
		--[[    Redone by Paris for VCMOD (Ya welcome)    ]]
		hook.Add("VC_postVehicleInit", "VC_postVehicleInit_hlclr"..Player:SteamID(), function(ent)
			if newVehicle and newVehicle.headLightColor and ent.Owner and IsValid(ent.Owner) and Player:SteamID() == ent.Owner:SteamID() then
				if not istable(newVehicle.headLightColor) then return end
				ent:VC_setOverride("HLColor", newVehicle.headLightColor)
				hook.Remove("VC_postVehicleInit", "VC_postVehicleInit_hlclr"..Player:SteamID())
			end
			tmysql.query( Format( "SELECT `vc_persist` FROM `perp_vehicles` WHERE `id`='%s' AND `car_id`='%s';", Player.PERPID, vehicleID ), function( Results, Status, ErrorMsg )
				if Results and Results[1] and Results[1]["vc_persist"] then
					ent:VC_setVehiclePersistanceData(util.JSONToTable(Results[1]["vc_persist"]))
				end
			end)
		end)
	end


	newVehicle:SetGNWVar('Fuel', PlayerTable['Fuel'] or 10000)

	-- Sickness's old bodygroup setting
	if vehicleTable.CustomBodyGroup then
		newVehicle:Fire( "setbodygroup", vehicleTable.CustomBodyGroup, 0 )
	end

	if vehicleTable.BodyGroups then
		for key, value in pairs( vehicleTable.BodyGroups ) do
			newVehicle:SetBodygroup( key, value );
		end
	end

	if PlayerTable.BodyGroups then
		for k, v in pairs( PlayerTable.BodyGroups ) do
			newVehicle:SetBodygroup( k, v )
		end
	end

	if PlayerTable.Disabled == 1 then newVehicle.Disabled = true end

	newVehicle.CarDamage = 50
	newVehicle.Owner = Player

	newVehicle:Fire( "lock", "", 0 )

	newVehicle:SetGNWVar( "Owner", Player:EntIndex() )
	newVehicle.Owner = Player

	newVehicle:SetGNWVar( "vehicleTable", vehicleTable )
	newVehicle.vehicleTable = vehicleTable
	newVehicle.ID = vehicleID

	local params = newVehicle:GetVehicleParams()
	if not params then newVehicle:Remove() Player:Notify("Vehicle Removed, No Valid VehicleScript!") return end
	newVehicle.OGhorsepwower = params.engine.horsepower
	params.engine.horsepower = params.engine.horsepower + 15*(PlayerTable['Engine'] or 0)
	newVehicle.OGmaxSpeed = params.engine.maxSpeed
	params.engine.maxSpeed = params.engine.maxSpeed + 10*(PlayerTable['Engine'] or 0)
	params.engine.boostDuration = 0
	newVehicle.Turbo = PlayerTable['Turbo']
	if newVehicle.Turbo == 1 then
		params.engine.horsepower = params.engine.horsepower + 50
	end
	newVehicle:SetVehicleParams(params)
	-- get gear switches

	if PlayerTable['License_Plate'] then
		newVehicle:SetGNWVar( "License_Plate", PlayerTable['License_Plate'] )
	else
		newVehicle:SetGNWVar( "License_Plate", {Text="GOV " .. string.format("%03d",math.random(0,999)), Plate = 4} )
	end

	if vehicleID == "3500TowTruck" then
		---1.1618 4.7689 106.6799
		newVehicle.Thingy3 = ents.Create( "ent_servicetruck" )
			newVehicle.Thingy3:SetPos( newVehicle:LocalToWorld( Vector( -48, -40, 50 ) ) )
			newVehicle.Thingy3:SetAngles( newVehicle:LocalToWorldAngles( Angle( 0, 180, 0 ) ) )
			//newVehicle.Thingy2:SetPos( newVehicle:GetPos() + newVehicle:GetUp() * 35 + newVehicle:GetForward() * -128 + newVehicle:GetRight() * -35 )
			//newVehicle.Thingy2:SetAngles( newVehicle:GetAngles() + Angle( 0, 270, 0 ) )
			newVehicle.Thingy3:SetVehicle( newVehicle )
			newVehicle.Thingy3.ThePlayer = Player
		newVehicle.Thingy3:Spawn()
	end

	if vehicleTable.Props then
		for _,p in pairs( vehicleTable.Props ) do
			local prop = ents.Create( "prop_physics" )
			prop:SetModel( p.Model )
			prop:SetModelScale( p.Scale, 0 )
			prop:SetParent( newVehicle )
			prop:SetPos( newVehicle:LocalToWorld( p.Pos ) )
			prop:SetAngles( newVehicle:LocalToWorldAngles( p.Ang ) )

			if p.Skin then prop:SetSkin(p.Skin) end

			prop:SetSolid( SOLID_VPHYSICS )
			prop:SetMoveType( MOVETYPE_NONE )
		--	prop:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
			prop:Activate()
			prop:Spawn()
			prop.UnBurnable = true

			if p.BodyGroups then
				for _,group in pairs( p.BodyGroups ) do
					prop:SetBodygroup( group[1], group[2] )
				end
			end
		end
	end

	Player.currentVehicle = newVehicle

	Player:SetGNWVar( "Vehicle", newVehicle:EntIndex() )

	newVehicle:SetNWString( "veh_name", newVehicle.vehicleTable.Name )
	newVehicle:SetNWString( "veh_id", newVehicle.vehicleTable.ID )

	return newVehicle
end

function PLAYER:SpawnVehicle( vehicleID, PlayerTable, override_spawn )
	GAMEMODE:SpawnVehicle(self, vehicleID, PlayerTable, override_spawn)
end

hook.Add("OnReloaded", "SendVehicleTableOnReload", function()
	timer.Simple(0.5, function()
		for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
			if v.vehicleTable then
				v.vehicleTable = VEHICLE_DATABASE[v.vehicleTable.ID]
				v:SetGNWVar( "vehicleTable", v.vehicleTable )
				if v.vehicleTable.BodyGroups then
					for key, value in pairs( v.vehicleTable.BodyGroups ) do
						v:SetBodygroup( key, value );
					end
				end
			end
		end
	end)
end)

/*************************************************
	"perp_v_su"
	Job: Allow player to start/stop their vehicle
*************************************************/
util.AddNetworkString("perp_v_su")
net.Receive("perp_v_su", function(len,Player)
	if !(Player:GetVehicle():IsVehicle()) then return end
	if (Player.nextStartUp && Player.nextStartUp > CurTime()) then return; end
	if (Player:GetVehicle().IsPassengerSeat) then return; end

	local currentVehicle = Player:GetVehicle()
	local vehicleCheck = Player:GetVehicle().vehicleTable;

	if Player:GetVehicle().ServiceNoStart then return end

	--[[if currentVehicle.Disabled then
		Player:Notify('This vehicle has been disabled in an accident.');
		return;
	end]]

	if (vehicleCheck && vehicleCheck.StartupSound) then
		if (!currentVehicle.IsRunning and currentVehicle:GetGNWVar( "Fuel", 0 ) > 0 ) then
			currentVehicle.IsRunning = true;
			currentVehicle:EmitSound(vehicleCheck.StartupSound, 75, 100);
			currentVehicle:Fire('turnon', '', vehicleCheck.StartupSoundDur)
			Player.nextStartUp = CurTime() + vehicleCheck.StartupSoundDur - 1;
			return
		end
	end

	if (vehicleCheck && vehicleCheck.ShutdownSound) then
		if (currentVehicle.IsRunning or currentVehicle:GetGNWVar( "Fuel", 0 ) <= 0) then
			currentVehicle.IsRunning = false;
			currentVehicle:EmitSound(vehicleCheck.ShutdownSound, 75, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 4;
			return
		end
	end

	if (vehicleCheck && vehicleCheck.Script == "veyron") then
		if (!currentVehicle.IsRunning and currentVehicle:GetGNWVar( "Fuel", 0 ) > 0) then
			currentVehicle.IsRunning = true;
			currentVehicle:EmitSound("perp3.0/vehicle/engine/veyron_ignitionstart.wav", 75, 100);
			currentVehicle:Fire('turnon', '', 3);
			Player.nextStartUp = CurTime() + 4;
		else
			currentVehicle.IsRunning = false;
			currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 75, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;
	elseif (vehicleCheck && vehicleCheck.Script != "veyron") then
		if (!currentVehicle.IsRunning and currentVehicle:GetGNWVar( "Fuel", 0 ) > 0) then
			currentVehicle.IsRunning = true;
			currentVehicle:EmitSound("Vehicles/Lambo/Start.wav", 75, 100);
			currentVehicle:Fire('turnon', '', 6);
			Player.nextStartUp = CurTime() + 7;
		else
			currentVehicle.IsRunning = false;
			currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 75, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;
	end;

end)

/*************************************************
	"perp_v_c"
	Job: Allow player to spawn their vehicle,
*************************************************/

util.AddNetworkString("perp_v_c")
net.Receive( "perp_v_c", function( len, Player )
	local ID = net.ReadString()
	if not ID then return end
	if not Player:NearNPC( 5 ) and not Player:IsAdmin() then return Player:CaughtCheating( "Trying to claim a vehicle without being near the Car Garage." ) end

	local objCar = Player.currentVehicle

	if IsValid( objCar ) then
		if Player:GetPos():Distance( objCar:GetPos() ) < 1000 or ( objCar.Disabled or objCar:WaterLevel() > 0 ) then
			objCar:Remove()
		elseif not Player:IsLeader() then
			net.Start( "vehicle_nothere_msg" ) net.Send(Player)
			return
		end
	end

	local vehicleID = ID
	local vehicleTable = VEHICLE_DATABASE[ vehicleID ]
	if not vehicleTable then return end
	if vehicleTable.Cost == 0 then return end
	if not Player:HasVehicle( vehicleID ) then return end
	if not vehicleTable.RequiredClass and ( Player:Team() ~= TEAM_CITIZEN and Player:Team() ~= TEAM_MAYOR and Player:Team() ~= TEAM_SECRET_SERVICE and Player:Team() ~= TEAM_DISPATCHER and Player:Team() ~= TEAM_DETECTIVE ) then return end

	if Player.Vehicles[ vehicleID ].Disabled == 1 then
		local iRepairCost = VEHICLE_DATABASE[ vehicleID ].Cost * 0.01

		net.Start( "vehicle_repair_msg" )
			net.WriteString( vehicleID )
			net.WriteInt( iRepairCost, 32 )
		net.Send(Player)

		return
	end

	Player:SetPNWVar( "lastvehicle", vehicleID )

	local override
	if not Player:NearNPC( 5 ) and Player:IsAdmin() then
		override = {Player:GetEyeTrace().HitPos}
	end

	GAMEMODE:SpawnVehicle( Player, vehicleID, Player.Vehicles[ vehicleID ], override )
end )

/*************************************************
	"perp_v_p"
	Job: Allow player to buy a vehicle
*************************************************/

util.AddNetworkString("perp_v_p")
util.AddNetworkString("perp_vehicle_change_string")
net.Receive( "perp_v_p", function( len, Player )
	local ID = net.ReadString()
	if not ID then return end
	if not Player:NearNPC( 4 ) then return Player:CaughtCheating( "Trying to buy a vehicle without being near the Car Dealer." ) end
	if Player:Team() ~= TEAM_CITIZEN then return end

	local vehicleID = tostring(ID)
	local vehicleTable = VEHICLE_DATABASE[vehicleID]

	if not vehicleTable then
		return Player:Notify( "Error ID: #1, Report this to an admin." )
	end

	if vehicleTable.RequiredClass then
		Player:CaughtCheating( "Trying to buy " .. vehicleTable.RequiredClass .. " a Class Restricted vehicle." )
		return Player:Notify( "Error when buying. (2)" )
	end

	if Player:GetBank() < vehicleTable.Cost then
		Player:CaughtCheating( "Trying to buy " .. vehicleTable.Name .. " without having enough cash." )
		return Player:Notify( "What you don't have the money to afford this? Error when buying." )
	end

	if vehicleTable.VipOnly and not Player:IsVIP() then
		Player:CaughtCheating( "Trying to buy " .. vehicleTable.Name .. " without VIP status." )
		return Player:Notify( "This vehicle requires VIP status." )
	end

	if not Player.Vehicles then
		Player.Vehicles = {}
	end

	if Player.Vehicles[ vehicleID ] then
		return Player:Notify( "You already own this vehicle." )
	end

	local Log = Format( "%s bought a %s for $%s", Player:Nick(), vehicleTable.Name, util.FormatNumber( vehicleTable.Cost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeBank( vehicleTable.Cost, true )

	hook.Run("BuyVehicle", Player, vehicleID)

	Player.Vehicles[ vehicleID ] = {
		PaintID = 1,
		UnderGlow = 0,
		DixieHorn = 0,
		Hydraulics = 0,
		Fuel = 10000,
	}

	tmysql.query( Format( Query( "CREATEVEHICLE" ), Player.PERPID, vehicleTable.ID ) )
	tmysql.query( Format( Query( "SELECTVEHICLEAUTOINC" ), Player.PERPID, vehicleTable.ID ), function(Results)
		local n = Results[1]["auto_inc"]
		Player.Vehicles[ vehicleID ].License_Plate = {}
		Player.Vehicles[ vehicleID ].License_Plate.Plate = 1
		Player.Vehicles[ vehicleID ].License_Plate.Text = GenerateLicensePlate(n)
		if IsValid(Player.currentVehicle) then Player.currentVehicle:SetGNWVar("License_Plate", Player.Vehicles[ vehicleID ].License_Plate) end
		Player:ChangeVehicleAttributeTable(vehicleID,"License_Plate",Player.Vehicles[ vehicleID ].License_Plate)
		tmysql.query( Format( Query( "SETVEHICLELICENSEPLATE" ), util.TableToJSON(Player.Vehicles[ vehicleID ].License_Plate), Player.PERPID, vehicleTable.ID ) )
	end)

	Player:PERPSave()

	-- Con fucking gradulations, you now own this car, blah blah...
	Player:Notify( Format( "You are the new owner of a %s for $%s", vehicleTable.Name, util.FormatNumber( vehicleTable.Cost ) ) )

	net.Start( "perp_vehicle_init" )
		net.WriteString( vehicleTable.ID )
		net.WriteInt( 1, 16 ) -- PaintID or error :(
	net.Send(Player)

	GAMEMODE:SpawnVehicle( Player, vehicleID, Player.Vehicles[ vehicleID ] )

	Player:AddRP(500)
	Player:ReputationNotify( "+500 RP for buying a vehicle!" )

end )

function GM:DemoVehicle( Player, vehicleID, DemEntity )

	if Player.LastDemoed and CurTime() - Player.LastDemoed <= 5 then return false end
	Player.LastDemoed = CurTime()

	if Player:Team() ~= TEAM_CITIZEN then
		return Player:Notify( "You must be a Citizen to demo these vehicles, sorry." )
	end

	if IsValid( Player.currentVehicle ) then
		return Player:Notify( "You must de-spawn your vehicle before you can demo, sorry." )
	end

	local veh = GAMEMODE:SpawnVehicle( Player, vehicleID, { PaintID = 1, HeadLights = 1 } )
	Player:Notify( "Please wait..." )
	Player:Lock()

	if not IsValid( veh ) then
		Player:UnLock()
		return Player:Notify( "Failed... try again later." )
	end

	Player:EnterVehicle( veh )

	-- Just in case they didn't get put in the vehicle :)
	timer.Simple( 1, function()
		if not IsValid( Player ) then if IsValid( veh ) then veh:Remove() end end

		if not Player:GetVehicle() ~= veh then
			if IsValid( veh ) then
				Player:EnterVehicle( veh )
				Player:Notify( "You have 1 minute, you'll spawn back at the dealership." )
			end
		end

		Player:UnLock()
	end )

	-- Double check... :)
	timer.Simple( 3, function()
		if not IsValid( Player ) then if IsValid( veh ) then veh:Remove() end end

		if not Player:GetVehicle() ~= veh then
			if IsValid( veh ) then
				Player:EnterVehicle( veh )
			end
		end
	end )

	Player.DemoVehicle = veh

	if DemEntity then
		veh:SetColor( DemEntity:GetColor() )
		veh:SetBodygroup( 2, DemEntity:GetBodygroup( 2 ) )
		veh:SetBodygroup( 3, DemEntity:GetBodygroup( 3 ) )
		veh:SetBodygroup( 4, DemEntity:GetBodygroup( 4 ) )
		veh:SetBodygroup( 5, DemEntity:GetBodygroup( 5 ) )
		veh:SetBodygroup( 6, DemEntity:GetBodygroup( 6 ) )
	end

	Player:ChatPrint( "-- You're able to drive this demonstration vehicle for one minute --" )
	Player:ChatPrint( "-- The vehicle will automaticly be removed after this time period --" )

	Player.ExpireTime = 60

	timer.Create( "DemoVehicle_" .. Player:SteamID(), 5, 12, function()
		if IsValid( Player ) and IsValid( Player.DemoVehicle ) then
			Player.ExpireTime = Player.ExpireTime - 5

			if Player.ExpireTime <= 0 then
				Player:ExitVehicle()

				if IsValid( Player.DemoVehicle ) then
					Player.DemoVehicle:Remove()
				end

				return
			end

			if Player:GetVehicle() ~= Player.DemoVehicle then
				Player.DemoVehicle:Remove()

				return Player:ChatPrint( "Somethings seems to have gone wrong, when demoing a car try not to walk away." )
			end

			Player:ChatPrint( "-- The vehicle demonstration ends in " .. Player.ExpireTime .. " seconds --" )
		end
	end )

end

/*************************************************
	"perp_v_demo"
	Job: Allow player to demo a vehicle
*************************************************/

util.AddNetworkString("perp_v_demo")
net.Receive( "perp_v_demo", function( len, Player )
	local ID = net.ReadString()
	if not ID then return end
	if not Player:NearNPC( 4 ) then return Player:CaughtCheating( "Trying to demo a vehicle without being near the Car Dealer." ) end

	if Player:Team() ~= TEAM_CITIZEN then return end

	if IsValid( Player.DemoVehicle ) then Player.DemoVehicle:Remove() end

	local vehicleID = ID
	local vehicleTable = VEHICLE_DATABASE[ vehicleID ]

	if not vehicleTable then return end

	if not vehicleTable.RequiredClass and ( Player:Team() ~= TEAM_CITIZEN and Player:Team() ~= TEAM_MAYOR ) then
		return Player:Notify( "You can't do this with your current class." )
	end

	if IsValid( Player.currentVehicle ) then
		Player:CaughtCheating( "Trying to demo a " .. vehicleTable.Name .. " while car is spawned." )
		return Player:Notify( "You must first put in your vehicle, there's a garage NPC infront of the building." )
	end

	if Player:HasItem( "item_parkingticket" ) then
		return Player:Notify( "You have to pay your traffic ticket(s) before you can drive in a vehicle again. :)" )
	end

	if Player:HasItem( "item_parkingticket" ) or Player:HasItem( "item_parkingticket0" ) or Player:HasItem( "item_parkingticket1" ) or Player:HasItem( "item_parkingticket2" ) or Player:HasItem( "item_parkingticket3" ) or Player:HasItem( "item_parkingticket4" ) or Player:HasItem( "item_parkingticket5" ) or Player:HasItem( "item_parkingticket6" ) or Player:HasItem( "item_parkingticket7" ) or Player:HasItem( "item_parkingticket8" ) or Player:HasItem( "item_parkingticket9" ) or Player:HasItem( "item_parkingticket10" ) and not Vehicle.vehicleTable.RequiredClass then
		Vehicle:Fire( "TurnOff", "", 0 )
		return Player:Notify( "You have to pay your traffic ticket(s) before you can drive in a vehicle again." )
	end

	Log( Format( "%s is demoing vehicle %s", Player:Nick(), vehicleTable.Name ) )

	GAMEMODE:DemoVehicle( Player, vehicleID )
end )

util.AddNetworkString( "perp_vehicle_entered" )
function GM:PlayerEnteredVehicle( Player, Vehicle, Role )
	local ourVehicle = Vehicle.vehicleTable

	-- Vehicle's only.
	if not ourVehicle then return end

	local owner = Vehicle.Owner

	if owner == Player then
		owner:RemoveBlip("perp_vehicle_"..tostring(ourVehicle.ID))
	end

	if not Vehicle.IsRunning then Vehicle:Fire( "TurnOff", "", 0 ) end

	if Vehicle.AlarmEntity then
		Vehicle.AlarmEntity:Stop()

		if owner:IsVIP() and Vehicle.AlarmWentOff then
			Player:Notify( "Car alarm went off approximately " .. TimeToString( os.time() - Vehicle.AlarmWentOff, "%02i:%02i" ) .. "ago" )
			Vehicle.AlarmWentOff = nil
		end
	end

	if Vehicle.LastRadioStation then
		Vehicle:SetGNWVar( "Radio", Vehicle.LastRadioStation )
	end

	Vehicle.LastRadioStation = nil

	if ourVehicle.PlayerReposition_Pos then
		local Rotator = ents.Create( "ent_rotator" )
			Rotator:SetModel( "models/props_junk/cinderblock01a.mdl" )
			Rotator:SetPos( Player:GetPos() )
			Rotator:SetAngles( Player:GetAngles() )
		Rotator:Spawn()

		Player:SetParent( Rotator )
		Rotator:SetParent( Vehicle )
		Rotator:SetLocalAngles( ourVehicle.PlayerReposition_Ang )
		Rotator:SetLocalPos( ourVehicle.PlayerReposition_Pos )

		Rotator:SetSolid( SOLID_NONE )
		Rotator:SetMoveType( MOVETYPE_NONE )

		Player.VehicleRotator = Rotator
	end

	Player.GotInCar = CurTime()
	
	/**************************************************
		VCMOD HELP IN CHAT (ON ENTRY OF VEHICLE) SV
	**************************************************/

	if IsValid( Player ) then
		net.Start("perp_vehicle_entered")
		net.WriteEntity( Player )
		net.Send( Player )
	end
end

function PLAYER:CanRideInCar( vehicle )
	if not vehicle:IsVehicle() then return end
	if not IsValid( vehicle.Owner ) then return end
	if self:CanManipulateDoor( vehicle ) then return true end

	local owner = vehicle.Owner

	if (owner:Team() == TEAM_SECRET_SERVICE && self:Team() == TEAM_MAYOR) then return true end
	if (owner:Team() == TEAM_POLICE && self:Team() == TEAM_CITIZEN && self.currentlyRestrained) then return true end
	if (owner:Team() == TEAM_DETECTIVE && self:Team() == TEAM_CITIZEN && self.currentlyRestrained) then return true end
	if (owner:Team() == TEAM_CHIEF && self:Team() == TEAM_CITIZEN && self.currentlyRestrained) then return true end


	-- check organization members.
	if owner:GetGNWVar( "org", 0 ) ~= 0 and GAMEMODE.OrganizationData[ self:GetGNWVar( "org", 0 ) ][ 5 ] then
		for _, v in pairs( GAMEMODE.OrganizationData[ self:GetGNWVar( "org", 0 ) ][ 5 ] ) do
			if v[2] == self:UniqueID() then
				return true
			end
		end
	end

	-- if theyre the same team, let 'em do it.
	if self:Team() == owner:Team() and self:Team() ~= TEAM_CITIZEN then return true end

	return false
end

function GM:CanPlayerEnterVehicle( Player, Vehicle )

	if Vehicle.RiggedToExplode then
		Player:TakeDamage( Player:Health(), Vehicle.Rigger or Player, Vehicle.Rigger or Player )

		//Vehicle:DisableVehicle( true, true )

		GAMEMODE.Explode( Vehicle:GetPos(), Vehicle.Rigger or Player )

		Vehicle.RiggedToExplode = nil

		return
	end

	if Vehicle:GetClass() == "prop_vehicle_prisoner_pod" and not Vehicle.IsPassengerSeat then -- Chair.
		Player.EntryPoint = Player:GetPos()
		Player.EntryAngles = Player:EyeAngles()
	end

	if Vehicle:GetClass() ~= "prop_vehicle_jeep" then
		if not Vehicle.pickupPlayer then return true end

		if Vehicle:GetAngles().r > 2 or Vehicle:GetAngles().r < -2 or Vehicle:GetAngles().p > 2 or Vehicle:GetAngles().p < -2 then return Vehicle:Fire( "turnoff", "", 0 ) end

		return true
	elseif Player:KeyDown( IN_WALK ) and Player:KeyDown( IN_USE ) and Vehicle:GetClass() == "prop_vehicle_prisoner_pod" then
		return
	end

	if Vehicle:GetClass() == "prop_vehicle_jeep" and Vehicle.DemoVehicle then
		GAMEMODE:DemoVehicle( Player, Vehicle.DemoVehicle, Vehicle )

		return Vehicle:Fire( "TurnOff", "", 0 )
	end

	if Vehicle.Disabled then
		Vehicle.IsRunning = false
		Vehicle:Fire( "TurnOff", "", 0 )
		return Player:Notify( "This vehicle has been disabled." )
	end

	local Blacklist = Player:HasBlacklist( "driving" )

	if Blacklist and Vehicle:GetClass() == "prop_vehicle_jeep" then
		if not Player.LastBlacklist or Player.LastBlacklist + 1 < CurTime() then
			Player.LastBlacklist = CurTime()
			Player:ChatPrint( "You're blacklisted from Driving for: " .. Blacklist.Reason .. ", time remaining: " .. ( Blacklist.Expire == 0 and "forever" or TimeToString( Blacklist.Expire - os.time() ) ) )
		end

		return Vehicle:Fire( "TurnOff", "", 0 )
	end

	if Vehicle:GetClass() == "prop_vehicle_jeep" and Player:HasItem( "item_parkingticket" ) and not Vehicle.vehicleTable.RequiredClass then
		Vehicle:Fire( "TurnOff", "", 0 )
		return Player:Notify( "You have to pay your traffic ticket(s) before you can drive in a vehicle again." )
	end

	if Vehicle:GetClass() == "prop_vehicle_jeep" and Player:HasItem( "item_parkingticket" ) or Player:HasItem( "item_parkingticket0" ) or Player:HasItem( "item_parkingticket1" ) or Player:HasItem( "item_parkingticket2" ) or Player:HasItem( "item_parkingticket3" ) or Player:HasItem( "item_parkingticket4" ) or Player:HasItem( "item_parkingticket5" ) or Player:HasItem( "item_parkingticket6" ) or Player:HasItem( "item_parkingticket7" ) or Player:HasItem( "item_parkingticket8" ) or Player:HasItem( "item_parkingticket9" ) or Player:HasItem( "item_parkingticket10" ) and not Vehicle.vehicleTable.RequiredClass then
		Vehicle:Fire( "TurnOff", "", 0 )
		return Player:Notify( "You have to pay your traffic ticket(s) before you can drive in a vehicle again." )
	end

	if Player:GetVelocity():Length() > 100 then return Vehicle:Fire( "TurnOff", "", 0 ) end

	if IsValid( Vehicle.Owner ) and Vehicle.Owner:IsGovernmentOfficial() and Player:Team() == TEAM_MAYOR then return true end

	if Vehicle.vehicleTable.RequiredClass and Player:Team() == Vehicle.vehicleTable.RequiredClass then
		return true
	elseif Vehicle.vehicleTable.RequiredClass == TEAM_DETECTIVE then	
		return true
	elseif Vehicle.vehicleTable.RequiredClass and Player:Team() ~= Vehicle.vehicleTable.RequiredClass then
		Vehicle:Fire( "TurnOff", "", 0 )
		return Player:Notify( "You are not of the required class to use this vehicle." )
	end

	if not Vehicle:GetDriver():IsPlayer() and not Vehicle:GetSaveTable().VehicleLocked then return true end
	if not Player:CanRideInCar( Vehicle ) then return Vehicle:Fire( "TurnOff", "", 0 ) end

	return true

end

function GM:CanExitVehicle( Vehicle, Player )

	Player:ExitVehicle()
	Player:SetPNWVar( "lastcar", Vehicle )

end

-- hot fix to the alarm going off when removing? wtf?
function GM:EntityRemoved( Entity )
	if IsValid( Entity.AlarmEntity ) then
		Entity.AlarmEntity:Stop()
		Entity.AlarmEntity = nil
	end

	if Entity:IsVehicle() and IsValid( Entity.Owner ) and Entity.Owner:GetGNWVar( "Vehicle" ) == Entity:EntIndex() then
		Entity.Owner:SetGNWVar( "Vehicle", nil )
	end
end

-- Alarm on any explosion damage

hook.Add( "EntityTakeDamage", "AlarmOnExplosion", function( target, dmginfo )
    --[[if ( target:IsVehicle() ) and dmginfo:IsExplosionDamage() then
		if target.AlarmEntity then
			if target.AlarmPos < CurTime() then
				target.AlarmEntity:Stop()
				target.AlarmEntity:Play()
				target.AlarmWentOff = os.time()
				target.AlarmPos = CurTime() + 23
			end
			if not VCMod1 then return end
			target:VC_setHazardLights(true)
			timer.Simple(24, function() target:VC_setHazardLights(false) end)
		end
    end]]
end )


function GM:PlayerLeaveVehicle( Player, Vehicle )
	Player.LastLeaveVehicle = CurTime() + .25

	Vehicle.TempAlarmDisable = CurTime() + 8

	if IsValid( Player.VehicleRotator ) then
		Player.VehicleRotator:Remove()
		Player.VehicleRotator = nil
	end

	if not Vehicle.IsPassengerSeat then
		local owner = Player:GetVehicle().Owner

		local ourVehicle = Player:GetVehicle().vehicleTable

		if owner == Player then
			Player:GetVehicle():AddMapBlipSpecificPlayer("paris/blips/vehicle", "perp_vehicle_"..tostring(Vehicle.ID), 25, Color(255,255,255,255), 100000, "*", false, Player)
		end

		if Vehicle.VC_HeadLghtT then
			for _, BL in pairs( Vehicle.VC_HeadLghtT ) do
				BL:Remove()
			end

			Vehicle.VC_HLtsOn = nil
			Vehicle.VC_HeadLghtT = nil
		end

		if Vehicle.Disabled or Vehicle:WaterLevel() > 0 then -- disable handbrake if underwater or disabled, heh.
			Vehicle.IsRunning = false
			Vehicle:Fire( "HandBrakeOff", "", 0 )
		end
	else
		Vehicle = Vehicle.ParentCar
	end

	-- DEMO teleporting back to car dealer, don't want to kill them if high velocity in vehicle
	if Player.DemoVehicle and Player.DemoVehicle == Vehicle then
		Vehicle:Remove()

		Player:GodEnable()
		Player:SetVelocity( Vector(-1, -1, -1)*Player:GetVelocity() )

		timer.Simple( 0.2, function() -- next frame, incase they dont get teleported
			if Player:Alive() then
				Player:SetPos( GAMEMODE.DemoRespawn[ math.random( #GAMEMODE.DemoRespawn ) ] )
				Player:SetEyeAngles( Angle( 0, 90, 0 ) )
				timer.Simple(1, function()
					if IsValid(Player) then
						Player:GodDisable()
					end
				end)
			end
		end )

		Player:ChatPrint( "-- Stopped vehicle demonstration. --" )
		Player.DemoVehicle = nil
	end
end

/*************************************************
	"perp_pechop_car"
	Chop Shop Selling
*************************************************/

util.AddNetworkString("perp_pechop_car")
net.Receive("perp_pechop_car", function( len, Player )

	-- CHANGE THIS
	for k, ent in pairs(ents.FindInSphere( Vector(-3764,5539,48), 600 )) do

		if ent:IsValid() and ent:IsVehicle() and ent:GetClass() == "prop_vehicle_jeep" then
			stolenVehicle = ent;
		end

	end

	Player.lastVehicleChop= Player.lastVehicleChop or 0;
	if (Player.lastVehicleChop > CurTime()) then
		Player:Notify("Dude.. you just sold me one! Come back in about 30 minutes.");
		return;
	end

	local PaintCost = stolenVehicle.vehicleTable.PaintJobCost;
	local ChopPay = PaintCost / 3;

	ChopPay = math.Round(ChopPay);

	if ChopPay < 1400 then
		ChopPay = 1400;
	end

	if ChopPay > 3600 then
		ChopPay = 3500;
	end

	if Player:StoleCar(stolenVehicle) then
		Player:GiveCash(ChopPay);
		Player:Notify("You made $'" .. ChopPay .. "' from the chop shop.");
		Player.StolenCar = nil;

		net.Start( "perp_vehicle_toggle_state" )
		net.WriteString( stolenVehicle.vehicleTable.ID )
		net.WriteInt( 1, 16 )
		net.Send(stolenVehicle.Owner)

		stolenVehicle.Owner.Vehicles[ stolenVehicle.vehicleTable.ID ].Disabled = 1

		tmysql.query( Format( Query( "TOGGLEVEHICLE" ), 1, stolenVehicle.Owner.PERPID, stolenVehicle.vehicleTable.ID ) )

		stolenVehicle:Remove();
		Player.lastVehicleChop = CurTime() + 10;
	else
		Player:Notify("You cannot chop this vehicle.");
	end
end )

function PLAYER:StoleCar( Vehicle )
	--local owner = Vehecle.owner
	local owner = Vehicle.Owner
	if (!Vehicle:IsVehicle()) then return false; end
	if (!owner || IsValid(!owner)) then return false; end

	if self:IsValid() && self:IsPlayer() then
		if self.StolenCar == Vehicle then
			return true;
		end
	end
	return false;
end

/*************************************************
	VCMOD Compatibility
	- By Paris
*************************************************/

hook.Add("VC_canSwitchSeat", "VC_canSwitchSeat", function(ply, ent_from, ent_to)

	if !IsValid(ent_to) then return true end

	if IsValid(ent_from:GetParent()) and ent_from:GetParent().ServiceNoStart then ply:Notify("You can not switch seats in the vehicle service menu.") return false end

	if ent_to:GetClass() == "prop_vehicle_jeep" then

		if ply.CurrentlyArrested then
			ply:Notify( "You can not switch seats when arrested." )
			return false
		end

		return true

	else
		if ply.CurrentlyArrested then
			ply:Notify( "You can not switch seats when arrested." )
			return false
		else
			return true
		end
	end
end)


hook.Add("VC_healthChanged", "VCMod_Health_System_PERP", function(ent, ohealth, nhealth)
	if ent.DoNot then return end
	if nhealth == 0 then
		local Fire = ents.Create( "ent_fire" )
		Fire:SetPos( ent:GetPos() )
		Fire:Spawn()

		ent.Disabled = true

		if not ent.vehicleTable or not ent.Owner.Vehicles[ ent.vehicleTable.ID ] then return end

		net.Start( "perp_vehicle_toggle_state" )
			net.WriteString( ent.vehicleTable.ID )
			net.WriteInt( 1, 16 )
		net.Send(ent.Owner)

		ent.Owner.Vehicles[ ent.vehicleTable.ID ].Disabled = 1

		tmysql.query( Format( Query( "TOGGLEVEHICLE" ), 1, ent.Owner.PERPID, ent.vehicleTable.ID ) )
	elseif ohealth == 0 then

		if not ent.Owner or not IsValid(ent.Owner) then return end
		if not ent.vehicleTable or not ent.Owner.Vehicles[ ent.vehicleTable.ID ] then return end

		net.Start( "perp_vehicle_toggle_state" )
			net.WriteString( ent.vehicleTable.ID )
			net.WriteInt( 0, 16 )
		net.Send(ent.Owner)

		ent.Disabled = false
	
		ent.Owner.Vehicles[ ent.vehicleTable.ID ].Disabled = 0
	
		tmysql.query( Format( Query( "TOGGLEVEHICLE" ), 0, ent.Owner.PERPID, ent.vehicleTable.ID ) )
	end
end)

/*************************************************
	License Plate Generator
*************************************************/

local characters = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
function GenerateLicensePlate(num)
	local abcs = ""
	local numfornum = num

	for i = 1, 3 do
		local test = (math.floor(num/(1000*math.Clamp(26*(i-1),1,9999999))) % (26))
		numfornum = numfornum % 1000
		abcs = abcs..characters[test+1]
	end

	local nums = string.format("%03d",numfornum)

	return abcs .. " " .. nums
end

/*************************************************
	Turbo Noise
*************************************************/

hook.Add("Think", "VehicleTurboNoise", function()
	for _, veh in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if veh:IsEngineStarted() and veh.GearSounds and veh.Turbo == 1 then
			if not veh.Gear then veh.Gear = 0 end
			local rat = (veh:GetSpeed()*0.5/veh:GetMaxSpeed()) * 1
			if (CurTime() < (veh.NextTurbo or 0)) then return end
			for gear, speedfac in pairs(veh.GearSounds or {}) do
				if rat > speedfac and veh.Gear < gear then
					veh:EmitSound("paris/shiftup.mp3", 75, math.random(150,190))
					veh.Gear = gear
					veh.NextTurbo = CurTime() + 2
					veh:GetPhysicsObject():AddVelocity(Vector(0,0,20))
				elseif rat < speedfac and veh.Gear >= gear and veh.Gear != 1 then 
					veh.Gear = math.Clamp(veh.Gear - 1,1,999)
				end
			end
		end
	end
end)

/*************************************************
	Random RP
*************************************************/

timer.Create("RandomRPForPlayersDriving",100,0,function()
	for k, v in pairs(player.GetAll()) do
		if IsValid(v:GetVehicle()) then
			if VCMod1 then
				local v = v:GetVehicle()
				if not IsValid(v:GetDriver()) then continue end
				local withPlayers = false
				for k, v in pairs(v:VC_getSeatsAvailable()) do
					local ply = v:GetDriver()
					if IsValid(ply) then
						withPlayers = true
						ply:AddRP(100) ply:ReputationNotify( "+100 RP for cruising with players" )
					end
				end
				local ply = v:GetDriver()
				if withPlayers then
					ply:AddRP(150) ply:ReputationNotify( "+150 RP for driving with players" )
				else
					ply:AddRP(100) ply:ReputationNotify( "+100 RP driving around town." )
				end
			end
		end
	end
end)