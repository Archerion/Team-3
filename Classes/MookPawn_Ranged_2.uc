class MookPawn_Ranged_2 extends MookPawn
placeable;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ControllerClass=class'WotS.MookBot_Ranged';
	SpawnDefaultController();
	`log("Spawned controller:"@Controller);

	Spawn(class'WotS.WotSWeapon_Spike',,,Location).GiveTo(self);
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Fitte = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim'));
}

simulated function PlayDying(class<DamageType> DamageType, Vector HitLoc)
{
	SetCollisionType(COLLIDE_NoCollision);
	Fitte.PlayCustomAnim('Dead',  1.0, 0, 0.0, false, false);		
	LifeSpan =0.40;
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
	Super.SetCharacterClassFromInfo(Info);
	self.Mesh.SetSkeletalMesh(SkeletalMesh'KarakterVill.KarakterVillScel');	
	self.Mesh.AnimSets[0]=AnimSet'KarakterVill.KarakterVill.Village_Animset';
	self.Mesh.SetAnimTreeTemplate(AnimTree'KarakterVill.Village_Animtree');
	self.Mesh.SetMaterial(0, Material'KarakterVill.TexturVillDIFF_Mat');
	self.Mesh.SetMaterial(1, Material'KarakterVill.TexturVillDIFF_Mat');
	self.Mesh.SetMaterial(2, Material'KarakterVill.TexturVillDIFF_Mat');
}