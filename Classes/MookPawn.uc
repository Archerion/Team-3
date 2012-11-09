class MookPawn extends WotSPawn 
	placeable;

// Mooks should have melee attack
defaultproperties
{
	ControllerClass=class'WotS.MookBot'
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SpawnDefaultController();
	Spawn(class'WotS.WotSWeapon_Melee',,,Location).GiveTo(self);
	`log("Spawned controller:"@Controller);
}

simulated function Tick(Float DeltaTime)
{
	super.Tick(DeltaTime);
}


simulated function StartFire(byte FireModeNum)
{
	`log("Firing");
	super.StartFire(FireModeNum);
}
