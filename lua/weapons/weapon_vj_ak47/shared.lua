SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "AK-47"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 1 -- Default is 1, The scale of the viewmodel sway
SWEP.UseHands					= true
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel					= "models/vj_weapons/w_csgo_ak47.mdl"
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(-8, 90, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-3.4, -1, -0.5)
SWEP.HoldType 					= "ar2"
SWEP.ViewModelFlip				= false -- Flip the model? Usally used for CS:S models
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 5 -- Damage
SWEP.Primary.PlayerDamage		= "Double" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 0.3 -- How much recoil does the player get?
SWEP.Primary.Delay				= 0.1 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"vj_weapons/ak47/ak47_single.wav"}
SWEP.Primary.DistantSound		= {"vj_weapons/ak47/ak47_single_dist.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "RifleShellEject"
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Reload_TimeUntilAmmoIsSet	= 1.8 -- Time until ammo is set to the weapon
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnFireAnimationEvent(pos, ang, event, options)
	if event == 5001 then return true end -- Asiga hose vor shtke gedervadz flash-e
end