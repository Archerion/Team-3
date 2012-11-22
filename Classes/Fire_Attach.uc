class Fire_Attach extends UTWeaponAttachment;

DefaultProperties
{
	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
	End Object

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'Player_Weapon.Player_Weapon_fire'
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Player_Weapon.Player_Weapon_AnimSet'
		Rotation=(Yaw=-16384)
	End Object

	Mesh=SkeletalMeshComponent0

	FireAnim = WeaponFire;

	WeaponClass=Class'WotSWeapon_ManaRifleFire';
}

