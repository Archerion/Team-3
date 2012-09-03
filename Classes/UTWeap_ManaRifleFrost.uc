class UTWeap_ManaRifleFrost extends UTWeap_ManaRifle;
defaultproperties
{
	WeaponFireTypes(1)=EWFT_Custom
	WeaponProjectiles(0)=class'UTProj_MagicalFrostBullet'
	
	WeaponManaCost=(Primary=5, Secondary=30);
	InventoryGroup=3
}

simulated function CustomFire()
{
	local MagicalPawn P;
	
	ForEach WorldInfo.AllPawns( class 'MagicalPawn', P)
	{
		P.ActivateFrostShield(100,3);
	}

}