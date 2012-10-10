class WotSWeapon_ManaRifleBase extends WotSWeapon
	abstract;

var int WeaponExperience;
var int WeaponLevel;
var int XPRequirementLevelTwo;
var int XPRequirementLevelThree;
var int WeaponRadiusDamage;

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

var ManaCost WeaponManaCost;
var float TimeToUpdateAmmo;

function GainExperience(int xp)
{
	WeaponExperience += xp;
	if (WeaponLevel == 2)
	{
		if (xp >= XPRequirementLevelThree)
		{
			LevelUp();
		}
	}
	if(WeaponLevel == 1)
	{
		if (xp >= XPRequirementLevelTwo)
		{
			LevelUp();
		}
	}
}

function LevelUp()
{
	`log("Leveled up");
	WeaponLevel += 1;
}

function int getWeaponExperience()
{
	return WeaponExperience;
}

function int getWeaponLevel()
{
	return WeaponLevel;
}

defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	WeaponProjectiles(0)=class'UTProj_LinkPlasma'
	WeaponProjectiles(1)=class'UTProj_LinkPlasma'

	FireInterval(0)=+0.77
	FireInterval(1)=+0.6

	WeaponExperience = 0;
	WeaponLevel = 1;
	XPRequirementLevelTwo = 100;
	XPRequirementLevelThree = 200;

	ShotCost(0)=0
	ShotCost(1)=0

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);
	WeaponRadiusDamage = 0;
}