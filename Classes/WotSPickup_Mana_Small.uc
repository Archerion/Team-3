class WotSPickup_Mana_Small extends WotSPickup
ClassGroup(WotS_Pickups)
placeable;

defaultproperties
{
	Begin Object Name=WActorStaticMeshComponent
		StaticMesh=StaticMesh'TheVillage.manapotion'
		Scale=0.7
	End Object
	HealthAmount = 0;
	ManaAmount = 30;
}