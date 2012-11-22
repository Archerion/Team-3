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
var float RequiredExpToLevel;

function AddXPToWeapon(int xp)
{
	WeaponExperience += xp;
	if(WeaponExperience >= RequiredExpToLevel && WeaponLevel < 3)
	{
		WeaponExperience -= RequiredExpToLevel;
		LevelUp();		
	}	
}

function int GetWeaponXP()
{
	return WeaponExperience;
}

function LevelUp()
{
	if (WeaponLevel < 3)
	{
		RequiredExpToLevel += 300;
		WeaponLevel += 1;
		WotSHUD(SorcererPlayerController(Instigator.Controller).myHUD).DisplayDialogText("Weapon level up!", "", 3.0f, true);
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

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
		if (SP.CheckMana() >= WeaponManaCost.Primary)
		{
			SP.TakeMana(WeaponManaCost.Primary);
			Super.FireAmmunition();
			`log("Weapon experience: "$WeaponExperience);
		}
	}
	if (CurrentFireMode == 1)
	{
		if (SP.CheckMana() >= WeaponManaCost.Secondary)
		{
			SP.TakeMana(WeaponManaCost.Secondary);
			Super.FireAmmunition();
		}
	}
}

defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	FireInterval(0)=+0.5
	FireInterval(1)=+1.25

	ShotCost(0)=0
	ShotCost(1)=0

	WeaponLevel = 1
	WeaponExperience = 0
	RequiredExpToLevel = 700;

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);

}