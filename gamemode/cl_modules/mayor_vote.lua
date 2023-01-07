--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

net.Receive( "perp_mayor_election", function()
	local numNominees = net.ReadInt(8)
	
	GAMEMODE.VotePanel = vgui.Create( "perp2_mayor_election" )
	
	for i = 1, numNominees do
		local nominee = net.ReadEntity()
		
		if nominee and IsValid( nominee ) then
			GAMEMODE.VotePanel:AddPlayer( nominee )
		end
	end
end )

net.Receive( "perp_mayor_end", function()
	local ent = net.ReadEntity()
	local numVotes = net.ReadInt(8)
	
	if ent == LocalPlayer() then
		LocalPlayer():Notify( "You won mayordom with " .. numVotes .. " votes." )
	elseif ent and IsValid( ent ) then
		LocalPlayer():Notify( ent:GetRPName() .. " won mayordom with " .. numVotes .. " votes." )
	end
	
	if GAMEMODE.VotePanel then
		GAMEMODE.VotePanel:Remove()
		GAMEMODE.VotePanel = nil
	end
	
	GAMEMODE.IsRunningForMayor = nil
end )