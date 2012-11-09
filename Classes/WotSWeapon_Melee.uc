class WotSWeapon_Melee extends UTWeapon;

var bool PlayerHit;

var name StartSocket;
var name EndSocket;
var name WeaponSocket;

defaultproperties
{
	PlayerViewOffset=(X=20.000000,Y=0.000000,Z=-10.000000)

	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'Melee_Weapon.Melee_Weapon'
		FOV=60
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Melee_Weapon.Melee_Anime'
		//AnimTreeTemplate=AnimTree'Melee_Weapon.Melee_Weapon_Animtree'		
		Scale=0.900000
		Rotation=(Yaw=-16384)
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'Melee_Weapon.Melee_Weapon'
	End Object

	Mesh=FirstPersonMesh

	AttachmentClass=class'Melee_Attach'

	StartSocket = Start_socket
	EndSocket = end_socket

	bMeleeWeapon = true

	FireInterval(0)=1
	FireInterval(1)=1

	WeaponFireTypes(0)=EWFT_InstantHit
	WeaponFireTypes(1)=EWFT_None

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

	WeaponRange=200
	CachedMaxRange=1000

	InventoryGroup=4;
}

simulated function SendToFiringState(byte FireModeNum)
{
	`log("Animation array size: " $WeaponFireAnim.Length);
	`log("Firing state: " $FiringStatesArray[FireModeNum]);
	super.SendToFiringState(FireModeNum);
}

simulated function FireAmmunition()
{
	`log("Firing Ammunition");
	super.FireAmmunition();
}

simulated state WeaponFiring
{/*
	simulated event BeginState(name PreviousStateName)
	{
		`log("Beginning firing state");
		if(!HasAmmo(CurrentFireMode))
		{
			WeaponEmpty();
			return;
		}
		PlayFireEffects(CurrentFireMode);
		SetTimer(GetFireInterval(CurrentFireMode), false, 'RefireCheckTimer');
	}

	simulated event EndState(name NextStateName)
	{
		`log("Ending firing state");
		PlayerHit = false;
		ClearTimer('RefireCheckTimer');
		NotifyWeaponFinishedFiring(CurrentFireMode);
		return;
	}

	simulated function RefireCheckTimer()
	{
		if(bWeaponPutDown)
		{
			PutDownWeapon();
			return;
		}

		if(ShouldRefire())
		{
			PlayerHit = false;
			PlayFireEffects(CurrentFireMode);
			SetTimer(GetFireInterval(CurrentFireMode), false, 'RefireCheckTimer');
		}

		HandleFinishedFiring();
		return;
	}*/

	function Tick(float DeltaTime)
	{
		local Vector start;
		local Vector end;

		SkeletalMeshComponent(Mesh).GetSocketWorldLocationAndRotation(StartSocket, start);
		SkeletalMeshComponent(Mesh).GetSocketWorldLocationAndRotation(EndSocket, end);

		WeaponTrace(start, end);
		super.Tick(DeltaTime);

	}

	simulated event WeaponTrace(Vector start, Vector end)
	{		
		local Vector HitLocation;
		local Vector HitNormal;
		local Actor HitActor;
		local SorcererPawn SP;
		SP = SorcererPawn(SorcererPlayerController(GetALocalPlayerController()).Pawn);

		HitActor = Trace(HitLocation, HitNormal, end, start, true);

		if (HitActor == SP && !PlayerHit)
		{
			HitActor.TakeDamage(InstantHitDamage[CurrentFireMode], Pawn(Owner).Controller, 
				HitLocation, Velocity * 100.0f, class 'Melee_Damage');
			AmmoCount -= ShotCost[CurrentFireMode];
			PlayerHit = true;
		}
	}
}

simulated function PlayFireEffects(byte FireModeNum, optional Vector HitLocation)
{
	super.PlayFireEffects(FireModeNum, HitLocation);
}

simulated function StopFireEffects(byte FireModeNum)
{
	StopMuzzleFlash();
}

simulated function PlayWeaponAnimation(name Sequence, float fDesiredDuration, optional bool bLoop, optional SkeletalMeshComponent SkelMesh)
{
	if (Mesh != None && Mesh.bAttached)
	{
		Super.PlayWeaponAnimation(Sequence, fDesiredDuration, bLoop, SkelMesh);
	}
}

simulated function StopWeaponAnimation()
{
	super.StopWeaponAnimation();	
}