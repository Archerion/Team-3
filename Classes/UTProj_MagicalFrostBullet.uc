class UTProj_MagicalFrostBullet extends UTProj_MagicalBullet;

var float SlowAmount;
var float SlowDuration;


simulated function SpawnFlightEffects()
{
	local vector FXColor;
	FXColor.x = 0.2;
	FXColor.y = 0.2;
	FXColor.z = 1.0;
	
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', FXColor);
	}
}

defaultproperties
{
	
	Damage=class'UTMagicalBullet'.default.LightBrightness+10
}