class MagicalPawn extends UTPawn;

var float FrostShieldStrength;
var PostProcessSettings ShieldPPSettings;

defaultproperties
{
	InventoryManagerClass = class'MagicalFPSGame.MagicalInventoryManager'
	WalkingPct=+0.4
	CrouchedPct=+0.4
	BaseEyeHeight=38.0
	EyeHeight=38.0
	GroundSpeed=440.0
	AirSpeed=440.0
	WaterSpeed=220.0
	AccelRate=2048.0
	JumpZ=322.0
	CrouchHeight=29.0
	CrouchRadius=21.0
	WalkableFloorZ=0.78	
}

simulated event PostBeginPlay()
{
    ShieldPPSettings.bEnableMotionBlur = false;
    ShieldPPSettings.bOverride_EnableMotionBlur = false;
    ShieldPPSettings.bOverride_MotionBlur_Amount = false;

    
    Super.PostBeginPlay();
}


simulated function Tick(float DeltaTime)
{
	local MagicalPlayerController PC;
	foreach LocalPlayerControllers(class'MagicalPlayerController', PC)
	{
	
		PC.TimeSinceRecharged += DeltaTime;
		if (PC.TimeSinceRecharged >= 0.20)
		{
			PC.GiveMana(1);
			PC.TimeSinceRecharged = 0.0;
		}
	}
}


function int ShieldAbsorb( int Damage )
{
	if ( Health <= 0 )
	{
		return damage;
	}

	if ( FrostShieldStrength > 0 )
	{
		bShieldAbsorb = true;
		FrostShieldStrength = AbsorbDamage(Damage, FrostShieldStrength, 0.75);
		if ( Damage == 0 )
		{
			return 0;
		}
	}
	return Damage;
}

function ActivateFrostShield(float ShieldStrength, float ShieldDuration)
{
	
	FrostShieldStrength = ShieldStrength;
	SetTimer(ShieldDuration, false, 'DeactivateFrostShield');
	
	// ShieldPPSettings

	
}

function DeactivateFrostShield()
{

	local MagicalPlayerController PC;
	FrostShieldStrength = 0;
	
	foreach LocalPlayerControllers(class'MagicalPlayerController', PC)
	{
		PC.SetFOV(85);
	}
}	

