local NPC = {}

NPC.Name = "The Secret Man"
NPC.ID = 69

NPC.Model = Model( "models/humans/Group01/male_02.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_rockford_v2b'] = {
									Vector( -4188.7749023438, -784.15838623047, 544.03125 ),
									Vector( -4586.5771484375, -4904.0053710938, 864.03125 ),
}	

NPC.Angles ['rp_rockford_v2b'] = {
									Angle( 0, 90, 0),
									Angle( 0, -90, 0),									
}

NPC.ShowChatBubble = true

function NPC:RunBehaviour( NPCEnt )
    return NPC_IDLE( NPCEnt )
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Get fucken bent." )
	GAMEMODE.DialogPanel:AddDialog( "Oh, ok. *Rude*", LEAVE_DIALOG )
	GAMEMODE.DialogPanel:Show()
end

GAMEMODE:LoadNPC( NPC )

--Vector( -4586.5771484375, -4904.0053710938, 864.03125 ), Angle( -0.23373816907406, -90.453483581543, 0)
