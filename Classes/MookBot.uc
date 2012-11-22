class MookBot extends WotSBot;

var Actor Destination;
var float AttackDistance;
var float SightDistance;

var float farAway;

protected event ExecuteWhatToDoNext()
{
   //Go to the roaming state
   GotoState('Roaming');
}

state Roaming
{
    ignores SeePlayer;
    //This function just returns the first player it finds
    function SorcererPawn FindEnemy()
    {
        local SorcererPawn P;

        P = SorcererPawn(GetALocalPlayerController().Pawn);
        if (SorcererPlayerController(P.Controller) != None)
        {
            return P;
        }
        Return None;
    }

    Begin:
    if(Enemy == None)
    {
        //If the bot has no enemy, find one
        Enemy = FindEnemy();
        if (Enemy.Class == class'SorcererPawn')
        {
            farAway = vsize(Pawn.Location - Enemy.Location);
            if (farAway > SightDistance)
            {
                Enemy = None;
            }
        }
    }

    if(Enemy != None)
    {
        farAway = vsize(Pawn.Location - Enemy.Location);
        if (farAway > SightDistance)
        {
            Enemy = None;
            goto('Begin');
        }

        if(farAway > AttackDistance)
        {
            if(FindBestPathToward(Enemy, false, false))
            {
                MoveToward(MoveTarget,,,False);
            }
            else
            {
                MoveToward(Enemy, , ,False);
            }
        }
        else
        {
            GotoState('Attack');
        }
    }
    else
    {
        //Find a random pathnode and go to it
        MoveTo(FindRandomDest().Location);
    }
    goto('Begin');
}

state Attack
{
    Begin:
    FireWeaponAt(Focus);
    GotoState('Roaming');
}

defaultproperties
{
    SightDistance=1200
    AttackDistance=150
    bSpawnedByKismet = true
}