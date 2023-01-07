--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_pipes/pipe03_connector01.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass(20)
	
	self:SetUseType(ONOFF_USE)
	self.Entity:GetPhysicsObject():Wake();
	self.WeldedItems = {}
	self.WeldedItemConstraints = {}
	self.VehicleWeld = nil
	self.NextAttach = CurTime()
	-- self:SetModelScale(2, 2)
	self:SetModelScale(2,0)
	Msg(self:GetBoneCount() .. "\n")
	for i=0, self:GetBoneCount() - 1 do
		MsgN(self:GetBoneName(i));
	end
	-- local matr = self:GetBoneMatrix(0) //6 is the head
	-- matr:Scale(Vector(2, 2, 0.5)) //Scale it by 2 on each axis.
	-- self:SetBoneMatrix(0, matr)
	-- local matr = self:GetBoneMatrix(1) //6 is the head
	-- matr:Scale(Vector(2, 2, 0.5)) //Scale it by 2 on each axis.
	-- self:SetBoneMatrix(1, matr)
	-- self:SetupBones( )
	
	
end

function ENT:Attach(obj)
	if(self.NextAttach > CurTime()) then return end

	-- if(!self.VehicleWeld) then return end
	
	// No attacking to other vehicles
	-- if ( obj:IsVehicle() ) then
		-- print("1")
		-- PrintTable(self)
		-- print(self.pickupPlayer:Nick())
		-- print(obj.owner:Nick() .. " - " .. " - " .. obj:GetNetworkedEntity("owner"):Nick())
		-- if ( obj.owner == self.Owner || obj:GetNetworkedEntity("owner") == self.Owner ) then 
			-- print("2"); return 
		-- end
	-- end
	-- bind backspace "ac_anti_nlr_kill_radius 25"
	//if ( not (obj.pickupPlayer == self.Owner) || not (obj:GetTable().ItemSpawner == self.Owner) || not (obj:GetTable().Owner == self.Owner) ) then print("2"); return end
	if (obj.IsWelded) then return end;
	
	// No, we can't attack to another luggage rack...
	if (obj:GetClass() == "ent_luggagelocker" || obj:GetClass() == "ent_towtruck") then return end;
	
	// No, we can't constrain an already constrained item...
	//if ( IsValid(constraint.FindConstraint( obj, "Weld" )) ) then return false end

	if ( obj:IsVehicle() && self.pickupPlayer == obj.owner ) then
		if (IsValid(self.VehicleWeld)) then
			return;
		else
			self.VehicleWeld = obj; //
			constraint.Weld(self, obj, 0, 0, 0, true)
			constraint.NoCollide( self, obj, 0, 0 );
			self:EmitSound("physics/metal/sawblade_stick1.wav")
			local eff = EffectData()
			eff:SetOrigin(self:GetPos())
			util.Effect("ManhackSparks", eff)
			self.pickupPlayer:ConCommand("-attack");
		end
	else
		if (IsValid(self.VehicleWeld) && !obj:IsVehicle()) then
			if (table.Count(self.WeldedItems) < 3) then
				obj.IsWelded = true
				table.insert(self.WeldedItems, obj)
				//table.insert(self.WeldedItemConstraints, 
				constraint.Weld(self, obj, 0, 0, 0, true) //)
				constraint.NoCollide( self, obj, 0, 0 );
				for k, v in pairs(self.WeldedItems) do
					constraint.NoCollide( v, obj, 0, 0 );
				end
				self:EmitSound("physics/metal/sawblade_stick1.wav")
				local eff = EffectData()
				eff:SetOrigin(self:GetPos())
				util.Effect("ManhackSparks", eff)
				self.pickupPlayer:ConCommand("-attack");
			else
				self.pickupPlayer:Notify("You may only attach 3 items.");
			end
		else
			if ( !IsValid(self.VehicleWeld) ) then
				self.pickupPlayer:Notify("You must first attach this Luggage Rack to a vehicle you own before attaching a maximum of 3 items.");
			end
		end
	end
	
	-- self:GetPhysicsObject():SetMass(500)
	
	-- if(obj:IsVehicle()) then
		-- obj:Fire("HandBrakeOff", "", 0)
	-- end
end

function ENT:Detach()
	if (IsValid(self.VehicleWeld)) then
		constraint.RemoveAll(self)
		self.VehicleWeld = nil
		self.NextAttach = CurTime() + 2
	end
	
	if (table.Count(self.WeldedItems) > 0) then
		for k, v in pairs(self.WeldedItems) do
			if (IsValid(v)) then
				constraint.RemoveAll(v);
				v.IsWelded = false
				table.remove(self.WeldedItems, k);
				//table.remove(self.WeldedItemConstraints, k);
				self.NextAttach = CurTime() + 2
			end
		end
		self.WeldedItems = {}
		//self.WeldedItemConstraints = {}
	end
	-- self:GetPhysicsObject():SetMass(20)
end

function ENT:Think()
	self:Extinguish()
	
	if(not IsValid(self.VehicleWeld) || (IsValid(self.VehicleWeld) && self.VehicleWeld.Disabled) ) then
		self:Detach()
	end
end

function ENT:Use(activator, caller)
	//if(not activator:IsPlayer()) then return end
	//if(activator:GetPos():Distance(self:GetPos()) > 100) then return end
	//if (activator != self.Owner) then activator:Notify("Hands off, you're not the owner."); return end
	if (activator == self.pickupPlayer) then
		self:Detach()
		
		if (activator:KeyDown(IN_WALK)) then
			activator:GiveItem(self.pickupTable, 1, true);
			self:Remove();
		end	
	end
end

function ENT:StartTouch(obj)
	-- if(obj == self.VehicleWeld) then return end
	-- if(obj == self.Pulley) then return end
	-- if(obj == self.Controller) then return end
	-- if(obj == self.Controller) then return end
	-- if(obj == self.Beam) then return end
	
	//if(self:GetVelocity():Length() > 50) then return end
	if(obj:GetPhysicsObject() and not obj:IsPlayer() and obj != game.GetWorld()) then
		self:Attach(obj)
		if(self:IsPlayerHolding()) then
			self:GetPhysicsObject():EnableMotion(false)
			timer.Simple(0.5, function()
				self:GetPhysicsObject():EnableMotion(true)
			end)
		end
	end
end

hook.Add("GravGunOnPickedUp", "luggagelockerGravGunOnPickedUp", function(objPl, obj)
	if(obj:GetClass() == "ent_luggagelocker") then
		if(obj.VehicleWeld != nil) then
			return false
		end
	end
end)

