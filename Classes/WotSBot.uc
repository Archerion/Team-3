class WotSBot extends UTBot
	abstract;

defaultproperties
{
	
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