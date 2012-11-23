class WotSPawn extends UTPawn
	abstract;

var(Mana) bool bUsesMana;
var(Mana) float ManaRechargeRate;
var(Mana) float MaxMana;
var float CurrentMana;
var float TimeSinceRecharged;
var float BurnDamage;
var float BurnTimer;
var float TimeBetweenIterations;
var vector BurnVector;
var float ExpWorth;

enum Armors {
	Unarmored, 
	LightArmor, 
	HeavyArmor
};

var Armors ArmorType;

defaultproperties
{
	bUsesMana = False;
	ManaRechargeRate = 1.0;
	TimeSinceRecharged = 0.0;
	CurrentMana = 100;   
	MaxMana = 100;
	BurnDamage = 0;
	BurnTimer = 0;
	ArmorType = LightArmor;
	ExpWorth = 100;
}

simulated function PostBeginPlay()
{
	InitializeArmor();
	super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
	local SorcererPlayerController PC;

	foreach LocalPlayerControllers(class'SorcererPlayerController', PC)
	{
	
		TimeSinceRecharged += DeltaTime;
		if (TimeSinceRecharged >= 0.20)
		{
			GiveMana(1);
			TimeSinceRecharged = 0.0;
		}
	}
	Super.Tick(DeltaTime);
}

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Damage = ModifyDamage(Damage, EventInstigator, DamageType);

	super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum,  DamageType, HitInfo, DamageCauser);
}

function int ModifyDamage(int Damage, Controller EventInstigator, class <DamageType> DamageType)
{	

	// Default damage: 35
	local float SlowDuration;
	local float BurnDuration;

	if (DamageType == class 'WotSPRJBurnDamage')
	{
		Damage = 35;
	}
		
	else if (DamageType == class 'WotSSPLBurnDamage')
	{
		BurnDuration = 3;
		SlowDuration = 3;
			
		if (ArmorType == HeavyArmor)
		{
			BurnDuration = 6;
			SlowDuration = 6;
		}
			Slow(0.5, SlowDuration);
			TakeFire(BurnDuration, 5, 0.5);		
	}
		
	else if(DamageType == class 'WotSPRJLightningDamage')
	{
		MookBot(Controller).Stun(0.5);
	}
		
	else if(DamageType == class 'WotSSPLLightningDamage')
	{
		if (ArmorType == LightArmor)
		{
			Damage = 10;
		}
			
		else
		{
			Damage = 5;
		}
	}
		
	else if(DamageType == class 'WotSPRJFrostDamage')
	{
		if (ArmorType == Unarmored)
		{
			Damage = 45;
		} 
		else 
		{
			Damage = 35;
		}
	}
		
	else if(DamageType == class 'WotSSPLFrostDamage')
	{
		MookBot(Controller).Stun(5);
	}	
	else if(DamageType == class 'WotSPRJSpikeDamage')
	{
		Damage = 75;
	}
	else if (DamageType == class'WotSPRJRangedMookDamage')
	{
		Damage = 20;
	}
	return Damage;
}

function bool died(Controller Killer, class<DamageType> damageType, Vector HitLocation)
{
	if(damageType == class'WotSPRJFrostDamage' || damageType == class'WotSSPLFrostDamage')
		WotSWeapon_ManaRifleFrost(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleFrost')).AddXPToWeapon(ExpWorth);
	
	else if(damageType == class'WotSPRJLightningDamage' || damageType == class'WotSSPLLightningDamage')
		WotSWeapon_ManaRifleLightning(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleLightning')).AddXPToWeapon(ExpWorth);
	
	else if(damageType == class'WotSPRJBurnDamage' || damageType == class'WotSSPLBurnDamage')
		WotSWeapon_ManaRifleFire(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleFire')).AddXPToWeapon(ExpWorth);

	return super.died(Killer, damageType, HitLocation);
}
	

function float GiveMana(float Amount)
{
	CurrentMana += Amount;
	
	if (CurrentMana > MaxMana)
	{
		CurrentMana = MaxMana;
	}
	return CurrentMana;
}

function float TakeMana(float Amount)
{
	CurrentMana -= Amount;
	if (CurrentMana < 0)
	{
		CurrentMana = 0;
	}
	return CurrentMana;
}

function float CheckMana()
{
	return CurrentMana;
}

function TakeFire(float Duration, float DamagePerIteration, float tBtwItr)
{
	BurnDamage = DamagePerIteration ;
	BurnTimer = Duration;
	TimeBetweenIterations = tBtwItr;
	SetTimer(TimeBetweenIterations, true, 'TakeBurnDamage');
}

function TakeBurnDamage()
{
	if (BurnTimer > 0)
	{	
		BurnTimer -= TimeBetweenIterations;
		TakeDamage(BurnDamage, None, BurnVector*0, BurnVector*0, class 'WotSPRJBurnDamage',, self);
	}
	else 
	{
		ClearTimer('TakeBurnDamage');
	}
}

function Slow(float SlowAmount, optional float SecondsToBeSlowed = 0)
{
	GroundSpeed *= 1-SlowAmount;
	AirSpeed *= 1-SlowAmount;
	WaterSpeed *= 1-SlowAmount;
	Mesh.GlobalAnimRateScale *= 1-SlowAmount;
	ClearTimer('UnFreeze');
	if (SecondsToBeSlowed > 0)
	{
		SetTimer(SecondsToBeSlowed, false, 'UnSlow');
	}
}

function UnSlow()
{
	Mesh.GlobalAnimRateScale = Mesh.Default.GlobalAnimRateScale;
	GroundSpeed = Default.GroundSpeed;
	AirSpeed = Default.AirSpeed;
	WaterSpeed = Default.WaterSpeed;
}

function InitializeArmor()
{
	switch (ArmorType)
		{
		case LightArmor:
			Health += 30;
			HealthMax += 30;
			GroundSpeed *= 0.9;
			break;
		case HeavyArmor:
			Health += 60;
			HealthMax += 60;
			GroundSpeed *= 0.8;
			break;
		}
}
