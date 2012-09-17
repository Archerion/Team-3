class UTWeap_ManaRifleLightning extends UTWeap_LinkGun;


var float UsedAmmo;
var float AddedAmmoCostOverTime;
var float TimeCounter;
var float ManaUsePerSecond;

DefaultProperties
{
	WeaponFireTypes(0) = EWFT_Projectile;
	WeaponProjectiles(0)=class'UTProj_MagicalLightningBullet'
	WeaponProjectiles(1)=class'UTProj_MagicalLightningSpell'

	FireInterval(0)=+0.77
	//FireInterval(1)=+0.6

	ShotCost(0) = 0;
	ShotCost(1) = 0;
	InventoryGroup=1

	BeamAmmoUsePerSecond = 5;
	ManaUsePerSecond = 5;
	AddedAmmoCostOverTime = 0;
	TimeCounter = 0;
	UsedAmmo = 0;
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
				PC.TakeMana(PrimaryCost);
				Super.FireAmmunition();
		}
	}
}

simulated function ProcessBeamHit(vector StartTrace, vector AimDir, out ImpactInfo TestImpact, float DeltaTime)
{
	local MagicalPlayerController PC;
	PC = MagicalPlayerController(GetALocalPlayerController());
	
	UsedAmmo = ManaUsePerSecond * DeltaTime + AddedAmmoCostOverTime * DeltaTime;
	TimeCounter += DeltaTime;

	if(TimeCounter >= 0.5)
	{
		AddedAmmoCostOverTime += 5;
		TimeCounter = 0;
	}

	if (PC.CheckMana() >= UsedAmmo)
	{
		`log("Used Mana:	"$UsedAmmo);
		`log("Mana use per second:	"$UsedAmmo*(1/DeltaTime));
		`log("Remaining Mana:	"$Pc.CheckMana());
		PC.TakeMana(UsedAmmo);
		Super.ProcessBeamHit(StartTrace, AimDir, TestImpact, DeltaTime);
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

simulated function UpdateBeamEmitter(vector FlashLocation, vector HitNormal, actor HitActor)
{
	local MagicalPlayerController PC;
	PC = MagicalPlayerController(GetALocalPlayerController());
	
	if (PC.CheckMana() >= UsedAmmo)
	{
		super.UpdateBeamEmitter(FlashLocation, HitNormal, HitActor);
	}
}