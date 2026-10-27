// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_survival_cs.gsc  (hash_737de2bbe7824ab9.gscc) (size: 4705 Bytes / 0x1261 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeced6fc0 (3974983616)
// size ...... 4705 (0x1261)
// includes .. 3   (offset: 0x103d)
// strings ... 15  (offset: 0x1055)
// dev strs .. 0   (offset: 0x1261)
// exports ... 9   (offset: 0xca5)
// cseg ...... 0x225 + 0xa80 (0xca5)
// imports ... 20  (offset: 0xe0d)
// animtree1 . 0   (offset: 0x1261)
// animtree2 . 0   (offset: 0x1261)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_script_survival_cs;

// Namespace zm_sat_ruby_script_survival_cs
// Params 0, eflags: 0x5
// Checksum 0xc7ae6375, Offset: 0x243
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_script_survival_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0xc84d3555, Offset: 0x264
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0x4d76e6b9, Offset: 0x275
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 2
// Checksum 0xfd9fb0f0, Offset: 0x286
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_script_survival_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_script_survival_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_script_survival_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_script_survival_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0xcef45276, Offset: 0x30e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_script_survival_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_script_survival_cs" );
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0x5d27d8e4, Offset: 0x388
// Size: 0x8fd
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4059, -41330, -12299 ), ( 0, 0, 0 ), undefined, "cspf_0_auto3842517081695162189", "survival_zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3958, -41404, -12492 ), ( 0, 0, 0 ), "cspf_0_auto3842517081695162189", "cspf_0_auto16773791663801158588", "survival_pap_set_zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4169, -41203.5, -12492 ), ( 0, 0, 0 ), "survival_spawn_set_zone_temple", "cspf_0_auto11274533013500027363" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4207.5, -40922, -12804 ), ( 0, 270, 0 ), "cspf_0_auto11274533013500027363" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3063.6, -42356.5, -13008 ), ( 0, 0, 0 ), "survival_round_accelerant_zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4079, -40921.5, -12804 ), ( 0, 270, 0 ), "cspf_0_auto11274533013500027363" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4137.5, -40929, -12804 ), ( 0, 270, 0 ), "cspf_0_auto11274533013500027363" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4014, -40924, -12804 ), ( 0, 270, 0 ), "cspf_0_auto11274533013500027363" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4086, -41479, -12492 ), ( 0, 0, 0 ), "cspf_0_auto3842517081695162189", "cspf_0_auto2218153191670014700", "survival_wallbuy_set_zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3971.5, -41504.5, -12492 ), ( 0, 0, 0 ), "cspf_0_auto3842517081695162189", "cspf_0_auto11361195287378062176", "anywhere_but_here_spawn_set_zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3644, -40953.5, -12804 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3617.5, -41011.5, -12804 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3707.5, -40930.5, -12804 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4589.66, -40994.5, -12804 ), ( 0, 193.83, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4601.53, -40931.8, -12804 ), ( 0, 193.83, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4533.5, -41032, -12804 ), ( 0, 193.83, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3412, -42372.5, -13060 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3460, -42448.5, -13060 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 3245.5, -42266.5, -13060 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4186.5, -42093, -12930 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4124.5, -42047, -12930 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4054.5, -42091, -12930 ), ( 0, 0, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 5029.18, -42474.6, -12994 ), ( 0, 130, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4927.8, -42555.7, -12994 ), ( 0, 130, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 5032.5, -42583, -12994 ), ( 0, 130, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4000.31, -41510.5, -13026 ), ( 0, 276, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4199.58, -41498, -13026 ), ( 0, 276, 0 ), "cspf_0_auto11361195287378062176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_survival_cs";
    s.groupid = "zone_temple";
    fe [[ f ]]( s, us, cf, ( 4086.5, -41449, -13026 ), ( 0, 276, 0 ), "cspf_0_auto11361195287378062176" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0xf6377419, Offset: 0xc8d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_script_survival_cs
// Params 0
// Checksum 0xca78f3b, Offset: 0xc97
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_script_survival_cs" );
}

