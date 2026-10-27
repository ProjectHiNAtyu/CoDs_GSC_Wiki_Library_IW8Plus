// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_boss_fight_urchin_cs.gsc  (hash_0afc39618026ed53.gscc) (size: 6915 Bytes / 0x1b03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc47c0f66 (3296464742)
// size ...... 6915 (0x1b03)
// includes .. 3   (offset: 0x176b)
// strings ... 15  (offset: 0x1783)
// dev strs .. 0   (offset: 0x1b03)
// exports ... 9   (offset: 0x13d3)
// cseg ...... 0x17a + 0x1259 (0x13d3)
// imports ... 20  (offset: 0x153b)
// animtree1 . 0   (offset: 0x1b03)
// animtree2 . 0   (offset: 0x1b03)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_boss_fight_urchin_cs;

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 0, eflags: 0x5
// Checksum 0xcc9c4b2e, Offset: 0x198
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_boss_fight_urchin_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0xc6de32fd, Offset: 0x1b9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0x43e5e111, Offset: 0x1ca
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 2
// Checksum 0xf30cb758, Offset: 0x1db
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_boss_fight_urchin_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_boss_fight_urchin_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_boss_fight_urchin_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_boss_fight_urchin_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 3, eflags: 0x4
// Checksum 0xc06755de, Offset: 0x263
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_boss_fight_urchin_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_boss_fight_urchin_cs" );
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 3, eflags: 0x4
// Checksum 0x7bd63efc, Offset: 0x2dd
// Size: 0x10d6
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47149.2, 945.31, -219.57 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45924.2, -2080.74, -171.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46726.3, -1402.76, -170.78 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47273.2, -2077.73, -181.23 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 45506, 1066, -192 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46098.2, -1261.82, -218.11 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45605.2, -790.78, -216.16 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 44740.2, -1264.76, -192 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45249.2, -353.69, -144 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45154.2, 1167.23, -191.19 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45013.2, -351.7, -144 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 44768.2, 598.21, -191.2 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45755.3, 403.21, -218.08 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 45332, -1402, -168.45 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46297.3, 1158.21, -242.51 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 47787, -384, -86.05 ), ( 1.37, 231.93, 1.57 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 46512, 1264, -237.09 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45956.2, 890.18, -216.16 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 47611, 899, -229.96 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 47634, -1502, -187.19 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 48487.3, -87.79, 3.34 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 48188.2, 880.19, -191.84 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 48133.2, -1745.73, -192 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47311.2, -1005.82, -225.91 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 48256.3, -253.75, -144.77 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46721.2, 1446.29, -240.16 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47465.2, 1437.31, -192.15 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46952.2, 586.31, -215.35 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45644.2, 1458.2, -193.03 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 46503.2, -2013.8, -186.99 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 48723.3, -709.79, 2.88 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Aetheric";
    fe [[ f ]]( s, us, cf, ( 48622, -302, 2.24 ), ( 0, 0, 0 ), undefined, undefined, "boss_aetheric_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Power";
    s.name = "Playspace";
    fe [[ f ]]( s, us, cf, ( 44824, -333, -127 ), ( 0, 0, 0 ), undefined, undefined, "boss_powerup_loc_InPlayspace" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 45609.3, -20.79, -207.99 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Power";
    s.name = "Playspace";
    fe [[ f ]]( s, us, cf, ( 48534, -332, 43 ), ( 0, 0, 0 ), undefined, undefined, "boss_powerup_loc_InPlayspace" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47818.2, 507.18, -195.18 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Death";
    fe [[ f ]]( s, us, cf, ( 47470.2, -466.81, -144 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, "sat_zm_death_urchin_puddle" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 45777, -1690, -138.47 ), ( 359.8, 348.93, 2.36 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 47964, -1436, -184.6 ), ( 0.77, 322.84, -0.16 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 47500, 321, -192.74 ), ( 1.37, 231.93, 1.57 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 48597, -402, 2.78 ), ( 1.95, 145.63, 1.78 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 47038, -1578, -137.83 ), ( 2.18, 235.46, -0.04 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 44924, -930, -172.27 ), ( 1.97, 71.17, -2.44 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 44883, 172, -167.38 ), ( 1.88, 299.35, 1.4 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 45717, 1199, -196.94 ), ( 1.5, 18.74, 1.22 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 47499, 1013, -218.56 ), ( 359.46, 107.59, -1.11 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 46502, 1299, -237.4 ), ( 2.36, 263.6, -1 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 45302, 698, -139.76 ), ( 1.37, 100.22, -1.17 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Power";
    s.name = "Out";
    fe [[ f ]]( s, us, cf, ( 48265, 1082, 101 ), ( 0, 0, 0 ), undefined, undefined, "boss_powerup_loc_OutPlayspace" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Barnacle";
    fe [[ f ]]( s, us, cf, ( 45550, -1253, -171.39 ), ( 2.15, 259.2, 2.46 ), "barnacle_boss_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_boss_fight_urchin_cs";
    s.groupid = "Power";
    s.name = "Out";
    fe [[ f ]]( s, us, cf, ( 45132, 1285, 101 ), ( 0, 0, 0 ), undefined, undefined, "boss_powerup_loc_OutPlayspace" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 0, eflags: 0x4
// Checksum 0x66ac93fc, Offset: 0x13bb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_boss_fight_urchin_cs
// Params 0
// Checksum 0x2348893, Offset: 0x13c5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_boss_fight_urchin_cs" );
}

