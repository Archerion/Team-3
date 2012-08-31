class UTWeap_ManaRifle extends UTWeapon;

var bool bUsesMana;
var float PrimaryFireManaCost;

defaultproperties
{
	
	Begin Object class=AnimNodeSequence Name=MeshSequenceA
	End Object

	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
		AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
		Animations=MeshSequenceA
		Rotation=(Yaw=-16384)
		FOV=60.0
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P'
	End Object

	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_None
	WeaponProjectiles(0)=class'UTProj_LinkPlasma'
	// WeaponProjectiles(1)=class'UTProj_ScorpionGlob'
	
	InstantHitDamage(0)=45
	FireInterval(0)=+0.2
	FireInterval(1)=+1.3
	InstantHitDamageTypes(0)=None
	InstantHitDamageTypes(1)=None

	WeaponFireSnd[0]=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_FireCue'
	WeaponFireSnd[1]=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireCue'
	WeaponEquipSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_RaiseCue'
	WeaponPutDownSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_LowerCue'
	PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Shock_Cue'
	
	ShotCost(0)=0
	ShotCost(1)=0

	FireOffset=(X=20,Y=5)
	PlayerViewOffset=(X=17,Y=10.0,Z=-8.0)

	AmmoCount=20
	LockerAmmoCount=20
	MaxAmmoCount=30

	FireCameraAnim(1)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
	WeaponFireAnim(1)=WeaponAltFire

	MuzzleFlashSocket=MF
	MuzzleFlashPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt
	MuzzleFlashAltPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt
	MuzzleFlashColor=(R=200,G=220,B=205,A=255)
	MuzzleFlashDuration=0.33
	MuzzleFlashLightClass=class'UTGame.UTShockMuzzleFlashLight'
	CrossHairCoordinates=(U=256,V=0,UL=64,VL=64)
	LockerRotation=(Pitch=32768,Roll=16384)

	IconCoordinates=(U=728,V=382,UL=162,VL=45)

	WeaponColor=(R=160,G=0,B=255,A=255)

	InventoryGroup=1
	GroupWeight=0.5
	
	bUsesMana = false;
	
	IconX=400
	IconY=129
	IconWidth=22
	IconHeight=48

	Begin Object Class=ForceFeedbackWaveform Name=ForceFeedbackWaveformShooting1
		Samples(0)=(LeftAmplitude=90,RightAmplitude=40,LeftFunction=WF_Constant,RightFunction=WF_LinearDecreasing,Duration=0.1200)
	End Object
	WeaponFireWaveForm=ForceFeedbackWaveformShooting1
}


simulated function FireAmmunition()
{
	local MagicalPlayerController PC;
	
	foreach LocalPlayerControllers(class'MagicalPlayerController', PC)
	{
		if (bUsesMana && PC.CheckMana() >= 1)
		{
			if (CurrentFireMode == 0)
			{
				PC.TakeMana(2);
			}else 
			{
				PC.TakeMana(15);
			}
		}
	}
	
	Super.FireAmmunition();
}








