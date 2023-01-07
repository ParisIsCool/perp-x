local moneymultiplier = 1
util.AddNetworkString("event_scorecard")
util.AddNetworkString("event_sound")
local events = {}

events["Longest Distance Driven"] = {}
local event = events["Longest Distance Driven"]
event.name = "Longest Distance Driven"
event.info = "Drive the longest distance."
event.win = "%s won the event with %s miles!"
event.units = " mi."
event.time = 10*60
event.preStartInfo = "Starting Soon"
event.scoreboard = {}
event.init = function()
    event.scoreboard = {}
    for k, v in pairs(player.GetAll()) do
        v.event_distance = nil
        v.event_lastpos = nil
    end
end
event.think = function()
    for k, v in pairs(player.GetAll()) do
        if IsValid(v:GetVehicle()) then
            if not v.event_distance then v.event_distance = 0 end
            if not v.event_lastpos then v.event_lastpos = v:GetPos() end
            event.scoreboard[v:SteamID()] = v.event_distance + v:GetPos():Distance(v.event_lastpos)
            v.event_distance = event.scoreboard[v:SteamID()]
            v.event_lastpos = v:GetPos()
        end
    end
end
-- slower think so we dont spam net events
event.net_think = function(pre)
    event.sorted = table.SortByKey( event.scoreboard )
	event.sboard = {}
	for k, v in ipairs(event.sorted) do
		event.sboard[k] = {sid=v,score=event.scoreboard[v]/84480}
	end
    net.Start("event_scorecard")
    if pre then
        net.WriteTable({score=event.sboard,timeleft=event.timeleft,name=event.name,info=event.preStartInfo})
    else
        net.WriteTable({score=event.sboard,timeleft=event.timeleft,name=event.name,info=event.info,units=event.units})
    end
    net.Broadcast()
end
event.calculate_winner = function()
    local biggest_num, biggest = 0
    for k, v in pairs(event.scoreboard) do
        if v > biggest_num then biggest_num = v biggest = k end
    end
    return biggest, math.Round(biggest_num/84480,3)
end
event.calculate_winnings = function()
    local biggestwin = 15000 * moneymultiplier
    local biggestply, biggest_num = event.calculate_winner()
    for k, v in pairs(event.scoreboard) do
        local ratio = (v/84480)/biggest_num
        local winnerply = player.GetBySteamID(k)
        if IsValid(winnerply) then
            winnerply:GiveCash(math.Round(ratio*biggestwin))
        else -- offline here
            -- cannot do until we store by perpid
        end
    end
end

--[[events["Most Distace In The Air"] = {}
local event = events["Most Distace In The Air"]
event.name = "Most Distace In The Air"
event.info = "Jump off buldings, drive off ramps."
event.win = "%s won the event with %s feet in the air!"
event.units = " feet."
event.time = 1*60
event.preStartInfo = "Starting Soon"
event.scoreboard = {}
event.init = function()
    event.scoreboard = {}
    for k, v in pairs(player.GetAll()) do
        v.event_distance = nil
        v.event_lastpos = nil
    end
end
local function isVehicleOnGround(veh)
    for i=veh:GetWheelCount(),1,-1 do
        local _, __, OnGround = veh:GetWheelContactPoint( i )
        if OnGround then return true end
    end
    return false
end
event.think = function()
    for k, v in pairs(player.GetAll()) do
        if not v:OnGround() or (IsValid(v:GetVehicle()) and not isVehicleOnGround(v:GetVehicle())) then
            if not v.event_distance then v.event_distance = 0 end
            if not v.event_lastpos then v.event_lastpos = v:GetPos() end
            event.scoreboard[v:SteamID()] = v.event_distance + v:GetPos():Distance(v.event_lastpos)
            v.event_distance = event.scoreboard[v:SteamID()]
            v.event_lastpos = v:GetPos()
        end
    end
end
-- slower think so we dont spam net events
event.net_think = function(pre)
    event.sorted = table.SortByKey( event.scoreboard )
	event.sboard = {}
	for k, v in ipairs(event.sorted) do
		event.sboard[k] = {sid=v,score=event.scoreboard[v]/16}
	end
    net.Start("event_scorecard")
    if pre then
        net.WriteTable({score=event.sboard,timeleft=event.timeleft,name=event.name,info=event.preStartInfo})
    else
        net.WriteTable({score=event.sboard,timeleft=event.timeleft,name=event.name,info=event.info,units=event.units})
    end
    net.Broadcast()
end
event.calculate_winner = function()
    local biggest_num, biggest = 0
    for k, v in pairs(event.scoreboard) do
        if v > biggest_num then biggest_num = v biggest = k end
    end
    return biggest, math.Round(biggest_num/16,3)
end
event.calculate_winnings = function()
    local biggestwin = 15000 * moneymultiplier
    local biggestply, biggest_num = event.calculate_winner()
    for k, v in pairs(event.scoreboard) do
        local ratio = (v/16)/biggest_num
        local winnerply = player.GetBySteamID(k)
        if IsValid(winnerply) then
            winnerply:GiveCash(math.Round(ratio*biggestwin))
        else -- offline here
            -- cannot do until we store by perpid
        end
    end
end]]

--------------------------------------------------------------
-- Event Manager
--------------------

local function StopEvent()
    net.Start("event_scorecard")
    net.WriteTable({})
    net.Broadcast()
end

local function PlaySound(sound)
    net.Start("event_sound")
    net.WriteString(sound)
    net.Broadcast()
end

local function StartEvent()
    hook.Remove("Think", "EVENT_THINKER")
    timer.Destroy("EVENT_NETTHINKER")
    StopEvent()
    local event = table.Random(events)
    --local event = events["Most Distace In The Air"]
    local timetostart = 60
    for k, v in pairs(player.GetAll()) do
        v:ChatPrint(event.name .. " event starting in 1 minute!")
    end
    local eventstart = CurTime()+timetostart
    timer.Create("EVENT_NETTHINKER", 0.5,0,function() event.net_think(true) event.timeleft = eventstart - CurTime() end)
    timer.Simple(timetostart, function()
        event.init()
        timer.Create("EVENT_NETTHINKER", 0.5,0,function() event.net_think(false) end)
        local start = CurTime()
        local eventend = CurTime()+event.time
        local timeendplayed = false
        hook.Add("Think", "EVENT_THINKER",function()
            event.timeleft = eventend - CurTime()
            if event.timeleft < 30 and not timeendplayed then
                timeendplayed = true
                PlaySound("paris/30secondcountdown.mp3")
            end
            if event.timeleft < 0 then
                hook.Remove("Think", "EVENT_THINKER")
                timer.Destroy("EVENT_NETTHINKER")
                local winner, amount = event.calculate_winner()
                local winnerply = player.GetBySteamID(winner)
                for k, v in pairs(player.GetAll()) do
                    local name = winnerply
                    if IsValid(winnerply) then
                        name = winnerply:Name()
                    end
                    v:ChatPrint(string.format(event.win,name,amount))
                end
                event.calculate_winnings()
                timer.Simple(5, function() StopEvent() end)
                return
            end
            event.think()
        end)
    end)
end

concommand.Add("startevent", StartEvent)