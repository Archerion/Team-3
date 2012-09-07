
class MagicalGameInfo extends UTGame;
var MagicalBotPawn BotT;

simulated function PostBeginPlay()
{
	
	Super.PostBeginPlay();

}


defaultproperties
{
   PlayerControllerClass=class'MagicalFPSGame.MagicalPlayerController'
   DefaultPawnClass=class'MagicalFPSGame.MagicalPawn'
   HUDType=class'MagicalFPSGame.MagicalHUD'
   bDelayedStart=false
   bUseClassicHUD=true
   DefaultInventory(0)=class'UTWeap_ManaRifleLightning'
   DefaultInventory(1)=class'UTWeap_ManaRifleFire'
   DefaultInventory(2)=class'UTWeap_ManaRifleFrost'
}

function SpawnTestBot()
{
}
