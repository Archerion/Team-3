
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
		`log ("Taking damage");
		UnFreeze();
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
	bIsBurning = True;
	BurningTime = SecondsToBurn;
}

function Freeze(float SecondsToBeFrozen)
{
	bIsBurning = False;
	GroundSpeed=220.00;
	AirSpeed=220.00;
	WaterSpeed=110.00;
	Mesh.GlobalAnimRateScale = 0.5f;
	ClearTimer('UnFreeze');
	SetTimer(SecondsToBeFrozen, false, 'UnFreeze');
}

function UnFreeze()
{
	Mesh.GlobalAnimRateScale = 1.0f;
	GroundSpeed=440.0;
	AirSpeed=440.0;
	WaterSpeed=220.0;
}


