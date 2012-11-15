class WotSWeapon_ManaRifleFrost extends WotSWeapon_ManaRifleBase;

defaultproperties
{
	WeaponProjectiles(0)=class'Proj_MRFrostBullet'
	WeaponProjectiles(1)=class'Proj_MRFrostSpell'

	WeaponManaCost=(primary=2, secondary=10);
	InventoryGroup=3

	PlayerViewOffset=(X=20.000000,Y=-10.000000,Z=-10.000000)

	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'Player_Weapon.Player_Weapon_ice'		
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Player_Weapon.Player_Weapon_AnimSet'		
		Scale=0.900000
		FOV=60
	End Object

}

function LevelUp()
{
	super.LevelUp();

	if(WeaponLevel == 2)
	{
		FireInterval[0] = default.FireInterval[0] / 1.2;
	}

	else if(WeaponLevel == 3)
	{
		FireInterval[1] = default.FireInterval[1] / 1.4;
	}
}