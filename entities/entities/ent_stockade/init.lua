AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/winningrook/gtav/stockade/stockade.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	

    self.Quantity = (team.NumPlayers(TEAM_BANK_SECURITY) * 3) - (team.NumPlayers(TEAM_BANK_SECURITY)-1)
    self.Served = 0
    self.Delivered = 0

    self.VaultPoints = {
        Vector(-1789,2977,-262),
        Vector(-1827,2976,-262),
        Vector(-1865,2977,-262),
        Vector(-1864,2980,-230),
        Vector(-1829,2978,-230),
        Vector(-1789,2980,-230),
        Vector(-1860,3517,-262),
        Vector(-1817,3518,-262),
        Vector(-1781,3517,-262),
        Vector(-1785,3517,-230),
        Vector(-1820,3526,-230),
        Vector(-1859,3515,-230),
        Vector(-1574,3404,-238),
        Vector(-1520,3406,-238),
        Vector(-1450,3539,-262),
        Vector(-1520,3537,-262),
        Vector(-1568,3535,-262),
        Vector(-1633,3536,-262),
        Vector(-1627,3534,-230),
        Vector(-1564,3535,-230),
        Vector(-1524,3534,-230),
        Vector(-1451,3533,-230),
        Vector(-1518,2980,-238),
        Vector(-1572,2981,-238),
        Vector(-1639,2849,-262),
        Vector(-1563,2848,-262),
        Vector(-1525,2847,-262),
        Vector(-1447,2850,-262),
        Vector(-1452,2850,-230),
        Vector(-1528,2850,-230),
        Vector(-1567,2849,-230),
        Vector(-1639,2849,-230),
    }

end

function ENT:Use(activator, caller)
	if (!activator:IsPlayer()) then return end
    
    if( self.Open ) then self:SetBodygroup(2, 0) self:SetBodygroup(3, 0) else self:SetBodygroup(2, 1) self:SetBodygroup(3, 1) end    

    if self.Served >= self.Quantity then 
        for _, v in pairs( team.GetPlayers(TEAM_BANK_SECURITY) ) do
            v:Notify("All money has been served.")
        end
        return 
    end
    if ( activator:Team() == TEAM_BANK_SECURITY ) then
        if activator:GetPos():Distance(self:GetAngles():Forward()*-150+self:GetPos()) > 50 then return end
        if not self.Open then
            activator:SetVelocity(activator:GetAngles():Forward()*-500)
            timer.Simple(0.5, function()
                self.Served = self.Served + 1
                local money = ents.Create("ent_money")
                local vp = math.random(1, #self.VaultPoints)
                activator:Notify("Money has been served - take it to the correct position in the vault to get paid.")
                money:SetNWVector("VaultPoint",self.VaultPoints[vp])
                money:SetNWBool("IsDelivered", false)
                money.Stockade = self
                table.remove(self.VaultPoints, vp)
                money:SetPos(self:GetAngles():Forward()*-150+self:GetPos())
                money:SetAngles(self:GetAngles())
                money:Spawn()
            end)
        end
    elseif( activator:Team() == TEAM_CITIZEN ) then
        activator:ChatPrint("dont rob me foo")
    end

    self.Open = not self.Open

end

--[[hook.Add("GravGunPickupAllowed", "EntMoneyAllowPickup", function(ply,ent)
    return ent:GetClass() == "ent_money"
end)]]

hook.Add("GravGunOnPickedUp", "EntMoneyOnPickup", function(ply,ent)
    if ent:GetClass() == "ent_money" and ply:Team() == TEAM_BANK_SECURITY then
        if( ent:GetNWBool("IsDelivered") ) then return end
        ply:SetNWEntity("MoneyPickedUp", ent)
    end
end)

hook.Add("GravGunOnDropped", "EntMoneyOnDropped", function(ply,ent)
    if ent:GetClass() == "ent_money" and ply:Team() == TEAM_BANK_SECURITY then
        ply:SetNWEntity("MoneyPickedUp", NULL)
        if ent:GetPos():Distance(ent:GetNWVector("VaultPoint")) < 20 then
            if( ent:GetNWBool("IsDelivered") ) then return end
            ply:Notify("You have been paid $100 for delivering the money!")
            ply:GiveBank(100)
            ent:SetNWBool("IsDelivered", true)
            if not IsValid(ent.Stockade) then return end
            ent.Stockade.Delivered = ent.Stockade.Delivered + 1
            if ent.Stockade.Delivered >= ent.Stockade.Quantity then
                for _, v in pairs( team.GetPlayers(TEAM_BANK_SECURITY) ) do
                    v:Notify("All of the money has been delivered - great work!")
                    v:ChatPrint("All of the money has been delivered - great work!")
                end
                timer.Destroy("MoneyMission")
                ent.Stockade:Remove()
            end
        end
    end
end)