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

function Moderate (int Damage, class<DamageType> DamageType, Actor DamageTaker)
{		
	local float SlowDuration;
	local float BurnDuration;
		
	if (DamageType == PRJBurnDamage)
	{
		DamageTaker.ModDamage = Damage * 0.7;
	}
		
	else if (DamageType == SPLBurnDamage)
	{
		BurnDuration = 3;
		SlowDuration = 3;
			
		if (TypeOfArmor == HeavyArmor)
		{
			BurnDuration = 6;
			SlowDuration = 6;
		}
			DamageTaker.Slow(50, SlowDuration);
			DamageTaker.TakeFire(BurnDuration, 5, 0.5);		
	}
		
	else if(DamageType == PRJLightningDamage)
	{
		DamageTaker.Stun(0.5);
	}
		
	else if(DamageType == SPLLightningDamage)
	{
		if (TypeOfArmor == MediumArmor)
		{
			DamageTaker.ModDamage = 10;
		}
			
		else
		{
			DamageTaker.ModDamage = 5;
		}
	}
		
	else if(DamageType == PRJFrostDamage)
	{
		if (TypeOfArmor == Unarmored)
		{
			DamageTaker.ModDamage = 15;
		} 
			
		else 
		{
			DamageTaker.ModDamage = 10;
		}
	}
		
	else if(DamageType == SPLFrostDamage)
	{
		DamageTaker.Freeze(5);
	}		
}