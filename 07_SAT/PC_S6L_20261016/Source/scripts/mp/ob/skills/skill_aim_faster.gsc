// scripts\mp\ob\skills\skill_aim_faster.gsc  (hash_773d8aa67edce662.gscc) (size: 883 Bytes / 0x373 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f2397a2 (1864603554)
// size ...... 883 (0x373)
// includes .. 3   (offset: 0x337)
// strings ... 2   (offset: 0x34f)
// dev strs .. 0   (offset: 0x373)
// exports ... 5   (offset: 0x187)
// cseg ...... 0x94 + 0xf3 (0x187)
// imports ... 8   (offset: 0x24f)
// animtree1 . 0   (offset: 0x373)
// animtree2 . 0   (offset: 0x373)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_aim_faster;

// Namespace skill_aim_faster
// Params 0, eflags: 0x1
// Checksum 0x5b8db0b, Offset: 0xb2
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"aim_faster", &init );
}

// Namespace skill_aim_faster
// Params 0, eflags: 0x4
// Checksum 0x633a6f9b, Offset: 0xd1
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"aim_faster", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"aim_faster", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_aim_faster
// Params 1, eflags: 0x4
// Checksum 0xb1e89321, Offset: 0x117
// Size: 0x30, Type: bool
function private on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_skill_aim_faster" );
    self setclientomnvar( "skill_aim_faster_perk_tier", skill_bundle.skilllevel );
    return true;
}

// Namespace skill_aim_faster
// Params 1, eflags: 0x4
// Checksum 0xfb0ef779, Offset: 0x150
// Size: 0x37
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( self.perks[ "specialty_skill_aim_faster" ] ) )
    {
        perk::removeperk( "specialty_skill_aim_faster" );
    }
    
    self setclientomnvar( "skill_aim_faster_perk_tier", 0 );
}

