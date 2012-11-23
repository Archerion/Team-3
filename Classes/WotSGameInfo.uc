class WotSGameInfo extends UTGame;

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return class'WotSGameInfo';
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	class'WotSWeapon_ManaRifleFire'.default.WeaponExperience = 0;
	class'WotSWeapon_ManaRifleFire'.default.WeaponLevel = 0;
	class'WotSWeapon_ManaRifleFire'.default.RequiredExpToLevel = 0;
	class'WotSWeapon_ManaRifleFire'.Static.StaticSaveConfig();

	class'WotSWeapon_ManaRifleFrost'.default.WeaponExperience = 0;
	class'WotSWeapon_ManaRifleFrost'.default.WeaponLevel = 0;
	class'WotSWeapon_ManaRifleFrost'.default.RequiredExpToLevel = 0;
	class'WotSWeapon_ManaRifleFrost'.Static.StaticSaveConfig();
}

function ScoreKill(Controller Killer, Controller Other)
{
	// No scoring please.
}

function ScoreKill(Controller Killer, Controller Other)
{
	// No scoring please.
}

function BroadcastDeathMessage(Controller Killer, Controller Other, class<DamageType> DamageType)
{
	// no.
}

function NotifySpree(UTPlayerReplicationInfo Other, int num)
{
	// No sprees!
}

function EndSpree(UTPlayerReplicationInfo Killer, UTPlayerReplicationInfo Other)
{
	// No sprees, I tell you!
}

defaultproperties
{
	PlayerControllerClass=class'WotS.SorcererPlayerController'
	DefaultPawnClass=class'WotS.SorcererPawn'
	HUDType=class'WotS.WotSHUD'
	bDelayedStart=false
	bUseClassicHUD=true //Needed to use traditional HUD instead of ScaleForm HUD
	DeathMessageClass=class'WotSMessage';
	DefaultInventory(0)=class'WotSWeapon_ManaRifleFire'
	DefaultInventory(1)=class'WotSWeapon_ManaRifleFrost'
	bSkipPlaySound = true
	bFirstBlood = true;
	CountDown = 0;
	bFirstBlood = false;
	bSkipPlaySound = true;
	bQuickStart = true;
	bFinalStartup = true;
	bOverTimeBroadcast = true;
	bMustHaveMultiplePlayers = false;
}