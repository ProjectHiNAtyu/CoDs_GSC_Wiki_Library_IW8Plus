// scripts\mp\ob\skills\skill_trap_avoidance.gsc  (hash_007f5b9c1ec38bb7.gscc) (size: 838 Bytes / 0x346 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x567f19d (90698141)
// size ...... 838 (0x346)
// includes .. 3   (offset: 0x31a)
// strings ... 1   (offset: 0x332)
// dev strs .. 0   (offset: 0x346)
// exports ... 5   (offset: 0x18a)
// cseg ...... 0x6f + 0x11b (0x18a)
// imports ... 7   (offset: 0x252)
// animtree1 . 0   (offset: 0x346)
// animtree2 . 0   (offset: 0x346)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_trap_avoidance;

// Namespace skill_trap_avoidance
// Params 0, eflags: 0x1
// Checksum 0xa622fdb9, Offset: 0x8d
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"trap_avoidance", &init );
}

// Namespace skill_trap_avoidance
// Params 0
// Checksum 0xa73686ea, Offset: 0xac
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"trap_avoidance", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"trap_avoidance", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_trap_avoidance
// Params 1, eflags: 0x4
// Checksum 0x82c76b22, Offset: 0xf2
// Size: 0x50, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( skill_bundle.var_b3a3f1ff8a41cc36 )
    {
        perk::giveperk( "specialty_lightfoot" );
    }
    
    self.var_ff102e941e8065c = skill_bundle.var_91fe058c5ce3d80f;
    self.var_79af01c812a15a4c = skill_bundle.var_42deffa94c9a8ccb;
    return true;
}

// Namespace skill_trap_avoidance
// Params 1, eflags: 0x4
// Checksum 0x40ca41f2, Offset: 0x14b
// Size: 0x3f
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( self.perks[ "specialty_lightfoot" ] ) )
    {
        perk::removeperk( "specialty_lightfoot" );
    }
    
    self.var_ff102e941e8065c = undefined;
    self.var_79af01c812a15a4c = undefined;
}

