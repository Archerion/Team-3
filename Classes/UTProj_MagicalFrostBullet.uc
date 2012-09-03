class UTProj_MagicalFrostBullet extends UTProj_MagicalBullet;

simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if(Other.IsA('MagicalBotPawn'))
		{
				MBP = MagicalBotPawn(Other);
				MBP.Freeze(6.0);		}
	}

	Super.ProcessTouch(Other, HitLocation, HitNormal);
}

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
}