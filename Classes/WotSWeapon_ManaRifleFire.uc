class WotSWeapon_ManaRifleFire extends WotSWeapon_ManaRifleBase;

function LevelUp()
{	
	Super.LevelUp();
	if (WeaponLevel == 2)
	{
		WeaponRadiusDamage = 192*1.5;
	}
	else if (WeaponLevel == 3)
	{
		WeaponRadiusDamage = 192*2;
	}
}

defaultproperties
{
	WeaponProjectiles(0)=class'Proj_MRFireBullet'
	WeaponProjectiles(1)=class'Proj_MRSpell_Fire'
	
	WeaponManaCost=(Primary=2, Secondary=10);
	InventoryGroup=2
}