class SorcererPlayerController extends UTPlayerController;

defaultproperties
{
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
}

exec function SpawnBot()
{
	local Vector SpawnLocationVector;
	SpawnLocationVector.X = self.Pawn.Mesh.getPosition().X + 200;
	SpawnLocationVector.Y = self.Pawn.Mesh.getPosition().Y;
	SpawnLocationVector.Z = 300;
	Spawn(class'WotS.WotSPickup',,,SpawnLocationVector);
	`log("Player Spawned a pickup");
}