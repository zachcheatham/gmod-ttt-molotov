
AddCSLuaFile()

SWEP.HoldType			= "grenade"

if CLIENT then
	SWEP.PrintName	 	= "Molotov Cocktail"
	SWEP.Slot		 	= 7

	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "A fire grenade that explodes on impact lighting terrorists on fire and creating a large radius of fire."
	};

	SWEP.Icon 			= "vgui/ttt/icon_nades"
end

SWEP.Base				= "weapon_tttbasegrenade"
SWEP.Spawnable 			= true

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_flashbang.mdl"
SWEP.Weight				= 5
SWEP.AutoSpawnable		= false
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
	return "ttt_molotov_proj"
end
