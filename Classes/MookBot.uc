class MookBot extends WotSBot;

defaultproperties
{
	bSpawnedByKismet = true;
}

function PostBeginPlay()
{
    Super.PostBeginPlay();
    SetTeam(1);
}

/*
auto state Follow
{
Begin:
    Target = SorcererPawn(GetALocalPlayerController().Pawn);
	`log("Target: " $Target);
    //Target is an Actor variable defined in my custom AI Controller.
    //Of course, you would normally verify that the Pawn is not None before proceeding.
 
    MoveToward(Target, Target, 128);
	goto 'Begin';
}*/
