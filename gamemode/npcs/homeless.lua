local NPC = {}

NPC.Name = "Homeless"
NPC.ID = 151
NPC.ShowChatBubble = false

NPC.Model = Model( "models/humans/clanof06/male_08.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 1,
    [2] = 1,
}
NPC.Sequence = 455
NPC.NoTalkSequence = true

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-2647,4633,-91),ang=Angle(0,-145,0),seq = 455},
    {pos=Vector(1770,541,-103),ang=Angle(9,91,0),seq = 373},

}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

local random_talks = {}
random_talks[1] = function()
    GAMEMODE.DialogPanel:SetDialog( "Arrrhgggg..." )

    GAMEMODE.DialogPanel:AddDialog( "...", LEAVE_DIALOG )

    GAMEMODE.DialogPanel:Show()
end
random_talks[2] = function()
    GAMEMODE.DialogPanel:SetDialog( "You got spare change?" )

    GAMEMODE.DialogPanel:AddDialog( "No.", function()
        GAMEMODE.DialogPanel:SetDialog( "Not even a dollar?" )
        GAMEMODE.DialogPanel:AddDialog( "Sorry, no.", function()
            GAMEMODE.DialogPanel:SetDialog( "Asshole." )
            GAMEMODE.DialogPanel:AddDialog( "...", LEAVE_DIALOG )
        end)
    end)
    GAMEMODE.DialogPanel:AddDialog( "Yeah, here you go!", function()
        -- sub $2?
        GAMEMODE.DialogPanel:SetDialog( "Thanks, god bless." )
        GAMEMODE.DialogPanel:AddDialog( "You need it man.", LEAVE_DIALOG )
    end)

    GAMEMODE.DialogPanel:Show()
end

random_talks[3] = function()
    GAMEMODE.DialogPanel:SetDialog( "ZzzzzzzzzzzzzzZZZ" )

    GAMEMODE.DialogPanel:AddDialog( "Hey my man wake up!", function()
        -- sub $2?
        GAMEMODE.DialogPanel:SetDialog( "**Snores**" )
        GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )
    end)

    GAMEMODE.DialogPanel:AddDialog( "**WALK AWAY**", LEAVE_DIALOG )

    GAMEMODE.DialogPanel:Show()
end

random_talks[4] = function()
    GAMEMODE.DialogPanel:SetDialog( "The earth is flat." )

    GAMEMODE.DialogPanel:AddDialog( "Holy fuck, I think you're right!", function()
        GAMEMODE.DialogPanel:SetDialog( "Barrack Obama was born in Africa." )
        GAMEMODE.DialogPanel:AddDialog( "That makes so much sense!", function()
            GAMEMODE.DialogPanel:SetDialog( "Bush did 9/11." )
            GAMEMODE.DialogPanel:AddDialog( "jrcwEsaLEVlLH858YEFEsbXjWCaB992tSITfDDmX", function()
                GAMEMODE.DialogPanel:SetDialog( "We are thing makers that make things that make maker things that make things that kill people." )
                GAMEMODE.DialogPanel:AddDialog( "**SMILE AND WALK AWAY**", LEAVE_DIALOG )
            end)
            GAMEMODE.DialogPanel:AddDialog( "You are crazy...", LEAVE_DIALOG )
        end)
        GAMEMODE.DialogPanel:AddDialog( "Nevermind...", LEAVE_DIALOG )
    end)

    GAMEMODE.DialogPanel:AddDialog( "**WALK AWAY**", LEAVE_DIALOG )

    GAMEMODE.DialogPanel:Show()
end


function NPC.OnTalk()
    random_talks[math.random(1,4)]()
end

function NPC.BuyHotdog()
    GAMEMODE.OpenShop( 75 )
    LEAVE_DIALOG()
end

GAMEMODE:LoadNPC( NPC )
