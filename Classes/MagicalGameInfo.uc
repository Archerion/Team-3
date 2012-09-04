
class MagicalGameInfo extends UTGame;
var Pawn BotP;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	BotP = Spawn(class'MagicalFPSGame.StupidBotPawn');


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
