AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("10x25MM", "10x25MM Rounds", 10, 25)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Glock 20"
	
	SWEP.IconLetter = "c"
	killicon.AddFont("cw_p99", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end
	
	SWEP.MuzzleAttachmentName = "muzzle"
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 2, z = -8}
		
	SWEP.IronsightPos = Vector(-1.43, -0.755, 0.54)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.43, 2, 0.104)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-1.43, -0.755, 0.175)
	SWEP.RMRAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.735, -7, -4.69)
	SWEP.SprintAng = Vector(58.433, 0, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "glock_slide"
	SWEP.BoltShootOffset = Vector(0, 1.2, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = false
	SWEP.BoltReloadOffset = Vector(0, 1.39, 0)
	SWEP.EmptyBoltHoldAnimExclusion = "fire_last"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = false
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "glock_main", pos = Vector(0, 4.4, 0.2), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "glock_main", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.15, 0.15, 0.15)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "glock_slide", pos = Vector(-0.015, -1.25, 0.3), angle = Angle(0, 0, 0), size = Vector(0.25, 0.25, 0.25)},
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "glock_slide", pos = Vector(0.2175, 2.15, -3.15), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "glock_main", pos = Vector(0, 1.15, 0.275), angle = Angle(0, 90, 0), size = Vector(0.095, 0.095, 0.095)}
	}
	
	SWEP.LaserPosAdjust = Vector(0, 0, -0.75)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.SightsBGs = {main = 3, regular = 0, tritiumsights = 1}
	
	
	SWEP.CustomizationMenuScale = 0.0075
end

SWEP.ShootWhileProne = true
SWEP.MuzzleVelocity = 375 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.BarrelBGs = {main = 2, rpk = 1, short = 4, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, heavy = 1, foldable = 2}
SWEP.ReceiverBGs = {main = 4, rpk = 1, regular = 0}
SWEP.SightsBGs = {main = 3, regular = 0, tritiumsights = 1}

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-400, -500}, atts = {"md_tundra9mm"}},
	[2] = {header = "Sight", offset = {100, -400}, atts = {"bg_glocktrit", "md_rmr", "md_microt1"}},
	[3] = {header = "Rail", offset = {-600, -100}, atts = {"md_insight_x2"}},
	[4] = {header = "Sleeve", offset = {400, 250}, atts = {"bg_sleeveak"}},
	[5] = {header = "NOMEN", offset = {-100, 200}, atts = {"md_fastreloadgl"}},
	["+reload"] = {header = "Ammo", offset = {500, -100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	reload_empty = "reload_empty",
	fire = {"fire_1", "fire_2"},
	fire_dry = "fire_last",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.4, sound = Sound("FAS2_GLOCK20.MagOut")},
	[2] = {time = 0.9, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.7, sound = Sound("FAS2_GLOCK20.MagIn")}},
	
	reload_nomen = {[1] = {time = 0.2, sound = Sound("MagPouch_Pistol")},
	[2] = {time = 0.6, sound = Sound("FAS2_GLOCK20.MagOut")},
	[3] = {time = 1.05, sound = Sound("FAS2_GLOCK20.MagIn")}},
	
	reload_empty_nomen = {[1] = {time = 0.2, sound = Sound("MagPouch_Pistol")},
	[2] = {time = 0.6, sound = Sound("FAS2_GLOCK20.MagOut")},
	[3] = {time = 1.05, sound = Sound("FAS2_GLOCK20.MagIn")},
	[4] = {time = 1.2, sound = Sound("FAS2_GLOCK20.SlideRelease")}},
	
	reload_empty = {[1] = {time = 0.4, sound = Sound("FAS2_GLOCK20.MagOut")},
	[2] = {time = 0.9, sound = Sound("MagPouch_Pistol")},
	[3] = {time = 1.55, sound = Sound("FAS2_GLOCK20.MagIn")},
	[4] = {time = 1.85, sound = Sound("FAS2_GLOCK20.SlideRelease")}}}
	


SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/view/pistols/glock20.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_glock18.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.FireDelay = 0.13
SWEP.FireSound = "CW_GLOCK20_FIRE"
SWEP.FireSoundSuppressed = "CW_GLOCK20_FIRE_SUPPRESSED"
SWEP.Recoil = 0.8

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadHalt = 2.3

SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt_Empty = 2.6

SWEP.SnapToIdlePostReload = false