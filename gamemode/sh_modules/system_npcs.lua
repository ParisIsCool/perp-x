--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

NPC_DATABASE = NPC_DATABASE or {}

if SERVER then
	util.AddNetworkString("perp_npc_used")
	function GM.NPCUsed( Player, ID, NPCEnt )
		if NPC_DATABASE[ ID ].S_OnTalk then
			NPC_DATABASE[ ID ]:S_OnTalk(NPCEnt)
		end
		net.Start( "perp_npc_used", Player )
			net.WriteInt(ID, 16)
		net.Send(Player)
	end

	function GM:LoadNPC( NPCTable )
		
		local locationsTable = NPCTable.Location[game.GetMap():lower()]
		local anglesTable = NPCTable.Angles[game.GetMap():lower()]

		if not NPCTable.PosAngle then NPCTable.PosAngle = {} end

		// This NPC isnt supported on this map!
		if not NPCTable.PosAngle[game.GetMap():lower()] and not NPCTable.Location[game.GetMap():lower()] then return end

		NPCTable.NPCs = {}

		local function CreateNPC(Pos,Ang,Seq)
			local NPC = ents.Create( "npc_vendor" )

			--[[function NPC:ActualRun()
				return NPCTable:RunBehaviour(NPC)
			end]]

			NPC:SetModel( NPCTable.Model )
			if NPCTable.Skin then NPC:SetSkin( NPCTable.Skin ) end

			NPC.NPCID = NPCTable.ID
			NPC:SetNWInt("ID", NPCTable.ID)
			NPC:SetNWString("Name", NPCTable.Name)
			NPC.OriginalPos = Pos
			NPC:SetPos( Pos )
			NPC:SetAngles( Ang )
			NPC.NoBBox = NPCTable.NoBBox
			if NPCTable.ShowChatBubble then
				NPC:MakeChatBubble()
			end

			NPC:Spawn()

			if NPCTable.Invisible then
				NPC:AddEffects( bit.bor( EF_NOSHADOW, EF_NODRAW ) )
				NPC:SetCollisionGroup( COLLISION_GROUP_WORLD )
			else
				NPC:SetColor( Color( 255, 255, 255, 255 ) )
			end
            
            if NPCTable.BodyGroups then
               	for k, v in pairs(NPCTable.BodyGroups) do
                	 NPC:SetBodygroup(k,v)
                end
            end

			if Seq or NPCTable.Sequence then
				NPC:SetSequence(Seq or NPCTable.Sequence)
				NPC.Sequence = Seq or NPCTable.Sequence
			end

			NPC.NoTalkSequence = NPCTable.NoTalkSequence

			if NPCTable.TalkSeq then
				NPC.TalkSeq = NPCTable.TalkSeq
			end

			if NPCTable.ToolTipMessage then
				NPC.ToolTipMessage = NPCTable.ToolTipMessage
			end

			table.insert( NPCTable.NPCs, NPC )

			hook.Call( "NPCSpawned", GAMEMODE, NPCTable.ID, NPC )
		end

		if NPCTable.PosAngle[game.GetMap():lower()] then
			for k, v in pairs( NPCTable.PosAngle[game.GetMap():lower()] ) do
				CreateNPC(v.pos,v.ang,v.seq)
			end
		else
			if not istable(NPCTable.Location[game.GetMap():lower()]) then
				NPCTable.Location[game.GetMap():lower()] = {NPCTable.Location[game.GetMap():lower()]}
				NPCTable.Angles[game.GetMap():lower()] = {NPCTable.Angles[game.GetMap():lower()]}
			end
			for k, v in pairs(NPCTable.Location[game.GetMap():lower()] or {}) do
				CreateNPC(v,NPCTable.Angles[game.GetMap():lower()][k])
			end
		end

		if not NPC_DATABASE[ NPCTable.ID ] then
			Msg( "\t-> Loaded " .. NPCTable.Name .. " [ID: " .. NPCTable.ID .. "]\n" )
		end

		NPC_DATABASE[ NPCTable.ID ] = NPCTable
	end

	function PLAYER:NearNPC( NPCID )
		for _, v in pairs( ents.FindInSphere( self:GetPos(), 500 ) ) do
			if (v:GetClass() == "npc_vendor" or v:GetClass() == "npc_nextbot") and v.NPCID == NPCID then
				return v
			end
		end
	end

	hook.Add( "OnReloaded", "KillAllNPCS", function()
		for _, v in pairs( ents.FindByClass( "npc_vendor" ) ) do
			v:Remove()
		end

		for _, v in pairs( ents.FindByClass( "npc_nextbot" ) ) do
			v:Remove()
		end

		for _, v in pairs( ents.FindByClass( "npc_bubble" ) ) do
			v:Remove()
		end
	end )
else
	function GM:LoadNPC( NPCTable )
		if not NPC_DATABASE[ NPCTable.ID ] then
			Msg( "\t-> Loaded " .. NPCTable.Name .. " [ID: " .. NPCTable.ID .. "]\n" )
		end
		NPC_DATABASE[ NPCTable.ID ] = NPCTable
	end

	net.Receive("perp_npc_used", function()
		-- Prevent opening menu too quickly.
		if LocalPlayer().LastUsedNPC and LocalPlayer().LastUsedNPC + 2 > CurTime() then return end
		LocalPlayer().LastUsedNPC = CurTime()

		local ID = net.ReadInt(16)

		local NearestNPC
		local NearestPos = 9999
		for k, v in pairs( ents.FindByClass( "npc_vendor" ) ) do
			local Dist = v:GetPos():Distance( LocalPlayer():GetEyeTrace().HitPos )
			if Dist < NearestPos then
				NearestPos = Dist
				NearestNPC = v
			end
		end

		NPC_DATABASE[ ID ].OnTalk( LocalPlayer() )
	end )
end
