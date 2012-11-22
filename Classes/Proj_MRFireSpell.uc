class Proj_MRFireSpell extends Proj_MRBullet;

defaultproperties
{
	ProjExplosionTemplate=ParticleSystem'WotS_Particles.Particles.Fire_hit'
	ProjFlightTemplate=ParticleSystem'WotS_Particles.Particles.Fire_particle'
	MyDamageType=class'WotsSPLBurnDamage'
}
