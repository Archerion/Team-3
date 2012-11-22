class WotSWeapon_ManaRifleFire extends WotSWeapon_ManaRifleBase;

defaultproperties
{
	PlayerViewOffset=(X=20.000000,Y=-10.000000,Z=-10.000000)

	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	Begin Object Name=FirstPersonMesh		
		SkeletalMesh=SkeletalMesh'Player_Weapon.Player_Weapon_fire'		
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Player_Weapon.Player_Weapon_AnimSet'	
		Scale=0.900000
		FOV=60
	End Object

	WeaponProjectiles(0)=class'Proj_MRFireBullet'
	WeaponProjectiles(1)=class'Proj_MRFireSpell'
	
	WeaponManaCost=(Primary=2, Secondary=10);
	InventoryGroup=1

	AttachmentClass=class'Test_Attach';

	MuzzleFlashSocket=MFSocket
	MuzzleFlashPSCTemplate=WotS_Particles.Particles.Muzzleflash_Fire
	MuzzleFlashAltPSCTemplate=WotS_Particles.Particles.Muzzleflash_Fire
}