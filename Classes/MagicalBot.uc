
class MagicalBot extends UTBot;

var Actor Destination;

defaultproperties
{	
	
}

function Stun(float TimeStunned)
{
	CustomTimeDilation = 0.0f;
	ClearTimer('UnStun');
}

function UnStun()
{
	CustomTimeDilation = 1.0f;
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
		Destination = FindRandomDest();
	}

	//Find a path to the destination and move to the next node in the path
	MoveToward(FindPathToward(Destination), FindPathToward(Destination));

	//fire off next decision loop
	LatentWhatToDoNext();
}
