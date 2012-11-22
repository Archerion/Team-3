class MookPawn extends WotSPawn 
	placeable;

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
	self.Mesh.SetSkeletalMesh(SkeletalMesh'enemy_ninja_pack.enemy_ninja_mesh');	
	self.Mesh.AnimSets[0]=AnimSet'enemy_ninja_pack.enemy_ninja_animset';	
	self.Mesh.SetAnimTreeTemplate(AnimTree'enemy_ninja_pack.enemy_ninja_animtree');
	self.Mesh.SetMaterial(0, Material'enemy_ninja_pack.Materials.Default');
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SpawnDefaultController();
	`log("Spawned controller:"@Controller);
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
	local WotSPickup DroppedPickup;
	local int PickupToDrop;

	PickupToDrop = int(RandRange(1,200));
	if (PickupToDrop < 30)
	{
		if (PickupToDrop>12)
		{
			DroppedPickup = Spawn(Class'WotS.WotSPickup_Health_Small',,, HitLocation,);
		}
		else if (PickupToDrop>3)
		{
			DroppedPickup = Spawn(Class'WotS.WotSPickup_Health_Medium',,, HitLocation,);
		}
		else 
		{
			DroppedPickup = Spawn(Class'WotS.WotSPickup_Health_Large',,, HitLocation,);
		}
	}

	return Super.Died(Killer, DamageType, HitLocation);
}