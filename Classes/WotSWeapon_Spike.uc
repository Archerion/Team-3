class WotSWeapon_Spike extends WotSWeapon;

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WeaponVill.Weapon'
		bForceUpdateAttachmentsInTick=true
		AnimSets(0)=AnimSet'WeaponVill.b_weapon_grip'
	End Object

	InventoryGroup=4

	ShotCost(0) = 0;
	ShotCost(1) = 99990;

	AttachmentClass=class'Spike_Attach';


	//WeaponFireTypes(0)=EWFT_Projectile
	//WeaponFireTypes(1)=EWFT_None
}