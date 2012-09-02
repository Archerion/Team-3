class MagicalPlayerController extends UTPlayerController;

var bool bUsesMana;
var float ManaRechargeRate;
var float TimeSinceRecharged;
var float CurrentMana;
var float MaxMana;


defaultproperties
{
   bUsesMana = True;
   ManaRechargeRate = 1.0;
   TimeSinceRecharged = 0.0;
   CurrentMana = 100;   
   MaxMana = 100;
   
   CameraClass=class'MagicalFPSGame.MagicalPlayerCamera'
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


reliable client function ClientSetHUD(class<HUD> newHUDType)
{
	if (myHUD != None)
	{	
		myHUD.Destroy();
	}
	
	myHUD = spawn(class'MagicalHUD', self);
	
}