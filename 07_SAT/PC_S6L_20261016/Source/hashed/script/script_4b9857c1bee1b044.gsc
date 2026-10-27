// script_4b9857c1bee1b044  (hash_4b9857c1bee1b044.gscc) (size: 12589 Bytes / 0x312d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6df125c2 (1844520386)
// size ...... 12589 (0x312d)
// includes .. 3   (offset: 0x2991)
// strings ... 67  (offset: 0x29a9)
// dev strs .. 0   (offset: 0x312d)
// exports ... 9   (offset: 0x25f9)
// cseg ...... 0x80c + 0x1ded (0x25f9)
// imports ... 20  (offset: 0x2761)
// animtree1 . 0   (offset: 0x312d)
// animtree2 . 0   (offset: 0x312d)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs;

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 0, eflags: 0x5
// Checksum 0x632e8a81, Offset: 0x82a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 0, eflags: 0x4
// Checksum 0x729aded6, Offset: 0x84b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 0, eflags: 0x4
// Checksum 0xf7a10d3a, Offset: 0x85c
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 2
// Checksum 0x47485b73, Offset: 0x86d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 3, eflags: 0x4
// Checksum 0x7423b9f5, Offset: 0x8f5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 3, eflags: 0x4
// Checksum 0x2bd28e81, Offset: 0x96f
// Size: 0x1c6a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "Center";
    fe [[ f ]]( s, us, cf, ( 43440.2, -14294.2, 526 ), ( 0, 0, 0 ), "pisces_step_02_center_struct", undefined, "watertreatment_pisces_03_vtol_reinforcements", "cspf_0_25 cspf_0_26 cspf_0_27" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, us, cf, ( 45181.5, -15434, 1011.01 ), ( 0, 68.05, 0 ), "pisces_step_02_supply_drop" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 43767, -15377, 688.1 ), ( 1.01, 17.66, -12.67 ), "sat_decor_bodybag_01", "cspf_0_auto9679370130181503842", "sat_ob_activity_pisces_step_02_c_interact", undefined, "cspf_0_25" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 41590.5, -12289.5, 307.26 ), ( 354.82, 194.52, -1.13 ), "sat_decor_bodybag_01", "cspf_0_auto5667525219182370570", "sat_ob_activity_pisces_step_02_a_interact", undefined, "cspf_0_26" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 44179, -13348, 734 ), ( 0, 15.73, 0 ), "sat_decor_bodybag_01", "cspf_0_auto5384445889954084606", "sat_ob_activity_pisces_step_02_b_interact", undefined, "cspf_0_27" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 43126.8, -9545.75, 306 ), ( 0, 0, 0 ), "pisces_step_02_center_struct", undefined, "watertreatment_pisces_04_vtol_reinforcements", "cspf_0_22 cspf_0_23 cspf_0_24" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 43103, -9831.5, -11 ), ( 0, 280.49, 0 ), "sat_decor_bodybag_01", "cspf_0_auto14022390216386521751", "sat_ob_activity_pisces_step_02_c_interact", undefined, "cspf_0_22" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 44611, -10446.5, 313.16 ), ( 0, 269.41, 0 ), "sat_decor_bodybag_01", "cspf_0_auto3278982181516893803", "sat_ob_activity_pisces_step_02_b_interact", undefined, "cspf_0_23" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 42279.5, -9561, 7 ), ( 0, 230.85, 0 ), "sat_decor_bodybag_01", "cspf_0_auto10932911491473641852", "sat_ob_activity_pisces_step_02_a_interact", undefined, "cspf_0_24" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 49065.5, -11836.8, 433 ), ( 0, 0, 0 ), "pisces_step_02_center_struct_old", undefined, "watertreatment_pisces_02_vtol_reinforcements", "cspf_0_16 cspf_0_17 cspf_0_18" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 50112, -11751.5, 443.67 ), ( 0.93, 275.82, -3.3 ), "sat_decor_bodybag_01", "cspf_0_auto1230620436237692782", "sat_ob_activity_pisces_step_02_a_interact", undefined, "cspf_0_16" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 48652, -13300, 507.13 ), ( 0, 119.3, 5.4 ), "sat_decor_bodybag_01", "cspf_0_auto2761098948083823992", "sat_ob_activity_pisces_step_02_b_interact", undefined, "cspf_0_17" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 46969, -12059, 441.13 ), ( 0, 12.3, -0 ), "sat_decor_bodybag_01", "cspf_0_auto10452187256301235850", "sat_ob_activity_pisces_step_02_c_interact", undefined, "cspf_0_18" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 50620.2, -8688.25, 601.61 ), ( 0, 0, 0 ), "pisces_step_02_center_struct", undefined, "watertreatment_pisces_01_vtol_reinforcements", "cspf_0_19 cspf_0_20 cspf_0_21" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 51003.5, -7344, 498.18 ), ( 3.23, 357.62, -0.32 ), "sat_decor_bodybag_01", "cspf_0_auto8591771374923800514", "sat_ob_activity_pisces_step_02_a_interact", undefined, "cspf_0_19" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 51333, -8999, 505.25 ), ( 345.29, 209.58, -15.01 ), "sat_decor_bodybag_01", "cspf_0_auto7083711393781270722", "sat_ob_activity_pisces_step_02_c_interact", undefined, "cspf_0_20" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    fe [[ f ]]( s, us, cf, ( 49651.5, -9503, 646 ), ( 0, 205.12, 0 ), "sat_decor_bodybag_01", "cspf_0_auto8488714528375036572", "sat_ob_activity_pisces_step_02_b_interact", undefined, "cspf_0_21" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43102, -9836, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43212, -9714, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42922, -9732, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42866, -9838, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42966, -9886, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43002, -9686, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43168, -9880, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42796, -9796, 138 ), ( 0, 270, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43306, -9774, 138 ), ( 0, 270, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42958, -9800, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43178, -9788, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43098, -9748, 138 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42884, -9774, 96 ), ( 0, 316, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43190, -9736, 88 ), ( 0, 234, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 42998, -9724, 32 ), ( 0, 272, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43070, -9818, 62 ), ( 0, 248, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_2" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "Water";
    fe [[ f ]]( s, us, cf, ( 43338, -9850, 184 ), ( 0, 0, 0 ), "sat_ob_pisces_elec_water_particles", undefined, "vfx_elec_water_sparks" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 46920.7, -11982.5, 439.5 ), ( 0, 270, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 43462.3, -9411.88, 181.5 ), ( 0, 2, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 43335, -15125.5, 621.53 ), ( 0, 112.99, 0 ), undefined, undefined, "watertreatment_pisces_03_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 43855, -14924, 621.5 ), ( 0, 71.7, 0 ), undefined, undefined, "watertreatment_pisces_03_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.model = "sat_decor_backpack_wingsuit_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 45187.4, -15418.9, 1019.51 ), ( 357, 340.9, -65 ), "pisces_wingsuit_prop" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 42876, -9954.5, 150 ), ( 0, 25.15, 0 ), undefined, undefined, "watertreatment_pisces_04_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 51216, -8755, 570.36 ), ( 0, 31.29, 0 ), undefined, undefined, "watertreatment_pisces_01_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 51301, -9314.5, 461.81 ), ( 0, 116.13, 0 ), undefined, undefined, "watertreatment_pisces_01_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 47239, -12261.4, 441.13 ), ( 0, 282.55, 0 ), undefined, undefined, "watertreatment_pisces_02_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 46689.5, -12233.1, 441.74 ), ( 0, 282.55, 0 ), undefined, undefined, "watertreatment_pisces_02_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.groupid = "Bodybag";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 43152, -9264, 150 ), ( 0, 16.93, 0 ), undefined, undefined, "watertreatment_pisces_04_vtol_reinforcements_drones" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 50218.3, -8058.88, 822.51 ), ( 0, 358.95, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 49545.9, -10572.7, 447.5 ), ( 0, 92.56, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 42566.5, -13115.8, 431 ), ( 0, 3.23, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_sm_tier_1" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 47140, -21932, 908 ), ( 360, 327.5, -1.3 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 51003, -7314, 502 ), ( 0, 176, 90 ), "cspf_0_auto8591771374923800514" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 51349, -9024, 501 ), ( 0, 30.9, 115 ), "cspf_0_auto7083711393781270722" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 49665, -9528, 650 ), ( 0, 21.7, 90 ), "cspf_0_auto8488714528375036572" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 43130, -9824, -9 ), ( 0, 99.29, 90 ), "cspf_0_auto14022390216386521751" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 44641, -10444, 316 ), ( 0, 89.09, 90 ), "cspf_0_auto3278982181516893803" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 42303, -9577, 12 ), ( 0, 50.29, 90 ), "cspf_0_auto10932911491473641852" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 43755, -15350, 686 ), ( 0, 197.29, 90 ), "cspf_0_auto9679370130181503842" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 41601, -12317, 310 ), ( 0, 13.69, 90 ), "cspf_0_auto5667525219182370570" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 44169, -13320, 737 ), ( 0, 191.69, 90 ), "cspf_0_auto5384445889954084606" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.name = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 50140, -11745, 448 ), ( 0, 96.59, 90 ), "cspf_0_auto1230620436237692782" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.name = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 48630, -13315, 513 ), ( 0, 294.09, 90 ), "cspf_0_auto2761098948083823992" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.is_cs_model = 1;
    s.groupid = "Bodybag";
    s.model = "sat_wm_accessory_prop_bio_canister_01";
    s.name = "sat_wm_accessory_prop_bio_canister_01";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 46960, -12032, 444 ), ( 0, 190.39, 90 ), "cspf_0_auto10452187256301235850" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_water_treatment_respawn";
    fe [[ f ]]( s, us, cf, ( 46419, -5644, 436.92 ), ( 0, 275.5, 0 ), "pisces_water_treatment_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_water_treatment_respawn";
    fe [[ f ]]( s, us, cf, ( 46307, -5651, 435.75 ), ( 0, 275.5, 0 ), "pisces_water_treatment_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_water_treatment_respawn";
    fe [[ f ]]( s, us, cf, ( 46522, -5642, 432.62 ), ( 0, 275.5, 0 ), "pisces_water_treatment_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_water_treatment_respawn";
    fe [[ f ]]( s, us, cf, ( 46634, -5635, 422.9 ), ( 0, 275.5, 0 ), "pisces_water_treatment_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_post_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 44586.1, -15212.1, 1094.1 ), ( 0, 323.6, 0 ), "pisces_post_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_post_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 44489.2, -15321.9, 1078.1 ), ( 0, 323.6, 0 ), "pisces_post_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_post_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 44689.8, -15131.5, 1090.1 ), ( 0, 323.6, 0 ), "pisces_post_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_post_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 44808.8, -15027.1, 1074.1 ), ( 0, 323.6, 0 ), "pisces_post_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 46719.5, -9253, 440.9 ), ( 1.14, 272, -0.65 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 43353.5, -15664.2, 628 ), ( 0, 182.7, 0 ), "s_pisces_caches", undefined, "ob_sat_item_select_equipment_loud" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_pre_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 40793.3, -12502.5, 307.91 ), ( 0, 353.6, 0 ), "pisces_pre_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_pre_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 40788.3, -12646.1, 307.28 ), ( 0, 353.6, 0 ), "pisces_pre_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_pre_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 40802.8, -12364.9, 308.28 ), ( 0, 353.6, 0 ), "pisces_pre_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "pisces_pre_supply_drop_respawn";
    fe [[ f ]]( s, us, cf, ( 40797.7, -12254.9, 308.65 ), ( 0, 353.6, 0 ), "pisces_pre_supply_drop_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 46898.6, -21711.7, 899.7 ), ( 360, 147.5, 1.3 ), "s_pisces_caches", undefined, "ob_sat_item_select_weapon_pisces_vtol_pickup" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 0, eflags: 0x4
// Checksum 0xc4b7c996, Offset: 0x25e1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs
// Params 0
// Checksum 0xb67064b8, Offset: 0x25eb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_pisces_water_treatment_cs" );
}

