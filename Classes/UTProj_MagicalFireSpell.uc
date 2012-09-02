class UTProj_MagicalFireSpell extends UTProjectile;

defaultproperties
{
	MyDamageType=class'UTDmgType_ScorpionGlob'

	ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile'
	ProjExplosionTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_Impact'

	Explosionsound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue'
	ImpactSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactFizzle_Cue'
	
	Speed=4000.0
	MaxSpeed=4000.0
	Damage=80.0
	DamageRadius=220.0
	MomentumTransfer=40000
	LifeSpan=1.6
	MaxEffectDistance=7000.0
	Buoyancy=1.5
	TossZ=0.0
	CheckRadius=48.0
	Physics=PHYS_Falling
	ExplosionLightClass=class'UTGame.UTRocketExplosionLight'
	ExplosionDecal=MaterialInstanceTimeVarying'WP_RocketLauncher.Decals.MITV_WP_RocketLauncher_Impact_Decal01'
	DecalWidth=128.0
	DecalHeight=128.0
	
	bNetTemporary=false
	bUpdateSimulatedPosition=false
}

