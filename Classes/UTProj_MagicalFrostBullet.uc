class UTProj_MagicalFrostBullet extends UTProj_MagicalBullet;

var float SlowAmount;
var float SlowDuration;


simulated function SpawnFlightEffects()
{
	local vector FXColor;
	FXColor.X = 0.2;
	FXColor.Y = 0.2;
	FXColor.Z = 1;
	
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', FXColor);
	}
}

simulated function PostBeginPlay()
{
	Damage=class'UTProj_MagicalBullet'.default.Damage+10;
	Super.PostBeginPlay();
}

defaultproperties
{
}