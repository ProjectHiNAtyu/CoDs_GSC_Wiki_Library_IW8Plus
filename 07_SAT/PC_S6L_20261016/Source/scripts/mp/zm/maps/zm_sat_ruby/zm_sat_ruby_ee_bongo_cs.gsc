// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_bongo_cs.gsc  (hash_2cf1bf4b82319a9d.gscc) (size: 2607 Bytes / 0xa2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe500f1b7 (3842044343)
// size ...... 2607 (0xa2f)
// includes .. 2   (offset: 0x913)
// strings ... 11  (offset: 0x923)
// dev strs .. 0   (offset: 0xa2f)
// exports ... 6   (offset: 0x663)
// cseg ...... 0x177 + 0x4ec (0x663)
// imports ... 16  (offset: 0x753)
// animtree1 . 0   (offset: 0xa2f)
// animtree2 . 0   (offset: 0xa2f)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_ee_bongo_cs;

// Namespace zm_sat_ruby_ee_bongo_cs
// Params 2
// Checksum 0xfa2bd8ef, Offset: 0x195
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_ee_bongo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_ee_bongo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_ee_bongo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_ee_bongo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_ee_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0xc9403a69, Offset: 0x21d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_ee_bongo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_ee_bongo_cs" );
}

// Namespace zm_sat_ruby_ee_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0xda053088, Offset: 0x297
// Size: 0x3ac
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( -174.93, 830.11, 252 ), ( 0, 204.37, 0 ), "ruby_ee_bongo", "cspf_0_auto15650602561265804182" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 382.37, 844.06, 252 ), ( 0, 156.37, 0 ), "ruby_ee_bongo", "cspf_0_auto5688643168286996258" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 41, -2601, 328 ), ( 0, 277.47, 0 ), "ruby_ee_bongo", "cspf_0_auto14636376563130235028" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 277, 637, 252 ), ( 0, 132.5, 0 ), "cspf_0_auto559290991323501075" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 55, 679, 259 ), ( 0, 0, 0 ), "cspf_0_auto15650602561265804182" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 277.24, 575.33, 252 ), ( 0, 233.6, 0 ), "ruby_ee_bongo", "cspf_0_auto559290991323501075" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 1923, -2648, 344 ), ( 0, 254.07, 0 ), "ruby_ee_bongo", "cspf_0_auto9409668115646270484" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 226, -2494, 328 ), ( 0, 0, 0 ), "cspf_0_auto14636376563130235028" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 1480.25, -3406.15, 8 ), ( 0, 42.2, 0 ), "ruby_ee_bongo", "cspf_0_auto7859308786440704017" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 1938, -3026, 344 ), ( 0, 0, 0 ), "cspf_0_auto9409668115646270484" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 1416.49, -3298.72, 8 ), ( 0, 0, 0 ), "cspf_0_auto7859308786440704017" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_bongo_cs";
    fe [[ f ]]( s, us, cf, ( 396.35, 957.38, 252 ), ( 0, 0, 0 ), "cspf_0_auto5688643168286996258" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_ee_bongo_cs
// Params 0, eflags: 0x4
// Checksum 0xa74bb143, Offset: 0x64b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_ee_bongo_cs
// Params 0
// Checksum 0xb13e724, Offset: 0x655
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_ee_bongo_cs" );
}

