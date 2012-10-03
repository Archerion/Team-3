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

enum Armors {
	Unarmored, 
	LightArmor, 
	HeavyArmor};

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
	local float SlowDuration;
	local float BurnDuration;

	if (DamageType == class 'WotSPRJBurnDamage')
	{
		Damage *= 0.7;
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
			Slow(50, SlowDuration);
			TakeFire(BurnDuration, 5, 0.5);		
	}
		
	else if(DamageType == class 'WotSPRJLightningDamage')
	{
		Stun(0.5);
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
			Damage = 15;
		} 
			
		else 
		{
			Damage = 10;
		}
	}
		
	else if(DamageType == class 'WotSSPLFrostDamage')
	{
		Stun(5);
	}	

	super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum,  DamageType, HitInfo, DamageCauser);
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

function Stun(float stunTime )
{	
	CustomTimeDilation = 0.0f;
	ClearTimer('UnStun');
	SetTimer(stunTime, false, 'UnStun');
}

function UnStun()
{
	CustomTimeDilation = 1.0f;
}

function InitializeArmor()
{
	switch (ArmorType)
		{
		case LightArmor:
			Health += 30;
			GroundSpeed *= 0.9;
			break;
		case HeavyArmor:
			Health += 60;
			GroundSpeed *= 0.8;
			break;
		}
		`log(""$ArmorType);
}

