class Proj_MRSpell_Fire extends Proj_MRSpell;

defaultproperties
{

	ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile'
	ProjExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'
	
	Burns = true
	Slows = true

	SlowAmount = 0.5
	SlowDuration = 3.0
	BurnDamage = 5.0
	BurnDuration = 3.0
}
