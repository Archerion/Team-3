class WotSHUD extends UTHUD;

var String Text;
var String Text2;
var float Time;
var bool Activated;
var bool Centered;
var bool TimerSet;
var float TextSizeCenteredX;
var float TextSizeCenteredY;
var float DialogScaling;

function DrawGameHud()
{
	
	Canvas.SetPos(Canvas.ClipX/2,Canvas.ClipY/2);
	Canvas.SetDrawColor(0,0,255,255);
	Canvas.Font	= class'Engine'.static.GetMediumFont();
	
	if ( !PlayerOwner.IsDead() && !UTPlayerOwner.IsInState('Spectating'))
	{
		DrawBar("Health",SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).Health, SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).HealthMax,20,Canvas.ClipY - 20,200,80,80);
		DrawBar("Mana",SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).CurrentMana, SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).MaxMana,20,Canvas.ClipY - 40,80,80,200);
		DrawBar("Weapon XP",WotSWeapon_ManaRifleBase(SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).Weapon).WeaponExperience, 
							WotSWeapon_ManaRifleBase(SorcererPawn(SorcererPlayerController(PlayerOwner).Pawn).Weapon).RequiredExpToLevel,20,Canvas.ClipY - 60,173,255,47);
    }
}

function DisplayDialogText(String TextInput, String TextInput2, float TimeInput, bool CenteredInput)
{
	Text = TextInput;
	Text2 = TextInput2;
	Time = TimeInput;
	Centered = CenteredInput;

	Activated = true;

	`log("Drawing text: " $TextInput);
}

event PostRender()
{
	super.PostRender();
	if(Activated)
	{
		Canvas.SetDrawColor(255, 200, 0, 200);
		Canvas.Font = class'Engine'.static.GetSubtitleFont();

		if(Centered)
		{
			Canvas.TextSize(Text, TextSizeCenteredX, TextSizeCenteredY);
			Canvas.SetPos(Canvas.ClipX / 2 - TextSizeCenteredX / 2, Canvas.ClipY / 2);
			Canvas.DrawText(Text);

			Canvas.TextSize(Text2, TextSizeCenteredX, TextSizeCenteredY);
			Canvas.SetPos(Canvas.ClipX / 2 - TextSizeCenteredX / 2, Canvas.ClipY / 2 + TextSizeCenteredY);
			Canvas.DrawText(Text2);
		}
		else
		{
			Canvas.SetPos(Canvas.ClipX * 0.35, Canvas.ClipY * 0.8);
			Canvas.DrawText(Text);
			Canvas.DrawText(Text2);
		}

		if(!TimerSet)
		{
			TimerSet=true;
			SetTimer(Time, false, 'TimerReset');
		}

	}
}

// Deactivates text on screen
function TimerReset()
{
	TimerSet = false;
	Activated = false;
}

defaultproperties
{
	TimerSet=false
	Activated=false
	DialogScaling=1.2f;
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

exec function ShowMenu()
{
	TogglePauseMenu();
}

function TogglePauseMenu()
{
	if(PauseMenuMovie != none && PauseMenuMovie.bMovieIsOpen)
    {
    PauseMenuMovie.Close();
    }

	else
    {
        PlayerOwner.SetPause(true); 

        if (PauseMenuMovie == none)
        {
            PauseMenuMovie = new class'WotS_PauseMenu';
            PauseMenuMovie.MovieInfo = SwfMovie'WotSPauseMenu.PauseMenu.WotS_PauseMenu';
            PauseMenuMovie.bEnableGammaCorrection = false;
            PauseMenuMovie.LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocalPlayer(PlayerOwner.Player));
            PauseMenuMovie.SetTimingMode(TM_Real);
        }

        PauseMenuMovie.Start();
        PauseMenuMovie.AddFocusIgnoreKey('Escape');
    }
}

function CompletePauseMenuClose()
{
	PlayerOwner.SetPause(false);
    PauseMenuMovie.Close(false);
}

function FlashToConsole(string command)
{
	`log("Flashing to console");
	ConsoleCommand(command);
}