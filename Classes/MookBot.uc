class MookBot extends WotSBot;

var Actor Destination;

var float attackRange;

protected event ExecuteWhatToDoNext()
{
   //Go to the roaming state
   GotoState('Roaming');
}

state Roaming
{
    function SetDestination()
    {
        Destination = GetALocalPlayerController().Pawn;
    }
    function float getDistance(Actor Dest)
    {
       return vsize(Pawn.Location - Dest.Location);
    }
Begin:
    if (Destination==None)
    {
       SetDestination(); 
    }
    else if (getDistance(Destination) > attackRange)
    {
        if (FindBestPathToward(Destination, false, false))
        {
            MoveToward(MoveTarget,,,False);
        }
        else 
        {
            MoveToward(Destination);
        }
    } else
    {
        GotoState('Attack');
    }
    ExecuteWhatToDoNext();
}

state Attack
{
    Begin:
        FireWeaponAt(Focus);
    ExecuteWhatToDoNext();
}

event SeePlayer(Pawn SeenPlayer)
{
    // NO!
}

defaultproperties
{
    attackRange = 130
    bSpawnedByKismet = true
}