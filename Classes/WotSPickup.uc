class WotSPickup extends Actor
abstract;

var int HealthAmount;
var int ManaAmount;

defaultproperties
{
    bCollideActors=true    
    bBlockActors=false
 
    Begin Object Class=CylinderComponent Name=CylinderComp
        CollisionRadius=32
        CollisionHeight=48
        CollideActors=true        
        BlockActors=false
    End Object
    
    Components.Add( CylinderComp )
    CollisionComponent=CylinderComp  

	Begin Object Class=StaticMeshComponent Name=WActorStaticMeshComponent
		StaticMesh=StaticMesh'TheVillage.Pickup.hppotion'
		BlockRigidBody=TRUE
	End Object

	Components.Add(WActorStaticMeshComponent)

	HealthAmount = 10;
	ManaAmount = 10;
}	

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local SorcererPawn SP;
	if (Other.Class == class'SorcererPawn')
	{
		SP = SorcererPawn(Other);
		if(SP.Health + HealthAmount >= SP.HealthMax)
		{
			SP.Health = SP.HealthMax;
		} else
		{
			SP.Health += HealthAmount;
		}
		if(SP.CurrentMana + ManaAmount >= SP.MaxMana)
		{
			SP.CurrentMana = SP.MaxMana;
		} else
		{
			SP.CurrentMana += ManaAmount;
		}
		self.Destroy();
	}	
}