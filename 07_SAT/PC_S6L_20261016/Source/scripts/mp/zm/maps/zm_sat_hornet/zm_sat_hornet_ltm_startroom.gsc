// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ltm_startroom.gsc  (hash_4ac4019ebcd87f79.gscc) (size: 878 Bytes / 0x36e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2bec04fe (736888062)
// size ...... 878 (0x36e)
// includes .. 3   (offset: 0x332)
// strings ... 1   (offset: 0x34a)
// dev strs .. 2   (offset: 0x356)
// exports ... 6   (offset: 0x13a)
// cseg ...... 0x64 + 0xd6 (0x13a)
// imports ... 9   (offset: 0x22a)
// animtree1 . 0   (offset: 0x36e)
// animtree2 . 0   (offset: 0x36e)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;

#namespace zm_sat_hornet_ltm_startroom;

// Namespace zm_sat_hornet_ltm_startroom
// Params 0, eflags: 0x5
// Checksum 0x4eab58ec, Offset: 0x82
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_rb_startroom_sat_hornet", #"zm_rb_startroom_sat", &pre_main, &post_main );
}

// Namespace zm_sat_hornet_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x64807eed, Offset: 0xaf
// Size: 0x21
function private pre_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    function_9f18488839dc1d9b();
}

// Namespace zm_sat_hornet_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x66aa0007, Offset: 0xd8
// Size: 0x22
function private post_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x45>" );
    #/
    
    level thread function_61a42d08ba520dff();
}

// Namespace zm_sat_hornet_ltm_startroom
// Params 0
// Checksum 0xe6bc5766, Offset: 0x102
// Size: 0x21
function function_9f18488839dc1d9b()
{
    setdvar( @"disable_ash", 1 );
    setdvar( @"hash_a3d8279ebfa85341", 0 );
}

// Namespace zm_sat_hornet_ltm_startroom
// Params 0
// Checksum 0x39ff8733, Offset: 0x12b
// Size: 0xf
function function_61a42d08ba520dff()
{
    level utility::flag_set( "power_on" );
}

