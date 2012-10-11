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

var int Heat;
var int MaximumHeat;
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

simulated function FireAmmunition()
{
	Super.FireAmmunition();
	Heat += 1;
	if (Heat >= MaximumHeat)
	{
		startCooldown(5);
	}
}

function startCooldown(int seconds)
{
	clearTimer(stopCooldown);
	SetTimer(seconds, false, 'stopCooldown');
}

function stopCooldown()
{

}

defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	FireInterval(0)=+1.25
	FireInterval(1)=+0.5

	ShotCost(0)=0
	ShotCost(1)=0

	Heat = 0
	WeaponLevel = 1
	WeaponExperience = 0
	MaximumHeat = 10

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);
}