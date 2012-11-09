class WotSPawn extends UTPawn
	abstract;

var(Mana) bool bUsesMana;
var(Mana) float ManaRechargeRate;
var(Mana) float MaxMana;
var float CurrentMana;
var float TimeSinceRecharged;
var float BurnDamage;
var float BurnTimer;
var float TimeBetweenIterations;
var vector BurnVector;
var float ExpWorth;

enum Armors {
	Unarmored, 
	LightArmor, 
	HeavyArmor
};

var Armors ArmorType;

defaultproperties
{
	bUsesMana = False;
	ManaRechargeRate = 1.0;
	TimeSinceRecharged = 0.0;
	CurrentMana = 100;   
	MaxMana = 100;
	BurnDamage = 0;
	BurnTimer = 0;
	ArmorType = LightArmor;
	ExpWorth = 100;
}

function ThrowWeaponOnDeath()
{
	// don't.
}

simulated function PostBeginPlay()
{
	InitializeArmor();
	super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
	local SorcererPlayerController PC;

	foreach LocalPlayerControllers(class'SorcererPlayerController', PC)
	{
	
		TimeSinceRecharged += DeltaTime;
		if (TimeSinceRecharged >= 0.20)
		{
			GiveMana(1);
			TimeSinceRecharged = 0.0;
		}
	}
	Super.Tick(DeltaTime);
}

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Damage = ModifyDamage(Damage, EventInstigator, DamageType);

	if (DamageType == class'WotSSPLLightningDamage' && EventInstigator.IsA('SorcererPlayerController'))
	{
		SorcererPawn(SorcererPlayerController(EventInstigator).pawn).Heal(
			Damage * WotSWeapon_ManaRifleLightning(EventInstigator.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleLightning')).HealthDrain);
	}

	super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum,  DamageType, HitInfo, DamageCauser);
}

function int ModifyDamage(int Damage, Controller EventInstigator, class <DamageType> DamageType)
{	
	local float SlowDuration;
	local float BurnDuration;

	if (DamageType == class 'WotSPRJBurnDamage')
	{
		Damage *= 0.7;
	}
		
	else if (DamageType == class 'WotSSPLBurnDamage')
	{
		BurnDuration = 3;
		SlowDuration = 3;
			
		if (ArmorType == HeavyArmor)
		{
			BurnDuration = 6;
			SlowDuration = 6;
		}
			Slow(50, SlowDuration);
			TakeFire(BurnDuration, 5, 0.5);		
	}
		
	else if(DamageType == class 'WotSPRJLightningDamage')
	{
		MookBot(Controller).Stun(0.5);
	}
		
	else if(DamageType == class 'WotSSPLLightningDamage')
	{
		if (ArmorType == LightArmor)
		{
			Damage = 10;
		}
			
		else
		{
			Damage = 5;
		}
	}
		
	else if(DamageType == class 'WotSPRJFrostDamage')
	{
		if (ArmorType == Unarmored)
		{
			Damage = 15;
		} 
			
		else 
		{
			Damage = 10;
		}
	}
		
	else if(DamageType == class 'WotSSPLFrostDamage')
	{
		MookBot(Controller).Stun(5);
	}	
	return Damage;
}

