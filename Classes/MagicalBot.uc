
class MagicalBot extends UTBot;
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