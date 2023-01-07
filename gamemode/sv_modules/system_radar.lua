resource.AddWorkshop("2034472616") -- Main Content


util.AddNetworkString("PARIS_AddBlipTOHUD")
util.AddNetworkString("PARIS_RemoveBlipFROMHUD")

local PLAYER = FindMetaTable("Player")
local ENTITY = FindMetaTable("Entity")


function PLAYER:AddMapBlip(Mat, BlipID, Scale, Color, FadeDist, Zone, Follow)
    timer.Simple(1, function()
        net.Start("PARIS_AddBlipTOHUD")
            net.WriteTable(
                {
                    VectorOrEntity = self,
                    Mat = Mat,
                    ID = BlipID,
                    Scale = Scale,
                    Color = Color,
                    Follow = Follow,
                    FadeDist = FadeDist,
                    Zone = Zone
                }
            )
        net.Broadcast()
    end)
end

function ENTITY:AddMapBlip(Mat, BlipID, Scale, Color, FadeDist, Zone, Follow)
    timer.Simple(1, function()
        net.Start("PARIS_AddBlipTOHUD")
            net.WriteTable(
                {
                    VectorOrEntity = self,
                    Mat = Mat,
                    ID = BlipID,
                    Scale = Scale,
                    Color = Color,
                    Follow = Follow,
                    FadeDist = FadeDist,
                    Zone = Zone
                }
            )
        net.Broadcast()
    end)
end

function ENTITY:AddMapBlipSpecificPlayer(Mat, BlipID, Scale, Color, FadeDist, Zone, Follow, Player)
    timer.Simple(1, function()
        net.Start("PARIS_AddBlipTOHUD")
            net.WriteTable(
                {
                    VectorOrEntity = self,
                    Mat = Mat,
                    ID = BlipID,
                    Scale = Scale,
                    Color = Color,
                    Follow = Follow,
                    FadeDist = FadeDist,
                    Zone = Zone
                }
            )
        net.Send(Player)
    end)
end

function AddMapBlip(Vector, Mat, BlipID, Scale, Color, FadeDist, Zone, Follow)
    timer.Simple(1, function()
        net.Start("PARIS_AddBlipTOHUD")
            net.WriteTable(
                {
                    VectorOrEntity = Vector,
                    Mat = Mat,
                    ID = BlipID,
                    Scale = Scale,
                    Color = Color,
                    Follow = Follow,
                    FadeDist = FadeDist,
                    Zone = Zone
                }
            )
        net.Broadcast()
    end)
end

function AddMapBlipSpecificPlayer(Vector, Mat, BlipID, Scale, Color, FadeDist, Zone, Follow, Player)
    timer.Simple(1, function()
        net.Start("PARIS_AddBlipTOHUD")
            net.WriteTable(
                {
                    VectorOrEntity = Vector,
                    Mat = Mat,
                    ID = BlipID,
                    Scale = Scale,
                    Color = Color,
                    Follow = Follow,
                    FadeDist = FadeDist,
                    Zone = Zone
                }
            )
        net.Send(Player)
    end)
end

function RemoveBlip(BlipID)
    timer.Simple(1, function()
        net.Start("PARIS_RemoveBlipFROMHUD")
            net.WriteTable(
                {
                    ID = BlipID,
                }
            )
        net.Broadcast()
    end)
end

function PLAYER:RemoveBlip(BlipID)
    timer.Simple(1, function()
        net.Start("PARIS_RemoveBlipFROMHUD")
            net.WriteTable(
                {
                    ID = BlipID,
                }
            )
        net.Send(self)
    end)
end


hook.Add("PlayerInitialSpawn", "PARIS_AddBlipTOHUD", function(ply)
    ply:AddMapBlip("_playerMaterial", ply:UniqueID(), 25, Color(255,255,255,255), false, "*", true)
end)

util.AddNetworkString("PlayerEnteredVehicle")
hook.Add("PlayerEnteredVehicle", "PARIS_ServerToClientEnterVehicle", function(ply)
    net.Start("PlayerEnteredVehicle")
    net.Send(ply)
end)

util.AddNetworkString("PlayerLeaveVehicle")
hook.Add("PlayerLeaveVehicle", "PARIS_ServerToClientLeaveVehicle", function(ply)
    net.Start("PlayerLeaveVehicle")
    net.Send(ply)
end)


-- Blips system FOR ONLY ONES IN MAP FILE!!!!!

local Blips = {}

util.AddNetworkString("SendBlipsToClient")

local function SendEverybodyUpdatedBlips()
    net.Start("SendBlipsToClient")
        net.WriteTable(Blips)
    net.Broadcast()
end

local function SendUpdatedBlips(ply)
    net.Start("SendBlipsToClient")
        net.WriteTable(Blips)
    net.Broadcast()
end

hook.Add("PlayerInitialSpawn", "GiveBlipsOnJoin", function(ply)
    net.Start("SendBlipsToClient")
        net.WriteTable(Blips)
    net.Send(ply)
end)

util.AddNetworkString("RequestNewBlips")
net.Receive("RequestNewBlips", function(len,ply)

    net.Start("SendBlipsToClient")
        net.WriteTable(Blips)
    net.Send(ply)

end)

local function ReloadBlips()

    if  !file.Exists("gtahud", "DATA") then
        file.CreateDir("gtahud")
    end

    if file.Exists("gtahud/"..game.GetMap()..".json", "DATA") then
        local data = file.Read("gtahud/"..game.GetMap()..".json", "DATA")
        local tab = util.JSONToTable(data)
        if tab and istable(tab) then
            Blips = tab
        elseif data != "" then
            Error("ERROR: gtahud/"..game.GetMap()..".json is not JSON formatted! Failed to load blips!\n")
        elseif !data then
            file.Write("gtahud/"..game.GetMap()..".json", "{}")
        end
    else
        file.Write("gtahud/"..game.GetMap()..".json", "{}")
    end

    SendEverybodyUpdatedBlips()

end

ReloadBlips()