function bool Died(Controller Killer, class<DamageType> damageType, Vector HitLocation)
{
	if(Killer.IsA('SorcererPlayerController'))
	{
		if(damageType == class'WotSPRJFrostDamage' || damageType == class'WotSSPLFrostDamage')
			WotSWeapon_ManaRifleFrost(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleFrost')).AddXPToWeapon(ExpWorth);
	
		else if(damageType == class'WotSPRJLightningDamage' || damageType == class'WotSSPLLightningDamage')
			WotSWeapon_ManaRifleLightning(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleLightning')).AddXPToWeapon(ExpWorth);
	
		else if(damageType == class'WotSPRJBurnDamage' || damageType == class'WotSSPLBurnDamage')
			WotSWeapon_ManaRifleFire(Killer.Pawn.InvManager.FindInventoryType(class 'WotSWeapon_ManaRifleFire')).AddXPToWeapon(ExpWorth);
	}
	return super.Died(Killer, damageType, HitLocation);
}	

function float GiveMana(float Amount)
{
	CurrentMana += Amount;
	
	if (CurrentMana > MaxMana)
	{
		CurrentMana = MaxMana;
	}
	return CurrentMana;
}

function float TakeMana(float Amount)
{
	CurrentMana -= Amount;
	if (CurrentMana < 0)
	{
		CurrentMana = 0;
	}
	return CurrentMana;
}

function float CheckMana()
{
	return CurrentMana;
}

function TakeFire(float Duration, float DamagePerIteration, float tBtwItr)
{
	BurnDamage = DamagePerIteration ;
	BurnTimer = Duration;
	TimeBetweenIterations = tBtwItr;
	SetTimer(TimeBetweenIterations, true, 'TakeBurnDamage');
}

function TakeBurnDamage()
{
	if (BurnTimer > 0)
	{	
		BurnTimer -= TimeBetweenIterations;
		TakeDamage(BurnDamage, None, BurnVector*0, BurnVector*0, class 'WotSPRJBurnDamage',, self);
	}
	else 
	{
		ClearTimer('TakeBurnDamage');
	}
}

function Slow(float SlowAmount, optional float SecondsToBeSlowed = 0)
{
	GroundSpeed *= 1-SlowAmount;
	AirSpeed *= 1-SlowAmount;
	WaterSpeed *= 1-SlowAmount;
	Mesh.GlobalAnimRateScale *= 1-SlowAmount;
	ClearTimer('UnFreeze');
	if (SecondsToBeSlowed > 0)
	{
		SetTimer(SecondsToBeSlowed, false, 'UnSlow');
	}
}

function UnSlow()
{
	Mesh.GlobalAnimRateScale = Mesh.Default.GlobalAnimRateScale;
	GroundSpeed = Default.GroundSpeed;
	AirSpeed = Default.AirSpeed;
	WaterSpeed = Default.WaterSpeed;
}

function InitializeArmor()
{
	switch (ArmorType)
		{
		case LightArmor:
			Health += 30;
			GroundSpeed *= 0.9;
			break;
		case HeavyArmor:
			Health += 60;
			GroundSpeed *= 0.8;
			break;
		}
}

function Heal(float HealAmount)
{
	Health += HealAmount;
	if (Health > HealthMax)
		Health = HealthMax;
}

simulated function WeaponAttachmentChanged()
{
	`log("Attachment changed");
	if ((CurrentWeaponAttachment == None || CurrentWeaponAttachment.Class != CurrentWeaponAttachmentClass) && Mesh.SkeletalMesh != None)
	{
		// Detach/Destroy the current attachment if we have one
		if (CurrentWeaponAttachment!=None)
		{
			`log("destroying previous attachment");
			CurrentWeaponAttachment.DetachFrom(Mesh);
			CurrentWeaponAttachment.Destroy();
		}

		// Create the new Attachment.
		if (CurrentWeaponAttachmentClass!=None)
		{
			`log("Creating new attachment");
			CurrentWeaponAttachment = Spawn(CurrentWeaponAttachmentClass,self);
			CurrentWeaponAttachment.Instigator = self;
		}
		else
			CurrentWeaponAttachment = none;

		// If all is good, attach it to the Pawn's Mesh.
		if (CurrentWeaponAttachment != None)
		{
			`log("Attaching weapon to pawn");
			CurrentWeaponAttachment.AttachTo(self);
			CurrentWeaponAttachment.SetSkin(ReplicatedBodyMaterial);
			CurrentWeaponAttachment.ChangeVisibility(bWeaponAttachmentVisible);
			`log("Mesh: "$Mesh);
			`log("Current Weapon Attachment: "$CurrentWeaponAttachment);
		}
	}
}

simulated function WeaponFired(Weapon InWeapon, bool bViaReplication, optional vector HitLocation)
{
	`log("Weapon fired");
	if (CurrentWeaponAttachment != None)
	{
		`log("Current weapon attachment: " $CurrentWeaponAttachment);
		if ( !IsFirstPerson() )
		{
			`log("Firing third person");
			CurrentWeaponAttachment.ThirdPersonFireEffects(HitLocation);
		}
		else
		{
			`log("Firing first person");
			CurrentWeaponAttachment.FirstPersonFireEffects(Weapon, HitLocation);
	                if ( class'Engine'.static.IsSplitScreen() && CurrentWeaponAttachment.EffectIsRelevant(CurrentWeaponAttachment.Location,false,CurrentWeaponAttachment.MaxFireEffectDistance) )
	                {
		                // third person muzzle flash
		                CurrentWeaponAttachment.CauseMuzzleFlash();
	                }
		}

		if ( HitLocation != Vect(0,0,0) && (WorldInfo.NetMode == NM_ListenServer || WorldInfo.NetMode == NM_Standalone || bViaReplication) )
		{
			CurrentWeaponAttachment.PlayImpactEffects(HitLocation);
		}
	}
}
