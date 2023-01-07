AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "BT MP9"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "d"
	killicon.Add("cw_tr09_mp9", "vgui/kills/cw_tr09_mp9_kill", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_tr09_mp9_select")
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -5, y = -1.5, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87
	
	SWEP.IronsightPos = Vector(-2.762, -2.5, 0.560)
	SWEP.IronsightAng = Vector(-0.08, -0.38, 5)
	SWEP.ZoomAmount = 5
	SWEP.FOVPerShot = 0.45
	
	SWEP.MicroT1Pos = Vector(-2.695, 0.5, -0.16)
	SWEP.MicroT1Ang = Vector(0, 0, 5)
	
	SWEP.CmorePos = Vector(-2.675, -4, -0.2)
	SWEP.CmoreAng = Vector(0, 0, 5)
	
	SWEP.WS_CMOREPos = Vector(-2.665, -4, -0.22)
	SWEP.WS_CMOREAng = Vector(0, 0, 5)
	
	SWEP.WS_BarskaPos = Vector(-2.695, -4, -0.19)
	SWEP.WS_BarskaAng = Vector(0, 0, 5)
	
	SWEP.ReflexPos = Vector(-2.7, -4.2, -0.035)
	SWEP.ReflexAng = Vector(0, 0, 5)
	
	SWEP.CoD4ReflexPos = Vector(-2.675, -4.5, 0.01)
	SWEP.CoD4ReflexAng = Vector(0, 0, 5)
	
	SWEP.TrijiconPos = Vector(-2.63, -4.2, -0.145)
	SWEP.TrijiconAng = Vector(0, 0, 5)
		
	SWEP.EoTechPos = Vector(-2.66, -3.5, -0.325)
	SWEP.EoTechAng = Vector(0, 0, 5)
	
	SWEP.EoTech553Pos = Vector(-2.68, -4, -0.22)
	SWEP.EoTech553Ang = Vector(0, 0, 5)
	
	SWEP.WS_EoTech557Pos = Vector(-2.675, -3.5, -0.3)
	SWEP.WS_EoTech557Ang = Vector(0, 0, 5)
	
	SWEP.HoloPos = Vector(-2.64, -3.5, -0.27)
	SWEP.HoloAng = Vector(0, 0, 5)
	
	SWEP.AimpointPos = Vector(-2.675, -4.2, -0.12)
	SWEP.AimpointAng = Vector(0, 0, 5)
	
	SWEP.FAS2AimpointPos = Vector(-2.675, -4, -0.04)
	SWEP.FAS2AimpointAng = Vector(0, 0, 5)
	
	SWEP.SprintPos = Vector(2, 0, -1)
	SWEP.SprintAng = Vector(-10, 35, -10)
	
	SWEP.AlternativePos = Vector(-0.7, 0.4, -0.45)
	SWEP.AlternativeAng = Vector(0, 0, 4)
	
	SWEP.CustomizePos = Vector(3.640, -0.5, -0.84)
	SWEP.CustomizeAng = Vector(17.096, 35.118, 10)

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 3, roll = 1, forward = 1, pitch = 1}
	SWEP.SprintViewNormals = {x = 1, y = -1, z = 1}

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "gun", pos = Vector(0, -0.322, 2.42), angle = Angle(0, 180, 0), size = Vector(0.35, 0.349, 0.349)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "gun", pos = Vector(0.23, -8.462, -6.659), angle = Angle(2.7, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_ws_c_more"] = { type = "Model", model = "models/attachments/white_snow/ws_c_more.mdl", bone = "gun", rel = "", pos = Vector(-0.05, 0.317, 2.37), angle = Angle(0, 0, 0), size = Vector(0.22, 0.22, 0.22)},
		["md_ws_barska"] = { type = "Model", model = "models/attachments/white_snow/ws_barska.mdl", bone = "gun", rel = "", pos = Vector(-0.010, 0.239, 2.360), angle = Angle(0, 0, 0), size = Vector(0.16, 0.16, 0.16)},
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "gun", rel = "", pos = Vector(0.01, 2.6, 1.9), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint_rigged.mdl", bone = "gun", rel = "", pos = Vector(0.01, 2.7, 1.7), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		--["md_fas2_holo"] = {model = "models/v_holo_sight_kkrc.mdl", bone = "gun", rel = "", pos = Vector(0.01, -1.9, -1.06), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_ws_scifi_silencer"] = { type = "Model", model = "models/attachments/White_Snow/ws_scifi_silencer.mdl", bone = "gun", rel = "", pos = Vector(-4.58, -47.6, -8.41), angle = Angle(0, 0, 0), size = Vector(1.7, 1.7, 1.7)},
		--["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "gun", rel = "", pos = Vector(0, -2.4, 0.28), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "gun", pos = Vector(-0.175, -3.917, -1.693), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7)},
		["md_ws_eotech557"] = {model = "models/attachments/ws_eotech557.mdl", bone = "gun", pos = Vector(-0.77, -6.09, -2.44), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "gun", rel = "", pos = Vector(-0.01, 2.259, 2.46), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "gun", rel = "", pos = Vector(0, 0.319, 2.26), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "gun", rel = "", pos = Vector(0.04, 1.986, 0.3), angle = Angle(0, 0, 0), size = Vector(1.7, 1.7, 1.7)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "gun", pos = Vector(0, 9.078, 0.07), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)}
	}

	SWEP.LaserPosAdjust = {x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = 2, y = 180, r = 0}
	SWEP.CustomizationMenuScale = 0.013
