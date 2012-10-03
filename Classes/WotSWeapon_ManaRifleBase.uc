class WotSWeapon_ManaRifleBase extends WotSWeapon
	abstract;

struct ManaCost
{
	var float Primary;
	var float Secondary;
	
	structdefaultproperties
	{
		Primary = 0;
		Secondary = 0;
	}
};

var ManaCost WeaponManaCost;
var float TimeToUpdateAmmo;

defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponFireTypes(1)=EWFT_Projectile

	FireInterval(0)=+0.77
	FireInterval(1)=+0.6

	ShotCost(0)=0
	ShotCost(1)=0

	TimeToUpdateAmmo = 1.5
	WeaponManaCost=(Primary=0, Secondary=0);
}