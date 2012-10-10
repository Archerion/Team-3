class WotSArmor extends Object;


enum Armors {
	Unarmored, 
	LightArmor, 
	MediumArmor, 
	HeavyArmor};

var Armors TypeOfArmor;

DefaultProperties
{
	TypeOfArmor = Unarmed
}

function SetArmorType(Armors armor)
{
	TypeOfArmor = armor;
}

function ModerateDamage(int Damage, class<DamageType> DamageType, Actor DamageTaker)
{		
	local float SlowDuration;
	local float BurnDuration;

	local WotSPawn DmgTaker;
	DmgTaker = WotsPawn(DamageTaker);
		
	if (DamageType == class 'WotSPRJBurnDamage')
	{
		DmgTaker.ModDamage = Damage * 0.7;
	}
		
	else if (DamageType == class 'WotSSPLBurnDamage')
	{
		BurnDuration = 3;
		SlowDuration = 3;
			
		if (TypeOfArmor == HeavyArmor)
		{
			BurnDuration = 6;
			SlowDuration = 6;
		}
			DmgTaker.Slow(50, SlowDuration);
			DmgTaker.TakeFire(BurnDuration, 5, 0.5);		
	}
		
	else if(DamageType == class 'WotSPRJLightningDamage')
	{
		DmgTaker.Stun(0.5);
	}
		
	else if(DamageType == class 'WotSSPLLightningDamage')
	{
		if (TypeOfArmor == MediumArmor)
		{
			DmgTaker.ModDamage = 10;
		}
			
		else
		{
			DmgTaker.ModDamage = 5;
		}
	}
		
	else if(DamageType == class 'WotSPRJFrostDamage')
	{
		if (TypeOfArmor == Unarmored)
		{
			DmgTaker.ModDamage = 15;
		} 
			
		else 
		{
			DmgTaker.ModDamage = 10;
		}
	}
		
	else if(DamageType == class 'WotSSPLFrostDamage')
	{
		DmgTaker.Stun(5);
	}		
}