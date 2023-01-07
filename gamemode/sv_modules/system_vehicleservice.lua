-- SERVERSIDE

util.AddNetworkString("BlackoutMenuOpacity")

function PLAYER:BlackoutScreen(Opacity)
    net.Start("BlackoutMenuOpacity")
    net.WriteInt(Opacity,16)
    net.Send(self)
end

stalls = stalls or {}
local stalls = stalls

local function UseButton(ply)
    for k, v in pairs(ents.FindInSphere(Vector(-2167,6338,75),50)) do
        if v:GetClass() == "func_button" then
            v:Use(ply)
        end
    end
end

local function EnterStallOne(veh,ply,pos,ang,extrafunc)
    net.Start("VehicleServiceInUse") net.WriteInt(1,4) net.WriteBool(true) net.Broadcast()
    veh:VC_setGodMode(true)
    ply:BlackoutScreen(255)
    local wait = 1
    if extrafunc then
        local n = extrafunc()
        if isnumber(n) then wait = wait + n end
    end
    veh:StartEngine(false)
    veh.ServiceNoStart = true
    timer.Simple(wait, function()
        if game.GetMap() == "rp_southside" then wait = 5.5 end
        timer.Simple(wait-1,function()
            net.Start("VehicleServiceStartMenu") net.WriteString("Repair") net.Send(ply)
        end)
        veh:StartEngine(false)
        veh:SetVelocity((veh:GetVelocity()*Vector(-1,-1,-1))+Vector(0,0,20))
        veh:GetPhysicsObject():EnableMotion( false )
        veh:SetPos(pos + Vector(0,0,5))
        veh:SetAngles(ang)
        timer.Simple(0.1, function() veh:GetPhysicsObject():EnableMotion( true ) veh:SetAngles(ang) end)
        UseButton(ply)
        ply:BlackoutScreen(0)
    end)
end
local function LeaveStallOne(veh,ply,extrafunc)
    local wait = 0
    if extrafunc then
        local n = extrafunc()
        if isnumber(n) then wait = wait + n end
    end
    timer.Simple(wait, function()
        net.Start("VehicleServiceInUse") net.WriteInt(1,4) net.WriteBool(false) net.Broadcast()
        veh.ServiceNoStart = false
        veh:StartEngine(true)
        veh:VC_setGodMode(false)
    end)
end

local function EnterStallTwo(veh,ply,pos,ang)
    net.Start("VehicleServiceInUse") net.WriteInt(2,4) net.WriteBool(true) net.Broadcast()
    veh:VC_setGodMode(true)
    ply:BlackoutScreen(255)
    local wait = 2
    veh:StartEngine(false)
    veh.ServiceNoStart = true
    veh.OGColor = veh:GetColor()
    veh.OGHLColor = veh:VC_getOverride("HLColor")
    veh.OGUnderglow = veh.UnderglowColor
    if VCMod1 then
        veh:VC_setRunningLights(true)
        veh:VC_setFogLights(true)
        veh:VC_setHighBeams(true)
    end
    timer.Simple(wait, function()
        net.Start("VehicleServiceStartMenu") net.WriteString("Paint") net.Send(ply)
        veh:StartEngine(false)
        veh:SetVelocity((veh:GetVelocity()*Vector(-1,-1,-1))+Vector(0,0,20))
        veh:GetPhysicsObject():EnableMotion( false )
        veh:SetPos(pos + Vector(0,0,5))
        veh:SetAngles(ang)
        timer.Simple(0.1, function() veh:GetPhysicsObject():EnableMotion( true ) veh:SetAngles(ang) end)
        ply:BlackoutScreen(0)
    end)
