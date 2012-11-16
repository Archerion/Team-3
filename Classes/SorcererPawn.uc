class SorcererPawn extends WotSPawn;

var bool isRunning;

defaultproperties
{
	bUsesMana = True;
	isRunning = false;
    Begin Object Name=WPawnSkeletalMeshComponent
        bOwnerNoSee=False
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human' 
        SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
        PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
    End Object

    Mesh=WPawnSkeletalMeshComponent
    Components.Add(WPawnSkeletalMeshComponent)
	ArmorType = HeavyArmor;
	MaxMultiJump = 0
	MultiJumpRemaining = 0
}

exec function StartSprint()
{
	GroundSpeed = default.GroundSpeed * 2;
	isRunning = true;
	StopFiring();
}

exec function StopSprint()
{
	GroundSpeed = default.GroundSpeed;
	isRunning = false;
}

simulated function StartFire(byte FireModeNum)
{
	if (!isRunning)
		super.StartFire(FireModeNum);
}