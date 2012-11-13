class MookPawn extends WotSPawn 
	placeable;

// Mooks should have melee attack
var AnimNodePlayCustomAnim Fitte;
defaultproperties
{
	ControllerClass=class'WotS.MookBot'

	Begin Object Name=WPawnSkeletalMeshComponent
		bOwnerNoSee=False
		SkeletalMesh=SkeletalMesh'enemy_ninja_pack.enemy_ninja_mesh'
		AnimTreeTemplate=AnimTree'enemy_ninja_pack.enemy_ninja_animtree'		
		PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
		AnimSets(0)=AnimSet'enemy_ninja_pack.enemy_ninja_animset'
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
	Spawn(class'WotS.WotSWeapon_Melee',,,Location).GiveTo(self);
	`log("Spawned controller:"@Controller);
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
  Fitte = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim'));
}

simulated function PlayDying(class<DamageType> DamageType, Vector HitLoc)
{
	SetCollisionType(COLLIDE_NoCollision);
	Fitte.PlayCustomAnim('enemy_ninja_deatanimation_1',  1.0, 0.05, 0.0, false, false);		
	LifeSpan =1.0;
}