class WotSHUD extends UTHUD;

var String Text;
var String Text2;
var float Time;
var bool Activated;
var bool Centered;
var float CenterX;
var float CenterY;

function DrawGameHud()
{
	
	Canvas.SetPos(Canvas.ClipX/2,Canvas.ClipY/2);
	Canvas.SetDrawColor(0,0,255,255);
	Canvas.Font	= class'Engine'.static.GetMediumFont();
	
	if ( !PlayerOwner.IsDead() && !UTPlayerOwner.IsInState('Spectating'))
	{
		DrawBar("Health",PlayerOwner.Pawn.Health, PlayerOwner.Pawn.HealthMax,20,Canvas.ClipY - 20,200,80,80);
		DrawBar("Mana",SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).CurrentMana, SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).MaxMana,20,Canvas.ClipY - 40,80,80,200);
		// DrawBar("Shield",MagicalPawn(PC.Pawn).ShieldStrength,MagicalPawn(PC.Pawn).ShieldStrengthMax, 20, Canvas.ClipY - 60, 80, 200, 80);
    }    
}

function DisplayDialogText(String TextInput, String TextInput2, float TimeInput, bool CenteredInput)
{
	Text = TextInput;
	Text2 = TextInput2;
	Time = TimeInput;
	Centered = CenteredInput;

	Activated = true;
}

event PostRender()
{
	local float CenterX;
	local float CenterY;
	
	CenterX = Canvas.ClipX;
	CenterY = Canvas.ClipY;
	if(Activated)
	{
		Canvas.SetDrawColor(0, 0, 0, 255);
		Canvas.Font = class'Engine'.static.GetLargeFont();

		if(Centered)
		{
			Canvas.TextSize(Text, 

		}
		else
		{
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