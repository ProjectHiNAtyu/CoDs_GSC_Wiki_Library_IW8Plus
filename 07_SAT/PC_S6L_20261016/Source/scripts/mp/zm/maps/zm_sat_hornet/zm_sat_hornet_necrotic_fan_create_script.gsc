// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_necrotic_fan_create_script.gsc  (hash_5db05a38322a5f3c.gscc) (size: 2277 Bytes / 0x8e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e6d4c7c (778914940)
// size ...... 2277 (0x8e5)
// includes .. 2   (offset: 0x81d)
// strings ... 6   (offset: 0x82d)
// dev strs .. 0   (offset: 0x8e5)
// exports ... 6   (offset: 0x56d)
// cseg ...... 0xe8 + 0x485 (0x56d)
// imports ... 16  (offset: 0x65d)
// animtree1 . 0   (offset: 0x8e5)
// animtree2 . 0   (offset: 0x8e5)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_necrotic_fan_create_script;

// Namespace zm_sat_hornet_necrotic_fan_create_script
// Params 2
// Checksum 0xa13a52ea, Offset: 0x106
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_necrotic_fan_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_necrotic_fan_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_necrotic_fan_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_necrotic_fan_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_necrotic_fan_create_script
// Params 3, eflags: 0x4
// Checksum 0x9251b06c, Offset: 0x18e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_necrotic_fan_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_necrotic_fan_create_script" );
}

// Namespace zm_sat_hornet_necrotic_fan_create_script
// Params 3, eflags: 0x4
// Checksum 0x39a0e313, Offset: 0x208
// Size: 0x345
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 33073, 41842, 16663 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 33321, 43058, 16753 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 32808.5, 42669.5, 16685 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    s.script_scenescriptbundle = "sat_cin_zm_vig_death_diana";
    fe [[ f ]]( s, us, cf, ( 33390, 42226, 16626 ), ( 0, 0, 0 ), "sat_cin_zm_vig_death_diana" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 32192.5, 42239.5, 16672 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 32562, 41886, 16674 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 34340, 42274, 16685 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 33250.5, 41042.5, 16634 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 33694, 41828, 16671 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 34095.5, 41541.5, 16686 ), ( 0, 0, 0 ), "nf_blocker" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    s.script_scenescriptbundle = "sat_cin_zm_hornet_outro";
    fe [[ f ]]( s, us, cf, ( 33390, 42226, 16626 ), ( 0, 0, 0 ), "sat_cin_zm_hornet_outro" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_necrotic_fan_create_script";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_necrotic_fan_create_script
// Params 0, eflags: 0x4
// Checksum 0x2dffcf88, Offset: 0x555
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_necrotic_fan_create_script
// Params 0
// Checksum 0x50026d21, Offset: 0x55f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_necrotic_fan_create_script" );
}

