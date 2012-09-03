class MagicalPawn extends UTPawn;

var float SS;
var float SSMax;

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
<<<<<<< HEAD
	SS = 0.0;
	SSMax = 100.0;
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

	if ( SS > 0 )
	{
		bShieldAbsorb = true;
		SS = AbsorbDamage(Damage, SS, 0.75);
		if ( Damage == 0 )
		{
			return 0;
		}
	}
	return Damage;
}

function ActivateFrostShield(float AddShieldStrength, float ShieldDuration)
{
	
	if (AddShieldStrength < 0)
	{
		AddShieldStrength = 0;
	}
	SS = SS + AddShieldStrength > SSMax ? SSMax : SS+AddShieldStrength;
	SetTimer(ShieldDuration, false, 'DeactivateFrostShield');
	
	// ShieldPPSettings

	
}

function DeactivateFrostShield()
{
	SS = 0;
}

