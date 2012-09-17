class UTWeap_ManaRifleFire extends UTWeap_ManaRifle;

defaultproperties
{
	WeaponFireTypes(1)=EWFT_Projectile
	WeaponProjectiles(0)=class'UTProj_MagicalFireBullet'
	WeaponProjectiles(1)=class'UTProj_MagicalFireSpell'
	
	WeaponManaCost=(Primary=2, Secondary=10);
	InventoryGroup=2
	WeaponColor=(R=255,G=0,B=0,A=255)

	
}