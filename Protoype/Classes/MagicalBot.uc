class MagicalBot extends UTBot;

var Actor Destination;
var() Vector TempDest;
var vector nextlocation;

defaultproperties
{
	bSpawnedByKismet = true
}


function Stun(float stunTime )
{
	
	Pawn.CustomTimeDilation = 0.0f;
	ClearTimer('UnStun');
	SetTimer(stunTime, false, 'UnStun');
}

function UnStun()
{
	Pawn.CustomTimeDilation = 1.0f;

}


protected event ExecuteWhatToDoNext()
{	
	GotoState('Roaming');
}

state Roaming
{
Begin:  

	if(Destination == none || Pawn.ReachedDestination(Destination))
	{
		do
		{
		Destination = FindRandomDest();
		} until (PointReachable(Destination.Location));
	}

	//Find a path to the destination and move to the next node in the path
	MoveToward(FindPathToward(Destination), FindPathToward(Destination));

	//fire off next decision loop
	LatentWhatToDoNext();
}


state Dead
{
Begin:
	Destroy();
}
