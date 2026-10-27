// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ltm_startroom.gsc  (hash_0a395b4641809e49.gscc) (size: 689 Bytes / 0x2b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbdd8d79d (3185104797)
// size ...... 689 (0x2b1)
// includes .. 3   (offset: 0x275)
// strings ... 3   (offset: 0x28d)
// dev strs .. 0   (offset: 0x2b1)
// exports ... 4   (offset: 0x125)
// cseg ...... 0x92 + 0x93 (0x125)
// imports ... 6   (offset: 0x1c5)
// animtree1 . 0   (offset: 0x2b1)
// animtree2 . 0   (offset: 0x2b1)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;

#namespace zm_sat_ruby_ltm_startroom;

// Namespace zm_sat_ruby_ltm_startroom
// Params 0, eflags: 0x5
// Checksum 0xb61030d7, Offset: 0xb0
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_ltm_startroom", #"zm_rb_startroom_sat", &pre_main, &post_main );
}

// Namespace zm_sat_ruby_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x9b41c24, Offset: 0xdd
// Size: 0x1a
function private pre_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    level utility::flag_set( "disable_galileo_spawn" );
}

// Namespace zm_sat_ruby_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x56107409, Offset: 0xff
// Size: 0x26
function private post_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    level utility::flag_set( "power_on" );
}

