// Mutator class for super jump

class MutSuperJump extends Mutator
    config(SuperJumpConfig);

var config int JumpMult;
var config float Gravity;
var config bool FallDamage;
var localized string GUIDisplayText[3];
var localized string GUIDescText[3];

// Define display text
static function string GetDisplayText(string PropName)
{
    switch (PropName)
    {
        case "JumpMult": return default.GUIDisplayText[0];
        case "Gravity": return default.GUIDisplayText[1];
        case "FallDamage": return default.GUIDisplayText[2];
    }
}

// Define description text
static event string GetDescriptionText(string PropName)
{
    switch (PropName)
    {
        case "JumpMult": return default.GUIDescText[0];
        case "Gravity": return default.GUIDescText[1];
        case "FallDamage": return default.GUIDescText[2];
    }
}

// Populate config options to GUI
static function FillPlayInfo(PlayInfo PlayInfo)
{
    Super.FillPlayInfo(PlayInfo);

    PlayInfo.AddSetting(default.RulesGroup, "JumpMult", GetDisplayText("JumpMult", 0, 0, "Text", "4;1:100"));
    PlayInfo.AddSetting(default.RulesGroup, "Gravity", GetDisplayText("Gravity", 0, 0, "Text", "4;-500.0:500.0"));
    PlayInfo.AddSetting(default.RulesGroup, "FallDamage", GetDisplayText("FallDamage", 0, 0, "Check"));

}

// Apply jump height to players
function ModifyPlayer(Pawn Other)
{
    local xPawn X;
    X = xPawn(Other);
    if (X != None)
    {
        X.JumpZ = class'Pawn'.default.JumpZ * JumpMult;
    }
}

defaultproperties
{
    JumpMult=50
    Gravity=1.0
    FallDamage=False
    GUIDisplayText[0]="Jump Multiplier"
    GUIDisplayText[1]="Gravity"
    GUIDisplayText[2]="Fall Damage"
    GUIDescText[0]="Higher value means higher jumps"
    GUIDescText[1]="Amount of gravity"
    GUIDescText[2]="Fall damage or no?"
}