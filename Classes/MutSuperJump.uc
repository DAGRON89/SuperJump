// Mutator class for super jump

class MutSuperJump extends Mutator
    config(SuperJumpConfig);

var config int JumpMult;
var config float GravMult;
var config bool bNoFallDamage;
var localized string GUIDisplayText[3];
var localized string GUIDescText[3];


simulated function PostBeginPlay()
{
    // Allow change to gravity
    Level.DefaultGravity = Level.DefaultGravity*GravMult;
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
    local xPawn X;
    X = xPawn(Other);
    
    if (X != None)
    {
        X.JumpZ = class'xPawn'.default.JumpZ*JumpMult;
        
        if (bNoFallDamage)
        {
            X.MaxFallSpeed = X.MaxFallSpeed*3;
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
    }
}

// Populate config options to GUI
static function FillPlayInfo(PlayInfo PlayInfo)
{
    Super.FillPlayInfo(PlayInfo);

    PlayInfo.AddSetting(default.RulesGroup, "JumpMult", GetDisplayText("JumpMult"), 0, 0, "Text", "4;1:100");
    PlayInfo.AddSetting(default.RulesGroup, "GravMult", GetDisplayText("GravMult"), 0, 0, "Text", "4;0.1:2.0");
    PlayInfo.AddSetting(default.RulesGroup, "bNoFallDamage", GetDisplayText("bNoFallDamage"), 0, 0, "Check");

}

defaultproperties
{
    JumpMult=2
    GravMult=1.0
    bNoFallDamage=True
    GUIDisplayText[0]="Jump Multiplier"
    GUIDisplayText[1]="Gravity Multiplier"
    GUIDisplayText[2]="No Fall Damage"
    GUIDescText[0]="Higher value means higher jumps"
    GUIDescText[1]="Lower values decrease gravity ex. 0.5 means half gravity"
    GUIDescText[2]="Check to disable damage from falling"
    GroupName="SuperJump"
    FriendlyName="Super Jump"
    Description="ALL OF THE JUMP!!"
}