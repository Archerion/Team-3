class WotSWeapon_Melee extends UTWeapon;
/*
var array<Actor> HitArray;

var name StartSocket;
var name EndSocket;

defaultproperties
{
	PlayerViewOffset=(X=20.000000,Y=0.000000,Z=-8.000000)

	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'WotS.SkeletalMesh.MeleeWeapon'
		FOV=60
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'WotS.SkeletalMesh.Cylinder'
		bForceUpdateAttachmentsInTick=true
		Scale=0.900000
	End Object

	FireInterval(0)=1
	FireInterval(1)=1

	bInstantHit=true

	InstantHitDamage(0)=50.0
	InstantHitDamage(1)=25.0

	DefaultAnimSpeed=0.9
       
	ShotCost(0)=0
	ShotCost(1)=0

	MessageClass=class'UTPickupMessage'
	DroppedPickupClass=class'UTDroppedPickup'

	MaxAmmoCount=1
	AmmoCount=1

	WeaponRange=100
}

simulated state WeaponFiring
{
	simulated event BeginState(name PreviousStateName)
	{
		if(!HasAmmo(CurrentFireState))
		{
			WeaponEmpty();
			return;
		}

		PlayFireEffects(CurrentFireState);
		SetTimer(GetFireInterval(CurrentFireMode), false, 'RefireCheckTimer');
	}

	simulated event EndFire(name NextStateName)
	{
		HitArray.Length = 0;
		ClearTimer('RefireCheckTimer');
	}
}*/