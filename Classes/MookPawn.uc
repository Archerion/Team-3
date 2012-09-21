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
	Spawn(class'WotSWeapon_Melee_Mook',,,Location).GiveTo(self);
	SpawnDefaultController();
	`log("Spawned controller:"@Controller);	
}