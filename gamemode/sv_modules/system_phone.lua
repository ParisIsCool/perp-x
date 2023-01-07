--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

// TEXT tones

local tones = {
    {Name = "Aurora", Path ="paris/phone/Aurora.mp3"},
    {Name = "Bamboo", Path ="paris/phone/Bamboo.mp3"},
    {Name = "Chord", Path ="paris/phone/Chord.mp3"},
    {Name = "Circles", Path ="paris/phone/Circles.mp3"},
    {Name = "Complete", Path ="paris/phone/Complete.mp3"},
    {Name = "Export", Path ="paris/phone/Export.mp3"},
    {Name = "Hello", Path ="paris/phone/Hello.mp3"},
    {Name = "Input", Path ="paris/phone/Input.mp3"},
    {Name = "Keys", Path ="paris/phone/Keys.mp3"},
    {Name = "Note", Path ="paris/phone/Note.mp3"},
    {Name = "Popcorn", Path ="paris/phone/Popcorn.mp3"},
    {Name = "Synth", Path ="paris/phone/Synth.mp3"},
}

util.AddNetworkString("paris_sendtextmessage")
util.AddNetworkString("paris_receivetextmessage")
function GM:SendTextMessage(sender,receiver,str)
    if (!sender:HasItem("item_phone")) then return end
	if (!receiver:HasItem("item_phone")) then return end
    local str = net.ReadString()
    if #str > 220 then return end
    net.Start("paris_receivetextmessage")
        net.WriteEntity(sender)
        net.WriteString(str)
    net.Send(receiver)
    receiver:EmitSound(tones[ply.TextTone or 1].Path, 150)
    print(tones[ply.TextTone].Path)
	Log(Format("%s [%s] messaged %s [%s] : %s",sender:Nick(), sender:SteamID(), receiver:Nick(), receiver:SteamID(), str))
end
net.Receive("paris_sendtextmessage", function(len,ply)
    local otherply = net.ReadEntity()
	if !IsValid(otherply) then return end
    GAMEMODE:SendTextMessage(ply,otherply,str)
end)

util.AddNetworkString("paris_startcall")
util.AddNetworkString("paris_callnotice")
util.AddNetworkString("paris_busytone")
net.Receive("paris_startcall", function(len,ply)
    if ply.InCall then return end
    local otherply = net.ReadEntity()
	if !IsValid(otherply) then return end
	if (!ply:HasItem("item_phone")) then return end
	if (!otherply:HasItem("item_phone")) then return end
    if otherply == ply then 
        net.Start("paris_busytone")
        net.Send(ply)
        return 
    end
    if otherply.InCall then 
        net.Start("paris_busytone")
        net.Send(ply)
        return 
    end
    print(ply:Nick() .. " is ringing " .. otherply:Nick())
    otherply.RingingCall = ply
    --otherply:EmitSound("paris/phone/Ringtones/Trap.mp3")
    if otherply.Ring then
        otherply.Ringer = otherply:StartLoopingSound( otherply.Ring[1] .. ".wav" )
    else
        otherply.Ringer = otherply:StartLoopingSound( "perp2.5/ringtones/badtouch.wav"  )
    end
    net.Start("paris_callnotice")
        net.WriteEntity(ply)
    net.Send(otherply)
    ply.RingingCall = otherply
    ply.InCall = true
	Log(Format("%s [%s] is ringing %s [%s]",ply:Nick(), ply:SteamID(), otherply:Nick(), otherply:SteamID(), str))
end)

util.AddNetworkString("paris_serverendcall")
util.AddNetworkString("paris_sendringtones")
net.Receive("paris_sendringtones", function(len,ply)
    local int = net.ReadInt(16)
    if not phoneRingTones[int] then int = 1 end
    ply.Ring = phoneRingTones[int]
end)
util.AddNetworkString("paris_sendtexttones")
net.Receive("paris_sendtexttones", function(len,ply)
    local int = net.ReadInt(16)
    if not tones[int] then int = 1 end
    ply.TextTone = tones[int]
end)
util.AddNetworkString("paris_serverpickupcall")

util.AddNetworkString("paris_pickupcall")
net.Receive("paris_pickupcall", function(len,ply)
    if !ply.RingingCall then return end
    if !IsValid(ply.RingingCall) then
        net.Start("paris_busytone")
        net.Send(ply)
        return 
    end
    if ply.RingingCall == ply.RingingCall.RingingCall then
        net.Start("paris_busytone")
        net.Send(ply)
        return 
    end
	if (!ply:HasItem("item_phone")) then return end
	if (!ply.RingingCall:HasItem("item_phone")) then return end
    local otherply = ply.RingingCall
    ply:StopLoopingSound(ply.Ringer or 0)
    print(ply:Nick() .. " picked up the call on " .. otherply:Nick())
    otherply.RingingCall = nil
    ply.RingingCall = nil
    otherply.InCallWith = ply
    ply.InCallWith = otherply
    net.Start("paris_serverpickupcall")
    net.Send(otherply)
	Log(Format("%s [%s] picked up the call with %s [%s]",ply:Nick(), ply:SteamID(), ply.InCallWith:Nick(), ply.InCallWith:SteamID()))
end)

util.AddNetworkString("paris_endcall")
net.Receive("paris_endcall", function(len,ply)
    if not ply.RingingCall and not ply.InCallWith then return end
    local otherply = ply.RingingCall or ply.InCallWith
    ply.InCall = false
    if !IsValid(otherply) then return end
    print(ply:Nick() .. " ended the call on " .. otherply:Nick())
    otherply.InCall = false
    otherply.RingingCall = nil
    ply.RingingCall = nil
    otherply.InCallWith = false
    ply.InCallWith = false
    if isnumber(ply.Ringer) then
        ply:StopLoopingSound(ply.Ringer or 0)
    end
    if isnumber(otherply.Ringer) then
        otherply:StopLoopingSound(otherply.Ringer or 0)
    end
    net.Start("paris_serverendcall")
    net.Send(otherply)
	Log(Format("%s [%s] ended the call on %s [%s]",ply:Nick(), ply:SteamID(), otherply:Nick(), otherply:SteamID()))
end)


util.AddNetworkString("paris_phonesyssendringtone")
net.Receive("paris_phonesyssendringtone", function(len,ply)
    --ply.RingTone = net.ReadString()
end)

hook.Add( "PlayerCanHearPlayersVoice", "PhoneCallTrust", function( listener, talker )
	if listener.InCallWith == talker or listener == talker.InCallWith then return true, false end
end )