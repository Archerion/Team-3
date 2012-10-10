class SorcererPlayerController extends UTPlayerController;

defaultproperties
{
}

exec function SpawnBot()
{
	local Vector SpawnLocationVector;
	SpawnLocationVector.Z = 300;
	Spawn(class'WotS.MookPawn',,,SpawnLocationVector);
	`log("Player Spawned a bot");
}
