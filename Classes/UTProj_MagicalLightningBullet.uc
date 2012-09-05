class UTProj_MagicalLightningBullet extends UTProj_MagicalBullet;


simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if(!Other.IsA('Projectile') || Other.bProjTarget)
		{
			MBP = MagicalBotPawn(Other);
			MagicalBot(MBP.Controller).Stun(0.5);
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

DefaultProperties
{
	Damage = 20;
}
