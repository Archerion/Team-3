class UTWeap_ManaRifleFrost extends UTWeap_ManaRifle;
defaultproperties
{
	WeaponFireTypes(1)=EWFT_Projectile
	WeaponProjectiles(0)=class'UTProj_MagicalFrostBullet'
	WeaponProjectiles(1)=class'UTProj_MagicalFrostSpell'
	
	WeaponManaCost=(Primary=2, Secondary=10);
	InventoryGroup=3
}