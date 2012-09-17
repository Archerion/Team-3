Class UTProj_MagicalFrostSpell extends UTProj_MagicalBullet;

defaultproperties
{
	Damage = 0
	ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile'
	ProjExplosionTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_Impact'
	MyDamageType=class'MDmgType_Stun'
}

simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if ( !Other.IsA('Projectile') || Other.bProjTarget )
		{
			MBP = MagicalBotPawn(Other);
			MagicalBot(MBP.Controller).Stun(10);
		}
	}
	Super.ProcessTouch(Other, HitLocation, HitNormal);
}
