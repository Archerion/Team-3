class SorcererPawn extends WotSPawn;

defaultproperties
{
	bUsesMana = True;
    
    Begin Object Name=WPawnSkeletalMeshComponent
        bOwnerNoSee=False
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human' 
        SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
        PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
    End Object

    Mesh=WPawnSkeletalMeshComponent
    Components.Add(WPawnSkeletalMeshComponent)
}

exec function StartSprint()
{
	GroundSpeed = default.GroundSpeed * 2;
	StopFiring();
}

exec function StopSprint()
{
	GroundSpeed = default.GroundSpeed;
}