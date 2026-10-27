// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_survival_lighthouse_fishing_cs.gsc  (hash_053e368ef3105d29.gscc) (size: 2191 Bytes / 0x88f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3cf52aee (1022700270)
// size ...... 2191 (0x88f)
// includes .. 2   (offset: 0x7a3)
// strings ... 10  (offset: 0x7b3)
// dev strs .. 0   (offset: 0x88f)
// exports ... 6   (offset: 0x4f3)
// cseg ...... 0x136 + 0x3bd (0x4f3)
// imports ... 16  (offset: 0x5e3)
// animtree1 . 0   (offset: 0x88f)
// animtree2 . 0   (offset: 0x88f)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_locust_survival_lighthouse_fishing_cs;

// Namespace zm_sat_locust_survival_lighthouse_fishing_cs
// Params 2
// Checksum 0x39178762, Offset: 0x154
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_survival_lighthouse_fishing_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_survival_lighthouse_fishing_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_survival_lighthouse_fishing_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_survival_lighthouse_fishing_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_survival_lighthouse_fishing_cs
// Params 3, eflags: 0x4
// Checksum 0xa7c65e4, Offset: 0x1dc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_survival_lighthouse_fishing_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_survival_lighthouse_fishing_cs" );
}

// Namespace zm_sat_locust_survival_lighthouse_fishing_cs
// Params 3, eflags: 0x4
// Checksum 0xdd0c92ee, Offset: 0x256
// Size: 0x27d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "fishing_pole_barrel";
    fe [[ f ]]( s, us, cf, ( 5592, 1256, 104 ), ( 0, 308, 0 ), undefined, "cspf_0_auto11277629128357191683", "fishing_pole_barrel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_1";
    fe [[ f ]]( s, us, cf, ( 5601.97, 1261.45, 107 ), ( 300.06, 45.41, -8.22 ), "cspf_0_auto11277629128357191683", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_4";
    fe [[ f ]]( s, us, cf, ( 5596.27, 1252.03, 104 ), ( 341.39, 20.97, 0.22 ), "cspf_0_auto11277629128357191683", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_3";
    fe [[ f ]]( s, us, cf, ( 5586.13, 1257.25, 105 ), ( 346.68, 13.86, -12.08 ), "cspf_0_auto11277629128357191683", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_1";
    fe [[ f ]]( s, us, cf, ( 5595.23, 1247.14, 105 ), ( 332.35, 293.45, 4.27 ), "cspf_0_auto11277629128357191683", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_survival_lighthouse_fishing_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_survival_lighthouse_fishing_cs
// Params 0, eflags: 0x4
// Checksum 0xed3bcc23, Offset: 0x4db
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_survival_lighthouse_fishing_cs
// Params 0
// Checksum 0xc82fb8a9, Offset: 0x4e5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_survival_lighthouse_fishing_cs" );
}

