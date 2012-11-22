class MookPawn_Spike extends MookPawn;


var AnimNodePlayCustomAnim DeathAnimNode;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	ControllerClass=class'WotS.MookBot_Ranged';
	Spawn(class'WotS.WotSWeapon_Spike',,,Location).GiveTo(self);
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
	self.Mesh.SetSkeletalMesh(SkeletalMesh'KarakterSpike.Spike.spike_skeletalmesh');	
	self.Mesh.AnimSets[0]=AnimSet'KarakterSpike.spike_animset';
	self.Mesh.SetAnimTreeTemplate(AnimTree'KarakterSpike.spike_animtree');
	self.Mesh.SetMaterial(0, Material'KarakterSpike.Spike.SpikeTextur_Mat');
}