class SorcererPlayerController extends UTPlayerController;

defaultproperties
{
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	ChangeTeam(2);
}

exec function SpawnBot()
{
	local Vector SpawnLocationVector;
	SpawnLocationVector.Z = 300;
	Spawn(class'WotS.MookPawn',,,SpawnLocationVector);
	`log("Player Spawned a bot");
}