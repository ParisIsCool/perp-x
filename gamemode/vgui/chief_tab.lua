--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


local PANEL = {};

function PANEL:FillWarrentList ( )
	self.OffenderList_W:Clear()
	
	self.panelListInfo_W = {};
		
	for k, v in pairs(player.GetAll()) do
		if (v != LocalPlayer() && v:Team() == TEAM_CITIZEN) then
			local warrentText = "No"
			if (v:GetNetworkedBool("warrent", false)) then
				warrentText = "Yes"
			end
			
			if (self.overrideWarrent && self.overrideWarrent == v:UniqueID()) then
				warrentText = "Yes"
			end
		
			self.panelListInfo_W[tonumber(self.OffenderList_W:AddLine(v:GetRPName(), warrentText):GetID())] = v:UniqueID();
		end
	end
end

function PANEL:FillGovOfficialsList ( )
	self.OffenderList_D:Clear()
	
	self.panelListInfo_D = {};
		
	for k, v in pairs(player.GetAll()) do
		if (v != LocalPlayer() && v:Team() != TEAM_CITIZEN) then
			if (!self.overrideOfficial || self.overrideOfficial != v:UniqueID()) then
				self.panelListInfo_D[tonumber(self.OffenderList_D:AddLine(v:GetRPName(), team.GetName(v:Team())):GetID())] = v:UniqueID();
			end
		end
	end
end

function PANEL:AddConVarBar ( parent, name, default, min, max, conVar, upGM )
	local newBar = vgui.Create("DNumSlider", parent);
	newBar:SetText(name);
	newBar:SetMin(min or 0);
	newBar:SetMax(max or 1);
	newBar:SetDecimals(0);
	newBar:SetValue(default);
	parent:AddItem(newBar);
	
	table.insert(self.conVarBars, {newBar, default, conVar, upGM})
end

function PANEL:Think ( )
	for _, each in pairs(self.conVarBars) do
		local curVal = each[1]:GetValue()
		
		if (curVal != each[2]) then
			RunConsoleCommand(each[3], curVal)
			if (each[4]) then GAMEMODE[each[4]] = curVal end
			self.checkText = 0
			each[2] = curVal
		end
	end
	
	
end

function PANEL:Init ( )
	self.conVarBars = {}
	
	self:SetTitle("Chief Commands");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("perp2")
	
	self.PropertySheet = vgui.Create("DPropertySheet", self);
	
	// Warrent Page
	self.warrentList = vgui.Create("DPanelList", self)
	self.warrentList:SetPadding(5);
	self.warrentList:SetSpacing(5);
	
	self.WarrentButton = vgui.Create("DButton", self.warrentList);
	self.WarrentButton:SetText("Warrant Citizen");
	function self.WarrentButton.DoClick ( )
		GAMEMODE.LastWarrentPlayer = GAMEMODE.LastWarrentPlayer or 0;
		
		if (GAMEMODE.LastWarrentPlayer > CurTime()) then
			LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastWarrentPlayer - CurTime()) .. " seconds before warranting another player.");
			return;
		end
					
		GAMEMODE.LastWarrentPlayer = CurTime() + 10;
		
		self.overrideWarrent = self.panelListInfo_W[self.OffenderList_W:GetSelectedLine()]
			
		RunConsoleCommand("perp_g_w", self.panelListInfo_W[self.OffenderList_W:GetSelectedLine()], self.AdditionalComments_W:GetValue());
		
		self:FillWarrentList()
	end
	self.warrentList:AddItem(self.WarrentButton);
	
	self.AdditionalComments_W = vgui.Create("DTextEntry", self.warrentList);
	self.AdditionalComments_W:SetText("Warrant Reason ( Keep This Short )");
	self.warrentList:AddItem(self.AdditionalComments_W);
	
	self.OffenderList_W = vgui.Create("DListView", self.warrentList)
	self.OffenderList_W:SetMultiSelect(false);
	self.OffenderList_W:AddColumn("Citizen");
	self.OffenderList_W:AddColumn("Currently Warranted");
	self.warrentList:AddItem(self.OffenderList_W)

	self:FillWarrentList()
	
	self.warrentList:PerformLayout();
	
	// Government Officials Demoting
	
	self.officialsList = vgui.Create("DPanelList", self)
	self.officialsList:SetPadding(5);
	self.officialsList:SetSpacing(5);
	
	self.DemoteButton = vgui.Create("DButton", self.officialsList);
	self.DemoteButton:SetText("Fire Police Department Member");
	function self.DemoteButton.DoClick ( )
		GAMEMODE.LastDemotePlayer = GAMEMODE.LastDemotePlayer or 0;
		
		if (GAMEMODE.LastDemotePlayer > CurTime()) then
			LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastDemotePlayer - CurTime()) .. " seconds before demoting another player.");
			return;
		end
		
		GAMEMODE.LastDemotePlayer = CurTime() + 60;
			
		RunConsoleCommand("perp_g_d_pc", self.panelListInfo_D[self.OffenderList_D:GetSelectedLine()], self.AdditionalComments_D:GetValue());
		
		self.overrideOfficial = self.panelListInfo_D[self.OffenderList_D:GetSelectedLine()]
		self:FillGovOfficialsList()
	end
	self.officialsList:AddItem(self.DemoteButton);
	
	self.AdditionalComments_D = vgui.Create("DTextEntry", self.officialsList);
	self.AdditionalComments_D:SetText("Demote Reason ( Keep This Short )");
	self.officialsList:AddItem(self.AdditionalComments_D);
	
	self.OffenderList_D = vgui.Create("DListView", self.officialsList)
	self.OffenderList_D:SetMultiSelect(false);
	self.OffenderList_D:AddColumn("Police Department Member");
	self.OffenderList_D:AddColumn("Position");
	self.officialsList:AddItem(self.OffenderList_D)

	self:FillGovOfficialsList()
	
	self.officialsList:PerformLayout();
	
	// Pop them all in
	self.PropertySheet:AddSheet("Warrants", self.warrentList);
	self.PropertySheet:AddSheet("Police Dept. Employees", self.officialsList);
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.PropertySheet:StretchToParent(5, 30, 5, 5)
	
	self.OffenderList_W:SetHeight(self:GetTall() - 75);
	self.OffenderList_D:SetHeight(self:GetTall() - 75);
	
	self.BaseClass.PerformLayout(self);
end

--function PANEL:Paint(width, height) //13
	--self.BaseClass.Paint(self);
function PANEL:Paint( w,h  )
	self.BaseClass.Paint( self, w, h )
end

vgui.Register("perp2_chief_tab", PANEL, "DFrame");