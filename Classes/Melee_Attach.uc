class Melee_Attach extends UTWeaponAttachment;

defaultproperties
{
	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
	End Object

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'Melee_Weapon.Melee_Weapon_3rd'
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Melee_Weapon.Melee_Anime'
		Rotation=(Yaw=-16384)
	End Object

	Mesh=SkeletalMeshComponent0

	FireAnim = WeaponFire;

	WeaponClass=Class'WotSWeapon_Melee';
}

simulated function ThirdPersonFireEffects(vector HitLocation)
{	
	local UTPawn P;
	`log("Third person fire");
	if ( EffectIsRelevant(Location,false,MaxFireEffectDistance) )
	{
		`log("Does muzzle flash");
		// Light it up
		CauseMuzzleFlash();
	}

	// Have pawn play firing anim
	P = UTPawn(Instigator);
	if (P != None && P.GunRecoilNode != None)
	{
		`log("Does recoil");
		// Use recoil node to move arms when we fire
		P.GunRecoilNode.bPlayRecoil = true;
	}

	`log("Main fire anim: " $FireAnim);
	`log("Secondary fire anim: " $AltFireAnim);
	if (Instigator.FiringMode == 1 && AltFireAnim != 'None')
	{
		`log("Alt fire mode: " $AltFireAnim);
		Mesh.PlayAnim(AltFireAnim,,, false);
	}
	else if (FireAnim != 'None')
	{
		`log("Main fire anim: " $FireAnim);
		Mesh.PlayAnim(FireAnim,,, false);
	}
}



