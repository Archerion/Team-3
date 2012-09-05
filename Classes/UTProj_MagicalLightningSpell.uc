class UTProj_MagicalLightningSpell extends UTProj_LinkPlasma;

DefaultProperties
{
	
}
simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if(!Other.IsA('Projectile') || Other.bProjTarget)
		{
			MBP = MagicalBotPawn(Other);
			MBP.TakeLightningDamage(Damage);
		}
	}
	super.ProcessTouch (Other, HitLocation, HitNormal);
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