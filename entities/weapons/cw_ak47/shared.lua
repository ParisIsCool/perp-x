AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-47"
	SWEP.CSMuzzleFlashes = true
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end
	
	SWEP.MuzzleAttachmentName = "muzzle"
	
	SWEP.IronsightPos = Vector(-2.201, -4.646, 0.675)
	SWEP.IronsightAng = Vector(0.264, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.305, -2, -0.815)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.4, -3.493, -0.98)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-2.4325, -3, -0.165)
	SWEP.KobraAng = Vector(0.717, -0.638, 0)
	
	SWEP.ShortenedPos = Vector(-2.428, -4.005, 0.815)
	SWEP.ShortenedAng = Vector(0, -0.036, 0)
	
	SWEP.RPKPos = Vector(-2.418, -3.481, 0.93)
	SWEP.RPKAng = Vector(0.125, -0.25, 0)
	
	SWEP.PSOPos = Vector(-2.35, 0.15, -0.325)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = true
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.BoltBone = "ak_bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "ak_frame", pos = Vector(-0.325, 1, 0.85), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "ak_frame", pos = Vector(0, -10, 0), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "ak_frame", pos = Vector(-0.35, -5, -2.95), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "ak_frame", pos = Vector(4.151, -0.433, -2.721), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "FLASH", pos = Vector(1.9, 0, -0.95), angle = Angle(0, -90, 0), size = Vector(0.775, 0.775, 0.775)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "ak_frame", pos = Vector(0.3, 1.25, -1.333), angle = Angle(0, 180, 0), size = Vector(0.575, 0.575, 0.575)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "ak_frame", pos = Vector(-0.25, -3.25, -0.9), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "ak_frame", pos = Vector(-0.375, -3.75, -1.85), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)}
	}

	SWEP.ShortDotPos = Vector(-2.3, -3.0, -0.6)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ForeGripHoldPos = {
		["Left12"] = {pos = Vector(0, 0, 0), angle = Angle(19.048, 0, 0) },
		["Left19"] = {pos = Vector(0, 0, 0), angle = Angle(7.56, -5.153, -33.453) },
		["Left3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 98.859, 0) },
		["Left8"] = {pos = Vector(0, 0, 0), angle = Angle(28.447, 0, 0) },
		["Left18"] = {pos = Vector(0, 0, 0), angle = Angle(31.268, 8.871, -34.725) },
		["Left17"] = {pos = Vector(0, 0, 0), angle = Angle(4.524, 0.3, -39.885) },
		["Left11"] = {pos = Vector(0, 0, 0), angle = Angle(17.864, 0, 0) },
		["Left9"] = {pos = Vector(0, 0, 0), angle = Angle(8.972, 0, 0) },
		["Left_L_Arm"] = {pos = Vector(1.231, 2.617, -1.206), angle = Angle(0, 0, 84.377) },
		["Left24"] = {pos = Vector(0, 0, 0), angle = Angle(31.447, -4.021, -22.029) },
		["Left16"] = {pos = Vector(0, 0, 0), angle = Angle(7.047, 11.637, -22.139) },
		["Left14"] = {pos = Vector(0, 0, 0), angle = Angle(14.432, -4.611, 0) },
		["Left2"] = {pos = Vector(0, 0, 0), angle = Angle(0, 40.631, 0) },
		["Left_U_Arm"] = {pos = Vector(2.54, 0.004, 0), angle = Angle(0, 0, 0) }}
		
	SWEP.PSO1AxisAlign = {right = 0, up = 0.0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.AttachmentPosDependency = {["md_pbs1"] = {["bg_ak74_rpkbarrel"] = Vector(-28, 0, -0.816), ["bg_ak74_ubarrel"] = Vector(-14, 0, -0.88)}}
end

SWEP.MuzzleVelocity = 715 -- in meter/s

SWEP.LuaViewmodelRecoil = true

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

SWEP.BarrelBGs = {main = 2, rpk = 1, short = 4, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, heavy = 1, foldable = 2}
SWEP.ReceiverBGs = {main = 3, rpk = 1, regular = 0}
SWEP.MagBGs = {main = 4, regular = 0, rpk = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -400},  atts = {"md_kobra", "md_aimpoint", "md_schmidt_shortdot", "md_pso1"}},
	[2] = {header = "Barrel", offset = {-50, -350}, atts = {"md_pbs1"}},
	[3] = {header = "NOMEN", offset = {-100, 300}, atts = {"md_fastreload"}},
	[4] = {header = "Sleeve", offset = {600, 400}, atts = {"bg_sleeveak"}},
	["+reload"] = {header = "Ammo", offset = {800, 25}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "deploy"}
	
SWEP.Sounds = {	deploy = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 1, sound = Sound("Weapon_AK47.MagOut")},
	[2] = {time = 1.5, sound = Sound("MagPouch_AR")},
	[3] = {time = 2, sound = Sound("Weapon_AK47.MagIn")}},
	
	reload_nomen = {[1] = {time = 0.6, sound = Sound("Weapon_AK47.MagOut")},
	[2] = {time = 1.2, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.8, sound = Sound("Weapon_AK47.MagIn")}},
	
	reload_empty = {[1] = {time = 0.7, sound = Sound("Weapon_AK47.MagOutEmpty")},
	[2] = {time = 1.15, sound = Sound("MagPouch_AR")},
	[3] = {time = 1.85, sound = Sound("Weapon_AK47.MagIn")},
	[4] = {time = 2.9, sound = Sound("Weapon_AK47.BoltPull")}},
	
	reload_empty_nomen = {[1] = {time = 0.8, sound = Sound("MagPouch_AR")},
	[2] = {time = 1.5, sound = Sound("Weapon_AK47.MagOutEmptyNomen")},
	[3] = {time = 1.8, sound = Sound("Weapon_AK47.MagIn")},
	[4] = {time = 2.5, sound = Sound("Weapon_AK47.BoltPull")}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/view/rifles/ak47.mdl"
SWEP.WorldModel		= "models/weapons/w_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_AK47_FIRE"
SWEP.FireSoundSuppressed = "CW_AK47_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.048
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 39
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 0.85
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.3
SWEP.SnapToIdlePostReload = false

--Crotch Gun Fix
SWEP.Offset = {
Pos = {
Up = 0,
Right = 1,
Forward = -3,
},
Ang = {
Up = 0,
Right = 180,
Forward = 0,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end