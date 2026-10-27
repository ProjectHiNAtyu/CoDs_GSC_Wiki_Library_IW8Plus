// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_urchin_cs.gsc  (hash_0c0126499f9a1d14.gscc) (size: 1752 Bytes / 0x6d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbfc1259b (3217106331)
// size ...... 1752 (0x6d8)
// includes .. 3   (offset: 0x674)
// strings ... 4   (offset: 0x68c)
// dev strs .. 0   (offset: 0x6d8)
// exports ... 9   (offset: 0x2dc)
// cseg ...... 0xc4 + 0x218 (0x2dc)
// imports ... 20  (offset: 0x444)
// animtree1 . 0   (offset: 0x6d8)
// animtree2 . 0   (offset: 0x6d8)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_urchin_cs;

// Namespace zm_sat_firefly_script_urchin_cs
// Params 0, eflags: 0x5
// Checksum 0xad1a1cfb, Offset: 0xe2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_urchin_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0x49af21df, Offset: 0x103
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0xcc94f233, Offset: 0x114
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 2
// Checksum 0x7c7da47a, Offset: 0x125
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_urchin_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_urchin_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_urchin_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_urchin_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 3, eflags: 0x4
// Checksum 0x4f1646fc, Offset: 0x1ad
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_urchin_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_urchin_cs" );
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 3, eflags: 0x4
// Checksum 0xfdc1a8fe, Offset: 0x227
// Size: 0x95
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_urchin_cs";
    s.name = "SPAWNS ARE NOW BAKED IN THE PREFAB ABOVE";
    fe [[ f ]]( s, us, cf, ( 1467.5, -468.5, 509 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0x8b8d22eb, Offset: 0x2c4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_urchin_cs
// Params 0
// Checksum 0x8d459bb1, Offset: 0x2ce
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_urchin_cs" );
}

