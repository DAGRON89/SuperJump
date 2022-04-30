class Rainbow extends Powerups;

//var int NumPoops;
var xEmitter Poop;

simulated function PostBeginPlay()
{
    // Poop = Spawn(class'SpeedTrail', self,, self.Location, self.Rotation);
    // xPawn(Owner).AttachToBone(Poop, 'spine');
    // Poop.Lifespan = Lifespan;
    SpawnPoop();
    Super.PostBeginPlay();
}

function SpawnPoop()
{
    local xPawn X;
    X = xPawn(Owner);

    if (X != None)
    {
        Poop = Spawn(class'SpeedTrail', X,, X.Location, X.Rotation);
        X.AttachToBone(Poop, 'spine');
        Poop.Lifespan = Lifespan;
    }

}

simulated function Destroyed()
{
    if (Poop !=None) 
    {
        Poop.mRegen=False;
    }
	Super.Destroyed();
}

event Tick (float DeltaTime)
{   
    if (Pawn(Owner).Physics == PHYS_Falling)
    {
        Poop.mRegenPause = False;
    }
    else 
    {
        Poop.mRegenPause = True;
    }
}

// state Pooping extends Activated
// {
//     function TurnOnRainbow()
//     {
//         if (Pawn(Owner).Physics == PHYS_Falling)
//             Poop.mRegen=True;
//     }
// }
// state NotPooping extends Activated
// {
//     function TurnOffRainbow()
//     {
//         if (Pawn(Owner).Physics != PHYS_Falling)
//             Poop.mRegen=False;
//     }
// }

// function PoopRainbows()
// {
//     local int p;
//     for (p=0;p<NumPoops;p++)
//     {
//         Spawn(class'RainbowPoops');
//     }
// }

defaultproperties
{
    bHidden=True
    bDisplayableInv=False
    bAutoActivate=True
    bActivatable=False
    bActive=True
    bCanHaveMultipleCopies=True
    //InventoryGroup=1
    //NumPoops=10
}