AddCSLuaFile()
include("zrmine/sh/zrmine_config.lua")
AddCSLuaFile("zrmine/sh/zrmine_config.lua")
TOOL.Category = "Zeros RetroMiningSystem"
TOOL.Name = "#OreSpawner"
TOOL.Command = nil
TOOL.ConfigName = nil
TOOL.ClientConVar["type"] = "Random"
TOOL.ClientConVar["amount"] = 5000

local function loadFonts()
	surface.CreateFont("my_font01", {
		font = "Arial",
		extended = false,
		size = 35,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false
	})
end

if (CLIENT) then
	loadFonts()
	hook.Add("InitPostEntity", "zrmine_LoadFonts", loadFonts)
	language.Add("tool.zrmine_orespawner.name", "Zeros Retro MiningSystem - Ore Spawner")
	language.Add("tool.zrmine_orespawner.desc", "Creates a Resource Ore")
	language.Add("tool.zrmine_orespawner.0", "LeftClick: Creates a Resource Ore.")
end


function TOOL:LeftClick(trace)
	local trEnt = trace.Entity
	if (trEnt:IsPlayer()) then return false end
	if (CLIENT) then return end
	local tool_rType = self:GetClientInfo("type")
	local tool_rAmount = self:GetClientNumber("amount", 3)

	if (tool_rType == 1) then
		if (SERVER) then
			zrmine.f.Notify(self:GetOwner(), "Select a Resource Type First!", 1)
		end

		return
	end

	if (trEnt:GetClass() == "worldspawn") then
		--This prevents the creation of Spawner that are too close to others
		local ahzdistance
		local pos = trace.HitPos

		for a, b in pairs(ents.FindByClass("zrms_ore")) do
			if not b:IsValid() then return end

			if pos:Distance(b:GetPos()) <= 100 then
				ahzdistance = true

				if (SERVER) then
					zrmine.f.Notify(self:GetOwner(), "Too Close to other Spawn!", 1)
				end

				break
			end
		end

		if ahzdistance then return false end
		local ent = ents.Create("zrms_ore")
		if (not ent:IsValid()) then return end
		ent:SetPos(pos + Vector(0, 0, 1))
		local ang = Angle(0, 0, 0)
		ang:RotateAroundAxis(Vector(0, 0, 1), math.random(0, 360))
		ent:SetAngles(ang)
		ent:SetResourceType(tool_rType)
		ent:SetResourceAmount(tool_rAmount)
		ent:Spawn()
		ent:Activate()
		ent:SetMax_ResourceAmount(tool_rAmount)
		undo.Create("zrms_ore")
		undo.AddEntity(ent)
		undo.SetPlayer(self:GetOwner())
		undo.Finish()

		if (SERVER) then
			zrmine.f.Notify(self:GetOwner(), "New Resource Spawn created!", 0)
			self:GetOwner():ConCommand("zrmine_spawn")
		end

		return true
	else
		if (trEnt:GetClass() == "zrms_ore") then
			trEnt:SetResourceType(tool_rType)
			trEnt:SetResourceAmount(tool_rAmount)
			trEnt:SetMax_ResourceAmount(tool_rAmount)
			trEnt:UpdateVisuals()

			if (SERVER) then
				zrmine.f.Notify(self:GetOwner(), "Resource Spawn Updated!", 0)
				self:GetOwner():ConCommand("zrmine_spawn")
			end

			return true
		else
			return false
		end
	end
end

function TOOL:RightClick(trace)
	if (trace.Entity:IsPlayer()) then return false end
end

function TOOL:Deploy()
end

function TOOL:Holster()
end


function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Text = "#tool.zrmine_orespawner.name",
		Description = "#tool.zrmine_orespawner.desc"
	})

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})

	local combobox = CPanel:ComboBox("Resource Type", "zrmine_orespawner_type")
	combobox:AddChoice("Random")
	combobox:AddChoice("Coal")
	combobox:AddChoice("Iron")
	combobox:AddChoice("Bronze")
	combobox:AddChoice("Silver")
	combobox:AddChoice("Gold")
	CPanel:NumSlider("Resource Amount", "zrmine_orespawner_amount", 25, 10000, 0)

	CPanel:AddControl("label", {
		Text = "Tip: When creating Bronze,Silver or Gold Ore´s make sure do not set the Amount too High."
		})

		CPanel:AddControl("label", {
			Text = "Recommended: 100-200"
		})

		CPanel:AddControl("label", {
			Text = "-------------------------------------------------------------------"
		})

		CPanel:AddControl("label", {
			Text = "Saves all Ore Spawners that are currently on the Map"
		})

		CPanel:Button("Save Ore Spawner", "zrmine_spawn")
	end
