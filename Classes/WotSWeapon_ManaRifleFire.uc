class WotSWeapon_ManaRifleFire extends WotSWeapon_ManaRifleBase;

defaultproperties
{
	InventoryGroup=2

	WeaponProjectiles(0)=class'Proj_MRFireBullet'
	WeaponProjectiles(1)=class'Proj_MRFireSpell'
	
	WeaponManaCost=(Primary=2, Secondary=10);
	InventoryGroup=2

}