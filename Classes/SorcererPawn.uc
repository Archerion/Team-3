class SorcererPawn extends WotSPawn;

var bool isRunning;

defaultproperties
{
	bUsesMana = True;
	isRunning = false;

	SpawnSound=SoundCue'WotS_Sound.silence_Cue'

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

function PlayTeleportEffect(bool bOut, bool bSound)
{
	// Don't.
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local string mapname;
	mapname = WorldInfo.GetMapName(false);	
	ConsoleCommand("open "@mapname);
	return true;
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
	Super.SetCharacterClassFromInfo(Info);
	SoundGroupClass=class'WotSSoundGroup_Silence';
}

exec function StartSprint()
{
	GroundSpeed = default.GroundSpeed * 1.5;
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