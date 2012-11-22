class WotSBot extends UTBot
	abstract;


function Stun(float stunTime )
{	
	Pawn.CustomTimeDilation = 0.001f;
	ClearTimer('UnStun');
	SetTimer(stunTime, false, 'UnStun');
}

function UnStun()
{
	Pawn.CustomTimeDilation = 1.0f;
}
