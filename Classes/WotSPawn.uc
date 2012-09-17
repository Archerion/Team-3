class WotSPawn extends UTPawn
	abstract;

var(Mana) bool bUsesMana;
var(Mana) float ManaRechargeRate;
var(Mana) float MaxMana;
var float CurrentMana;
var float TimeSinceRecharged;

defaultproperties
{
	bUsesMana = False;
	ManaRechargeRate = 1.0;
	TimeSinceRecharged = 0.0;
	CurrentMana = 100;   
	MaxMana = 100;
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