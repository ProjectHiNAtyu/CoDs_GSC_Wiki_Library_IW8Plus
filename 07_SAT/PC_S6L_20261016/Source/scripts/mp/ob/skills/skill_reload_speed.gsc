// scripts\mp\ob\skills\skill_reload_speed.gsc  (hash_6a52ede4b6ed2544.gscc) (size: 768 Bytes / 0x300 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77e91f0d (2011766541)
// size ...... 768 (0x300)
// includes .. 3   (offset: 0x2e8)
// strings ... 0   (offset: 0x300)
// dev strs .. 0   (offset: 0x300)
// exports ... 5   (offset: 0x158)
// cseg ...... 0x58 + 0x100 (0x158)
// imports ... 7   (offset: 0x220)
// animtree1 . 0   (offset: 0x300)
// animtree2 . 0   (offset: 0x300)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_reload_speed;

// Namespace skill_reload_speed
// Params 0, eflags: 0x1
// Checksum 0x78cf6fed, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"reload_speed", &init );
}

// Namespace skill_reload_speed
// Params 0
// Checksum 0xbf3ea971, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"reload_speed", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"reload_speed", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_reload_speed
// Params 1, eflags: 0x4
// Checksum 0x99a3de05, Offset: 0xdb
// Size: 0x2e, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( skill_bundle.var_ff34bf6bae104e46 )
    {
        perk::giveperk( skill_bundle.var_ff34bf6bae104e46 );
    }
    
    return true;
}

// Namespace skill_reload_speed
// Params 1, eflags: 0x4
// Checksum 0x1d449bd1, Offset: 0x112
// Size: 0x46
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_ff34bf6bae104e46 && isdefined( self.perks[ skill_bundle.var_ff34bf6bae104e46 ] ) )
    {
        perk::removeperk( skill_bundle.var_ff34bf6bae104e46 );
    }
}

