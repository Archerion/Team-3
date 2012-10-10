class WotSWeapon_ManaRifleFrost extends WotSWeapon_ManaRifleBase;

defaultproperties
{
	WeaponProjectiles(0)=class'Proj_MRFrostBullet'
	WeaponProjectiles(1)=class'Proj_MRFrostSpell'

	WeaponManaCost=(primary=2, secondary=10);
	InventoryGroup=3
}