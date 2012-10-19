class WotSWeapon_ManaRifleFrost extends WotSWeapon_ManaRifleBase;

defaultproperties
{
	WeaponProjectiles(0)=class'Proj_MRFrostBullet'
	WeaponProjectiles(1)=class'Proj_MRFrostSpell'

	WeaponManaCost=(primary=2, secondary=10);
	InventoryGroup=3
}

function LevelUp()
{
	super.LevelUp();

	if(WeaponLevel == 2)
	{
		FireInterval[0] = default.FireInterval[0] / 1.2;
	}

	else if(WeaponLevel == 3)
	{
		FireInterval[1] = default.FireInterval[1] / 1.4;
	}
}