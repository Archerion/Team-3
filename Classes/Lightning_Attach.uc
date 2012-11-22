class Lightning_Attach extends UTAttachment_LinkGun;

DefaultProperties
{
	WeaponClass=class'WotSWeapon_ManaRifleLightning'
	/*
	BeamTemplate[1]=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam'
	
	LinkBeamSystems[0]=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam_Red'
	LinkBeamSystems[1]=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam_Blue'
	LinkBeamSystems[2]=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam'

	HighPowerSystem=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam_Gold'
	*/
	
	BeamTemplate[1]=ParticleSystem'WotS_Particles.Particles.Lightning_Particle'


	// These seems to overwrite the default beam but now spawns nothing.
	LinkBeamSystems[0]=ParticleSystem'WotS_Particles.Particles.Lightning_Particle'
	LinkBeamSystems[1]=ParticleSystem'WotS_Particles.Particles.Lightning_Particle'
	LinkBeamSystems[2]=ParticleSystem'WotS_Particles.Particles.Lightning_Particle'
	HighPowerSystem=ParticleSystem'WotS_Particles.Particles.Lightning_Particle'
}
