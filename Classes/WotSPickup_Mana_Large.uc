class WotSPickup_Mana_Large extends WotSPickup
ClassGroup(WotS_Pickups)
placeable;


defaultproperties
{
	Begin Object Name=WActorStaticMeshComponent
		StaticMesh=StaticMesh'TheVillage.Pickup.manapotion'
		Scale=1.5
	End Object
	HealthAmount = 0;
	ManaAmount = 100;
}