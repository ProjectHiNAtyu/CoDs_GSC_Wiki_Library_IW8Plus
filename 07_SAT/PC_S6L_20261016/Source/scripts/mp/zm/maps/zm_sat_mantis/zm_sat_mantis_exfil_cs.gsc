// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_exfil_cs.gsc  (hash_4e8d9c11ead4f70f.gscc) (size: 3578 Bytes / 0xdfa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d46a05e (1028038750)
// size ...... 3578 (0xdfa)
// includes .. 3   (offset: 0xc6e)
// strings ... 16  (offset: 0xc86)
// dev strs .. 0   (offset: 0xdfa)
// exports ... 9   (offset: 0x8b2)
// cseg ...... 0x1ce + 0x6e4 (0x8b2)
// imports ... 21  (offset: 0xa1a)
// animtree1 . 0   (offset: 0xdfa)
// animtree2 . 0   (offset: 0xdfa)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_exfil_cs;

// Namespace zm_sat_mantis_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xd40b81eb, Offset: 0x1ec
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x43e4bfd, Offset: 0x20d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x81059811, Offset: 0x21e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_exfil_cs
// Params 2
// Checksum 0x31ecce58, Offset: 0x22f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_exfil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x2872cde, Offset: 0x2b7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_exfil_cs" );
}

// Namespace zm_sat_mantis_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xfa6bc8ab, Offset: 0x331
// Size: 0x561
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    s.script_int = int( 120 );
    s.script_label = "zombie_mangler_hvt";
    s.script_radius = int( 9000 );
    s.script_timer = int( 30 );
    fe [[ f ]]( s, us, cf, ( 55000, -31816, 184 ), ( 0, 308.7, 0 ), "zm_exfil", "cspf_0_auto3739756290037545803" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54600, -32064, -80 ), ( 0, 135, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54422, -31763, -64 ), ( 0, 315, 0 ), "cspf_0_auto1284933450841619039", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54648, -31984, 32 ), ( 0, 135, 0 ), "cspf_0_auto1284933450841619039", "cspf_0_auto16911536170443586329", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54656, -32008, -80 ), ( 0, 135, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54624, -32040, -80 ), ( 0, 135, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54680, -31976, -80 ), ( 0, 135, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54398, -31739, -123.89 ), ( 0, 315, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto1284933450841619039", "zone_street_present" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54802, -31986, -124 ), ( 0, 315, 0 ), "cspf_0_auto1284933450841619039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77120, -32064, -80 ), ( 0, 135, 0 ), "cspf_0_auto3792238885705217103" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 76945, -31767, -64 ), ( 0, 315, 0 ), "cspf_0_auto18319990520155899661", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77168, -31984, 32 ), ( 0, 135, 0 ), "cspf_0_auto18319990520155899661", "cspf_0_auto3792238885705217103", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77176, -32008, -80 ), ( 0, 135, 0 ), "cspf_0_auto3792238885705217103" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77144, -32040, -80 ), ( 0, 135, 0 ), "cspf_0_auto3792238885705217103" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77200, -31976, -80 ), ( 0, 135, 0 ), "cspf_0_auto3792238885705217103" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 76921, -31743, -123.09 ), ( 0, 315, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto18319990520155899661", "zone_street_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 77038, -31853, -124 ), ( 0, 315, 0 ), "cspf_0_auto18319990520155899661", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 54763, -31986, -133 ), ( 0, 0, 0 ), "cspf_0_auto1284933450841619039", undefined, "override_exfil_center" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xd615f3a7, Offset: 0x89a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_exfil_cs
// Params 0
// Checksum 0xc0d4f193, Offset: 0x8a4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_exfil_cs" );
}

