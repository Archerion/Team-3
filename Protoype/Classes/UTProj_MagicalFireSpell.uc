class UTProj_MagicalFireSpell extends UTProj_MagicalBullet;

var float BurnDamage;
var float BurnDuration;

var float SlowAmount;
var float SlowDuration;

simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MagicalBotPawn MBP;
	if ( Other != Instigator )
	{
		if(Other.IsA('MagicalBotPawn'))
		{
			MBP = MagicalBotPawn(Other);
			MBP.Slow(SlowAmount, SlowDuration);		
			MBP.TakeFire(BurnDuration, BurnDamage);
		}
	}

	Super.ProcessTouch(Other, HitLocation, HitNormal);
}

simulated function SpawnFlightEffects()
{
	local vector FXColor;
	FXColor.x = 1.0;
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

	ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile'
	ProjExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'

	Damage=0
	SlowAmount = 0.5
	SlowDuration = 3.0
	BurnDamage = 10.0
	BurnDuration = 3.0
}

