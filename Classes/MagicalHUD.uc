
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
			DrawBar("Health",PC.Pawn.Health, PlayerOwner.Pawn.HealthMax,20,Canvas.ClipY - 20,200,80,80);
			DrawBar("Mana",PC.CurrentMana, PC.MaxMana,20,Canvas.ClipY - 60,80,80,200);
			DrawBar("Ammo",MagicalInventoryManager(PC.Pawn.InvManager).GetAmmoCount(), MagicalInventoryManager(PC.Pawn.InvManager).GetMaxAmmoCount(),20,Canvas.ClipY-40,200,200,80);  
		}
	}
}

defaultproperties
{
}

function DrawBar(String Title, float Value, float MaxValue,int X, int Y, int R, int G, int B)
{

    local int PosX,NbCases,i;

    PosX = X; // Where we should draw the next rectangle
    NbCases = 100 * Value / MaxValue; // Number of active rectangles to draw
    i=0; // Number of rectangles already drawn

    /* Displays active rectangles */
    while(i < NbCases && i < 100)
    {
        Canvas.SetPos(PosX,Y);
        Canvas.SetDrawColor(R,G,B,200);
        Canvas.DrawRect(2,12);

        PosX += 2;
        i++;

    }

    /* Displays deactived rectangles */
    while(i < 100)
    {
        Canvas.SetPos(PosX,Y);
        Canvas.SetDrawColor(255,255,255,80);
        Canvas.DrawRect(2,12);

        PosX += 2;
        i++;

    }

    /* Displays a title */
    Canvas.SetPos(PosX + 5,Y);
    Canvas.SetDrawColor(R,G,B,200);
    Canvas.Font = class'Engine'.static.GetSmallFont();
    Canvas.DrawText(Title);

} 