class MookPawn extends WotSPawn 
	abstract;

var AnimNodePlayCustomAnim Fitte;

defaultproperties
{
	ControllerClass=class'WotS.MookBot'

	Begin Object Name=WPawnSkeletalMeshComponent
		bOwnerNoSee=False
	End Object

	Mesh=WPawnSkeletalMeshComponent
	Components.Add(WPawnSkeletalMeshComponent)
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
	Super.SetCharacterClassFromInfo(Info);

	self.SoundGroupClass=class'WotSSoundGroup_Silence';

	self.Mesh.SetSkeletalMesh(SkeletalMesh'enemy_ninja_pack.enemy_ninja_mesh');	
	self.Mesh.AnimSets[0]=AnimSet'enemy_ninja_pack.enemy_ninja_animset';	
	self.Mesh.SetAnimTreeTemplate(AnimTree'enemy_ninja_pack.enemy_ninja_animtree');
	self.Mesh.SetMaterial(0, Material'enemy_ninja_pack.Materials.Default');
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	ControllerClass=class'WotS.MookBot';
}

simulated function ThrowWeaponOnDeath()
{
	// don't
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Fitte = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim'));
}

simulated function PlayDying(class<DamageType> DamageType, Vector HitLoc)
{
	SetCollisionType(COLLIDE_NoCollision);
	Fitte.PlayCustomAnim('enemy_ninja_deathanimation',  1.0, 0.05, 0.0, false, false);		
	LifeSpan =1.0;
}

function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
	local int PickupToDrop;
	local Vector DropLocation;
	DropLocation = self.Location;
	DropLocation.Z -= 35;
	PickupToDrop = int(RandRange(1,200));
	if (PickupToDrop < 200)
	{
		if (PickupToDrop>12)
		{
			Spawn(Class'WotS.WotSPickup_Health_Small',,, DropLocation,);
		}
		else if (PickupToDrop>3)
		{
			Spawn(Class'WotS.WotSPickup_Health_Medium',,, DropLocation,);
		}
		else 
		{
			Spawn(Class'WotS.WotSPickup_Health_Large',,, DropLocation,);
		}
	}

	return Super.Died(Killer, DamageType, HitLocation);
}