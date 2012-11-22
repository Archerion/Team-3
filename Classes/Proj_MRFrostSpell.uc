class Proj_MRFrostSpell extends Proj_MRBullet;

defaultproperties
{
	ProjExplosionTemplate=ParticleSystem'WotS_Particles:Particles.Ice_Hit'
	ProjFlightTemplate=ParticleSystem'WotS_Particles.Particles.ice_particle'
	MyDamageType=class'WotSSPLFrostDamage'
}

