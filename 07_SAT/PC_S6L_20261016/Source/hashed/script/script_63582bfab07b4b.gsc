// script_63582bfab07b4b  (hash_0063582bfab07b4b.gscc) (size: 1938 Bytes / 0x792 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f8ddc54 (2408438868)
// size ...... 1938 (0x792)
// includes .. 3   (offset: 0x71a)
// strings ... 4   (offset: 0x732)
// dev strs .. 0   (offset: 0x792)
// exports ... 9   (offset: 0x376)
// cseg ...... 0xb7 + 0x2bf (0x376)
// imports ... 20  (offset: 0x4de)
// animtree1 . 0   (offset: 0x792)
// animtree2 . 0   (offset: 0x792)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_lm_avalon_ob_aether_storm_cs;

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 0, eflags: 0x5
// Checksum 0xc9cf5744, Offset: 0xd5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_lm_avalon_ob_aether_storm_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 0, eflags: 0x4
// Checksum 0xda8cb8e0, Offset: 0xf6
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 0, eflags: 0x4
// Checksum 0x5fb76b0c, Offset: 0x107
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 2
// Checksum 0xecbbe76a, Offset: 0x118
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_lm_avalon_ob_aether_storm_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_lm_avalon_ob_aether_storm_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_lm_avalon_ob_aether_storm_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 3, eflags: 0x4
// Checksum 0xdc35dfc3, Offset: 0x190
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_lm_avalon_ob_aether_storm_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_lm_avalon_ob_aether_storm_cs" );
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 3, eflags: 0x4
// Checksum 0xa1d565c, Offset: 0x20a
// Size: 0x14c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_lm_avalon_ob_aether_storm_cs";
    fe create_script_utility::strike_additem( s, us, cf, ( -41603, 22743, 887 ), ( 0, 0, 0 ), "aether_storm_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_lm_avalon_ob_aether_storm_cs";
    fe create_script_utility::strike_additem( s, us, cf, ( -39864, -24167, 314 ), ( 0, 0, 0 ), "aether_storm_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_lm_avalon_ob_aether_storm_cs";
    fe create_script_utility::strike_additem( s, us, cf, ( 34325, 40780, 2285 ), ( 0, 0, 0 ), "aether_storm_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_lm_avalon_ob_aether_storm_cs";
    fe create_script_utility::strike_additem( s, us, cf, ( 48041, -21250, 742 ), ( 0, 0, 0 ), "aether_storm_spawnpoint" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 0, eflags: 0x4
// Checksum 0x4bc283db, Offset: 0x35e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_lm_avalon_ob_aether_storm_cs
// Params 0
// Checksum 0x1e66028e, Offset: 0x368
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_lm_avalon_ob_aether_storm_cs" );
}

