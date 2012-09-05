
class MagicalBotPawn extends UTPawn 
	placeable;

var float BurningTime;
var int BurnDamage;
var float BurnTimer;
var vector BurnVector;
var class<DamageType> BurnDmgType;

defaultproperties
{
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	BurningTime = 0;
	BurnTimer = 1;
	BurnDamage = 5;	
	BurnDmgType = class'UTDmgType_Burning';
}

function TakeFire(float Duration, int Damage)
{
	`log("Setting bot on fire!");
	BurnDamage = Damage;
	BurnTimer = Duration;
	SetTimer(1, true, 'TakeBurnDamage');
}

function TakeBurnDamage()
{
	`log("TakeBurnDamage! BurnTimer = "$BurnTimer);
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

function TakeLightningDamage(float lDamage)
{

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





