// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_redeploy_parent_cs.gsc  (hash_28ffbc75e4711e68.gscc) (size: 17370 Bytes / 0x43da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fb43970 (1337211248)
// size ...... 17370 (0x43da)
// includes .. 2   (offset: 0x392a)
// strings ... 101 (offset: 0x393a)
// dev strs .. 0   (offset: 0x43da)
// exports ... 6   (offset: 0x367a)
// cseg ...... 0x736 + 0x2f44 (0x367a)
// imports ... 16  (offset: 0x376a)
// animtree1 . 0   (offset: 0x43da)
// animtree2 . 0   (offset: 0x43da)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_redeploy_parent_cs;

// Namespace mp_saw_avalon_bongo_redeploy_parent_cs
// Params 2
// Checksum 0xecbc48b0, Offset: 0x754
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_redeploy_parent_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_redeploy_parent_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_redeploy_parent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_redeploy_parent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_redeploy_parent_cs
// Params 3, eflags: 0x4
// Checksum 0xdfd7aa36, Offset: 0x7dc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_redeploy_parent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_redeploy_parent_cs" );
}

// Namespace mp_saw_avalon_bongo_redeploy_parent_cs
// Params 3, eflags: 0x4
// Checksum 0x6db38bd8, Offset: 0x856
// Size: 0x2e04
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_TENNISCLUB";
    fe [[ f ]]( s, us, cf, ( -16587.8, 42685.6, 1575.07 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_TENNISCLUB", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_TOWN";
    fe [[ f ]]( s, us, cf, ( 1135, 9478, 219.13 ), ( 0, 257.2, 0 ), "activity_nexus_variant", "REDEPLOY_TOWN", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_HIGHTOWN";
    fe [[ f ]]( s, us, cf, ( -17720, 7800, 1320 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_HIGHTOWN", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_RESORT";
    fe [[ f ]]( s, us, cf, ( 10798, 17920.5, 510 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_RESORT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_001";
    fe [[ f ]]( s, us, cf, ( 34724, -11933, 434.34 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_001", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_WATER";
    fe [[ f ]]( s, us, cf, ( 44584, -12664, 784 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_WATER", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_003";
    fe [[ f ]]( s, us, cf, ( 39847.7, -26404.2, 431.17 ), ( 0, 330.2, 0 ), "activity_nexus_variant", "REDEPLOY_003", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.target = "REDEPLOY_CLIFFTOWN";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_CLIFFTOWN";
    fe [[ f ]]( s, us, cf, ( 39025.4, 7584.45, 1320 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_COLOSSEUM";
    fe [[ f ]]( s, us, cf, ( 45232, 23464, 928.93 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_COLOSSEUM", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_PONYCLUB";
    fe [[ f ]]( s, us, cf, ( 30760.4, 48028.6, 1605.74 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_PONYCLUB", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.target = "REDEPLOY_CARFACTORY";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_CARFACTORY";
    fe [[ f ]]( s, us, cf, ( 50961.4, -40431.9, 2247 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_HELIPORT";
    fe [[ f ]]( s, us, cf, ( 31693.7, -24498.9, 544 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_HELIPORT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.target = "REDEPLOY_ARSENAL";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_ARSENAL";
    fe [[ f ]]( s, us, cf, ( 31667.6, -47526.3, 241 ), ( 0, 312, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_CHOPSHOP";
    fe [[ f ]]( s, us, cf, ( 1968.07, -44096.9, 432.95 ), ( 0, 21.4, 0 ), "activity_nexus_variant", "REDEPLOY_CHOPSHOP", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_PIER";
    fe [[ f ]]( s, us, cf, ( -5037.29, -20086.9, 376 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_PIER", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_FORT";
    fe [[ f ]]( s, us, cf, ( -38902.2, -39582.3, 1144.42 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_FORT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.target = "REDEPLOY_FIRINGRANGE";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_FIRINGRANGE";
    fe [[ f ]]( s, us, cf, ( -27283.3, -30752.6, 1136.84 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_SECURITY";
    fe [[ f ]]( s, us, cf, ( -39175.3, -10903.2, 260.01 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_SECURITY", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_WINERY";
    fe [[ f ]]( s, us, cf, ( 11142, 47138.9, 858.18 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_WINERY", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_SUBURBS";
    fe [[ f ]]( s, us, cf, ( -10655.3, 51787.9, 720 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_SUBURBS", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_CONSTRUCTION";
    fe [[ f ]]( s, us, cf, ( -24397.5, 26932.2, 2415.29 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_CONSTRUCTION", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_STADIUM";
    fe [[ f ]]( s, us, cf, ( -34485.7, 8139.3, 583 ), ( 0, 134.9, 0 ), "activity_nexus_variant", "REDEPLOY_STADIUM", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_CASINO";
    fe [[ f ]]( s, us, cf, ( -8000.73, 21761.5, 969.5 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_CASINO", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_WINERYSOUTH";
    fe [[ f ]]( s, us, cf, ( 13959.7, 33881.6, 2185.5 ), ( 0, 90, 0 ), "activity_nexus_variant", "REDEPLOY_WINERYSOUTH", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_DIGSITE";
    fe [[ f ]]( s, us, cf, ( 30865.4, 28189.8, 3294.91 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_DIGSITE", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_ANTENNA";
    fe [[ f ]]( s, us, cf, ( 10126.1, -31437.6, 4507.13 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_ANTENNA", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_VILLA";
    fe [[ f ]]( s, us, cf, ( -34049.5, 35605.7, 2232 ), ( 0, 0, 0 ), "activity_nexus_variant", "REDEPLOY_VILLA", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_WINERYSOUTH";
    fe [[ f ]]( s, us, cf, ( 13959.7, 33881.6, 1983.15 ), ( 0, 90, 0 ), "REDEPLOY_WINERYSOUTH", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_WINERY";
    fe [[ f ]]( s, us, cf, ( 11142, 47138.9, 602.18 ), ( 0, 0, 0 ), "REDEPLOY_WINERY", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_WATER";
    fe [[ f ]]( s, us, cf, ( 44584, -12664, 528 ), ( 0, 0, 0 ), "REDEPLOY_WATER", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_VILLA";
    fe [[ f ]]( s, us, cf, ( -34049.5, 35605.7, 1976 ), ( 0, 0, 0 ), "REDEPLOY_VILLA", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_TOWN";
    fe [[ f ]]( s, us, cf, ( 1135, 9478, 24.14 ), ( 0, 257.2, 0 ), "REDEPLOY_TOWN", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_TENNISCLUB";
    fe [[ f ]]( s, us, cf, ( -16587.8, 42685.6, 1319.07 ), ( 0, 0, 0 ), "REDEPLOY_TENNISCLUB", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_SUBURBS";
    fe [[ f ]]( s, us, cf, ( -10655.3, 51787.9, 464 ), ( 0, 0, 0 ), "REDEPLOY_SUBURBS", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_STADIUM";
    fe [[ f ]]( s, us, cf, ( -34485.7, 8139.3, 327 ), ( 0, 134.9, 0 ), "REDEPLOY_STADIUM", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_COLOSSEUM";
    fe [[ f ]]( s, us, cf, ( 45232, 23464, 672.93 ), ( 0, 0, 0 ), "REDEPLOY_COLOSSEUM", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_CHOPSHOP";
    fe [[ f ]]( s, us, cf, ( 1968.07, -44096.9, 243.95 ), ( 0, 21.4, 0 ), "REDEPLOY_CHOPSHOP", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_CARFACTORY";
    fe [[ f ]]( s, us, cf, ( 50961.4, -40431.9, 1991 ), ( 0, 0, 0 ), "REDEPLOY_CARFACTORY", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_001";
    fe [[ f ]]( s, us, cf, ( 34733, -11930, 210.26 ), ( 0, 0, 0 ), "REDEPLOY_001", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_ANTENNA";
    fe [[ f ]]( s, us, cf, ( 10126.1, -31437.6, 4251.13 ), ( 0, 0, 0 ), "REDEPLOY_ANTENNA", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_ARSENAL";
    fe [[ f ]]( s, us, cf, ( 31667.6, -47526.3, 49 ), ( 0, 312, 0 ), "REDEPLOY_ARSENAL", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_CASINO";
    fe [[ f ]]( s, us, cf, ( -8000.73, 21761.5, 713.5 ), ( 0, 0, 0 ), "REDEPLOY_CASINO", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_CONSTRUCTION";
    fe [[ f ]]( s, us, cf, ( -24397.5, 26932.2, 2159.29 ), ( 0, 0, 0 ), "REDEPLOY_CONSTRUCTION", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_CLIFFTOWN";
    fe [[ f ]]( s, us, cf, ( 39025.4, 7584.45, 1064 ), ( 0, 0, 0 ), "REDEPLOY_CLIFFTOWN", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_DIGSITE";
    fe [[ f ]]( s, us, cf, ( 30865.4, 28189.8, 3038.91 ), ( 0, 0, 0 ), "REDEPLOY_DIGSITE", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_FIRINGRANGE";
    fe [[ f ]]( s, us, cf, ( -27283.3, -30752.6, 880.84 ), ( 0, 0, 0 ), "REDEPLOY_FIRINGRANGE", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_FORT";
    fe [[ f ]]( s, us, cf, ( -38902.2, -39582.3, 888.42 ), ( 0, 0, 0 ), "REDEPLOY_FORT", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_HELIPORT";
    fe [[ f ]]( s, us, cf, ( 31693.7, -24498.9, 288 ), ( 0, 0, 0 ), "REDEPLOY_HELIPORT", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_HIGHTOWN";
    fe [[ f ]]( s, us, cf, ( -17720, 7800, 1064 ), ( 0, 0, 0 ), "REDEPLOY_HIGHTOWN", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_PIER";
    fe [[ f ]]( s, us, cf, ( -5037.29, -20086.9, 120 ), ( 0, 0, 0 ), "REDEPLOY_PIER", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_PONYCLUB";
    fe [[ f ]]( s, us, cf, ( 30760.4, 48028.6, 1349.74 ), ( 0, 0, 0 ), "REDEPLOY_PONYCLUB", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_RESORT";
    fe [[ f ]]( s, us, cf, ( 10798, 17920.5, 254 ), ( 0, 0, 0 ), "REDEPLOY_RESORT", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_SECURITY";
    fe [[ f ]]( s, us, cf, ( -39175.3, -10903.2, 4.01 ), ( 0, 0, 0 ), "REDEPLOY_SECURITY", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_003";
    fe [[ f ]]( s, us, cf, ( 39857, -26406, 258.17 ), ( 0, 330.2, 0 ), "REDEPLOY_003", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_002";
    fe [[ f ]]( s, us, cf, ( 58203.6, -22774.5, 2658.73 ), ( 0, 253.7, 0 ), "activity_nexus_variant", "REDEPLOY_002", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_002";
    fe [[ f ]]( s, us, cf, ( 58204, -22784, 2480.73 ), ( 0, 253.7, 0 ), "REDEPLOY_002", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_004";
    fe [[ f ]]( s, us, cf, ( 33456.1, -38342.3, 1277.38 ), ( 0, 1.3, 0 ), "activity_nexus_variant", "REDEPLOY_004", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_004";
    fe [[ f ]]( s, us, cf, ( 33465, -38339, 1092.78 ), ( 0, 1.3, 0 ), "REDEPLOY_004", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_005";
    fe [[ f ]]( s, us, cf, ( 20430.3, -36955.4, 640.99 ), ( 0, 170.8, 0 ), "activity_nexus_variant", "REDEPLOY_005", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_005";
    fe [[ f ]]( s, us, cf, ( 20421, -36957, 449.99 ), ( 0, 170.8, 0 ), "REDEPLOY_005", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_007";
    fe [[ f ]]( s, us, cf, ( 1012.9, -53357.4, 1443 ), ( 0, 206, 0 ), "activity_nexus_variant", "REDEPLOY_007", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_007";
    fe [[ f ]]( s, us, cf, ( 1006.2, -53364.1, 1224 ), ( 0, 206, 0 ), "REDEPLOY_007", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_008";
    fe [[ f ]]( s, us, cf, ( -11977.5, -44183.6, 837.68 ), ( 0, 305.4, 0 ), "activity_nexus_variant", "REDEPLOY_008", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_008";
    fe [[ f ]]( s, us, cf, ( -11969.8, -44189.1, 647.69 ), ( 0, 305.4, 0 ), "REDEPLOY_008", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_009";
    fe [[ f ]]( s, us, cf, ( -21442.4, -43954.5, 634.23 ), ( 0, 98.3, 0 ), "activity_nexus_variant", "REDEPLOY_009", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_009";
    fe [[ f ]]( s, us, cf, ( -21446.8, -43946.1, 359.07 ), ( 0, 98.3, 0 ), "REDEPLOY_009", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_012";
    fe [[ f ]]( s, us, cf, ( -44489.3, -27447.7, 280 ), ( 0, 241.3, 0 ), "activity_nexus_variant", "REDEPLOY_012", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_012";
    fe [[ f ]]( s, us, cf, ( -44490.8, -27457.1, 82 ), ( 0, 241.3, 0 ), "REDEPLOY_012", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_013";
    fe [[ f ]]( s, us, cf, ( -49901.3, -16675.7, 546.23 ), ( 0, 182.79, 0 ), "activity_nexus_variant", "REDEPLOY_013", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_013";
    fe [[ f ]]( s, us, cf, ( -49910.1, -16679.3, 371.66 ), ( 0, 182.79, 0 ), "REDEPLOY_013", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_014";
    fe [[ f ]]( s, us, cf, ( -47655.3, 4897.05, 424.5 ), ( 0, 186.06, 0 ), "activity_nexus_variant", "REDEPLOY_014", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_014";
    fe [[ f ]]( s, us, cf, ( -47663.9, 4892.95, 256.5 ), ( 0, 186.06, 0 ), "REDEPLOY_014", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_015";
    fe [[ f ]]( s, us, cf, ( -46689.1, 21748.4, 897.86 ), ( 0, 39.36, 0 ), "activity_nexus_variant", "REDEPLOY_015", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_015";
    fe [[ f ]]( s, us, cf, ( -46685.1, 21756.6, 719.86 ), ( 0, 39.36, 0 ), "REDEPLOY_015", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_016";
    fe [[ f ]]( s, us, cf, ( -42427.9, 29319.4, 1769.82 ), ( 0, 232.36, 0 ), "activity_nexus_variant", "REDEPLOY_016", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_016";
    fe [[ f ]]( s, us, cf, ( -42427.9, 29319.4, 1584.82 ), ( 0, 232.36, 0 ), "REDEPLOY_016", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_017";
    fe [[ f ]]( s, us, cf, ( -30658.9, 16259.4, 1067.99 ), ( 0, 182.46, 0 ), "activity_nexus_variant", "REDEPLOY_017", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_017";
    fe [[ f ]]( s, us, cf, ( -30658.9, 16259.4, 1067.99 ), ( 0, 182.46, 0 ), "REDEPLOY_017", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_018";
    fe [[ f ]]( s, us, cf, ( -36857.6, 25174.9, 1799.84 ), ( 0, 95.86, 0 ), "activity_nexus_variant", "REDEPLOY_018", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_018";
    fe [[ f ]]( s, us, cf, ( -36857.6, 25174.9, 1799.84 ), ( 0, 95.86, 0 ), "REDEPLOY_018", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_019";
    fe [[ f ]]( s, us, cf, ( -24622.9, 49622.4, 1684.62 ), ( 0, 313.46, 0 ), "activity_nexus_variant", "REDEPLOY_019", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_019";
    fe [[ f ]]( s, us, cf, ( -24622.9, 49622.4, 1684.62 ), ( 0, 313.46, 0 ), "REDEPLOY_019", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_020";
    fe [[ f ]]( s, us, cf, ( -3090.1, 43807.6, 232.07 ), ( 0, 133.46, 0 ), "activity_nexus_variant", "REDEPLOY_020", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_020";
    fe [[ f ]]( s, us, cf, ( -3090.1, 43807.6, 232.07 ), ( 0, 133.46, 0 ), "REDEPLOY_020", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_021";
    fe [[ f ]]( s, us, cf, ( 1831.1, 31206.4, 1022.86 ), ( 0, 93.26, 0 ), "activity_nexus_variant", "REDEPLOY_021", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_021";
    fe [[ f ]]( s, us, cf, ( 1831.1, 31206.4, 1022.86 ), ( 0, 93.26, 0 ), "REDEPLOY_021", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_022";
    fe [[ f ]]( s, us, cf, ( 22855.4, 23351.9, 647.89 ), ( 0, 14.06, 0 ), "activity_nexus_variant", "REDEPLOY_022", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_022";
    fe [[ f ]]( s, us, cf, ( 22855.4, 23351.9, 647.89 ), ( 0, 14.06, 0 ), "REDEPLOY_022", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_023";
    fe [[ f ]]( s, us, cf, ( 43033.4, 34979.9, 1342 ), ( 0, 316.36, 0 ), "activity_nexus_variant", "REDEPLOY_023", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_023";
    fe [[ f ]]( s, us, cf, ( 43033.4, 34979.9, 1342 ), ( 0, 316.36, 0 ), "REDEPLOY_023", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_024";
    fe [[ f ]]( s, us, cf, ( 9480.56, -8643.01, 1798.99 ), ( 0, 186, 0 ), "activity_nexus_variant", "REDEPLOY_024", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_024";
    fe [[ f ]]( s, us, cf, ( 9472, -8647, 1798.99 ), ( 0, 186, 0 ), "REDEPLOY_024", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.activity_bundle = "saw_activity_bongo_redeploy_station";
    s.name = "REDEPLOY_025";
    fe [[ f ]]( s, us, cf, ( -25155.6, -20892.2, 964.83 ), ( 0, 166.1, 0 ), "activity_nexus_variant", "REDEPLOY_025", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_redeploy_parent_cs";
    s.name = "TOWER_025";
    fe [[ f ]]( s, us, cf, ( -25165, -20893, 964.83 ), ( 0, 166.1, 0 ), "REDEPLOY_025", undefined, "redeploy_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 4000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_redeploy_parent_cs
// Params 0, eflags: 0x4
// Checksum 0xfdabd8b0, Offset: 0x3662
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_redeploy_parent_cs
// Params 0
// Checksum 0x1d84777b, Offset: 0x366c
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_redeploy_parent_cs" );
}

