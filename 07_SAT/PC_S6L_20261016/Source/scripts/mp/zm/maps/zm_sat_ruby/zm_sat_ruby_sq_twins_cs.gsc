// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_twins_cs.gsc  (hash_62da6a7945a7a625.gscc) (size: 2351 Bytes / 0x92f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x557335d2 (1433613778)
// size ...... 2351 (0x92f)
// includes .. 3   (offset: 0x88b)
// strings ... 4   (offset: 0x8a3)
// dev strs .. 0   (offset: 0x92f)
// exports ... 9   (offset: 0x4f3)
// cseg ...... 0xa5 + 0x44e (0x4f3)
// imports ... 20  (offset: 0x65b)
// animtree1 . 0   (offset: 0x92f)
// animtree2 . 0   (offset: 0x92f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_sq_twins_cs;

// Namespace zm_sat_ruby_sq_twins_cs
// Params 0, eflags: 0x5
// Checksum 0x71c712ef, Offset: 0xc3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_sq_twins_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 0, eflags: 0x4
// Checksum 0xc1c9bf0b, Offset: 0xe4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 0, eflags: 0x4
// Checksum 0x44f26ce7, Offset: 0xf5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 2
// Checksum 0xf41b3aae, Offset: 0x106
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_sq_twins_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_sq_twins_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_sq_twins_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_sq_twins_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 3, eflags: 0x4
// Checksum 0xc770d828, Offset: 0x18e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_sq_twins_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_sq_twins_cs" );
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 3, eflags: 0x4
// Checksum 0x2eb763bf, Offset: 0x208
// Size: 0x2cb
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 232, -826, 252.1 ), ( 0, 335.5, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 1021, 1703, 284 ), ( 0, 182.6, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( -3198, 201, 7 ), ( 0, 325.9, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 4338, 749, -48 ), ( 0, 50.5, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 272, -1530, 200 ), ( 0, 48.1, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 1115, -3334, 344 ), ( 0, 3.7, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 4183, -2439, 0 ), ( 0, 3.7, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 3704, -1724, 16 ), ( 0, 219.6, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_twins_cs";
    fe [[ f ]]( s, us, cf, ( 1398, 1876, 252 ), ( 0, 127.9, 0 ), "ruby_sq_tw_scenes", undefined, undefined, undefined, undefined, undefined, undefined, 48, undefined, undefined );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 0, eflags: 0x4
// Checksum 0x25422cf3, Offset: 0x4db
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_sq_twins_cs
// Params 0
// Checksum 0x5230565, Offset: 0x4e5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_sq_twins_cs" );
}

