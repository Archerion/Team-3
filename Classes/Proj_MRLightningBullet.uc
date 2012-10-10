class Proj_MRLightningBullet extends Proj_MRBullet;

defaultproperties
{
	FlightFXColor=(X=0.8,Y=0.8,Z=0.8)
}


simulated function ProcessTouch (Actor Other, vector HitLocation, vector HitNormal)
{
	if ( Other != Instigator )
	{
		if(Other.IsA('MookPawn'))
		{
			Other.Stun(0.5);
		}
	}

	Super.ProcessTouch(Other, HitLocation, HitNormal);
}