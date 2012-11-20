class Proj_MRFrostBullet extends Proj_MRBullet;

defaultproperties
{
	ProjExplosionTemplate=ParticleSystem'WotS_Particles.Particles.Ice_Hit'
	ProjFlightTemplate=ParticleSystem'WotS_Particles.Particles.IcePEffect'
	MyDamageType=class'WotSPRJFrostDamage';
}


