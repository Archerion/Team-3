class SeqAct_DialogSystem extends SequenceAction;

var() String text;
var() String text2;

var() float time;

var() bool centered;



DefaultProperties
{
	ObjName="Display HUD text"
	ObjCategory="Player HUD"
	Name="Default__PBHUDAct_DisplayText"
	ObjectArchetype=SequenceAction'Engine.Default_SequenceAction'

	centered=true

	bCallHandler=false
}
