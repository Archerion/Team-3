class MookBot extends WotSBot;

var Pawn Target;

defaultproperties
{
	bSpawnedByKismet = true	
}

protected event ExecuteWhatToDoNext()
{
	GotoState('Idle');
}



state Searching
{
	local SorcererPawn Player;
Begin:
	foreach WorldInfo.AllPawns(class'SorcererPawn', Player)
	{
		if (Player != None)   //if there is a player pawn
      	{

        	if (CanSee(Player))
           	{
            	//look at it and shoot it
            	Pawn.SetDesiredRotation(Rotator(Normal(Player.Location)));
                Pawn.StartFire(0);
           	}
           	else
           	{
            	Pawn.StopFire(0);
           	}
		}
	}
	LatentWhatToDoNext();
}

state Idle
{
	local float playerDistance;
    event SeePlayer (Pawn Seen)
    {
        super.SeePlayer(Seen);
        Target = Seen;
        playerDistance = VSize(Pawn.Location - Target.Location);
        if(playerDistance<70)
        {
            GotoState('Shoot');
        }
        else
        {
            GotoState('Follow');
        }
    }
}

state Follow
{
Begin:
    Target = GetALocalPlayerController().Pawn;
    //Target is an Actor variable defined in my custom AI Controller.
    //Of course, you would normally verify that the Pawn is not None before proceeding.
 
    MoveToward(Target, Target, 128);
 
    LatentWhatToDoNext();
}
