// scripts\mp\zm\livingworld\zm_sat_locust_livingworld.gsc  (hash_126b689574369729.gscc) (size: 913 Bytes / 0x391 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa052b624 (2689775140)
// size ...... 913 (0x391)
// includes .. 3   (offset: 0x331)
// strings ... 6   (offset: 0x349)
// dev strs .. 0   (offset: 0x391)
// exports ... 3   (offset: 0x211)
// cseg ...... 0xc4 + 0x14d (0x211)
// imports ... 6   (offset: 0x289)
// animtree1 . 0   (offset: 0x391)
// animtree2 . 0   (offset: 0x391)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_livingworld;

#namespace zm_sat_locust_livingworld;

// Namespace zm_sat_locust_livingworld
// Params 0, eflags: 0x5
// Checksum 0xcb47328a, Offset: 0xe2
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_livingworld", [ #"zm_livingworld", #"zm_sat_livingworld" ], undefined, &function_111e5b87aa3ef98e );
}

// Namespace zm_sat_locust_livingworld
// Params 0
// Checksum 0x7df7e740, Offset: 0x11d
// Size: 0xf4
function function_111e5b87aa3ef98e()
{
    if ( zm_livingworld::livingworld_is_disabled( "SAT", "zm_sat_locust" ) )
    {
        return;
    }
    
    while ( !isdefined( level._livingworld_info.script_funcs ) )
    {
        waitframe();
    }
    
    anim_func_pairs = [];
    
    foreach ( stringid, func in anim_func_pairs )
    {
        level._livingworld_info.script_funcs[ stringid ] = func;
    }
    
    level._effect[ "zmb_eye_glow" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_base_eye" );
    level utility::flag_set( "init_" + level.mapname + "_anim_func_pairs" );
}

