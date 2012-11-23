class WotSWeapon_Ranged_Mook extends WotSWeapon;

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'enemy_ninja_pack.enemy_ninja_rifle'
		AnimSets(0)=AnimSet'enemy_ninja_pack.b_gun_root'
		bForceUpdateAttachmentsInTick=true
	End Object

	InventoryGroup=4

	WeaponProjectiles(0)=class'Proj_RangedMookBullet'

	FireInterval(0)=+0.8
	FireInterval(1)=+2

	ShotCost(0) = 0;
	ShotCost(1) = 99990;

	AttachmentClass=class'Ranged_Attach';

	//WeaponFireTypes(0)=EWFT_Projectile
	//WeaponFireTypes(1)=EWFT_None
}