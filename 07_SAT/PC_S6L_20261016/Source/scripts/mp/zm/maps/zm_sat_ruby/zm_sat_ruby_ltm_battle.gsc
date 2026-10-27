// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ltm_battle.gsc  (hash_1fa3d9b993218236.gscc) (size: 733 Bytes / 0x2dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c9a6e1 (29992673)
// size ...... 733 (0x2dd)
// includes .. 4   (offset: 0x299)
// strings ... 3   (offset: 0x2b9)
// dev strs .. 0   (offset: 0x2dd)
// exports ... 4   (offset: 0x12d)
// cseg ...... 0x92 + 0x9b (0x12d)
// imports ... 7   (offset: 0x1cd)
// animtree1 . 0   (offset: 0x2dd)
// animtree2 . 0   (offset: 0x2dd)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\gametypes\zm_rb_battle;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;

#namespace zm_sat_ruby_ltm_battle;

// Namespace zm_sat_ruby_ltm_battle
// Params 0, eflags: 0x5
// Checksum 0x51d24869, Offset: 0xb0
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_678cc588ef07c489", #"zm_rb_battle", &pre_main, &post_main );
}

// Namespace zm_sat_ruby_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0xd728ee82, Offset: 0xdd
// Size: 0x1a
function private pre_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
    
    level utility::flag_set( "disable_galileo_spawn" );
}

// Namespace zm_sat_ruby_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0x39f0aa95, Offset: 0xff
// Size: 0x2e
function private post_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
    
    level thread zm_rb_startroom_sat::function_7ff4cf75757ec51();
    utility::flag_wait( "scriptables_ready" );
    level utility::flag_set( "power_on" );
}

