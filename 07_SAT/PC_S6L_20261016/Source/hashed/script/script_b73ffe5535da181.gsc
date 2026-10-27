// script_b73ffe5535da181  (hash_0b73ffe5535da181.gscc) (size: 1628 Bytes / 0x65c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd51f1c1 (223474113)
// size ...... 1628 (0x65c)
// includes .. 4   (offset: 0x600)
// strings ... 5   (offset: 0x620)
// dev strs .. 0   (offset: 0x65c)
// exports ... 6   (offset: 0x3a0)
// cseg ...... 0xe6 + 0x2ba (0x3a0)
// imports ... 13  (offset: 0x490)
// animtree1 . 0   (offset: 0x65c)
// animtree2 . 0   (offset: 0x65c)
#using script_54a05cbb2455bc6f;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_score;

#namespace namespace_784ffa04ce762ac;

// Namespace namespace_784ffa04ce762ac
// Params 0, eflags: 0x5
// Checksum 0xb08a406c, Offset: 0x104
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e6cebeae193d6843", #"ztron_fate", undefined, &init );
}

// Namespace namespace_784ffa04ce762ac
// Params 0
// Checksum 0x57b75dd8, Offset: 0x12d
// Size: 0x4b
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 2, #"fortune", &activate, &deactivate, "ztron_fate_rock_fortune", "sat_zm_ztron_props_diamond_red", "dx_zm_ztr4_anno_anz4_d4fatefrt" );
    utility::registersharedfunc( #"fortune", #"get_award_model", &function_aec9fbc9b7b9399c );
}

// Namespace namespace_784ffa04ce762ac
// Params 1
// Checksum 0x13a8fbe1, Offset: 0x180
// Size: 0x17f
function activate( loadgame )
{
    if ( self.ztron.score.multix < 2 )
    {
        self.ztron.score.multix = 2;
        self.ztron.score.gemscurlevel = ztron_score::function_9fa8b6a9b8f84ba2( 1 );
        self.ztron.score.gemsnextlevel = ztron_score::function_9fa8b6a9b8f84ba2( 2 );
        self.ztron.score.var_e294e535d5856517 = self.ztron.score.gemsnextlevel * 0.1;
        self.ztron.score.gems = self.ztron.score.gemscurlevel;
        self.ztron.score.desired_gems = self.ztron.score.gems;
        self.ztron.score.multiprogress = 0;
        ztron_score::function_4ea454cb6435a318();
        ztron_score::function_33efcadca04bd395();
    }
}

// Namespace namespace_784ffa04ce762ac
// Params 0
// Checksum 0xb2d1b19c, Offset: 0x307
// Size: 0x2
function deactivate()
{
    
}

// Namespace namespace_784ffa04ce762ac
// Params 1, eflags: 0x4
// Checksum 0xb162fc44, Offset: 0x312
// Size: 0x8d
function private function_aec9fbc9b7b9399c( fatedata )
{
    ent = spawn( "script_model", self.origin + ( 0, 0, 1500 ) );
    
    if ( isdefined( ent ) )
    {
        ent.angles = ( 0, 0, 0 );
        ent setscale( 2 );
        model = "sat_zm_ztron_props_diamond_" + self.ztron.color;
        ent setmodel( model );
    }
    
    return ent;
}

