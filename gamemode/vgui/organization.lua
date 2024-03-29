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

local PANEL = {}

function PANEL:Init()
	self:SetTitle("Organizations")
	self:ShowCloseButton(true)
	self:SetDraggable(false)
	self:SetAlpha(GAMEMODE.GetGUIAlpha())
	self:MakePopup()
	
	local orgID = LocalPlayer():GetGNWVar( "org", 0 )
	if orgID == 0 then return end

	self:SetTitle( "Organizations - " .. GAMEMODE.OrganizationData[orgID][1] )
	
	self.isSetup = nil
		
	self.membersList = vgui.Create("DListView", self)
	self.membersList:SetMultiSelect(false)
	self.membersList_PlayerName = self.membersList:AddColumn('Organization Member')
	self.membersList_IsFriend = self.membersList:AddColumn('Is Currently Online')
	self.membersList_IsFriend:SetMinWidth(125)
	self.membersList_IsFriend:SetMaxWidth(125)
end

function PANEL:Setup()
	if (self.isSetup) then return end
	
	local orgID = LocalPlayer():GetGNWVar("org", 0)
	
	if (orgID == 0) then return end
	if(not self.membersList) then return end
	
	if (!GAMEMODE.OrganizationData[orgID] or !GAMEMODE.OrganizationData[orgID][2]) then
		self.membersList:StretchToParent(5, 60, 5, 5)
		return
	end
	
	self.isSetup = true
	
	self.memberInfo = {}
	for k, v in pairs(GAMEMODE.OrganizationData[orgID][5]) do
		local online = "No"
		local realName = v[1]
		for _, pl in pairs(player.GetAll()) do
			if pl:GetNWBool("Disguise2") then continue end
			if tostring(pl:SteamID()) == v[2] then
				online = "Yes"
				realName = pl:GetRPName()
				break
			end
		end
			
		
		self.memberInfo[tonumber(self.membersList:AddLine(realName, online):GetID())] = v[2]
	end
	
	self.membersList:SetVisible(true)
	if (GAMEMODE.OrganizationData[orgID][5]) then
		self.membersList:StretchToParent(5, 60, (self:GetWide() * .5) + 2.5, 5)
		
		self.pMembersList = vgui.Create("DListView", self)
		self.pMembersList:SetMultiSelect(false)
		self.pMembersList_PlayerName = self.pMembersList:AddColumn('Prospective Member')
		
		local bottomSpace = 20 * 3 + 5 * 4
		local midSpace = 30
		
		self.pMembersList:StretchToParent(self:GetWide() * .5 + 2.5, 60, 5, 15 + bottomSpace + midSpace)
		
		self.pMemberInfo = {}
		for k, v in pairs(player.GetAll()) do
			if v:GetNWBool("Disguise2") then continue end
			if (v:GetGNWVar("org", 0) == 0) then
				self.pMemberInfo[tonumber(self.pMembersList:AddLine(v:GetRPName()):GetID())] = v
			end
		end
		
		self.pList = vgui.Create("DPanelList", self)
		self.pList:SetPadding(5)
		self.pList:SetSpacing(5)
		self.pList:StretchToParent(self:GetWide() * .5 + 2.5, self:GetTall() - 5 - bottomSpace, 5, 5)
		
		self.mList = vgui.Create("DPanelList", self)
		self.mList:SetPadding(5)
		self.mList:SetSpacing(5)
		self.mList:EnableHorizontal(true)
		self.mList:SetPos(self:GetWide() * .5 + 2.5, self:GetTall() - 10 - bottomSpace - midSpace)
		self.mList:SetSize(self:GetWide() * .5 - 7.5, midSpace)
		
		local fWide = ((self:GetWide() * .5 - 7.5) - 15) * .5
		
		local nameChange = vgui.Create("DTextEntry", self)
		nameChange:SetText(GAMEMODE.OrganizationData[orgID][1])
		self.pList:AddItem(nameChange)
		
		local motdChange = vgui.Create("DTextEntry", self)
		motdChange:SetText(GAMEMODE.OrganizationData[orgID][2])
		self.pList:AddItem(motdChange)
		
		local changeButton = vgui.Create("DButton", self)
		changeButton:SetText("Save Changes")
		self.pList:AddItem(changeButton)
		
		local addButton = vgui.Create("DButton", self)
		addButton:SetText("Invite Player")
		addButton:SetWide(fWide)
		self.mList:AddItem(addButton)
		
		local remButton = vgui.Create("DButton", self)
		remButton:SetText("Remove Player")
		remButton:SetWide(fWide)
		self.mList:AddItem(remButton)
		
		function changeButton:DoClick ( )
			if (string.len(nameChange:GetValue()) < 3) then
				LocalPlayer():Notify("Your organization's name must be longer than that.")
				return
			end
		if (string.len(nameChange:GetValue()) > 19) then
				LocalPlayer():Notify("Your organization's name is too long.")
				return
			end
			
			RunConsoleCommand("perp_o_c", nameChange:GetValue(), motdChange:GetValue())
		end
		
		function addButton.DoClick ( )
			local selected = self.pMembersList:GetSelectedLine()
			
			if (self.pMemberInfo[selected] and IsValid(self.pMemberInfo[selected])) then
				RunConsoleCommand("perp_o_i", self.pMemberInfo[selected]:UniqueID())
			end
		end
		
		function remButton.DoClick ( )
			local selected = self.membersList:GetSelectedLine()
			
			if (self.memberInfo[selected]) then
				if (self.memberInfo[selected] == LocalPlayer():SteamID()) then
					LocalPlayer():Notify("You cannot kick yourself out of your organization!")
					LocalPlayer():Notify("If you wish to disband your organization, you can do so at the County Clerk.")
				else
					RunConsoleCommand("perp_o_r", self.memberInfo[selected])

					self.memberInfo[selected] = nil
					self.membersList:RemoveLine( selected )
				end
			end
		end
	else
		self.membersList:StretchToParent(5, 60, 5, 5)
	end
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5)
	self:SetPos(ScrW() * .25, ScrH() * .25)
	
	self.BaseClass.PerformLayout(self)
end

local rodUs
function PANEL:Paint( w, h )
	self.BaseClass.Paint( self, w, h )
	
	self:Setup()
	
	if (LocalPlayer():GetGNWVar("org", 0) == 0) then
		draw.SimpleText("You are not currently in an organization visit the County Clerk if you are interested in creating one.", "Default", self:GetWide() * .5, self:GetTall() * .5, Color(255, 255, 255, 255), 1, 1)
		return
	elseif (GAMEMODE.OrganizationData and GAMEMODE.OrganizationData[LocalPlayer():GetGNWVar("org", 0)]) then
		draw.SimpleText("MOTD: " .. GAMEMODE.OrganizationData[LocalPlayer():GetGNWVar("org", 0)][2], "Default", self:GetWide() * .5, 27, Color(255, 255, 255, 255), 1)
		draw.SimpleText("Owner: " .. GAMEMODE.OrganizationData[LocalPlayer():GetGNWVar("org", 0)][3], "Default", self:GetWide() * .5, 39, Color(255, 255, 255, 255), 1)
	elseif (!rodUs or rodUs ~= LocalPlayer():GetGNWVar("org", 0)) then
		rodUs = LocalPlayer():GetGNWVar("org", 0)
	end
end

vgui.Register("perp2_organization", PANEL, "DFrame")