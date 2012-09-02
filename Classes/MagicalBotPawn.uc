
class MagicalBotPawn extends UTPawn;

var bool bIsBurning;
var int BurningTime;
var float TimeToNextBurn;
var vector BurnVector;
var class<DamageType> BurnDmgType;

defaultproperties
{
	
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	bIsBurning = false;
	BurningTime = 0;
	TimeToNextBurn = 1;
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
				TimeToNextBurn = 1;
				BurningTime -= 1;
			}
		}
		else 
		{
			bIsBurning = False;
		}
	}
}

function TakeFire(int SecondsToBurn)
{
	bIsBurning = True;
	BurningTime = SecondsToBurn;
}

