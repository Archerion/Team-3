class UTWeap_ManaRifleLightning extends UTWeap_LinkGun;

var float UsedAmmo;
var float AddedAmmoCostOverTime;
var float TimeCounter;

DefaultProperties
{
	WeaponFireTypes(1) = EWFT_Projectile;
	WeaponProjectiles(0)=class'UTProj_MagicalLightningBullet'
	WeaponProjectiles(1)=class'UTProj_MagicalLightningSpell'

	FireInterval(0)=+0.1
	//FireInterval(1)=+0.6

	ShotCost(0) = 0;
	ShotCost(1) = 0;
	InventoryGroup=1

	BeamAmmoUsePerSecond = 10;
	AddedAmmoCostOverTime = 0;
	TimeCounter = 0;

}

simulated function FireAmmunition()
{
	local MagicalPlayerController PC;
	local float PrimaryCost;
	PC = MagicalPlayerController(GetALocalPlayerController());	
	PrimaryCost = 2;

	if (CurrentFireMode == 0)
	{
		if (PC.CheckMana() >= PrimaryCost)
		{
			if ( MagicalInventoryManager(PC.Pawn.InvManager).GetAmmoCount() > 0)
			{
				PC.TakeMana(PrimaryCost);
				Super.FireAmmunition();
			}
		}
	}
}

simulated function ProcessBeamHit(vector StartTrace, vector AimDir, out ImpactInfo TestImpact, float DeltaTime)
{
	local MagicalPlayerController PC;
	PC = MagicalPlayerController(GetALocalPlayerController());
	UsedAmmo = BeamAmmoUsePerSecond * DeltaTime + AddedAmmoCostOverTime;
	/*TimeCounter += DeltaTime;

	if(TimeCounter >= 0.5)
	{
		AddedAmmoCostOverTime += 5;
		TimeCounter = 0;
	}*/
	if (PC.CheckMana() >= UsedAmmo)
	{
		`log("Used Mana:	"$UsedAmmo);
		`log("Mana use per second:	"$UsedAmmo*(1/DeltaTime));
		`log("Remaining Mana:	"$Pc.CheckMana());
		if ( MagicalInventoryManager(PC.Pawn.InvManager).GetAmmoCount() > 0)
		{
			PC.TakeMana(UsedAmmo);
			Super.ProcessBeamHit(StartTrace, AimDir, TestImpact, DeltaTime);
		}

	}
	else
	{
		`log("BeamWeapon out of mana!");
		EndFire(1);
	}
}

simulated function EndFire(byte FireModeNum)
{
	AddedAmmoCostOverTime = 0;
	super.EndFire(FireModeNum);
}


