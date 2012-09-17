Class StupidBot extends UTBot;

var Actor Destination;

protected event ExecuteWhatToDoNext()
{
  GotoState('Sleepy');
}

state  Sleepy
{
Begin:
  LatentWhatToDoNext();
}

defaultproperties
{
}
