class MookBot_Ranged extends MookBot;

defaultproperties
{
    SightDistance=12000
    AttackDistance=800
    bSpawnedByKismet = true
}

state Roaming
{

    ignores SeePlayer, HearNoise, Touch;
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
        else {
        	Enemy = None;
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

        if(FindBestPathToward(Enemy, false, false))
        {
            MoveToward(MoveTarget,,,False);
        }
        else
        {
            MoveToward(Enemy, , ,False);
        }

        GotoState('Attack');
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
