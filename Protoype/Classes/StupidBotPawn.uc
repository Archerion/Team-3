Class StupidBotPawn extends UTPawn
	placeable;

var(NPC) class<StupidBot> BotController;

simulated event PostBeginPlay()
{
	if (BotController != None)
	{
			ControllerClass = BotController;
	}	
}


simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
}

defaultproperties
{

	Begin Object Class=SkeletalMeshComponent Name=NPCMesh0
		SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
		PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimtreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
	End Object
	
	Mesh=NPCMesh0
	
	Components.Add(NPCMesh0)
	
	BotController=class'MagicalFPSGame.StupidBot'
}