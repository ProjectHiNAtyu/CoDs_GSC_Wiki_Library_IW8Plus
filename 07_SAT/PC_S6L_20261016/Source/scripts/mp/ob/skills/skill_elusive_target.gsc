// scripts\mp\ob\skills\skill_elusive_target.gsc  (hash_2990f771d1494176.gscc) (size: 829 Bytes / 0x33d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1aa3b0c1 (446935233)
// size ...... 829 (0x33d)
// includes .. 3   (offset: 0x305)
// strings ... 2   (offset: 0x31d)
// dev strs .. 0   (offset: 0x33d)
// exports ... 5   (offset: 0x175)
// cseg ...... 0x84 + 0xf1 (0x175)
// imports ... 7   (offset: 0x23d)
// animtree1 . 0   (offset: 0x33d)
// animtree2 . 0   (offset: 0x33d)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\common\values;

#namespace skill_elusive_target;

// Namespace skill_elusive_target
// Params 0, eflags: 0x1
// Checksum 0x43e49229, Offset: 0xa2
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"elusive_target", &init );
}

// Namespace skill_elusive_target
// Params 0
// Checksum 0x3fc573c3, Offset: 0xc1
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"elusive_target", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"elusive_target", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_elusive_target
// Params 1, eflags: 0x4
// Checksum 0xc061db9b, Offset: 0x107
// Size: 0x39, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( isdefined( skill_bundle.var_70705b21662e6239 ) )
    {
        val::set( "skill_elusive_target", "attackeraccuracy", skill_bundle.var_70705b21662e6239 );
    }
    
    return true;
}

// Namespace skill_elusive_target
// Params 1, eflags: 0x4
// Checksum 0x8e6ab11f, Offset: 0x149
// Size: 0x2c
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( skill_bundle.var_70705b21662e6239 ) )
    {
        val::reset( "skill_elusive_target", "attackeraccuracy" );
    }
}

