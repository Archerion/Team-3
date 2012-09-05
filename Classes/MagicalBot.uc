
class MagicalBot extends UTBot;

var Actor Destination;

defaultproperties
{		
}


function Stun()
{
Pawn.CustomTimeDilation=0.0;
SetTimer(10.0, false, 'UnStun');
}

function UnStun()
{
Pawn.CustomTimeDilation=1.0;
GoToState('Roaming');
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
	MoveToward(FindPathToward(Destination), FindPathToward(Destination));
	LatentWhatToDoNext();
}

