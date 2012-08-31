
class MagicalBotPawn extends UTPawn;

var bool bIsBurning;
var int BurningTime;
var float TimeToNextBurn;

defaultproperties
{
	
	ControllerClass=class'MagicalFPSGame.MagicalBot'
	bIsBurning = false;
	BurningTime = 0;
	TimeToNextBurn = 1;
}

simulated function Tick(float DeltaTime)
{
	if(bIsBurning)
	{
		if (BurningTime != 0)
		{
			BurningTime -= 1;
			TimeToNextBurn -= DeltaTime;
			if (TimeToNextBurn <= 1)
			{
				SetTimer(1,false,'BurnTimer');
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




function BurnTimer()
{
	`log("Burn!");
    TakeDamage(5);
}