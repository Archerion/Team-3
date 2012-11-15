class WotSWeapon_ManaRifleLightning extends UTWeap_LinkGun;

var float UsedAmmo;
var float AddedAmmoCostOverTime;
var float TimeCounter;
var float ManaUsePerSecond;
var int WeaponExperience;
var int WeaponLevel;

defaultproperties
{
	WeaponProjectiles(0)=class'Proj_MRLightningBullet'
	WeaponProjectiles(1)=class'Proj_MRLightningSpell'
	InventoryGroup=1

	ShotCost(0) = 0;
	ShotCost(1) = 0;

	BeamAmmoUsePerSecond = 5;
	ManaUsePerSecond = 5;
	AddedAmmoCostOverTime = 0;
	TimeCounter = 0;
	UsedAmmo = 0;

	PlayerViewOffset=(X=20.000000,Y=-10.000000,Z=-10.000000)

	Begin Object Class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'Player_Weapon.Player_Weapon_elec'		
		Animations=MeshSequenceA
		AnimSets(0)=AnimSet'Player_Weapon.Player_Weapon_AnimSet'		
		Scale=0.900000
		FOV=60
	End Object
}

simulated function FireAmmunition()
{
	local SorcererPawn SP;
	local float PrimaryCost;
	SP = SorcererPawn(SorcererPlayerController(GetALocalPlayerController()).Pawn);	
	
	PrimaryCost = 2;

	if (CurrentFireMode == 0)
	{
		if (SP.CheckMana() >= PrimaryCost)
		{
				SP.TakeMana(PrimaryCost);
				Super.FireAmmunition();
		}
	}
}

simulated function ProcessBeamHit(vector StartTrace, vector AimDir, out ImpactInfo TestImpact, float DeltaTime)
{
	local SorcererPawn SP;
	SP = Sorcererpawn(SorcererPlayerController(GetALocalPlayerController()).Pawn);
	
	
	UsedAmmo = ManaUsePerSecond * DeltaTime + AddedAmmoCostOverTime * DeltaTime;
	TimeCounter += DeltaTime;

	if(TimeCounter >= 0.5)
	{
		AddedAmmoCostOverTime += 5;
		TimeCounter = 0;
	}

	if (SP.CheckMana() >= UsedAmmo)
	{
		SP.TakeMana(UsedAmmo);
		Super.ProcessBeamHit(StartTrace, AimDir, TestImpact, DeltaTime);
	}
	else
	{			
		EndFire(1);
	}
}

simulated function EndFire(byte FireModeNum)
{
	AddedAmmoCostOverTime = 0;
	super.EndFire(FireModeNum);
}

simulated function UpdateBeamEmitter(vector FlashLocation, vector HitNormal, actor HitActor)
{
	local SorcererPawn SP;
	SP = SorcererPawn(SorcererPlayerController(GetALocalPlayerController()).Pawn);
	
	if (SP.CheckMana() >= UsedAmmo)
	{
		super.UpdateBeamEmitter(FlashLocation, HitNormal, HitActor);
	}
}

function AddXPToWeapon(int xp)
{
	WeaponExperience += xp;
}

function int GetWeaponXP()
{
	return WeaponExperience;
}

function LevelUp()
{
	if (WeaponLevel < 3)
	{
		WeaponLevel += 1;
	}
}

function int GetLevel()
{
	return WeaponLevel;
}