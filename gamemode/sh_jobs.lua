--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

SEX_MALE = 1
SEX_FEMALE = 2
SEX_TO_STRING = {"m", "f"}

JOB_DATABASE = {}
function GM:RegisterJob(JOB)
    JOB_DATABASE[JOB.ID] = JOB
    if JOB.Playermodels then
        for _, v in pairs(JOB.Playermodels[SEX_MALE] or {}) do util.PrecacheModel(v) end
        for _, v in pairs(JOB.Playermodels[SEX_FEMALE] or {}) do util.PrecacheModel(v) end
    end
    team.SetUp(JOB.ID, JOB.Name, JOB.Color)
end

function GM:IsTeamFull(TeamID)
    if not TeamID then return end
    if JOB_DATABASE[TeamID].MaxPlayers != true then
        if team.NumPlayers(TeamID) >= JOB_DATABASE[TeamID].MaxPlayers then
            return true
        else
            return false
        end
    end
end

if CLIENT then
    function GM:RequestJobJoin(Job)
        net.Start("perp_requestjobnpc")
            net.WriteInt(Job,32)
        net.SendToServer()
    end
    function GM:RequestJobLeave()
        net.Start("perp_leavejobnpc")
        net.SendToServer()
    end
    function GM:RequestJobVehicle(id)
        net.Start("perp_requestjobvehicle")
		net.WriteString(id)
		net.SendToServer()
    end
    function GM:RequestHolsterJobVehicle()
        net.Start("perp_requestholsterjobvehicle")
		net.SendToServer()
    end
    function GM:RequestJobAmmo(id)
        net.Start("perp_requestjobammo")
		net.SendToServer()
    end
end