// script_634d2942afcc76e  (hash_0634d2942afcc76e.gscc) (size: 5837 Bytes / 0x16cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc93284d1 (3375531217)
// size ...... 5837 (0x16cd)
// includes .. 3   (offset: 0x13bd)
// strings ... 30  (offset: 0x13d5)
// dev strs .. 0   (offset: 0x16cd)
// exports ... 9   (offset: 0x1025)
// cseg ...... 0x319 + 0xd0c (0x1025)
// imports ... 20  (offset: 0x118d)
// animtree1 . 0   (offset: 0x16cd)
// animtree2 . 0   (offset: 0x16cd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs;

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 0, eflags: 0x5
// Checksum 0xf69a175d, Offset: 0x337
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 0, eflags: 0x4
// Checksum 0xdc5f50bc, Offset: 0x358
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 0, eflags: 0x4
// Checksum 0x59648350, Offset: 0x369
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 2
// Checksum 0xe98dd519, Offset: 0x37a
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 3, eflags: 0x4
// Checksum 0xdae6379f, Offset: 0x402
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 3, eflags: 0x4
// Checksum 0x281bd00d, Offset: 0x47c
// Size: 0xb89
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 26107, -55100, 223.5 ), ( 0, 130.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_cqb_green" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_surprise_shipment";
    fe [[ f ]]( s, us, cf, ( 25106, -56166, 83 ), ( 0, 286, 0 ), "pisces_surprise_shipment", undefined, "bots" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 374, 484, 62 );
    s._size_min = ( 1214, 384, 202 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 30396, -43905.5, 612.5 ), ( 0, 339.48, 0 ), "s_pisces_cushion" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "outro_teleport";
    fe [[ f ]]( s, us, cf, ( 30531, -43928, 718.09 ), ( 0, 229.3, 0 ), "pisces_outro_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "outro_teleport";
    fe [[ f ]]( s, us, cf, ( 30468.9, -43868.1, 719.14 ), ( 0, 234.5, 0 ), "pisces_outro_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "outro_teleport";
    fe [[ f ]]( s, us, cf, ( 30584, -43991.5, 715.08 ), ( 0, 229.1, 0 ), "pisces_outro_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "outro_teleport";
    fe [[ f ]]( s, us, cf, ( 30395, -43821.5, 723.41 ), ( 0, 241, 0 ), "pisces_outro_teleport" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_step_06_center";
    fe [[ f ]]( s, us, cf, ( 31876, -43383, 1110 ), ( 0, 0, 0 ), "pisces_step_06_center" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "objective_location";
    fe [[ f ]]( s, us, cf, ( 20838, -56769, 32 ), ( 0, 100.9, 0 ), "pisces_objective_location", undefined, undefined, undefined, undefined, undefined, undefined, 800 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "objective_location";
    fe [[ f ]]( s, us, cf, ( 20089, -56199, 32 ), ( 0, 100.9, 0 ), "pisces_objective_location", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "pisces_juggerbot";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 20068.3, -56186, 32 ), ( 0, 109, 0 ), "cspf_0_auto1505603201058633571", undefined, "juggerbot" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "juggerbot_encounter";
    fe [[ f ]]( s, us, cf, ( 20076.8, -56202.7, 32 ), ( 0, 100.9, 0 ), "pisces_shipyard_juggerbot_encounter" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 30618, -51858, 1365 ), ( 0, 222, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_long_green" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 26170, -51698, 206.5 ), ( 0, 310.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 20371, -51998, 142.75 ), ( 0, 130.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 26871.5, -52074.5, 47.5 ), ( 0, 310.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_stealth" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 26402, -49802, 791.5 ), ( 0, 220.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 27236, -46729, 214.75 ), ( 0, 173.7, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 31603, -53052, 951.5 ), ( 0, 173.7, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 28779, -49197, 47.5 ), ( 0, 220.8, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_stealth" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 21786, -54744, 79.72 ), ( 0, 131.2, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.groupid = "Supply";
    s.name = "Supply";
    fe [[ f ]]( s, us, cf, ( 27016, -56757, 223.5 ), ( 0, 221.2, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_juggerbot_respawn";
    fe [[ f ]]( s, us, cf, ( 20930, -58833.9, 144 ), ( 0, 103.5, 0 ), "pisces_juggerbot_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_juggerbot_respawn";
    fe [[ f ]]( s, us, cf, ( 20887.5, -58951.8, 144 ), ( 0, 108.5, 0 ), "pisces_juggerbot_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_juggerbot_respawn";
    fe [[ f ]]( s, us, cf, ( 20757.8, -58714.9, 192 ), ( 0, 103.5, 0 ), "pisces_juggerbot_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_juggerbot_respawn";
    fe [[ f ]]( s, us, cf, ( 20976.2, -59046.1, 144 ), ( 0, 102.1, 0 ), "pisces_juggerbot_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 844, 538, 48 );
    s._size_min = ( 1152, 438, 202 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 29840.5, -44598.5, 381.5 ), ( 0, 314.86, 0 ), "s_pisces_cushion" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_surprise_shipment";
    fe [[ f ]]( s, us, cf, ( 20802, -53606, 83 ), ( 0, 286, 0 ), "pisces_surprise_shipment", undefined, "bots" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs";
    s.name = "pisces_surprise_shipment";
    fe [[ f ]]( s, us, cf, ( 23698, -50246, 211.52 ), ( 0, 166, 0 ), "pisces_surprise_shipment", undefined, "bots" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 0, eflags: 0x4
// Checksum 0xf71a2832, Offset: 0x100d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs
// Params 0
// Checksum 0x18b5ead2, Offset: 0x1017
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_pisces_shipyard_cs" );
}

