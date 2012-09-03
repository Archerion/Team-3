
class MagicalHUD extends UTHUD;

function DrawGameHud()
{
	local MagicalPlayerController PC;
	
	Canvas.SetPos(Canvas.ClipX/2,Canvas.ClipY/2);
	Canvas.SetDrawColor(0,0,255,255);
	Canvas.Font	= class'Engine'.static.GetMediumFont();
	
	
	foreach LocalPlayerControllers(class'MagicalPlayerController', PC)
	
	{
	
		if ( !PlayerOwner.IsDead() && !UTPlayerOwner.IsInState('Spectating'))
		{
			DrawBar("Health",PlayerOwner.Pawn.Health, PlayerOwner.Pawn.HealthMax,20,Canvas.ClipY - 20,200,80,80);
			DrawBar("Ammo",MagicalInventoryManager(PC.Pawn.InvManager).GetAmmoCount(), MagicalInventoryManager(PC.Pawn.InvManager).GetMaxAmmoCount(),20,Canvas.ClipY-40,200,200,80); 
			DrawBar("Mana",PC.CurrentMana, PC.MaxMana,20,Canvas.ClipY - 60,80,80,200);
			DrawBar("Shield",MagicalPawn(PC.Pawn).SS,MagicalPawn(PC.Pawn).SSMax, 20, Canvas.ClipY - 80, 80, 200, 80);
		}
	}
}

defaultproperties
{
}

function DrawBar(String s, float v, float mv,int X, int Y, int R, int G, int B)
{

    local int PosX,TotalRects,i;

    PosX = X;
    TotalRects = 100 * v / mv;
    i=0;

    while(i < TotalRects && i < 100)
    {
        Canvas.SetPos(PosX,Y);
        Canvas.SetDrawColor(R,G,B,200);
        Canvas.DrawRect(2,12);

        PosX += 2;
        i++;

    }

    while(i < 100)
    {
        Canvas.SetPos(PosX,Y);
        Canvas.SetDrawColor(255,255,255,80);
        Canvas.DrawRect(2,12);

        PosX += 2;
        i++;

    }

    Canvas.SetPos(PosX + 5,Y);
    Canvas.SetDrawColor(R,G,B,200);
    Canvas.Font = class'Engine'.static.GetSmallFont();
    Canvas.DrawText(s);

} 