end

SWEP.StockBGs = {main = 2, regular = 0, fold = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.AttachmentDependencies = {
	["md_ws_scifi_silencer"] = {"bg_tr09_mp9_chromosynth"}}

if CustomizableWeaponry_KK_HK416 and CustomizableWeaponry_G4P_UECW and CustomizableWeaponry_WS_Pack then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {50, -400}, atts = {"md_microt1", "md_cmore", "md_ws_c_more", "md_reflex", "md_ws_barska", "md_trijicon", "md_eotech", "md_fas2_eotech", "md_ws_eotech557", "md_aimpoint", "md_fas2_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm", "md_ws_scifi_silencer"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_WS_Pack and CustomizableWeaponry_KK_HK416 then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {150, -400}, atts = {"md_microt1", "md_ws_c_more", "md_ws_barska", "md_eotech", "md_fas2_eotech", "md_ws_eotech557", "md_aimpoint", "md_fas2_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm", "md_ws_scifi_silencer"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_G4P_UECW and CustomizableWeaponry_KK_HK416 then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {150, -400}, atts = {"md_microt1", "md_cmore", "md_reflex", "md_trijicon", "md_eotech", "md_fas2_eotech", "md_aimpoint", "md_fas2_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_WS_Pack and CustomizableWeaponry_G4P_UECW then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {150, -400}, atts = {"md_microt1", "md_cmore", "md_ws_c_more", "md_reflex", "md_ws_barska", "md_trijicon", "md_eotech", "md_ws_eotech557", "md_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm", "md_ws_scifi_silencer"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_KK_HK416 then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -400}, atts = {"md_microt1", "md_eotech", "md_fas2_eotech", "md_aimpoint", "md_fas2_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_G4P_UECW then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -400}, atts = {"md_microt1", "md_cmore", "md_reflex", "md_trijicon", "md_eotech", "md_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
elseif CustomizableWeaponry_WS_Pack then
	SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -400}, atts = {"md_microt1", "md_ws_c_more", "md_ws_barska", "md_eotech", "md_ws_eotech557", "md_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm", "md_ws_scifi_silencer"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
else
	SWEP.Attachments = {[1] = {header = "Sight", offset = {400, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
		[2] = {header = "Barrel", offset = {-300, -200}, atts = {"md_tundra9mm"}},
		[3] = {header = "Stock", offset = {950, 350}, atts = {"bg_tr09_mp9_stock"}},
		["impulse 100"] = {header = "Skin", offset = {950, 0}, atts = {"bg_tr09_mp9_tan", "bg_tr09_mp9_chromosynth"}},
		["+reload"] = {header = "Ammo", offset = {-300, 250}, atts = {"am_magnum", "am_matchgrade"}}
	}
end

SWEP.Animations = {fire = {"fire2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_MP9_DEPLOY"}},

	reload = {[1] = {time = 0.6, sound = "CW_MP9_CLIPOUT"},
	[2] = {time = 1.7, sound = "CW_MP9_CLIPIN"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 TheRambotnic09"

SWEP.Author			= "TheRambotnic09 & Niggarto el Negro"
SWEP.Contact		= ""
SWEP.Purpose		= "To kill bad guys. Duh!"
SWEP.Instructions	= "Press your primary PEW-PEW key to kill the bad guys."

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/therambotnic09/v_cw2_mp9.mdl"
SWEP.WorldModel		= "models/weapons/therambotnic09/w_cw2_mp9.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/therambotnic09/w_cw2_mp9.mdl"
SWEP.WMPos = Vector(-1, -0.5, -1)
SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.FireDelay = 0.0667
SWEP.FireSound = "CW_MP9_FIRE"
SWEP.FireSoundSuppressed = "CW_MP9_FIRE_SUPPRESSED"
SWEP.Recoil = 0.6

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 21
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 1
SWEP.ReloadTime_Empty = 1
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 2.4

if CLIENT then
    function SWEP:createCustomVM(mdl)
        self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
        self.CW_VM:SetNoDraw(true)
        self.CW_VM:SetupBones()
        self.CW_VM:SetOwner( self.Owner ) -- FIX: PlayerWeaponColor can't find owner for proxy.
       
        if self.ViewModelFlip then
            local mtr = Matrix()
            mtr:Scale(Vector(1, -1, 1))
           
            self.CW_VM:EnableMatrix("RenderMultiply", mtr)
        end
    end
end	