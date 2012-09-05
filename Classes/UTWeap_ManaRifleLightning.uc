class UTWeap_ManaRifleLightning extends UTWeap_ManaRifle;

DefaultProperties
{
	WeaponFireTypes(1) = EWFT_Projectile;
	WeaponProjectiles(0)=class'UTProj_MagicalLightningBullet'
	WeaponProjectiles(1)=class'UTProj_MagicalFireSpell'
	
	WeaponManaCost=(Primary=2, Secondary=20);
	InventoryGroup=4
}
