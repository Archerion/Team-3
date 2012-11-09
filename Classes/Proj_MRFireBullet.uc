class Proj_MRFireBullet extends Proj_MRBullet;

defaultproperties
{

	DamageRadius = 192;
	FlightFXColor=(X=0.8,Y=0.2,Z=0.2)
	MyDamageType = class'WotSPRJBurnDamage'
}

simulated function PostBeginPlay()
{
	local float WLevel;
	if(Instigator.IsA('SorcererPawn'))
	{
		WLevel = WotSWeapon_ManaRifleFire(Instigator.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleFire')).GetLevel();
		DamageRadius = default.DamageRadius * ((WLevel + 1) / 2);
	}

	super.PostBeginPlay();
}