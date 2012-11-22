class WotSPickup_Mana_Medium extends WotSPickup
ClassGroup(WotS_Pickups)
placeable;

defaultproperties
{
	Begin Object Name=WActorStaticMeshComponent
		StaticMesh=StaticMesh'TheVillage.Pickup.manapotion'
	End Object
	HealthAmount = 0;
	ManaAmount = 65;
}