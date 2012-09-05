class UTWeap_ManaRifle extends UTWeapon abstract;

struct ManaCost
{
	var float Primary;
	var float Secondary;
	
	structdefaultproperties
	{
		Primary = 0;
		Secondary = 0;
	}
};

var ManaCost WeaponManaCost;
var float TimeToUpdateAmmo;

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
	WeaponProjectiles(0)=class'UTProj_MagicalBullet'
	// WeaponProjectiles(1)=class'UTProj_ScorpionGlob'
	
	InstantHitDamage(0)=45
	FireInterval(0)=+0.77
	FireInterval(1)=+0.6
	InstantHitDamageTypes(0)=None
	InstantHitDamageTypes(1)=None

	WeaponFireSnd[0]=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_FireCue'
	WeaponFireSnd[1]=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireCue'
	WeaponEquipSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_RaiseCue'
	WeaponPutDownSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_LowerCue'
	PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Shock_Cue'
	
	ShotCost(0)=1
	ShotCost(1)=0

	FireOffset=(X=20,Y=5)
	PlayerViewOffset=(X=17,Y=10.0,Z=-8.0)

	AmmoCount=50
	LockerAmmoCount=50
	MaxAmmoCount=80

	
	FireCameraAnim(0)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
	FireCameraAnim(1)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
	WeaponFireAnim(1)=WeaponAltFire

	
	EffectSockets(0)=MuzzleFlashSocket
	EffectSockets(1)=MuzzleFlashSocket
	
	MuzzleFlashSocket=MuzzleFlashSocket
	MuzzleFlashPSCTemplate=ParticleSystem'WP_LinkGun.Effects.P_FX_LinkGun_MF_Primary'
	MuzzleFlashAltPSCTemplate=ParticleSystem'WP_LinkGun.Effects.P_FX_LinkGun_MF_Beam'
	bMuzzleFlashPSCLoops=true
	MuzzleFlashLightClass=class'UTGame.UTLinkGunMuzzleFlashLight'
	
	CrossHairCoordinates=(U=256,V=0,UL=64,VL=64)
	LockerRotation=(Pitch=32768,Roll=16384)

	IconCoordinates=(U=728,V=382,UL=162,VL=45)

	WeaponColor=(R=160,G=0,B=255,A=255)

	InventoryGroup=1
	GroupWeight=0.5
	
	TimeToUpdateAmmo = 1.5
	
	WeaponManaCost=(Primary=0, Secondary=0);
	
	IconX=400
	IconY=129
	IconWidth=22
	IconHeight=48
}


simulated function FireAmmunition()
{
	local MagicalPlayerController PC;
	PC = MagicalPlayerController(GetALocalPlayerController());
	if (CurrentFireMode == 0)
	{
		if (PC.CheckMana() >= WeaponManaCost.Primary)
		{
			if ( MagicalInventoryManager(PC.Pawn.InvManager).GetAmmoCount() > 0)
			{
				PC.TakeMana(WeaponManaCost.Primary);
				Super.FireAmmunition();
			}
		}
	}
	else if (CurrentFireMode == 1)
	{
		if (PC.CheckMana() >= WeaponManaCost.Secondary)
		{
			PC.TakeMana(WeaponManaCost.Secondary);
			Super.FireAmmunition();
			
		}
	}
}

simulated function Tick(float DeltaTime)
{
	local int CurrentAmmo;
	if (TimeToUpdateAmmo <= 0)
	{
		CurrentAmmo	= GetAmmoCount();
		if(AmmoCount != CurrentAmmo)
		{
			AmmoCount = CurrentAmmo;
		}
		TimeToUpdateAmmo = 1.5;
	}
	else 
	{
	TimeToUpdateAmmo-=DeltaTime;
	}
}

function int AddAmmo( int Amount )
{
	MagicalInventoryManager(InvManager).AddManaRifleAmmo(Amount);
	return MagicalInventoryManager(InvManager).GetAmmoCount();
}

simulated function int GetAmmoCount()
{
	return MagicalInventoryManager(InvManager).GetAmmoCount();
}
