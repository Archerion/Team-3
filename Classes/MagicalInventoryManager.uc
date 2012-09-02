class MagicalInventoryManager extends UTInventoryManager;

var int ManaRifleAmmo;
var int ManaRifleMaxAmmo;

defaultproperties
{
	bMustHoldWeapon = true;
	ManaRifleAmmo = 50;
	ManaRifleMaxAmmo = 80;
}

function AddAmmoToWeapon(int AmountToAdd, class<UTWeapon> WeaponClassToAddTo)
{
	AddManaRifleAmmo(AmountToAdd);
}

function int AddManaRifleAmmo(int AmountToAdd)
{
	`log("Current Ammo "$ManaRifleAmmo);
	`log("Adding "$AmountToAdd);
	ManaRifleAmmo = ManaRifleAmmo + AmountToAdd > ManaRifleMaxAmmo ? ManaRifleMaxAmmo : ManaRifleAmmo+AmountToAdd;
	return ManaRifleAmmo;
}

function int GetAmmoCount()
{
	return ManaRifleAmmo;
}

function int GetMaxAmmoCount()
{
	return ManaRifleMaxAmmo;
}