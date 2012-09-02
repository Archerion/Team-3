class UTAmmo_ManaRifle extends UTAmmoPickupFactory;

defaultproperties
{
	RespawnTime = 3;
	AmmoAmount = 50
	TargetWeapon=class'UTWeap_ManaRifle'
	
	PickupSound=SoundCue'A_Pickups.Ammo.Cue.A_Pickup_Ammo_Rocket_Cue'
	
	Begin Object Name=AmmoMeshComp
        StaticMesh=StaticMesh'Pickups.Ammo_Shock.Mesh.S_Ammo_ShockRifle'
        Translation=(X=0.0,Y=0.0,Z=-15.0)
    End Object
	
	Begin Object Name=CollisionCylinder
        CollisionHeight=14.4
    End Object
}
	

function SpawnCopyFor( Pawn Recipient )
{
	if ( MagicalInventoryManager(Recipient.InvManager) != none )
	{
		MagicalInventoryManager(Recipient.InvManager).AddAmmoToWeapon(AmmoAmount, TargetWeapon);
	}

	Recipient.PlaySound(PickupSound);
	Recipient.MakeNoise(0.2);

	if (PlayerController(Recipient.Controller) != None)
	{
		PlayerController(Recipient.Controller).ReceiveLocalizedMessage(MessageClass,,,,Class);
	}
}