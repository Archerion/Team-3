
class MagicalGameInfo extends UTGame;
var MagicalBotPawn BotP;

simulated function PostBeginPlay()
{
	local Vector SpawnLocationVector;
	Super.PostBeginPlay();
	SpawnLocationVector.X = 0;
	SpawnLocationVector.Y = 0;
	SpawnLocationVector.Z = 300;
	
	BotP = Spawn(class'MagicalFPSGame.MagicalBotPawn',,, SpawnLocationVector);
}


defaultproperties
{
   PlayerControllerClass=class'MagicalFPSGame.MagicalPlayerController'
   DefaultPawnClass=class'MagicalFPSGame.MagicalPawn'
   HUDType=class'MagicalFPSGame.MagicalHUD'
   bDelayedStart=false
   bUseClassicHUD=true
   DefaultInventory(0)=class'UTWeap_ManaRifleBasic'
   DefaultInventory(1)=class'UTWeap_ManaRifleFire'
   DefaultInventory(2)=class'UTWeap_ManaRifleFrost'
}
