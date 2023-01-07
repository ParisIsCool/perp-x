
local AutoUnlockedDoors = {}
AutoUnlockedDoors["rp_southside"] = {
	{pos=Vector(7690,7955,252), model="*375"},
	{pos=Vector(7690,7853,252), model="*374"},
	{pos=Vector(7866,7768,256), model="*377"},
	{pos=Vector(7974,7768,256), model="*376"},
}

local function UnlockMapDoors()
	for _, d in pairs(AutoUnlockedDoors[game.GetMap()] or {}) do
		for _, ent in pairs(ents.FindInSphere(d.pos, 50)) do
			if ent:IsDoor() and ent:GetModel() == d.model then
				ent:Fire("unlock")
			end
		end
	end
end
hook.Add("PostInitEntity", "UnlockMapDoors", UnlockMapDoors)
hook.Add("OnReloaded", "UnlockMapDoors", UnlockMapDoors)