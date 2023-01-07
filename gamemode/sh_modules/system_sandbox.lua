---------------------------

// Resource: sh_sandbox
// Creator: Predator
// Org: aSocket.net // PredatorNetwork.com

---------------------------


if CLIENT then
    // CLIENT SIDE SANDBOX
    local pets = {
        {
            ["Name"] = "Rat",
            ["Price"] = "50",
            ["Model"] = "models/tsbb/animals/rat.mdl"
        }, 
        {
            ["Name"] = "Cat",
            ["Price"] = "30",
            ["Model"] = "models/tsbb/animals/rat.mdl"
        }, 
        {
            ["Name"] = "Dog",
            ["Price"] = "20",
            ["Model"] = "models/tsbb/animals/rat.mdl"
        }, 
    }
    net.Receive( "petShop", function( len, ply )

        print("Pet Shop!")
    end)
end

if SERVER then
    // SERVER SIDE SANDBOX
    util.AddNetworkString("petShop")
    --[[concommand.Add("spawn_friend", function( ply, cmd, args )
        print("Spawning friend")
        local pet = ents.Create( "pet" )
        pet:SetpetVars( ply, args )
        pet:SetPos( ply:GetPos() + Vector( -50, 0, 0 ) )
        pet:Spawn()
        
    
    end )
    
    concommand.Add("goodbye_friends", function()
        for k, v in pairs(ents.FindByClass("pet")) do
            v:Remove()
        end
    end)

    concommand.Add( "petShop", function( ply, cmd, args )
        net.Start( "petShop" )
        net.Send( ply )
    end)]]
end


if CLIENT then
    net.Receive("PERP_GoThirdPerson", function()
        local bool = net.ReadBool()
        if bool then
            hook.Add( "CalcView", "PERP_ThirdPerson", function( ply, pos, angles, fov )

                if IsValid(ply:GetVehicle()) then return end

                local endpos = pos - ( angles:Forward() * 90 )

                local t = util.TraceLine({start = pos, endpos = endpos, filter = {LocalPlayer()}})

                local view = {
                    origin = t.HitPos,
                    angles = angles,
                    fov = fov,
                    drawviewer = true
                }
            
                return view
            end )
        else
            hook.Remove( "CalcView", "PERP_ThirdPerson")
        end
    end)
end

if SERVER then
    util.AddNetworkString("PERP_GoThirdPerson")

    function PLAYER:SetThirdPerson(bool)
        net.Start("PERP_GoThirdPerson")
        net.WriteBool(bool)
        net.Send(self)
    end

    function PLAYER:ToggleHandsUp(arrestingtoggle)
        if IsValid(self:GetVehicle()) then return end
        if self.ArrestHands and not arrestingtoggle then return end
        self.Handsup = not self.Handsup
        if self.Handsup then
            self.OriginalWalkSpeed = self:GetWalkSpeed()
            self.OriginalRunSpeed = self:GetRunSpeed()
            self:SetThirdPerson(true)
            hook.Add("Think", "HandsupEquipFistsAlways"..self:SteamID(), function()
                if not IsValid(self) then return end
                if not self:LookupBone("ValveBiped.Bip01_L_Clavicle") then return end
                self:SelectWeapon("roleplay_fists")
                if self:KeyDown(IN_DUCK) then
                    self:SetWalkSpeed(1)
                    self:SetRunSpeed(1)
                    self:SetCanWalk(false)
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 0,0,-60 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 0,0,0 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( -30,0,60 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( 0,0,0 ) )
                else
                    self:SetWalkSpeed(30)
                    self:SetRunSpeed(60)
                    self:SetCanWalk(true)
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 50,0,-90 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 0,-90,0 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( -50,0,90 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( 0,-90,0 ) )
                end
            end)
        else
            self:SetWalkSpeed(self.OriginalWalkSpeed)
            self:SetRunSpeed(self.OriginalRunSpeed)
            self:SetCanWalk(true)
            self:SetThirdPerson(false)
            hook.Remove("Think", "HandsupEquipFistsAlways"..self:SteamID())
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( 0,0,0 ) )
        end
    end

    hook.Add("PlayerSay", "PERP_HandsUp", function(p,text,team)
        if string.StartWith(text, "/handsup") or string.StartWith(text, "/hu") then
            p:ToggleHandsUp()
        end
    end)
    concommand.Add("handsup", function(ply)
        ply:ToggleHandsUp()
    end)



    function PLAYER:ToggleArrestHands()
        if IsValid(self:GetVehicle()) then return end
        self.ArrestHands = not self.ArrestHands
        if self.Handsup then self:ToggleHandsUp(true) end
        if self.ArrestHands then
            self:SetThirdPerson(true)
            hook.Add("Think", "ArrestHandsEquipFistsAlways"..self:SteamID(), function()
                if not IsValid(self) then return end
                --self:SelectWeapon("roleplay_fists")
                if self:KeyDown(IN_DUCK) then
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 0,0,0 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 120,0,0 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( 0,0,-40 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( -90,0,0 ) )
                else
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 0,0,15 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 40,0,0 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( 0,0,-20 ) )
                    self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( -40,0,0 ) )
                end
            end)
        else
            self:SetThirdPerson(false)
            hook.Remove("Think", "ArrestHandsEquipFistsAlways"..self:SteamID())
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle( 0,0,0 ) )
            self:ManipulateBoneAngles( self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle( 0,0,0 ) )
        end
    end

end