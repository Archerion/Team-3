class MookController extends AIController;

state ScriptedMove
{
    // state functions...
    
    Begin:
    // while we have a valid pawn and move target, and
    // we haven't reached the target yet
    while (Pawn != None &&
           ScriptedMoveTarget != None &&
           !Pawn.ReachedDestination(ScriptedMoveTarget))
    {
        // check to see if it is directly reachable
        if (ActorReachable(ScriptedMoveTarget))
        {
            // then move directly to the actor
            MoveToward(ScriptedMoveTarget, ScriptedFocus);
        }
        else
        {
           // attempt to find a path to the target
           MoveTarget = FindPathToward(ScriptedMoveTarget);
           if (MoveTarget != None)
           {
               // move to the first node on the path
               MoveToward(MoveTarget, ScriptedFocus);
           }
           else
           {
               // abort the move                
               ScriptedMoveTarget = None;
           }
        }
    }
}
defaultproperties
{
	
}