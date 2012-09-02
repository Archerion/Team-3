class MagicalPawn extends UTPawn;

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