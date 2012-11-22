class WotSGameInfo extends UTGame;

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return class'WotSGameInfo';
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> DamageType)
{
	// no.
}

defaultproperties
{
	PlayerControllerClass=class'WotS.SorcererPlayerController'
	DefaultPawnClass=class'WotS.SorcererPawn'
	HUDType=class'WotS.WotSHUD'
	bDelayedStart=false
	bUseClassicHUD=true //Needed to use traditional HUD instead of ScaleForm HUD

	DefaultInventory(0)=class'WotSWeapon_ManaRifleFire'
	DefaultInventory(1)=class'WotSWeapon_ManaRifleFrost'
	bSkipPlaySound = true
	bFirstBlood = false;
	CountDown = 0;
	bQuickStart = true;
	bFinalStartup = true;
	bOverTimeBroadcast = true;
	bMustHaveMultiplePlayers = false;
}