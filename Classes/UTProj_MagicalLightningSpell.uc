class UTProj_MagicalLightningSpell extends UTProj_LinkPlasma;

DefaultProperties
{
	
}

simulated function SpawnFlightEffects()
{
	local vector FXColor;
	FXColor.x = 1;
	FXColor.y = 0.2;
	FXColor.z = 1;
	
	Super.SpawnFlightEffects();
	if (ProjEffects != None)
	{
		ProjEffects.SetVectorParameter('LinkProjectileColor', FXColor);
	}
}