// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ltm_startroom.gsc  (hash_6c2364babe02dae3.gscc) (size: 871 Bytes / 0x367 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae0fd95 (182517141)
// size ...... 871 (0x367)
// includes .. 4   (offset: 0x33b)
// strings ... 1   (offset: 0x35b)
// dev strs .. 0   (offset: 0x367)
// exports ... 6   (offset: 0x167)
// cseg ...... 0x74 + 0xf3 (0x167)
// imports ... 8   (offset: 0x257)
// animtree1 . 0   (offset: 0x367)
// animtree2 . 0   (offset: 0x367)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\magicbox;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;

#namespace zm_sat_firefly_ltm_startroom;

// Namespace zm_sat_firefly_ltm_startroom
// Params 0, eflags: 0x5
// Checksum 0x4936b847, Offset: 0x92
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_fa851c411fead8cb", #"zm_rb_startroom_sat", &pre_main, &post_main );
}

// Namespace zm_sat_firefly_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x6881e96b, Offset: 0xbf
// Size: 0xd
function private pre_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
}

// Namespace zm_sat_firefly_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xa03350a1, Offset: 0xd4
// Size: 0x15
function private post_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    level thread function_5c127c737c11cec8();
}

// Namespace zm_sat_firefly_ltm_startroom
// Params 0
// Checksum 0x11d3d6, Offset: 0xf1
// Size: 0x13
function function_5c127c737c11cec8()
{
    level thread function_57dc121b22df6e28();
    level magicbox::function_2e49cd8681e36211( 0 );
}

// Namespace zm_sat_firefly_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x983350fa, Offset: 0x10c
// Size: 0x5b
function private function_57dc121b22df6e28()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.wonder_veh.stagerequested ) )
    {
        wait 0.1;
    }
    
    wait 0.3;
    level utility::flag_set( "upgraded_pluto_to_stage_" + 83 );
    level.wonder_veh.stagerequested = 83;
}

