class WotSWeapon_Melee extends WotSWeapon
	abstract;

var SorcererPawn P;

defaultproperties
{
	InstantHitDamage(0)=75.0
	InstantHitDamage(1)=35.0
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'Melee_Weapon.Melee_Weapon'
	End Object

	AttachmentClass=class'Melee_Attach'

	bMeleeWeapon = true


	DefaultAnimSpeed=0.9
       
	ShotCost(0)=0
	ShotCost(1)=0

	MessageClass=class'UTPickupMessage'
	DroppedPickupClass=class'UTDroppedPickup'

	MaxAmmoCount=1
	AmmoCount=1

	WeaponRange=100
	InventoryGroup=4
}

simulated state WeaponEquipping
{
	simulated event BeginState(Name PreviousStateName)
	{
		P = SorcererPawn(Instigator);
		
		super.BeginState(PreviousStateName);
	}
}

simulated function FireAmmunition()
{
	local vector hitLocation, hitNormal, traceEnd, traceStart;
	local Actor hitActor;
	
	traceEnd = hitNormal * 70.f; //P.Location - Vector(P.Controller.Rotation) * 192.f;

	hitActor = Trace(hitLocation, hitNormal, traceEnd );

	if (hitActor != None)
	{
		`log("Hit: "$hitActor);
	}
	else
	{
		`log("Hit None");
	}
}