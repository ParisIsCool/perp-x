--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ITEM 					= {}

ITEM.ID 					= 104
ITEM.Reference 				= "item_lawbook"

ITEM.Name 					= "Book of the Law"
ITEM.Description			= "This book sells you the current laws and limits."

ITEM.Weight 				= 5
ITEM.Cost					= 250

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/props_lab/bindergreenlabel.mdl" )
ITEM.WorldModel 			= Model( "models/props_lab/bindergreenlabel.mdl" )

ITEM.ModelCamPos 			= Vector( 1, -17, 6 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

if CLIENT then
	function ITEM.OnUse( SlotID )
		local jobsinfo = ""
		for k, v in ipairs(JOB_DATABASE) do
			local str1, str2, str3 = "", "", ""
			if GAMEMODE.JobWages[k] then
				str1 = [[<br /> ]]..v.Name..[[ Salary: $]]..util.FormatNumber( GAMEMODE.JobWages[k] )
			end
			if GAMEMODE.MaxJobs[k] then
				str2 = [[<br /> ]]..v.Name..[[ Maximum Employment: ]]..GAMEMODE.MaxJobs[k]
			end
			if GAMEMODE.MaxVehicles[k] then
				str3 = [[<br /> ]]..v.Name..[[ Max Vehicles: ]]..GAMEMODE.MaxVehicles[k]
			end
			local str4 = [[<br /> ]]..v.Name..[[ Current Employment: ]]..#team.GetPlayers(k)..[[<br />]]
			local mini = str1 .. str2 .. str3 .. str4
			jobsinfo = jobsinfo .. mini
		end
		local str = [[
		<html>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://bootswatch.com/cyborg/bootstrap.min.css">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

		<body style="text-align: center;" background="https://i.imgur.com/X0bBWNS.jpg"> 
		<h1>The mayor has stated the following laws in town:</h1><br />
		Sales Tax Rate: ]] .. GAMEMODE.GetTaxRate_Sales() * 100 .. [[%<br />
		Income Tax Rate: ]] .. GAMEMODE.GetTaxRate_Income() * 100 .. [[%<br />
		Traffic Ticket Price: $]] .. util.FormatNumber( GetGNWVar( "ticket_price" ) ) .. [[<br />
		Inner City Speedlimit: ]] .. SpeedText( GetGNWVar( "innercity_speedlimit_i" ), true ) .. [[<br />
		Outter City Speedlimit: ]] .. SpeedText( GetGNWVar( "innercity_speedlimit_o" ) ) .. [[<br />

		<h1>Current written laws by the mayor:</h1><br />
		]] .. string.Replace(tostring(GAMEMODE.MayorLaws),"\n","<br />") .. [[

		<h1>The mayor has stated the following governmental job limits:</h1><br />

		]] .. jobsinfo .. [[
		
		]]

		
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( ScrW() * 0.8, ScrH() * 0.8 )
		Frame:Center()
		Frame:SetTitle( "Book of the Law" )
		Frame:MakePopup()

		local HTML = vgui.Create( "HTML", Frame )
		HTML:StretchToParent( 5, 27, 5, 5 )
		HTML:SetHTML( str )

		return false
	end
end

GAMEMODE:RegisterItem( ITEM )
