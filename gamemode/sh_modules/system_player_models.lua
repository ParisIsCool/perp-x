--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- Helpers
SEX_MALE = 1
SEX_FEMALE = 2
SEX_TO_STRING = {"m", "f"}

CAM_LOOK_AT = {}
CAM_LOOK_AT[SEX_MALE] = Vector(-1, 0, 67)
CAM_LOOK_AT[SEX_FEMALE] = Vector(-1, 0, 65)
CAM_LOOK_AT["f"] = CAM_LOOK_AT[SEX_FEMALE]
CAM_LOOK_AT["m"] = CAM_LOOK_AT[SEX_MALE]


-- Helper functions
function GM.ConvertModelInfo( json )
	local split = util.JSONToTable(json)
	if not split[1] then return split end
	local new = {}
	new.gender = split[1]
	new.face = split[2]
	new.clothes = split[3]
	new.skin = split[4]
	new.Custom = split[5]
	return new
end

function PLAYER:GetModelInfo()
	return self.ModelInfo or self:GetPNWVar("ModelInfo") or {}
end

function PLAYER:GetSex() return self:GetModelInfo().gender or SEX_MALE end 
function PLAYER:GetFace() return self:GetModelInfo().face or 1 end

function GetModelPath( sex, face )
	if type( sex ) == "string" then
		if sex == "f" then
			sex = SEX_FEMALE
		else
			sex = SEX_MALE
		end
	end

	return JOB_DATABASE[TEAM_CITIZEN]["Playermodels"][ sex ][ tonumber( face ) ]
end

function PLAYER:GetModelPath( sex, face )
	if self.ModelInfo and self.ModelInfo.Custom then
		 return self.ModelInfo.Custom 
	else 
		return GetModelPath( sex or self.ModelInfo.gender, face or self.ModelInfo.face ) 
	end
end