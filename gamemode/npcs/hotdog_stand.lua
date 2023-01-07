local NPC = {}

NPC.Name = "Hotdog Stand"
NPC.ID = 67
NPC.ShowChatBubble = false

NPC.Model = Model( "models/humans/clanof06/male_08.mdl" )
NPC.Skin = 1
NPC.BodyGroups = {
    [1] = 1,
    [2] = 2,
}
NPC.TalkSeq = 418

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(5192,8700,128),ang=Angle(0,88,0)},
    {pos=Vector(5813,4446,-55),ang=Angle(0,-90,0)},
    {pos=Vector(-6299,2641,-39),ang=Angle(0,89,0)},
    {pos=Vector(6355,870,-103),ang=Angle(0,179,0)},
    {pos=Vector(3745,5825,8),ang=Angle(3,92,0)},
    {pos=Vector(1965,5497,8),ang=Angle(1,91,0)},
    {pos=Vector(-2749,11654,128),ang=Angle(3,-179,0)},
	{pos=Vector(1604,321,-103),ang=Angle(1,-178,0)},

}

if SERVER then util.AddNetworkString("HotDogYellLmao") end
function NPC:S_OnTalk(NPCEnt)
    --NPCEnt:EmitSound( Sound( "paris/hotdog/hotdog_" .. math.random(1,5) .. ".mp3" ) )
    net.Start("HotDogYellLmao")
    net.WriteEntity(NPCEnt)
    net.WriteInt(math.random(1,5),8)
    net.Broadcast()
end
if CLIENT then
    net.Receive("HotDogYellLmao", function()
        local NPCEnt = net.ReadEntity()
        if not IsValid(NPCEnt) then return end
        local soundnum = net.ReadInt(8)
        local s
        sound.PlayFile( "sound/paris/hotdog/hotdog_" .. soundnum .. ".mp3", "3d", function(station,errid,errstr)
            if station then
                s = station
                station:SetPos(NPCEnt:GetPos())
            else
                print(station,errid,errstr)
            end
        end)
        local flexes = {
            NPCEnt:GetFlexIDByName( "jaw_drop" ),
            NPCEnt:GetFlexIDByName( "left_part" ),
            NPCEnt:GetFlexIDByName( "right_part" ),
            NPCEnt:GetFlexIDByName( "left_mouth_drop" ),
            NPCEnt:GetFlexIDByName( "right_mouth_drop" )
        }
        local lerpsound = 0
        hook.Add("Think", "JawMovementHotdogGuy"..tostring(NPCEnt), function()
            if not IsValid(s) then return end
            local l,r = s:GetLevel()
            lerpsound = Lerp(1, lerpsound, (l+r)/2)
            for k, v in pairs( flexes ) do
                NPCEnt:SetFlexWeight( v, lerpsound*4 )
            end
            if not IsValid(NPCEnt) or s:GetTime() >= s:GetLength() then
                hook.Remove("Think", "JawMovementHotdogGuy"..tostring(NPCEnt))
            end
        end)
    end)
end

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end


function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Heyo, you want some hotdogs?" )

	GAMEMODE.DialogPanel:AddDialog( "Yeah, I'll take one.", NPC.BuyHotdog )
	GAMEMODE.DialogPanel:AddDialog( "I'll pass.", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.BuyHotdog()
    GAMEMODE.OpenShop( 75 )
    LEAVE_DIALOG()
end

GAMEMODE:LoadNPC( NPC )