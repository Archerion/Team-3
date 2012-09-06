class MagicalBotPawn extends UTPawn 
placeable;

var float BurningTime;
var int BurnDamage;
var float BurnTimer;
var vector BurnVector;
var class<DamageType> BurnDmgType;

enum ArmorType {
		Unarmored,
		LightArmor,
		MediumArmor,
		HeavyArmor
};

var ArmorType Armor;

defaultproperties
{
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	BurningTime = 0;
	BurnTimer = 1;
	BurnDamage = 5;	
	BurnDmgType = class'UTDmgType_Burning';
	Armor = HeavyArmor;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	Spawn(class'UTWeap_ShockRifle',,,Location).GiveTo(self);
	SpawnDefaultController();
	`log(">>>>>>>> Spawned controller:"@Controller);
}

function TakeFire(float Duration, int Damage)
{
	if (Armor == HeavyArmor)
	{   
		Duration *=2;
	}

	`log("Setting bot on fire!");
	BurnDamage = Damage;
	BurnTimer = Duration;
	SetTimer(1, true, 'TakeBurnDamage');
}

function TakeBurnDamage()
{
	if (BurnTimer > 0)
	{	
		BurnTimer -= 1;
		TakeDamage(BurnDamage, None, BurnVector*0, BurnVector*0, BurnDmgType,, self);
		`log("Bot took burn damage!");
	}
	else 
	{
		ClearTimer('TakeBurnDamage');
	}
}

function Slow(float SlowAmount, optional float SecondsToBeSlowed = 0)
{
	if (Armor == HeavyArmor)
	{
		SecondsToBeSlowed *= 2;
	}

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

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if (Armor == Unarmored)
	{
		/*if (DamageType == FrostDmgType)
		{
			Damage *= 2;
		}*/
	}

	else if (Armor == LightArmor)
	{

	}

	else if (Armor == MediumArmor)
	{
		/*if (DamageType == LightningDmgType)
		{ 
			damage *= 2;
		}*/
	}

	else if (Armor == HeavyArmor)
	{

	}
	super.TakeDamage( Damage, EventInstigator, HitLocation, Momentum,  DamageType, HitInfo, DamageCauser);
}





