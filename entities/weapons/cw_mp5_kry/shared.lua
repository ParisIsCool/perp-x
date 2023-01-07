AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP5"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -1}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	
	SWEP.IronsightPos = Vector(-1.591, -2.406, 0.259)
	SWEP.IronsightAng = Vector(-0.101, 0, 0)
	
	SWEP.BaseArm = "arm_controller_01"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.62, 0, -0.83)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
		
	--SWEP.EoTechPos = Vector(2.042, -5.042, 0.014)
	--SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.601, -2, -0.85)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	--SWEP.ACOGPos = Vector(2.028, -5.613, -0.113)
	--SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(-1.61, -3.801, -0.60)
	SWEP.DocterAng = Vector(0, 0, 0)

	
	SWEP.SprintPos = Vector(0.602, 0.602, -1.005)
	SWEP.SprintAng = Vector(-15.478, 36.583, -22.514)

	SWEP.CustomizePos = Vector(7.519, -1.504, -0.301)
	SWEP.CustomizeAng = Vector(28.42, 41.053, 29.474)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.TrijiconSightPos = Vector(0, 0, 0)
	SWEP.TrijiconSightAng = Vector(0, 0, 0)
	
	SWEP.BarskaRDPos = Vector(-1.62, -3.2, -0.93)
	SWEP.BarskaRDAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.625, -3.422, -1.01)
	SWEP.KR_CMOREAng =  Vector(0.3, 0, 0.5)

	
	SWEP.KB4XPos = Vector(-1.601, -2.945, -0.801)
	SWEP.KB4XAng = Vector(0, 0, 0)

	SWEP.KB4XAxisAlign = {right = 0, up = 180, forward = 90 }

	--SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AttachmentModelsVM = {
		["kry_docter_sight"] = { type = "Model", model = "models/weapons/krycek/sights/docter_reddot.mdl", bone = "MP5Helper", pos = Vector(0.02, -3.1, 4.689), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85) },
		["kry_g3_claw_rail"] = { type = "Model", model = "models/weapons/krycek/kry_g3_claw_rail.mdl", bone = "MP5Helper", rel = "", pos = Vector(-1.67, 6.699, 4.4), angle = Angle(0, 90, 0), size = Vector(1.049, 1.049, 1.049) },
		["kry_mp5_laser"] = { type = "Model", model = "models/weapons/krycek/kry_mp5_laser.mdl", bone = "MP5Helper", pos = Vector(0, -8.4, 3.359), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "MP5Helper", pos = Vector(0.01, -2.3, 4.58), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.34)},
		--["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "MP5Helper", pos = Vector(-0.304, 10.126, -8.047), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "MP5Helper", rel = "", pos = Vector(-0.181, -7.4, 0.12), angle = Angle(0, 0, 0), size = Vector(0.76, 0.76, 0.76)},
		--["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "MP5Helper", pos = Vector(0.284, 4.372, -2.46), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_tundra9mm"] = { model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "MP5Helper", pos = Vector(0, -11.95, 2), angle = Angle(0, 0, 0),size = Vector(0.55, 0.55, 0.55) },
		["kry_mp5_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "MP5Helper", rel = "", pos = Vector(-0.301, -16.1, 0.2), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6) },
		["odec3d_barska_sight"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_barska_reddot.mdl", bone = "MP5Helper", rel = "", pos = Vector(0.02, -2.3, 4.97), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "MP5Helper", rel = "", pos = Vector(0.09, -3.2, 4.51), angle = Angle(0, 90, 0), size = Vector(0.242, 0.242, 0.242)},
		--["md_m203"] = { type = "Model", model = "models/weapons/krycek/launchers/m203_populik.mdl", bone = "MP5Helper", rel = "", pos = Vector(-2.3, 7.4, 5.3), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true }

	}
	
	SWEP.ForegripOverridePos = {
		["kry_mp5_forearm_slim"] = {
			["l_wrist"] = { pos = Vector(0, 0, 0), angle = Angle(-4.586, 0, 6.879) },
			["arm_controller_01"] = {pos = Vector(0, 0, 0.1), angle = Angle(0, 0, 0) } },
		
		["kry_mp5_forearm_grip"] = {
			["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.528, -11.322, 54.34) },
			["l_armtwist_2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 15.848) },
			["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(43.019, -47.548, -2.264) },
			["arm_controller_01"] = { scale = Vector(1, 1, 1), pos = Vector(0.8, -0.301, -0.755), angle = Angle(0, 0, 0) },
			["l_armtwist_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 36.226) },
			["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(15.848, -2.264, 0) } },
			
		["md_foregrip"] = {
			["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-9.101, -7.079, 53.596) },
			["l_middle_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(29.326, -17.191, 0) },
			["l_armtwist_2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 17.19) },
			["l_armtwist_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 31.347) },
			["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(39.437, -27.303, 0) },
			["arm_controller_01"] = { scale = Vector(1, 1, 1), pos = Vector(-0.6, -0.169, -1.101), angle = Angle(0, 0, 0) },
			["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(23.257, -1.012, 0) }
		},
		["kry_mp5sd_bt_barrel"] = {
			["l_thumb_tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.422, 7.412, 0) },
			["arm_controller_01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -0.959) },
			["l_thumb_mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.176, 1.059, 1.059) },
			["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-13.766, -1.06, 5.294) }
				}

		
		}
		
	SWEP.AttachmentDependencies = {}
	SWEP.AttachmentPosDependency = {}
	SWEP.AttachmentExclusions = {
	}
	
	SWEP.LaserPosAdjust = Vector(0, 0, -0.5)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
	
	--[[function SWEP:IndividualThink()
	if self.ActiveAttachments.md_m203 then
	self:setBodygroup(self.BarrelBGs.barrel, self.BarrelBGs.m203)
	self:setBodygroup(self.BarrelLengthBGs.barrels, self.BarrelLengthBGs.m203)
	self.FireSound = "KRY_MP5_FIRE_M203"
	else
		--if not self.ActiveAttachments.kry_mp5_forearm_slim and not self.ActiveAttachments.md_m203 then
		--self:setBodygroup(self.BarrelBGs.barrel, self.BarrelBGs.wide)
		--self:setBodygroup(self.BarrelLengthBGs.barrels, self.BarrelLengthBGs.standard)
		--end
		
	end
	
	end]]
	
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.BarrelBGs = {barrel = 2, wide = 0, wide_railed = 0, slim = 2, front_grip = 3 , sd = 5, sd_bt = 6, fab = 7}
SWEP.StocksBGs = {stock = 1, retractable = 0, rear_cap = 1, a2 = 2 }
SWEP.RailBGs = {main = 6, on = 1, off = 0}
SWEP.IronsightsBGs = {ironsights = 3, drum = 0, trij = 1}
SWEP.BarrelLengthBGs = {barrels = 5, standard = 0, hk94 = 1, sd = 2}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
[1] = {header = "Forearms", offset = {-420, 350}, atts = {"kry_mp5_forearm_slim", "kry_mp5_forearm_grip", "kry_mp5_forearm_fab"  }, exclusions = { kry_mp5_sd = true, kry_mp5_sd_bt = true}}, 
[2] = {header = "Laser sight", offset = {-200, -50}, atts = {"kry_mp5_laser"}},
[3] = {header = "Barrel", offset = {-100, -500}, atts = {"md_tundra9mm", "kry_mp5_longbarrel","kry_mp5_sd", "kry_mp5_sd_bt"}},
[4] = {header = "Tactical stuff", offset = {-700, -100}, atts = {"kry_mp5_foregrip"}, dependencies = {kry_mp5_forearm_fab=true, kry_mp5_sd_bt=true}},
[5] = {header = "Sights", offset = {700, -400}, atts = { "kry_docter_sight", "odec3d_barska_sight", "odec3d_cmore_kry", "md_microt1", "md_aimpoint" }}, 
[6] = {header = "Stock", offset = {800, 500}, atts = {"kry_mp5_tact_cap", "kry_mp5_a2_stock"}},

["+use"] = {header = "Ironsight", offset = {1000, 200}, atts = {"kry_mp5_sight_trij"}},
["+reload"] = {header = "Ammo", offset = {150, 400}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "freload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "KRY_MP5_FOLEY"}},

	freload = { [1] = {time = 0.1, sound = "KRY_MP5_RELOADFOLEY"},
	[2] = {time = 0.6, sound = "KRY_MP5_MAGOUT"},
	[3] = {time = 0.45, sound = "KRY_MP5_MAGINSERT"},
	[4] = {time = 2.0, sound = "KRY_MP5_MAGIN"}},
	
	reload = {  [1] = {time = 0.1, sound = "KRY_MP5_RELOADFOLEY"},
	[2] = {time = 0.4, sound = "KRY_MP5_BOLTBACK"},
	[3] = {time = 1.3, sound = "KRY_MP5_MAGOUT"},
	[4] = {time = 2.95, sound = "KRY_MP5_MAGINSERT"},
	[5] = {time = 3.1, sound = "KRY_MP5_MAGIN"},
	[6] = {time = 3.8, sound = "KRY_MP5_BOLTFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Krycek"

SWEP.Author			= "Krycek"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/krycek/v_kry_mp5_cw.mdl"
SWEP.WorldModel		= "models/weapons/krycek/w_cw_mp5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.FireDelay = 0.075
SWEP.FireSound = "KRY_MP5_FIRE"
SWEP.FireSoundSuppressed = "KRY_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.59

SWEP.HipSpread = 0.049
SWEP.AimSpread = 0.027
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.11
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.06
SWEP.Shots = 1
SWEP.Damage = 19
SWEP.DeployTime = 0.92

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 4.4