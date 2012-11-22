class MookPawn_Ogg extends MookPawn
placeable;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ControllerClass=class'WotS.MookBot_Ranged';
	Spawn(class'WotS.WotSWeapon_Spike',,,Location).GiveTo(self);
}

simulated function PlayDying(class<DamageType> DamageType, Vector HitLoc)
{
	SetCollisionType(COLLIDE_NoCollision);	
	LifeSpan =1.0;
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
	Super.SetCharacterClassFromInfo(Info);
	self.Mesh.SetSkeletalMesh(SkeletalMesh'Jonatan.ogg_beta_V2');	
	self.Mesh.AnimSets[0]=AnimSet'Jonatan.ogg_animset';
	self.Mesh.SetAnimTreeTemplate(AnimTree'Jonatan.Ogg_animtree');
	self.Mesh.SetMaterial(0, Material'Jonatan.Materials.ogg_material');
}