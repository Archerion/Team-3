class WotSWeapon_Ranged_Mook extends WotSWeapon;

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'enemy_ninja_pack.enemy_ninja_rifle'
		AnimSets(0)=AnimSet'enemy_ninja_pack.b_gun_root'
		bForceUpdateAttachmentsInTick=true
	End Object

	InventoryGroup=4


	AttachmentClass=class'Ranged_Attach';
}