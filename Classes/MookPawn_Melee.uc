class MookPawn_Melee extends MookPawn
placeable;

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
	Spawn(class'WotS.WotSWeapon_Melee',,,Location).GiveTo(self);
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