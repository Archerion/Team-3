class MookPawn_Ranged extends MookPawn;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ControllerClass=class'WotS.MookBot_Ranged';
	Spawn(class'WotS.WotSWeapon_Ranged_Mook',,,Location).GiveTo(self);
}

simulated function PlayDying(class<DamageType> DamageType, Vector HitLoc)
{
	SetCollisionType(COLLIDE_NoCollision);
	Fitte.PlayCustomAnim('enemy_ninja_deathanimation',  1.0, 0.05, 0.0, false, false);		
	LifeSpan =1.0;
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
	Super.SetCharacterClassFromInfo(Info);
	self.Mesh.SetSkeletalMesh(SkeletalMesh'enemy_ninja_pack.enemy_ninja_rangemesh');	
	self.Mesh.AnimSets[0]=AnimSet'enemy_ninja_pack.enemy_ninja_rangeanimset';
	self.Mesh.SetAnimTreeTemplate(AnimTree'enemy_ninja_pack.enemy_ninja_rangeanimtree');
}