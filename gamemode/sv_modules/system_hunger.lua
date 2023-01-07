util.AddNetworkString("HungerNotification") 
util.AddNetworkString("setTired") 

local PLAYER = FindMetaTable("Player")

function PLAYER:GetHunger()
    return self:GetNWFloat("Hunger")
end 

function PLAYER:GetSaturation()
    return self:GetNWFloat("Saturation")
end

function PLAYER:CheckHungerStatus( dmghook )
end

function PLAYER:SetHunger( value )
    self:SetNWFloat("Hunger", value)
end

-- Add HP - Hunger
function PLAYER:AddHunger( value )   
    local Hunger = self:GetHunger()
    if Hunger >= 100 and Hunger + value >= 100 and value > 0 then -- If you're at 100 hunger and you try to eat. 
        self:Notify("You can't consume anymore, you might explode!")
		net.Start( "perp_puke" )
            net.WriteEntity(self)
        net.Send(self)
        if (self:Health() - 10 >= 1) then self:SetHealth(self:Health() - 10) end
        return 
    elseif Hunger + value <= 0 then -- If you go below 0 hunger.
        self:SetHunger(0)
        return 
    elseif Hunger + value < Hunger then -- If hunger is being taken. 
        if self:GetSaturation() > value then
            self:SetSaturation( self:GetSaturation() + value )
        else
            self:SetHunger( self:GetHunger() + value + self:GetSaturation() )
            self:SetSaturation( 0 )
        end
        return
    --[[elseif (Hunger >= 95) then -- If you try to eat past 95 hunger points.
        if Hunger + value > Hunger then
            self:Notify("You're too full to eat again.")
            return
        end]]
    elseif Hunger + value >= 100 then -- If eating takes you to 100 or past 100 | Eat Food
        -- CONSUME FOOD
        self:SetHunger(100)
        self:AddSaturation( math.floor(value/2) ) -- saturation x2 as hard to obtain, as it heals you quicker.
        self:Notify("You're full.")
        return 
    elseif Hunger + value > Hunger then -- If you're adding hunger | Consume food, Add Hunger, Add Sat.
        -- CONSUME FOOD
        self:SetHunger(self:GetHunger() + value)
    end
end 

function PLAYER:SetSaturation( value )
    self:SetNWFloat("Saturation", value)
end

function PLAYER:AddSaturation( value )   
    local Saturation = self:GetSaturation()
    local Hunger = self:GetHunger()
    if Saturation >= 25 and Saturation + value >= 25 then -- If you're at max saturation.
        self:Notify("Your Saturation is already full.")
        -- Happy stomach noises
        return
    elseif Saturation + value >= 25 then -- If eating takes you to or past 25 
        self:SetNWFloat("Saturation", 25)
        self:Notify("You're fully saturated, and feeling great.")
        return
    elseif Saturation == 0 then
        if Saturation + value > Saturation and Hunger < 95 then -- If it's adding
            self:SetNWFloat( "Saturation", self:GetSaturation() + value )
        else
            return false
        end
    elseif Saturation <= 0 then -- If there is saturation, subtract from saturation then subtract leftover from hunger.
        value = value - Saturation
        self:SetNWFloat("Saturation", 0)
        if value >= 1 then 
            self:AddHunger( value )
        else
            return false
        end
    elseif (Saturation + value < Saturation) then -- If removing saturation. 
        self:SetNWFloat( "Saturation", self:GetSaturation() + value )
        --return true
    else
        self:SetNWFloat("Saturation", self:GetSaturation() + value)
    end
    --self:CheckHungerStatus()
end

local rate = 0
hook.Add("Think", "Hungry", function()

    if CurTime() < rate then 
        return
    else
        for k, v in pairs ( player.GetAll() ) do

            if v:GetNWBool("isAFK") then continue end

            local amount = -0.015

            if v.hlastpos then
                if not IsValid(v:GetVehicle()) and v:GetMoveType() == MOVETYPE_WALK then
                    amount = amount * (math.Clamp(v.hlastpos:Distance(v:GetPos())/5000,0.01,0.1)) * 1.5 * 60
                end
            end

            v:AddHunger( amount * 1 )
            if v.AdminHunger then v:SetHunger( 100 ) continue end

            if v:Health() < v:GetMaxHealth() then
                local multiplier = 1
                if v:GetSaturation() > 0 then
                    multiplier = 2
                end
                local amt = ((v:GetSkillLevel(SKILL_HEALING) * 0.1) + 1) * multiplier
                if v:GetSaturation() > 0 then
                    v:SetNWFloat("Saturation",math.Clamp(v:GetNWFloat("Saturation")-amt, 0, 100))
                else
                    v:SetNWFloat("Hunger",math.Clamp(v:GetNWFloat("Hunger")-amt, 0, 100))
                end
                v:SetHealth(v:Health()+(amt*1))
                v:GiveExperience( SKILL_HEALING, 0.5 )
            end

            v.hlastpos = v:GetPos()

        end
    end        

    rate = CurTime() + 1

end)

hook.Add("PostEntityTakeDamage", "checkSatRegen", function(target)
    if target:IsPlayer() then
        if target:Alive() then
            target:CheckHungerStatus( true )
        end
    end
end )

hook.Add("PlayerInitialSpawn", "SetInitialHunger", function(ply)
    ply:SetHunger(100)
    ply:SetSaturation(0)
end)

concommand.Add("adminhunger", function(ply)
    if not ply:IsAdmin() then return end
    ply.AdminHunger = true
    ply:SetHunger(100)
end)

-- Set food to SetSat and AddHunger IN THAT ORDER 