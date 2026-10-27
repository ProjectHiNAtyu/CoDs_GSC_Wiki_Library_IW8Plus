// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage_cs.gsc  (hash_4bffcca413424762.gscc) (size: 3523 Bytes / 0xdc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30a1518a (815878538)
// size ...... 3523 (0xdc3)
// includes .. 3   (offset: 0xc07)
// strings ... 24  (offset: 0xc1f)
// dev strs .. 0   (offset: 0xdc3)
// exports ... 9   (offset: 0x86f)
// cseg ...... 0x211 + 0x65e (0x86f)
// imports ... 20  (offset: 0x9d7)
// animtree1 . 0   (offset: 0xdc3)
// animtree2 . 0   (offset: 0xdc3)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_garage_cs;

// Namespace zm_sat_firefly_script_garage_cs
// Params 0, eflags: 0x5
// Checksum 0xf8d2f47a, Offset: 0x22f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_garage_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 0, eflags: 0x4
// Checksum 0xdc1a556c, Offset: 0x250
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 0, eflags: 0x4
// Checksum 0x59218680, Offset: 0x261
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 2
// Checksum 0xe9c8d0c9, Offset: 0x272
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_garage_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_garage_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_garage_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_garage_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 3, eflags: 0x4
// Checksum 0xdaa3324f, Offset: 0x2fa
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_garage_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_garage_cs" );
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 3, eflags: 0x4
// Checksum 0x10e721b8, Offset: 0x374
// Size: 0x4db
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    fe [[ f ]]( s, us, cf, ( 3774, -1065, -328.5 ), ( 0, 270, 0 ), "garage_player_teleport_station" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    fe [[ f ]]( s, us, cf, ( 3955.5, -894, -328 ), ( 0, 270, 0 ), "garage_upgrade_station" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    s.name = "Boss";
    fe [[ f ]]( s, us, cf, ( 46364, -2484, -128 ), ( 0, 270, 0 ), "boss_garage_player_teleport_station" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    fe [[ f ]]( s, us, cf, ( 3777, -1083.5, -332 ), ( 0, 270, 0 ), "garage_pluto_spawn", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "PAP";
    fe [[ f ]]( s, us, cf, ( 3957.96, -901.11, -275.65 ), ( 16.83, 270, 0 ), "garage_pap_hanging_part" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Turret";
    fe [[ f ]]( s, us, cf, ( 3958.31, -900.52, -282.9 ), ( 0, 0, 270 ), "garage_turret_part" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 4115.5, -1040.01, -328 ), ( 0, 270, 0 ), "garage_door", undefined, "02" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 3788, -1228, -328 ), ( 0, 0, 0 ), "garage_door", undefined, "01" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 3524, -1040, -328 ), ( 0, -90, 0 ), "garage_door", undefined, "02" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    s.name = "Boss";
    fe [[ f ]]( s, us, cf, ( 46727, 1645, -177 ), ( 0, 270, 0 ), "boss_garage_player_teleport_station" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 23141, 479, 314.49 ), ( 357.05, 345.58, -1.7 ), "pluto_start_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    fe [[ f ]]( s, us, cf, ( 4031, -1232, -255.99 ), ( 0, 270, 0 ), "garage_summon_station" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Abom";
    fe [[ f ]]( s, us, cf, ( 4021.54, -889, -255.92 ), ( 0, -90, 0 ), "garage_abom_part", undefined, "c_t10_zmb_abomination_head_ri" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_garage_cs";
    s.groupid = "Garage";
    fe [[ f ]]( s, us, cf, ( 3800, -995.5, -328.5 ), ( 0, 83.31, -0 ), "s_garage", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 0, eflags: 0x4
// Checksum 0xe0adf5b5, Offset: 0x857
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_garage_cs
// Params 0
// Checksum 0x18f0ef02, Offset: 0x861
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_garage_cs" );
}

