Class UTProj_MagicalFrostSpell extends UTProj_MagicalBullet;

defaultproperties
{
	MyDamageType=class'MDmgType_Freeze'
}

simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if ( !Other.IsA('Projectile') || Other.bProjTarget )
		{
			MBP = MagicalBotPawn(Other);
			MagicalBot(MBP.Controller).Stun();
		}
	}
	Super.ProcessTouch(Other, HitLocation, HitNormal);
}
