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
		StaticMesh=StaticMesh'TheVillage.hppotion'
		BlockRigidBody=TRUE
	End Object

	Mesh=WActorStaticMeshComponent
	Components.Add(WActorStaticMeshComponent)

	Mesh=WPawnSkeletalMeshComponent
	StaticMesh=StaticMesh'Pickups.Health_Medium.Mesh.S_Pickups_Health_Medium'

	HealthAmount = 10;
	ManaAmount = 10;
}	

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local SorcererPawn SP;
	if (Other.Class == class'SorcererPawn')
	{
		SP = SorcererPawn(Other);
		SP.Health += HealthAmount;
		SP.CurrentMana += ManaAmount;
		self.Destroy();
	}	
}