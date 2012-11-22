class WotSWeapon_Spike extends WotSWeapon;

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'WeaponVill.Weapon'
		bForceUpdateAttachmentsInTick=true
		AnimSets(0)=AnimSet'WeaponVill.b_weapon_grip'
	End Object

	InventoryGroup=4


	AttachmentClass=class'Spike_Attach';
}