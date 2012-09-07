class MagicalPawn extends UTPawn;

var float ShieldStrength;
var float ShieldStrengthMax;

defaultproperties
{
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
	ShieldStrength = 0.0;
	ShieldStrengthMax = 100.0;
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
	
	if ( ShieldStrength > 0 )
	{
		bShieldAbsorb = true;
		ShieldStrength = AbsorbDamage(Damage, ShieldStrength, 1);
		if ( Damage == 0 )
		{
			return 0;
		}
	}
	return Damage;
}

function ActivateFrostShield(float AddShieldStrength, optional float ShieldDuration  = 0)
{
	
	if (AddShieldStrength < 0)
	{
		AddShieldStrength = 0;
	}
	ShieldStrength = ShieldStrength + AddShieldStrength > ShieldStrengthMax ? ShieldStrengthMax : ShieldStrength+AddShieldStrength;
	if (ShieldDuration > 0)
	{
		SetTimer(ShieldDuration, false, 'DeactivateFrostShield');
	}
	
}

function DeactivateFrostShield()
{
	ShieldStrength = 0;
}