end
local function LeaveStallTwo(veh,ply)
    net.Start("VehicleServiceInUse") net.WriteInt(2,4) net.WriteBool(false) net.Broadcast()
    local wait = 0
    veh:SetColor(veh.OGColor)
    veh:VC_setOverride("HLColor", veh.OGHLColor)
    veh:VC_setHighBeams(false)
    veh:VC_setRunningLights(false)
    veh:VC_setFogLights(false)
    timer.Simple(0.5, function() veh:VC_setHighBeams(true) veh:VC_setRunningLights(true) veh:VC_setFogLights(true) end)
    veh.UnderglowColor = veh.OGUnderglow
    ply:ConCommand("perp_v_ug 0 ") timer.Simple(0.5, function() ply:ConCommand("perp_v_ug 1") end)
    timer.Simple(wait, function()
        veh.ServiceNoStart = false
        veh:StartEngine(true)
        veh:VC_setGodMode(false)
    end)
end

stalls["rp_southside"] = {
    [1] = {
        trigger = Vector(-1730, 6227, 77),
        stallcar = function(veh,ply)
            EnterStallOne(veh,ply,Vector(-2165,6243,50),Angle(0,90,0),function()
                for k, v in pairs(ents.FindInSphere(Vector(-2167,6237,60),150)) do
                    if v:GetClass() == "func_door" then
                        if v:GetSaveTable().m_toggle_state == 0 then
                            UseButton(ply)
                            return 5
                        end
                    end
                end
            end)
        end,
        leave = function(veh,ply)
            LeaveStallOne(veh,ply,function()
                for k, v in pairs(ents.FindInSphere(Vector(-2167,6237,60),150)) do
                    if v:GetClass() == "func_door" then
                        if v:GetSaveTable().m_toggle_state == 0 then
                            UseButton(ply)
                            return 4
                        end
                    end
                end
            end)
        end
    },
    [2] = {
        trigger = Vector(-1735,6661,13),
        stallcar = function(veh,ply)
            EnterStallTwo(veh,ply,Vector(-2165,6626,24),Angle(0,90,0))
        end,
        leave = function(veh,ply)
            LeaveStallTwo(veh,ply)
        end
    }
}


stalls["rp_rockford_v2b"] = {
    [1] = {
        trigger = Vector(-7609,-1749,8),
        stallcar = function(veh,ply)
            EnterStallOne(veh,ply,Vector(-7439,-1728,12),Angle(0,-90,0))
        end,
        leave = function(veh,ply)
            LeaveStallOne(veh,ply)
        end
    },
    [2] = {
        trigger = Vector(-8357,-1741,8),
        stallcar = function(veh,ply)
            EnterStallTwo(veh,ply,Vector(-8541,-1751,12),Angle(0,90,0))
        end,
        leave = function(veh,ply)
            LeaveStallTwo(veh,ply)
        end
    }
}

net.Receive("ServiceVehicleEnterShop", function(len,ply)
    local stallid = net.ReadInt(4)
    local stall = stalls[game.GetMap()][stallid]
    if not stall then return end
    if stall.InUse then return end
    if not IsValid(ply:GetVehicle()) then return end
    if ply:GetVehicle().RequiredClass then return end
    if ply:GetVehicle().Owner != ply then return end
    for _, ent in pairs(ents.FindInSphere(stall.trigger,50)) do
        if ent:IsVehicle() and IsValid(ent:GetDriver()) and ent:GetDriver() == ply then
            stall.stallcar(ent,ply)
            stall.InUse = {ent,ply}
        end
    end
end)

net.Receive("ServiceVehicleLeaveShop", function(len,ply)
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == ply then
            stall.leave(stall.InUse[1],ply)
            stall.InUse = false
        end
    end
end)

