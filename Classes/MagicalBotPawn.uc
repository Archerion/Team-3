
class MagicalBotPawn extends UTPawn;

var bool bIsBurning;
var float BurningTime;
var float TimeToNextBurn;
var vector BurnVector;
var class<DamageType> BurnDmgType;

defaultproperties
{
	
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	bIsBurning = false;
	BurningTime = 0;
	TimeToNextBurn = 0.5;
	BurnDmgType = class'UTDmgType_Burning';
}

simulated function Tick(float DeltaTime)
{
	if(bIsBurning)
	{
		if (BurningTime != 0)
		{
			TimeToNextBurn -= DeltaTime;
			if (TimeToNextBurn <= 0)
			{
				TakeDamage(5, None, BurnVector*0, BurnVector*0, BurnDmgType,, self);
				TimeToNextBurn = 0.5;
				BurningTime -= 0.5;
			}
		}
		else 
		{
			bIsBurning = False;
		}
	}
}

function TakeFire(float SecondsToBurn)
{

	UnFreeze();
	bIsBurning = True;
	BurningTime = SecondsToBurn;
}

function Freeze(float FreezeAmount, optional float SecondsToBeFrozen = 0)
{
	bIsBurning = False;
	GroundSpeed *= 0.8;
	AirSpeed *= FreezeAmount;
	WaterSpeed *= FreezeAmount;
	Mesh.GlobalAnimRateScale *= FreezeAmount;
	ClearTimer('UnFreeze');
	if (SecondsToBeFrozen > 0)
	{
		SetTimer(SecondsToBeFrozen, false, 'UnFreeze');
	}
}

function UnFreeze()
{
	Mesh.GlobalAnimRateScale = Mesh.Default.GlobalAnimRateScale;
	GroundSpeed = Default.GroundSpeed;
	AirSpeed = Default.AirSpeed;
	WaterSpeed = Default.WaterSpeed;
}


