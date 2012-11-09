class MookBot extends WotSBot;

var SorcererPawn Target;

defaultproperties
{
	bSpawnedByKismet = true;
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
