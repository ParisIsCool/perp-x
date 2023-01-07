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

function PANEL:FillGovOfficialsFiremanList ( )
	self.OffenderFiremanList_D:Clear()
	
	self.panelListInfo_D = {};
		
	for k, v in pairs(player.GetAll()) do
		if (v != LocalPlayer() && v:Team() != TEAM_CITIZEN && v:Team() == TEAM_FIREMAN) then
		--if (v != LocalPlayer() && v:Team() == TEAM_FIREMAN) then
			if (!self.overrideOfficial || self.overrideOfficial != v:UniqueID()) then
				self.panelListInfo_D[tonumber(self.OffenderFiremanList_D:AddLine(v:GetRPName(), team.GetName(v:Team())):GetID())] = v:UniqueID();
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
	
	self:SetTitle("Fire Chief Demote firemen for bad job");
	self:ShowCloseButton(true);
	self:SetDraggable(false);
	self:SetAlpha(GAMEMODE.GetGUIAlpha());
	self:MakePopup()
	self:SetSkin("perp2")
	
	self.PropertySheet = vgui.Create("DPropertySheet", self);
			
	// Government Officials Demoting
	
	self.officialsFiremanList = vgui.Create("DPanelList", self)
	self.officialsFiremanList:SetPadding(5);
	self.officialsFiremanList:SetSpacing(5);
	
	self.DemoteButton = vgui.Create("DButton", self.officialsFiremanList);
	
	self.DemoteButton:SetText("Fire Department Member");
	function self.DemoteButton.DoClick ( )
		GAMEMODE.LastDemotePlayer = GAMEMODE.LastDemotePlayer or 0;
		
		if (GAMEMODE.LastDemotePlayer > CurTime()) then
			LocalPlayer():Notify("You must wait another " .. math.ceil(GAMEMODE.LastDemotePlayer - CurTime()) .. " seconds before demoting another player.");
			return;
		end
		
		GAMEMODE.LastDemotePlayer = CurTime() + 60;
			
		RunConsoleCommand("perp_g_d_fc", self.panelListInfo_D[self.OffenderFiremanList_D:GetSelectedLine()], self.AdditionalComments_D:GetValue());
		
		self.overrideOfficial = self.panelListInfo_D[self.OffenderFiremanList_D:GetSelectedLine()]
		self:FillGovOfficialsFiremanList()
	end
	self.officialsFiremanList:AddItem(self.DemoteButton);
	
	self.AdditionalComments_D = vgui.Create("DTextEntry", self.officialsFiremanList);
	self.AdditionalComments_D:SetText("Demote Reason ( Keep This Short )");
	self.officialsFiremanList:AddItem(self.AdditionalComments_D);
	
	self.OffenderFiremanList_D = vgui.Create("DListView", self.officialsFiremanList)
	self.OffenderFiremanList_D:SetMultiSelect(false);
	self.OffenderFiremanList_D:AddColumn("Fire Department Member");
	self.OffenderFiremanList_D:AddColumn("Position");
	self.officialsFiremanList:AddItem(self.OffenderFiremanList_D)

	self:FillGovOfficialsFiremanList()
	
	self.officialsFiremanList:PerformLayout();
	
	
	// Pop them all in
	--self.PropertySheet:AddSheet("Warrants", self.warrentList);
	self.PropertySheet:AddSheet("Fire Dept. Employees", self.officialsFiremanList);
	--self.PropertySheet:AddSheet("Funding", self.funding);
end

function PANEL:PerformLayout ( )
	self:SetSize(ScrW() * .5, ScrH() * .5);
	self:SetPos(ScrW() * .25, ScrH() * .25);
	
	self.PropertySheet:StretchToParent(5, 30, 5, 5)
	
	--self.OffenderList_W:SetHeight(self:GetTall() - 75);
	self.OffenderFiremanList_D:SetHeight(self:GetTall() - 75);
	
	self.BaseClass.PerformLayout(self);
end

--function PANEL:Paint(width, height) //13
	--self.BaseClass.Paint(self);
--end

function PANEL:Paint( w,h  )
	self.BaseClass.Paint( self, w, h )
end

vgui.Register("perp2_firechief_tab", PANEL, "DFrame");