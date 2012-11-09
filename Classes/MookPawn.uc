class MookPawn extends WotSPawn 
	placeable;

var AnimNodeSlot FullBodyAnimSlot;

// Mooks should have melee attack
defaultproperties
{
	Begin Object Name=WPawnSkeletalMeshComponent
        bOwnerNoSee=False
        AnimTreeTemplate=AnimTree'enemy_ninja_pack.enemy_ninja_animtree'
        SkeletalMesh=SkeletalMesh'enemy_ninja_pack.enemy_ninja_skeletalmesh'
        PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
        AnimSets(0)=AnimSet'enemy_ninja_pack.enemy_ninja_animset'
    End Object

    Mesh=WPawnSkeletalMeshComponent
    Components.Add(WPawnSkeletalMeshComponent)
	ControllerClass=class'WotS.MookBot'
}


simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
    Super.SetCharacterClassFromInfo(Info);
    self.Mesh.SetSkeletalMesh(SkeletalMesh'enemy_ninja_pack.enemy_ninja_mesh');
    self.Mesh.AnimSets[0]=AnimSet'enemy_ninja_pack.enemy_ninja_animset';
    self.Mesh.SetAnimTreeTemplate(AnimTree'enemy_ninja_pack.enemy_ninja_animtree');
    self.Mesh.SetMaterial(0, Material'enemy_ninja_pack.Materials.Default');
}



function ThrowWeaponOnDeath()
{
    Spawn(Class'WotSPickupFactory_Health', self); 
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	Spawn(class'WotSWeapon_Melee_Mook',,,Location).GiveTo(self);
	SpawnDefaultController();
    //SetCharacterClassFromInfo(class'UTFamilyInfo_Mook');
    // Mesh.SetAnimTreeTemplate(AnimTree'enemy_ninja.enemy_ninja_animtree');
	`log("Spawned controller:"@Controller);
}

simulated event Destroyed()
{
  Super.Destroyed();
}
