class UTProj_MagicalFireBullet extends UTProj_MagicalBullet;

simulated function SpawnFlightEffects()
{
	local vector FXColor;
	FXColor.x = 1;
	FXColor.y = 0.2;
	FXColor.z = 0.2;
	
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', FXColor);
	}
}



defaultproperties
{
	ExplosionLightClass=class'UTGame.UTRocketExplosionLight'
	DamageRadius=100
}