net.Receive("ServiceVehicleRepairVehicle", function(len,ply)
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == ply then
            local repaircost = math.Round(100+(#stall.InUse[1]:VC_getDamagedParts()*30)+((100-stall.InUse[1]:VC_getHealth(true))*3))
            if ply:GetCash() < repaircost then return false end
            ply:TakeCash(repaircost)
            stall.InUse[1]:VC_repairFull_Admin()
            timer.Simple(0.2, function() net.Start("ServiceVehicleDoneRequest") net.Send(ply) end)
        end
    end
end)

net.Receive("ServiceVehicleTryColor", function(len,ply)
    local color = net.ReadColor()
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == ply then
            stall.InUse[1]:SetColor(color)
            net.Start("ServiceVehicleDoneRequest") net.WriteString("ServiceVehicleKeepRGBColor") net.WriteInt(5000, 16) net.Send(ply)
        end
    end
end)
net.Receive("ServiceVehicleTryHLColor", function(len,ply)
    local color = net.ReadColor()
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == ply then
            stall.InUse[1]:VC_setOverride("HLColor", color)
            stall.InUse[1]:VC_setHighBeams(false)
            stall.InUse[1]:VC_setRunningLights(false)
            stall.InUse[1]:VC_setFogLights(false)
            timer.Simple(0.5, function() stall.InUse[1]:VC_setHighBeams(true) stall.InUse[1]:VC_setRunningLights(true) stall.InUse[1]:VC_setFogLights(true) end)
            net.Start("ServiceVehicleDoneRequest") net.WriteString("ServiceVehicleKeepHLColor") net.WriteInt(10000, 16)net.Send(ply)
        end
    end
end)

util.AddNetworkString("ServiceVehicleTryUGColor")
net.Receive("ServiceVehicleTryUGColor", function(len,ply)
    local color = net.ReadColor()
    for stallid, stall in pairs(stalls[game.GetMap()]) do
        if stall.InUse and stall.InUse[2] == ply then
            stall.InUse[1].UnderglowColor = color
            ply:ConCommand("perp_v_ug 0 ") timer.Simple(0.5, function() ply:ConCommand("perp_v_ug 1") end)
            net.Start("ServiceVehicleDoneRequest") net.WriteString("ServiceVehicleKeepUGColor") net.WriteInt(10000, 16)net.Send(ply)
        end
    end
end)

util.AddNetworkString("ServiceVehicleTryLicensePlate")
net.Receive("ServiceVehicleTryLicensePlate", function(len,ply)
    if (ply.NextPlateRequest or 0) > CurTime() then return ply:Notify("Slow Down!") end
    ply.NextPlateRequest = CurTime() + 1
    local plate = net.ReadTable()
    plate.Text = string.Left(plate.Text,7)
    plate.Text = string.upper(plate.Text)
    local ok = true
    if #plate.Text < 1 then ok = false end
    -- insert more checks later
    tmysql.query("SELECT id FROM perp_vehicles WHERE license_plate LIKE '%\"" .. tmysql.escape(plate.Text) .. "\"%';", function(Results)
        net.Start("ServiceVehicleTryLicensePlate")
        net.WriteBool(#Results > 0 and ok)
        net.Send(ply)
    end)
end)

hook.Add("CanExitVehicle", "VehicleServiceNoLeaveVeh", function(Vehicle, Player)
    if Vehicle.ServiceNoStart then return false end
end)
hook.Add("VC_canSwitchSeat", "VehicleServiceNoLeaveVeh", function(Player, VehFrom, VehTo)
    if VehFrom.ServiceNoStart then return false end
end)

util.AddNetworkString("ServiceVehicleEnterShop")
util.AddNetworkString("VehicleServiceInUse")
util.AddNetworkString("VehicleServiceStartMenu")
util.AddNetworkString("ServiceVehicleLeaveShop")
util.AddNetworkString("ServiceVehicleRepairVehicle")
util.AddNetworkString("ServiceVehicleDoneRequest")
util.AddNetworkString("ServiceVehicleTryColor")
util.AddNetworkString("ServiceVehicleKeepColor")
util.AddNetworkString("ServiceVehicleTryHLColor")

concommand.Add("servicevehicle", function(ply,cmd,args)
    if ply:IsSuperAdmin() then
        local veh = ply:GetVehicle()
        if not IsValid(veh) then return end
        if stalls[game.GetMap()][1].InUse then
            stalls[game.GetMap()][1].leave(veh,ply)
            stalls[game.GetMap()][1].InUse = false
            print("leaving")
        else
            stalls[game.GetMap()][1].stallcar(veh,ply)
            stalls[game.GetMap()][1].InUse = {veh,ply}
            print("entering")
        end
    end
end)