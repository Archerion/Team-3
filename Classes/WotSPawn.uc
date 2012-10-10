class WotSPawn extends UTPawn
	abstract;

var(Mana) bool bUsesMana;
var(Mana) float ManaRechargeRate;
var(Mana) float MaxMana;
var float CurrentMana;
var float TimeSinceRecharged;
var float ModDamage;
var float BurnDamage;
var float BurnTimer;
var float TimeBetweenIterations;
var vector BurnVector;
var WotSArmor ArmorType;

defaultproperties
{
	bUsesMana = False;
	ManaRechargeRate = 1.0;
	TimeSinceRecharged = 0.0;
	CurrentMana = 100;   
	MaxMana = 100;
	BurnDamage = 0;
	BurnTimer = 0;
}

simulated function PostBeginPlay()
{
	ArmorType.SetArmorType(Unarmored);
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
	local SorcererPlayerController localPC;
	ModDamage = Damage;
	ArmorType.ModerateDamage(Damage, DamageType, self);
	localPC = SorcererPlayerController(GetALocalPlayerController());
	if (EventInstigator == localPC)
	{
		`log("Player was source of Damage! Add XP to his weapon.");
		WotSWeapon_ManaRifleBase(WotSPawn(localPC.Pawn).Weapon).GainExperience(100);
	}
	super.TakeDamage(ModDamage, EventInstigator, HitLocation, Momentum,  DamageType, HitInfo, DamageCauser);
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
	`log("Stunned for"$stunTime);
}

function UnStun()
{
	CustomTimeDilation = 1.0f;
	`log("Unstunned!");
}

function InitializeArmor()
{
	switch (ArmorType.TypeOfArmor)
		{
		case MediumArmor:
			Health += 30;
			GroundSpeed *= 0.9;
			break;
		case HeavyArmor:
			Health += 60;
			GroundSpeed *= 0.8;
			break;
		}
}

