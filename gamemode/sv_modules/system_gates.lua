local controlleddoors = {}
local function AddControlledDoor(centerpoint, radius, locsnmodels, teams)
	local entry = {}
	entry.ents = {}
	for k,v in pairs(locsnmodels) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50))do
			if (ent:IsDoor() && (ent:GetModel() == v[2] || !v[2] && string.StartWith(ent:GetModel(), "*"))) then
				ent:Fire("lock", "", 0);
				table.insert(entry.ents, ent);
				break
			end
		end
	end
	entry.open = false;
	entry.radius = radius
	entry.centerpoint = centerpoint;
	entry.teams = teams;
	table.insert(controlleddoors, entry)
end

local controlledgates = {}
local function AddControlledGate(centerpoint, locsnmodels, teams, pointsndistances)
	local entry = {}
	entry.ents = {}
	for k,v in pairs(locsnmodels) do
		for _, ent in pairs(ents.FindInSphere(v[1], 150))do
			if (ent:IsDoor() && (ent:GetModel() == v[2] || !v[2] && string.StartWith(ent:GetModel(), "*"))) then
				ent:Fire("lock", "", 0);
				table.insert(entry.ents, ent);
				break
			end
		end
	end
	if(table.Count(entry.ents) == 0) then
		MsgN("Error adding controlled gate with center " .. tostring(centerpoint))
	end
	entry.open = false;
	entry.centerpoint = centerpoint;
	entry.teams = teams;
	entry.pointsndistances = pointsndistances;
	for k,v in pairs(pointsndistances) do
		if(entry.radius == nil || entry.radius < v[2]) then
			entry.radius = v[2]
		end
	end
	table.insert(controlledgates, entry)
end

local lastcheckeddoors = 0
hook.Add("Think", "ControlledDoorsThink", function()
	if(CurTime() - lastcheckeddoors < 0.5) then
		return;
	end
	for k,v in pairs(controlleddoors) do
		local open = false;
		for _,ply in pairs(ents.FindInSphere(v.centerpoint, v.radius)) do
			if(!IsValid(ply) || !ply:IsPlayer()) then continue; end
			open = true;
		end
		if(open != v.open) then
			v.open = open
			if(v.open) then
				for _, ent in pairs(v.ents) do
					ent:Fire('unlock', '', 0);
					ent:Fire('open', '', .1);
				end
			else
				for _, ent in pairs(v.ents) do
					ent:Fire('lock', '', 0);
					ent:Fire('close', '', .1);
				end
			end
		end
	end
	lastcheckeddoors = CurTime();
end)

local lastcheckedgates = 0
hook.Add("Think", "ControlledGateThink", function()
	if(CurTime() - lastcheckedgates < 0.2) then
		return;
	end
	for k,v in pairs(controlledgates) do
		local open = false;
		for _,ent in pairs(ents.FindInSphere(v.centerpoint, v.radius)) do
			if(!IsValid(ent) || ent:GetClass() != "prop_vehicle_jeep") then continue; end
			local min = Either(v.pointsndistances[1][1]:Distance(ent:GetPos()) < v.pointsndistances[2][1]:Distance(ent:GetPos()), v.pointsndistances[1], v.pointsndistances[2])
			local dist = ent:NearestPoint(v.centerpoint):Distance(v.centerpoint)
			if(dist <= min[2]) then
				if(v.open) then
					open = true
					break;
				end
				if(IsValid(ent:GetDriver()) && ent:GetDriver():IsPlayer()) then --&& table.HasValue(v.teams, ent:GetDriver():Team())) then
					open = true;
					break;
				end
			end
		end
		if(open != v.open) then
			v.open = open
			if(v.open) then
				for _, ent in pairs(v.ents) do
					ent:Fire('unlock', '', 0);
					ent:Fire('open', '', .1);
				end
			else
				for _, ent in pairs(v.ents) do
					ent:Fire('lock', '', 0);
					ent:Fire('close', '', .1);
				end
			end
		end
	end
	lastcheckedgates = CurTime();
end)

local function AddControlledGates()
	AddControlledDoor(Vector(-1844,6620,24), 350, {{Vector(-1896,6632,160), "*132"}}, {TEAM_CITIZEN})
	AddControlledDoor(Vector(-1900,6241,24), 350, {{Vector(-1896,6240,160), "*133"}}, {TEAM_CITIZEN})
	AddControlledDoor(Vector(-2977,3843,-75), 320, {{Vector(-2982,3840,-38), "*111"},}, {TEAM_CITIZEN, TEAM_ROADSERVICE})
	-- firedoor
	AddControlledDoor(Vector(9108,1285,-103), 320, {{Vector(9128,1288,-3), "*182"}}, {TEAM_CITIZEN, TEAM_ROADSERVICE})
	AddControlledDoor(Vector(9108,1773,-103), 320, {{Vector(9128,1791,-3), "*183"},}, {TEAM_CITIZEN, TEAM_ROADSERVICE})
	-- TEAM CHECKING IS DISABLED SO IT DOESN'T MATTER
end

hook.Add( "InitPostEntity", "controlledgates", function()
	AddControlledGates()
end)

hook.Add( "OnReloaded", "controlledgates", function()
	AddControlledGates()
end)