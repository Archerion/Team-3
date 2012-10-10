class SeqAct_DialogSystem extends SequenceAction;

var() String text;
var() String text2;

var() float time;

var() bool centered;

event Activated()
{
	local SorcererPlayerController SCP;
	local WotSHUD hudVar;

	if(Targets.Length == 0)
	{
		`log("Dialog not working");
	}

	else
	{
		if(Targets[0].IsA('SorcererPlayerController'))
		{
			SCP = SorcererPlayerController(Targets[0]);

			if(SCP != none)
			{
				hudVar = WotSHUD(SCP.myHUD);
				if(!hudVar.Activated)
				{
					hudVar.DisplayDialogText(Text, Text2, Time, Centered);
				}
				else
				{
					`log("No target");
				}
			}
				

		}

	}
}

DefaultProperties
{
	ObjName="Display HUD text"
	ObjCategory="Player HUD"
	Name="Default__PBHUDAct_DisplayText"
	ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'

	centered=true

	bCallHandler=false
}
