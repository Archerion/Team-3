
class MagicalBotPawn extends UTPawn 
	placeable;

var float BurningTime;
var float BurnDamage;
var vector BurnVector;
var class<DamageType> BurnDmgType;

defaultproperties
{
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	BurningTime = 0;
	BurnDamage = 5;
	BurnDmgType = class'UTDmgType_Burning';
}

function TakeFire(float Duration, float Damage, optional float TimeBetweenBurns = 1)
{
	while (BurningTime > 0)
	{
		SetTimer(0.5, true, 'TakeBurnDamage');
		BurningTime -= TimeBetweenBurns;
	}
}

function TakeBurnDamage()
{
		TakeDamage(BurningDamage, None, BurnVector*0, BurnVector*0, BurnDmgType,, self);
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


