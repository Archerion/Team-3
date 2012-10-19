class WotSWeapon_ManaRifleBase extends WotSWeapon
	abstract;

struct ManaCost
{
	var float Primary;
	var float Secondary;
	
	structdefaultproperties
	{
		Primary = 0;
		Secondary = 0;
	}
};

var int WeaponExperience;
var int WeaponLevel;
var ManaCost WeaponManaCost;
var float TimeToUpdateAmmo;

function AddXPToWeapon(int xp)
{
	WeaponExperience += xp;
}

function int GetWeaponXP()
{
	return WeaponExperience;
}

function LevelUp()
{
	if (WeaponLevel < 3)
	{
		WeaponLevel += 1;
	}
}

function int GetLevel()
{
	return WeaponLevel;
}

simulated function FireAmmunition()
{
	super.FireAmmunition();
	`log("Weapon experience: "$WeaponExperience);
}
defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	FireInterval(0)=+1.25
	FireInterval(1)=+1.25

	ShotCost(0)=0
	ShotCost(1)=0

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);

	WeaponLevel = 1;
}