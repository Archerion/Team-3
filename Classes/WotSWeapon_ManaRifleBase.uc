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

var bool bIsOnCooldown;
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

function int GetLevel()
{
	return WeaponLevel;
}


simulated function FireAmmunition()
{
	local SorcererPawn SP;
	SP = SorcererPawn(SorcererPlayerController(GetALocalPlayerController()).Pawn);	


	if (CurrentFireMode == 0)
	{
		if (!bIsOnCooldown)
		{
			if (SP.CheckMana() >= WeaponManaCost.Primary)
			{
				SP.TakeMana(WeaponManaCost.Primary);
				Super.FireAmmunition();
				Heat += 1;
				`log("heat: "$Heat);
				if (Heat >= MaximumHeat)
				{
					overheat();
				}
			}
		}
	}
	if (CurrentFireMode == 1)
	{
		if (!bIsOnCooldown)
		{
			if (SP.CheckMana() >= WeaponManaCost.Secondary)
			{
				SP.TakeMana(WeaponManaCost.Secondary);
				Super.FireAmmunition();
			}
		}
	}
}

function overheat()
{
	local int i;
	bIsOnCooldown = true;
	`log("Weapon is on cooldown for: "$3);
	for (i = 0;i < 3*10;i++)
	{
	SetTimer(i, false, 'coolOneHeat');
	}
}

function coolOneHeat()
{
	Heat-=1;
	if (Heat == 0)
	{
		bIsOnCooldown = false;
	}
}

function stopCooldown()
{
	`log("Weapon no longer on cooldown;");
	bIsOnCooldown = false;
	Heat = 0;
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
	bIsOnCooldown = false;

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);
}