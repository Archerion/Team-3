class Proj_MRSpell extends UTProjectile;

var bool Stuns;
var bool Burns;
var bool Slows;

var float BurnDamage;
var float BurnDuration;
var float SlowAmount;
var float SlowDuration;
var float StunDuration;
var float AreaOfEffect;


simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	local MookPawn MPawn;
	if ( Other != Instigator )
	{
		if(Other.IsA('MookPawn'))
		{
			MPawn = MookPawn(Other);

			if (Slows) 
			{
				MPawn.Slow(SlowAmount, SlowDuration);
			}
			if (Burns)
			{
				MPawn.TakeFire(BurnDuration, BurnDamage, 0.5);
			}
			if (Stuns)
			{
				MookBot(MPawn.Controller).Stun(StunDuration);
			}
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
	DamageRadius = 0;
	
	Stuns = false
	Burns = false
	Slows = false
	
	SlowAmount = 0.0
	SlowDuration = 0.0
	BurnDamage = 0.0
	BurnDuration = 0.0
	StunDuration = 0.0
}
