// Mutator class for super jump

class MutSuperJump extends Mutator
    config(SuperJumpConfig);

var config int JumpMult;
var config float GravMult;
var config bool bNoFallDamage;
var config bool bRainbowPoop;
var localized string GUIDisplayText[4];
var localized string GUIDescText[4];


// simulated function PreBeginPlay()
// {

// }

simulated function PostBeginPlay()
{
    // Allow change to gravity
    Level.DefaultGravity = Level.DefaultGravity*GravMult;

    //Set default Pawn class
    //Level.Game.DefaultPlayerClassName = "SuperJump.RainbowPoopsPawn";
}

//Check replacement
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    local PhysicsVolume PV;

    if (Other == None)
    {
        return false;
    }

    PV = PhysicsVolume(Other);
    if (PV != None)
    {
        PV.Gravity.Z = Level.DefaultGravity*GravMult;
    }

    return true;
}

// Apply jump height to players
function ModifyPlayer(Pawn Other)
{
    //local RainbowPoopsPawn X;
    //X = RainbowPoopsPawn(Other);
    
    if (Other != None)
    {
        Other.JumpZ = Other.default.JumpZ*JumpMult;
        
        if (bNoFallDamage)
        {
            Other.MaxFallSpeed = Other.MaxFallSpeed*3;
        }
        if (bRainbowPoop)
        {
            GiveRainbow(Other);
        }
    }
    Super.ModifyPlayer(Other);
}

// Define display text
static function string GetDisplayText(string PropName)
{
    switch (PropName)
    {
        case "JumpMult": return default.GUIDisplayText[0];
        case "GravMult": return default.GUIDisplayText[1];
        case "bNoFallDamage": return default.GUIDisplayText[2];
        case "bRainbowPoop": return default.GUIDisplayText[3];
    }
}

// Define description text
static event string GetDescriptionText(string PropName)
{
    switch (PropName)
    {
        case "JumpMult": return default.GUIDescText[0];
        case "GravMult": return default.GUIDescText[1];
        case "bNoFallDamage": return default.GUIDescText[2];
        case "bRainbowPoop": return default.GUIDescText[3];
    }
}

// Populate config options to GUI
static function FillPlayInfo(PlayInfo PlayInfo)
{
    Super.FillPlayInfo(PlayInfo);

    PlayInfo.AddSetting(default.RulesGroup, "JumpMult", GetDisplayText("JumpMult"), 0, 0, "Text", "4;1:100");
    PlayInfo.AddSetting(default.RulesGroup, "GravMult", GetDisplayText("GravMult"), 0, 0, "Text", "4;0.1:2.0");
    PlayInfo.AddSetting(default.RulesGroup, "bNoFallDamage", GetDisplayText("bNoFallDamage"), 0, 0, "Check");
    PlayInfo.AddSetting(default.RulesGroup, "bRainbowPoop", GetDisplayText("bRainbowPoop"), 0, 0, "Check");
}

//Give rainbow inventory item
function GiveRainbow (Pawn Other)
{
    //Other.AttachEffect(class'RainbowPoop', 'spine', Other.Location, Other.Rotation);
    Other.CreateInventory("SuperJump.Rainbow");
}

defaultproperties
{
    JumpMult=2
    GravMult=1.0
    bNoFallDamage=True
    bRainbowPoop=True
    GUIDisplayText[0]="Jump Multiplier"
    GUIDisplayText[1]="Gravity Multiplier"
    GUIDisplayText[2]="No Fall Damage"
    GUIDisplayText[3]="Poop Rainbows!"
    GUIDescText[0]="Higher value means higher jumps"
    GUIDescText[1]="Lower values decrease gravity ex. 0.5 means half gravity"
    GUIDescText[2]="Check to disable damage from falling"
    GUIDescText[3]="Check to poop rainbows when jumping"
    GroupName="SuperJump"
    FriendlyName="Super Jump"
    Description="ALL OF THE JUMP!!"
}