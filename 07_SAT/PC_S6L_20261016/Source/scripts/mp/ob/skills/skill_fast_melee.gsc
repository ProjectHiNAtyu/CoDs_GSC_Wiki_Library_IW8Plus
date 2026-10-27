// scripts\mp\ob\skills\skill_fast_melee.gsc  (hash_4492e45eb8235d38.gscc) (size: 860 Bytes / 0x35c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7b0c752 (3081815890)
// size ...... 860 (0x35c)
// includes .. 3   (offset: 0x324)
// strings ... 2   (offset: 0x33c)
// dev strs .. 0   (offset: 0x35c)
// exports ... 5   (offset: 0x174)
// cseg ...... 0x94 + 0xe0 (0x174)
// imports ... 8   (offset: 0x23c)
// animtree1 . 0   (offset: 0x35c)
// animtree2 . 0   (offset: 0x35c)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_fast_melee;

// Namespace skill_fast_melee
// Params 0, eflags: 0x1
// Checksum 0xcc15511d, Offset: 0xb2
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"fast_melee", &init );
}

// Namespace skill_fast_melee
// Params 0
// Checksum 0x3e06e015, Offset: 0xd1
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"fast_melee", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"fast_melee", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_fast_melee
// Params 1, eflags: 0x4
// Checksum 0x36b9fe30, Offset: 0x117
// Size: 0x30, Type: bool
function private on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_skill_fast_melee" );
    self setclientomnvar( "skill_fast_melee_perk_tier", skill_bundle.skilllevel );
    return true;
}

// Namespace skill_fast_melee
// Params 1, eflags: 0x4
// Checksum 0x85371993, Offset: 0x150
// Size: 0x24
function private function_c51f1692ecb73bfe( skill_bundle )
{
    perk::removeperk( "specialty_skill_fast_melee" );
    self setclientomnvar( "skill_fast_melee_perk_tier", 0 );
}

