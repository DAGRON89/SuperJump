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
    PlayInfo.AddSetting(default.RulesGroup, "Gravity", GetDisplayText("Gravity", 0, 0, "Text", "4;-100:100"));
    PlayInfo.AddSetting(default.RulesGroup, "FallDamage", GetDisplayText("FallDamage", 0, 0, "Check"));

}

defaultproperties
{
    JumpMult=50
    Gravity=1
    FallDamage=False
}