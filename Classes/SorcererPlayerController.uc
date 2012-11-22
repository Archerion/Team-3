class SorcererPlayerController extends UTPlayerController;

defaultproperties
{
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

exec function SpawnBot()
{
	local Vector SpawnLocationVector;
	SpawnLocationVector.Z = 300;
	Spawn(class'WotS.MookPawn_Spike',,,SpawnLocationVector);
	`log("Player spawned spike");
}