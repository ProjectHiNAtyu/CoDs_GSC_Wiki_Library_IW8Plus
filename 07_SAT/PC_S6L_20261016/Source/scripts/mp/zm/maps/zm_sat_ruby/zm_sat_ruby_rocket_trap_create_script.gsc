// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rocket_trap_create_script.gsc  (hash_7f8f3a7aa4adbb49.gscc) (size: 2979 Bytes / 0xba3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cf02a96 (1559243414)
// size ...... 2979 (0xba3)
// includes .. 2   (offset: 0xa1b)
// strings ... 22  (offset: 0xa2b)
// dev strs .. 0   (offset: 0xba3)
// exports ... 6   (offset: 0x76b)
// cseg ...... 0x205 + 0x566 (0x76b)
// imports ... 16  (offset: 0x85b)
// animtree1 . 0   (offset: 0xba3)
// animtree2 . 0   (offset: 0xba3)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_rocket_trap_create_script;

// Namespace zm_sat_ruby_rocket_trap_create_script
// Params 2
// Checksum 0x62a0b5fa, Offset: 0x223
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_rocket_trap_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_rocket_trap_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_rocket_trap_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_rocket_trap_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_rocket_trap_create_script
// Params 3, eflags: 0x4
// Checksum 0x51cb577c, Offset: 0x2ab
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_rocket_trap_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_rocket_trap_create_script" );
}

// Namespace zm_sat_ruby_rocket_trap_create_script
// Params 3, eflags: 0x4
// Checksum 0xc9bf309e, Offset: 0x325
// Size: 0x426
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.script_label = "sat_zm_rocket_trap_swtich_handle";
    fe [[ f ]]( s, us, cf, ( 2480, -539, 33 ), ( 331.92, 263.9, 0.67 ), "cspf_0_auto9878994379062229902", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket1";
    fe [[ f ]]( s, us, cf, ( 2500.17, -496.36, 51 ), ( 0, 73.71, 0 ), "cspf_0_auto9878994379062229902", "cspf_0_auto2074944954386227119", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket1_target_1";
    fe [[ f ]]( s, us, cf, ( 1961.95, -389.72, 50.31 ), ( 0, 247.26, 0 ), "cspf_0_auto2074944954386227119", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket1_target_3";
    fe [[ f ]]( s, us, cf, ( 2090.22, -110.48, 64.85 ), ( 0, 333.6, 0 ), "cspf_0_auto2074944954386227119", undefined, undefined, undefined, undefined, undefined, undefined, 60 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket2_target_1";
    fe [[ f ]]( s, us, cf, ( 1844.34, -681.15, 16.34 ), ( 0, 0, 0 ), "cspf_0_auto5264493837485679954", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket2_target_2";
    fe [[ f ]]( s, us, cf, ( 1947.62, -789.03, 0.68 ), ( 0, 0, 0 ), "cspf_0_auto5264493837485679954", undefined, undefined, undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket2_target_3";
    fe [[ f ]]( s, us, cf, ( 2120.36, -798.8, 11.97 ), ( 0, 0, 0 ), "cspf_0_auto5264493837485679954", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket2_target_4";
    fe [[ f ]]( s, us, cf, ( 2240.66, -807.96, 13.53 ), ( 0, 0, 0 ), "cspf_0_auto5264493837485679954", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket1_target_2";
    fe [[ f ]]( s, us, cf, ( 2038.22, -275.48, 64.85 ), ( 0, 329.7, 0 ), "cspf_0_auto2074944954386227119", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.script_cost = "500";
    s.script_duration = "15";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 2470, -568, 0 ), ( 0, 0, 0 ), "rocket_trap_switch", "cspf_0_auto9878994379062229902", undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rocket_trap_create_script";
    s.name = "rocket2";
    fe [[ f ]]( s, us, cf, ( 1824.17, -131.36, 216 ), ( 0.04, 203.72, -0.36 ), "cspf_0_auto9878994379062229902", "cspf_0_auto5264493837485679954", "trap" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_rocket_trap_create_script
// Params 0, eflags: 0x4
// Checksum 0x39512c5f, Offset: 0x753
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_rocket_trap_create_script
// Params 0
// Checksum 0x93988a31, Offset: 0x75d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_rocket_trap_create_script" );
}

