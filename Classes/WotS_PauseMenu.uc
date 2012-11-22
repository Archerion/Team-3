class WotS_PauseMenu extends GFxUI_PauseMenu;

var GFxClikWidget ResumeButton, MainMenuButton, QuitButton;
DefaultProperties
{
	WidgetBindings.Add((WidgetName="btn_resume", WidgetClass=class'GFxClikWidget'))
    WidgetBindings.Add((WidgetName="btn_return", WidgetClass=class'GFxClikWidget'))
    WidgetBindings.Add((WidgetName="btn_quit", WidgetClass=class'GFxClikWidget'));
}

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0);        

    RootMC = GetVariableObject("_root");
	`log("Widget name" $WidgetBindings[1].WidgetClass);
    return true;
}

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
	`log("Initializing widget");
    switch(WidgetName)
    {
            case ('btn_resume'):
                    ResumeButton = GFxClikWidget(Widget);
                    ResumeButton.AddEventListener('CLIK_press', ResumePressed);
                    break;
            case ('btn_return'):
                    MainMenuButton = GFxClikWidget(Widget);
                    MainMenuButton.AddEventListener('Clik_press', RestartLevel);
                    break;
            case ('btn_quit'):
                    QuitButton = GFxClikWidget(Widget);
                    QuitButton.AddEventListener('Clik_press', MainMenu);
                    break;
            default:
                    break;
    }
    return true;
}

function ResumePressed(GFxClikWidget.EventData ev)
{
	WotSHUD(GetPC().MyHUD).CompletePauseMenuClose();
}

function RestartLevel(GFxClikWidget.EventData ev)
{
    local string currentMapName;
    local WorldInfo WI;        

    WI = class'WorldInfo'.static.GetWorldInfo();        

    currentMapName = WI.Title;

    switch(currentMapName)
    {
		case ("Level1Sketch"):
			ConsoleCommand("open Level1Sketch");
            break;
        case ("Level3Sketch"):
			ConsoleCommand("open Level3Sketch");
            break;

        default:
            ConsoleCommand("open MainMenu");
    }
}

function MainMenu(GFxClikWidget.EventData ev)
{
	ConsoleCommand("open MainMenu");
}

function CloseMovie()
{
	RootMC.GoToAndPlay("close");
}

function FlashToConsole(string command)
{
	`log("Flashing to console");
	ConsoleCommand(command);
}