//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//
// Project HiNAtyu
//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//

//=================================================================//
// [ English ]
// Creator       : HiNAtyu
// Created date  : 2025/04/02
// Latest update : 2025/04/02
// ---------------
// [ Japanese ]
// 制作者         : HiNAtyu
// 作成日         : 2025/04/02
// 更新日         : 2025/04/02
// ---------------
// [ Social ]
// YouTube  : http://www.youtube.com/channel/UCmxJAnVPtkStQVKrvAVMZSw?sub_confirmation=1
// Twitter1 : https://x.com/KonataGIF
// Twitter2 : https://twitter.com/H1NAtyu
// Discord  : hinatapoko （ https://discordapp.com/users/239453096026046464 ）
//=================================================================//

//:::::::::::::::::::::::::::::::::::::::::::::::::://
// [ English ]
//   < CoD GSC (C++) syntax explanation >
//     @ level                    = modifier for the entire room
//     @ level.players[i]         = 1 player participating in the room
//     @ self                     = myself where the function is being executed
//     @ thread                   = Execute the specified function in a subthread
//     @ Endon( "event_name" )    = Terminates function processing when the specified event name is issued.
//     @ WaitTill( "event_name" ) = Waits until the specified event name is issued, and then resumes subsequent processing
//     @ Notify( "event_name" )   = Publish the specified event name
//     @ Destroy( )               = Delete the specified variable and its actual state
//     @ IsDefined( variable )    = Check if the specified variable has been created
//     @ ^0                       = Color code (Black)
//     @ ^1                       = Color code (Red)
//     @ ^2                       = Color code (Green)
//     @ ^3                       = Color code (Yellow)
//     @ ^4                       = Color code (Blue)
//     @ ^5                       = Color code (Cyan)
//     @ ^6                       = Color code (Pink)
//     @ ^7                       = Color code (White)
//     @ wait                     = Wait for the specified time
// ---------------------------------------------
// [ Japanese ]
//   < CoD GSC (C++) 構文解説 >
//     @ level                    = 部屋全体に対する修飾子
//     @ level.players[i]         = 部屋に参加しているプレイヤー1個人
//     @ self                     = 関数が実行されている自分自身
//     @ thread                   = 指定した関数をサブスレッドで実行する
//     @ Endon( "event_name" )    = 指定したイベント名が発行されたら、関数の処理を終了する
//     @ WaitTill( "event_name" ) = 指定したイベント名が発行されるまで待機し、イベントが発行されたら、以降の処理を再開する
//     @ Notify( "event_name" )   = 指定したイベント名を発行する
//     @ Destroy( )               = 指定した変数とその実態を削除する
//     @ IsDefined( variable )    = 指定した変数が作成されているか調べる
//     @ ^0                       = カラーコード (黒)
//     @ ^1                       = カラーコード (赤)
//     @ ^2                       = カラーコード (緑)
//     @ ^3                       = カラーコード (黄色)
//     @ ^4                       = カラーコード (青)
//     @ ^5                       = カラーコード (水色)
//     @ ^6                       = カラーコード (ピンク)
//     @ ^7                       = カラーコード (白)
//     @ wait                     = 指定した時間分待機する
//:::::::::::::::::::::::::::::::::::::::::::::::::://





// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : main process
// ja : メイン処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : build model list
// ja : モデルリストを構築する
//++++++++++++++++++++++++++++++
modellistconstruction( onlymap )
{
    if ( !isdefined( onlymap ) )
    {
        l_name                                                  = "modellistpackages";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vm_equip_gen_care_package_00";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_carepackage_01_enemy";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_carepackage_01_juggernaut";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_carepackage_01_friendly";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "com_plasticcase_beige_big_iw6";

        l_name                                                  = "modellistsubpackages";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_field_upgrade_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_large_stackable_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_large_stackable_01_jugg";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_large_stackable_01_dummy";
        
        
        l_name                                                  = "modellistallpackages";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistpackages"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsubpackages"] );

        l_name                                                  = "modellistsmallvehicles";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_ind_air_bombing_drone";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_whotel";
        
        l_name                                                  = "modellistmediumvehicles";
        level.lvlstat[l_name]                                   = [];

        l_name                                                  = "modellistbigvehicles";
        level.lvlstat[l_name]                                   = [];
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_juniform52_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_papa61_vista";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_pindigoj5a_00";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_lbravo_personnel_mp_flyable";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_atango_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_west_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_mkilo23_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_skilo_rus_police_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_umike_infil_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_zuniform_physics";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_west";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_asierra_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_techo_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_tromeo_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_hindia_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mw_dist_soldier";
        
        
        l_name                                                  = "modellistvehicles";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsmallvehicles"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistmediumvehicles"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistbigvehicles"] );


        l_name                                                  = "modellistsubvehicles";
        level.lvlstat[l_name]                                   = [];
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_skilo_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_ilima4";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_boscar17_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_boscar17_vista_des";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_wm_dalpha_articulated_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "bomber_hecho177_00_vista";
        
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_alfa10";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_alfa10_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mquebec8_small";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mquebec8_small_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_lbravo";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_lbravo_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_lbravo_east_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_palfa_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mquebec9_small";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mquebec9_small_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_auniform";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_auniform_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_small";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_palfa";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_ks_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_ks_east_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_suniform25";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_suniform25_west";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_halfa_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_halfa_east_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_stango_static";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_plunder_x";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_mkilo23_skud_static2";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x1_u2_plane";


        l_name                                                  = "modellistallvehicles";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistvehicles"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsubvehicles"] );

        l_name                                                  = "modellistflags";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_flag_neutral";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ctf_game_flag_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ctf_game_flag_west";


        l_name                                                  = "modellistdogtags";
        level.lvlstat[l_name]                                   = [];
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_usa_kc_dogtags_01_red";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_usa_kc_dogtags_01_vday_pink";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_usa_kc_dogtags_01_vday_blue";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_blue";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_green";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_purple";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_orange";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_gold";
        
        l_name                                                  = "modellistsmallprops";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "axis_guide_createfx";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "axis_guide_createfx_rot";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_c4";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_emp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_crate_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "head_male_bc_03";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "viewhands_base_iw8";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dz_flare_scriptable";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_deployable_cover";

        l_name                                                  = "modellistprops";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsmallprops"] );
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wmd_vm_missile_cruise_warhead";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wmd_vm_missile_cruise";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "aae_ger_scharlie_50_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "usa_boscar17_ballturret_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "plane_boscar17_00_tur_main";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_skulls_resource_model_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_mg_bravo50_balcony";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_carepackage_parachute";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "body_opforce_london_terrorist_1_2";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_mp_vbear_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mw_test_soldier";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mw_dist_soldier";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mw_scale_soldier";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_greenbay_device_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_kenosha_scale_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_cuniform";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_cuniform_east";
        
        l_name                                                  = "modellistsmallprops";
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsmallvehicles"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistdogtags"] );

        l_name                                                  = "modellistsubprops";
        level.lvlstat[l_name]                                   = [];
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_mp_elf_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp_mesh";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_nuke_mp";
        
        l_name                                                  = "modellistallprops";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistprops"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistsubprops"] );
        
        
        l_name                                                  = "modellistanimal";
        level.lvlstat[l_name]                                   = [];
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_doberman_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_doberman_03";
        
        l_name                                                  = "modellistdebug";
        level.lvlstat[l_name]                                   = [];

        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_neutral";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_west";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_east";

        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_flarestick";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks_carrier";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_malfa_big";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "uk_electrical_box_medium_02_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_cruise_predator_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_halfa_turret";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_whotel_turret";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "art_stadium_ball";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_carepackage_02_rupture";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_grenade_smoke";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "pilot_viewmodel_arms";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "box_wooden_grenade_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_domination_point_01";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_backpack";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_far";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_white_phosphorus_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_radar_drone_escort_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_radar_drone_recon_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "usa_glidebomb_hatchdoors";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ger_glidebomb_hatchdoors";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_death_switch_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_doberman_04";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_doberman_05";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_whotel_crate";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_pac_sentry_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c130_zoomrig";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_suitcase_bomb";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_hero_price_urban";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "automotive_fix_a_can_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_decho_rebel_mg_no_hatch";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "test_character_dog_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_mp_krampus_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "box_wooden_grenade_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_umike_static_allied";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x1_u2_plane";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_stango_static";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_plunder_x";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_mkilo23_skud_static2";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_west_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_mkilo23_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_skilo_rus_police_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_zuniform_physics";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_decho_vm_dirty_blue_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_umike_infil_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_east";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_west";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_asierra_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_techo_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_tromeo_physics_mp";
        level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_hindia_physics_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_palfa_ambulance_ukraine";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "medical_defibrillator_wall_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_01_br_scavenger_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_usa_kc_dogtags_01_holiday";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_usa_kc_dogtags_01_holiday_blue";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_holiday_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_valentines_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "grind_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "care_package_iw7_dummy";
        
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "com_teddy_bear";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "british_pilot_fullbody";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_mp_optic_wave_scr";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "body_spetsnaz_ar";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_zm_machine_weapon_dim";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_zm_fxanim_pap_mod";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "s4_zm_machine_weapon";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "container_ammo_box_01_nophysics";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_supportbox_killstreak";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "shardball_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_fullbody_heavy";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_body_infected_a";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "burntbody_male";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wpn_s4_zm_monkey_bomb_main_world";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "aq_pilot_fullbody_1";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "uk_electrical_box_medium_02_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "crate_plastic_box_red";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "barrier_traffic_concrete_block_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fence_corrugated_metal_03_256_cp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "allied_pilot_fullbody_3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "suv_gamma503_xmas_00";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_fuelstrike_mp";



		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mortar_target";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "equipment_mortar_shell_improvised_01_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "viewhands_base_iw8";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "viewhands_base_iw8";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_c4";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "shardball_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_c4";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_flag_neutral";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_minefield_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mw_dist_soldier";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "super_scramble_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_fullbody_heavy";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_body_infected_a";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_carepackage_parachute";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_grenade_smoke";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_carepackage_parachute_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks_carrier";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_target_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_target_br_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_br_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_fuelstrike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_fuelstrike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_marker_br_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_apache_turret_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_apache_turret_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_apache_turret_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "pilot_viewmodel_arms";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wmd_vm_missile_cruise";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_target_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp_mesh";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_radar_drone_escort_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_radar_drone_recon_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_vm_mg_sentry_turret_invis_base";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_vm_mg_sentry_turret_invis_base";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_vm_mg_sentry_turret_invis_base_vehicle";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_white_phosphorus_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_white_phosphorus_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_turret_west_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_vindia_a1_turret_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_east_turret";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_west_turret";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_east_turret_gun";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_west_turret_gun";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_bromeo_parachute";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks_carrier";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_coscar_west_turret_gun";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "player_death_fx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "viewhands_base_iw8";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "equip_snapshot_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_flarestick";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_deployable_cover";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "trophy_system_mp_explode";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_field_upgrade_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_death_switch_mp";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_grenade_smoke";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_crate_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_whotel_crate";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_whotel";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_pac_sentry_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_toma_strike_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_life_pack";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_col_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_fr_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_en_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_dam_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_dam_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_dam_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_shinguard_wm";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_suitcase_bomb";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_wm_sn_crossbow_bolt_fire_static_dst";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_wm_sn_xmike109_projectile";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_wm_ascender_ch3";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_ach_gp_bomb_600lb_01_gameplay";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh_s4_mil_ratrace_suv_turret_wz";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "trophy_system_mp_explode";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_far_mp_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_buy_station_crate_wood_01_ww2";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_briefcase_gas_closed";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_briefcase_gas_nodraw";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_greenbay_impact";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_rock_boulder_02_kenosha_s3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_offhand_vm_stim_zmb_loot";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_target_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_ac130_target_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "temp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_depballoon_backpack";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_neutral";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ctf_game_flag_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_christmas_tree_large_set_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_zombie_a_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "loot_helmet";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_mercenary_buy_station_rig_skeleton";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_rigid";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_military_old_recon_station";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "comms_tower_indicator";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh_s4_mil_air_dalpha_wz_turret_attach";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_domination_point_01_mover_nocol";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_domination_point_01_mover";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_military_old_recon_station";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "soa_tower_bomb";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_marker_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_br_bodycount";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_backpack";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_delivery_rope";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_delivery_bag";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_rus_redshirt_02";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wz_usa_bomber_b17_phase05";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "wz_usa_bomber_b17_destroyed_rig";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "usa_bomber_b17_hero_wing_combined_02";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_br_lep";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_military_old_recon_station";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lep_sfx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lep_sfx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_intel_br_mendota";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_mkilo23_turret_payload_nomesh";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_supportbox_armor_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_br_payload_checkpoint";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "uk_tool_box_small_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "payload_bld_barrier_constructed_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "uk_tool_box_small_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_briefcase_bomb";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_hq_crate_02_payload";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_wm_mg_mobile_turret";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_br_payload_checkpoint";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_raven_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_skyhook_backpack";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_delivery_rope";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_delivery_bag";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "risk_dom_plate";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_turret_wm_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_turret_wm_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "rebirth_fx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_bromeo_parachute";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_ks_carrier";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_br_x2";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_vfx_ambushes_spawn";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_military_old_recon_station";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ca_ger_bomber_117_group_ultralow";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_target_mp_x2";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airstrike_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_01_br_geigerstash_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_gulag_cuffs";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "p9_ver_soldier_gear";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ctl_parachute_player";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x5";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x5";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_interior_infil_netting";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_interior_infil_cabin_door";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x5";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_mp_eastern_bale_3_1";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x10";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_infil_flight";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_acharlie130_magma_animated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_infil_int_bags_back_left_up";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_infil_int_bags_back_right_up";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_infil_int_bags_back_right_low";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_infil_ropes";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x5";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_br_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x5";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "generic_prop_x10";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_open_back_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_interior_vm_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_infil_flight";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_vm_infil";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_infil_flight_articulated";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_skilo_interior_infil_cabin_door";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_lep_quest";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_turret_wm_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_ahotel64_turret_wm_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_veh8_mil_lnd_br_train_assault_decal_0"+"x2_vfx_turret_loco_pop";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_vfx_turret_pop";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_reveal_assault_car_turrets_destroyed_decal";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "communication_antenna_mobile_rig";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_air_mindia8_plunder_x";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_rapelling_rope_01_fiber_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_delivery_bag";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_fafir_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_fafir_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "scr_smoke_grenade";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_rapelling_rope_01_fiber_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_mercenary_extraction_delivery_bag";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "rebirth_fx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "equip_flare_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_plunder_extraction_vault";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_civ_lnd_palfa_ambulance_ukraine";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "medical_defibrillator_wall_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_usmc_ar_scriptmover";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "p9_ang_satellite_recovery_unit_full";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "p9_ang_satellite_recovery_unit_full_02";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "p9_wz_sat_link_objective_satellite_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_scavenger_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_01_br_scavenger_01_adler";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_loot_crate_01_br_scavenger_01_soa_tower";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_military_skyhook_extraction_01_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_military_skyhook_extraction_01_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_skyhook_extraction_base_01_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "misc_vm_ascender_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lm_military_skyhook_extraction_01_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "br_skyhook_extraction_base_01_ch3";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "t9_vnm_door_bunker_metal_01_rig";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lep_sfx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lep_sfx";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "us_military_tnt_bundle_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x2_smoke_marker";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "x1_military_loot_crate_br_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_crate_large_stackable_01_jugg";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "weapon_mg_bravo50_balcony";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_grenade_smoke";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_stadium_scoreboard_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_stadium_scoreboard_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_emp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "prop_suitcase_bomb";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ks_airdrop_crate_br";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_human_skull_02";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dz_flare_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_contest";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_friend";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_enemy";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "fullbody_zombie_a";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_contest";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_friend";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "mp_parkour_hardpoint_floor_01_enemy";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "lethal_smoke_grenade_wm";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dogtags_iw7_foe";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dogtags_iw7_foe";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ctf_game_flag_base";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_emp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "offhand_wm_emp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_human_skull_02";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_human_skull_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_orange";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_blue";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_west";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_east";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dom_flag_neutral";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "ee_decor_gravestone_01_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "grind_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_bromeo_allies_mp_to";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "veh8_mil_lnd_bromeo_turret_allies_mp";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_orange";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "military_dogtags_iw8_blue";

		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vfx_ri_dom";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "care_package_iw7_dummy";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "dom_flag_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "cop_marker_scriptable";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "vm_arms_zombie_a";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "c_s4_vm_fra_novak_01";
		level.lvlstat[l_name][level.lvlstat[l_name].size]       = "enemy_lw_base_zombie";

        
        l_name                                                  = "modellistall";
        level.lvlstat[l_name]                                   = [];
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistpackages"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistflags"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistdogtags"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistprops"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistvehicles"] );
        level.lvlstat[l_name]                                   = scripts\engine\utility::array_combine( level.lvlstat[l_name] , level.lvlstat["modellistmaps"] );
    }
    else
    {
        l_defentities = getentarray( "script_model" , "classname" );
        l_brushentities = getentarray( "script_brushmodel" , "classname" );
        level.lvlstat["modellistmaps"] = [];

        if ( isdefined( l_defentities ) && ( 0 < l_defentities.size ) )
        {
            for ( i = 0; i < l_defentities.size; i++ )
            {
                if ( scripts\engine\utility::array_contains( level.lvlstat["modellistmaps"] , l_defentities[i].model ) ) { continue; }
                level.lvlstat["modellistmaps"] = scripts\engine\utility::array_add( level.lvlstat["modellistmaps"] , l_defentities[i].model );
            }
        }
        if ( isdefined( l_brushentities ) && ( 0 < l_brushentities.size ) )
        {
            for ( i = 0; i < l_brushentities.size; i++ )
            {
                if ( scripts\engine\utility::array_contains( level.lvlstat["modellistmaps"] , l_brushentities[i].model ) ) { continue; }
                level.lvlstat["modellistmaps"] = scripts\engine\utility::array_add( level.lvlstat["modellistmaps"] , l_brushentities[i].model );
            }
        }
    }



    /*
    "ks_crate_marker_mp"   ,
    "ks_airstrike_target_mp"   ,
    "ks_airstrike_mp"   ,
    "ks_fuelstrike_mp"   ,
    "ks_cruise_predator_mp"   ,
    "ks_ac130_target_mp"   ,
    "ks_radar_drone_escort_mp"   ,
    "ks_radar_drone_recon_mp"   ,
    "ks_toma_strike_mp"   ,
    "ks_toma_strike_marker_mp"   ,
    "ks_toma_strike_missile_mp"   ,
    "ks_toma_strike_cluster_mp"   ,
    "ks_white_phosphorus_mp"   ,
    "mortar_target"   ,
    "equipment_mortar_shell_improvised_01_mp"   ,
    "shardball_wm"   ,
    "military_skyhook_far_mp"   ,
    "equip_snapshot_marker_mp"   ,
    "trophy_system_mp_explode"   ,
    "dom_flag_scriptable"   ,
    "fullbody_usmc_ar"   ,
    "loot_helmet"   ,
    "veh8_civ_lnd_palfa_ambulance_ukraine"   ,
    "medical_defibrillator_wall_01"   ,
    "fullbody_usmc_ar_scriptmover"   ,
    "electrical_elevator_access_keypad_01"   ,
    "prop_suitcase_bomb"   ,
    "mp_parkour_hardpoint_floor_01"   ,
    "lethal_smoke_grenade_wm"   ,
    "grind_flag_scriptable"   ,
    "veh8_mil_lnd_bromeo_allies_mp_to"   ,
    "care_package_iw7_dummy"   ,
    "ks_death_switch_mp"   ,
    "veh8_mil_lnd_whotel_crate"   ,
    "ks_pac_sentry_mp"   ,
    "ks_minefield_mp"   ,
    "weapon_life_pack"   ,
    "mp_fullbody_heavy"   ,
    "mp_body_infected_a"   ,
    "super_trophy_mp"   ,
    "shock_sentry_gun_wm"   ,
    "vehicle_uav_static_mp"   ,
    "prop_ballistic_vest_iw6"   ,
    "vehicle_aas_72x_killstreak"   ,
    "mp_remote_turret"   ,
    "p7_bottle_plastic_16oz_water"   ,
    "cp_disco_folding_chair_lod0"   ,
    "dogtags_iw7_foe"   ,
    "mw_scale_soldier"
    */
}



//++++++++++++++++++++++++++++++
// en : build sound list
// ja : 音声リストを構築する
//++++++++++++++++++++++++++++++
soundlistconstruction( )
{
    l_sfx                   = "sfxlist";
    l_lsfx                  = "loopsfxlist";
    level.lvlstat[l_sfx]    = [];
    level.lvlstat[l_lsfx]   = [];
    
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "iw8_cruise_missile_plr";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "elev_musak_loop";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "elev_run_loop";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "hind_helicopter_dying_loop";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_care_package_owner_cap";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_care_package_non_owner_cap";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_care_package_drop_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "iw8_bradley_drop_c130";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "veh_apache_killstreak_amb_lr";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "iw8_rc_plane_engine";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "iw8_ks_ac130_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "veh_scrambler_drone_idle_high";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "recon_drone_overlay";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "emp_nade_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "weap_mortar_fly_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_door_alarm_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "smoke_carepackage_smoke_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_flare_burn_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "tmp_emt_mp_faridah_propaganda_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "mp_iw8_hq_crate_active_idle";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "weap_hind_20mm_fire_npc";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "iw8_nuke_flight_loop";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "veh_wheelson_engine_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "recondrone_idle_high";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "br_reviver_use_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "dx_mpo_usop_drone_deathchatter";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "smoke_grenade_smoke_lp";
    level.lvlstat[l_lsfx][level.lvlstat[l_lsfx].size] = "weap_molotov_fire_enemy_burn";

    // 機械音系Oneshot
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_new_objective_sfx";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_bodycount_tick_positive";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_countdown";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_perk_tactical_recon_marked";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "match_start_tick_in3";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "match_start_tick_in5";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recon_drone_spotted_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_defcon_one";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_mp_timer_countdown";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_weaponswitch";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_bombplaced_friendly";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_grind_token_banked";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recon_drone_marked_owner";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_mp_cranked_timer";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_cluster_target_beep";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breach_warning_beep_01";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_bombplaced_enemy";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recondrone_tag";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breach_warning_beep_02";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killconfirm_tags_deny";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breach_warning_beep_03";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killconfirm_tags_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breach_warning_beep_04";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breach_warning_beep_05";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recondrone_lockon";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_grind_token_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_grind_token_drop";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killconfirm_tags_drop";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sentry_gun_target_lock_beep";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_mp_suitcasebomb_timer";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_restock_tactical";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_bodycount_tick_negative";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_cranked_splash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_cranked_start_splash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_kill_alert_quiet";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_war_objective_lost";

    // 機械音系連続
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "javelin_clu_lock";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ks_ac130_damage_warning";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "lbravo_noflares_warning";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "maaws_reticle_locked";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "maaws_reticle_tracking";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_door_alarm_off";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_door_alarm_on";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recon_drone_marking_owner";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sentry_gun_beep";

    // 尖った系Oneshot
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "bullet_impact_headshot_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "door_locked";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "fulton_bag_drop";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "hit_marker_3d_armor_break";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_equip_destroyed";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_grind_token_banked_large";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_hit_alert_final_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_kill_alert";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_war_objective_taken";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "vehicle_body_hit";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_headshot_alert";

    // ぺちゃつぶれ系Oneshot
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "bullet_impact_headshot";

    // Uplifter
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "exp_cyber_emp_preexplode";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_cruise_missile_plr_intro";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_intro";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "jammer_drone_charge";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_camera_intro_whoosh";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_cmd_camera_zoom_in";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killstreak_apache_death_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killstreak_apache_transition_lr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killstreak_transition_whoosh";

    // Downlifter
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_whine";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_white_phos_su25_exit";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_cmd_camera_zoom_out";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "smoke_carepackage_expl_trans";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "smoke_grenade_expl_atmo";

    // Impact FX
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "final_killcam_in";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "deaths_door_in";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "flag_spawned";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_dist_launch";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_impact_low";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_hq_deactivate_sfx";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recondrone_damaged";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recondrone_destroyed";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_hellfire_impact";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_molotov_fire_enemy_burn_end";

    // 静か系
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "deadsilence_end";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "deadsilence_start";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "deaths_door_out";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "breathing_better";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "exp_cyber_emp_close";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "final_killcam_out";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_perk_shrapnel";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_tactical_insert_flare_pu";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_tactical_insert_smash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_bomb_plant";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_jugg_mus_toggle_button";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_killstreak_disappear";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "oracle_radar_pulse_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "plr_breath_land_parachute";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "recondrone_marker";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scavenger_pack_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sentry_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "smoke_canister_tail_dissipate";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "tactical_spawn";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_restock_lethals";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_ammo_full";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_bradley_reload_plr";

    // 金属音系
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_deployable_cover_plant_fail";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ammo_crate_use";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_support_box_deploy";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_support_box_use";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_fusebox_lever_off_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_fusebox_lever_on_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_heavy_metal_single_bash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_heavy_metal_single_close";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_heavy_metal_single_open";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_heavy_metal_single_start_peek";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_barn_bash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_barn_close";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_barn_open";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_barn_start_peek";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_double_bash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_double_close";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_double_open";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scrpt_door_wood_double_start_peek";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sentry_explode_smoke";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sentry_gun_plant";

    // サイレン
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_snatch_fight_start";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_alarm";

    // 爆発
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "c4_expl_trans";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "car_explode";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "deaths_door_death";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "exp_bombsite_lr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "exp_helicopter_fuel";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "frag_grenade_expl_trans";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_bradley_drop_bradley";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_explo_main";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_white_phos_midair_explo";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_rc_plane_engine_exp";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ks_a10_fire_dist_crack";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ks_ac130_flares";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ks_apache_flares";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "small_car_explode";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "veh_bradley_expl_destr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "veh_chopper_support_crash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "veh_lbravo_explode";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "vest_expl_trans";

    // 人間声
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "gas_player_cough";

    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "bullet_impact_headshot_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "jammer_drone_shockwave";



    /*
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_knife_fire_burn_end";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "attachment_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_ac130_flyby";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_bunker_door_open_01";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_bunker_door_open_02";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_circle_closing";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_computer_deny";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_exfil_end_part_lr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_exfil_incoming_heli_lr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_finish_them_splash";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_fulton_extract_exp";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_gas_mask_crack_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_gas_mask_depleted_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_gas_mask_off_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_gas_mask_on_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_gulag_rock_player_impact";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_infil_part1_lr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_keypad_deny";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_legendary_loot_drop";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_legendary_loot_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_map_selection_error";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_map_selection_placed";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_phone_deny";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_phone_ring";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_pickup_deny";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_player_revived";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_plunder_atm_cancel";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_plunder_atm_deposit_gtr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_plunder_atm_use";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_reviver_use_end";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "br_rock_pickup";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "cp_bank_gate_fall";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "cp_bank_vault_open";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "crate_impact";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "death_switch_beep";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "dropship_explode_mp";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ds_shield_impact";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "dx_mpb_chem_phase2_chemreact";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "dx_mpb_us3_hvt_thank";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "dx_mpb_us3_hvt_up";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_bell_ding";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_door_close";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_door_interupt";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_door_open";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_run_end";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "elev_run_start";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "emp_nade_lp_end";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "exp_stinger_armor_destroy";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "Fem_breathing_better";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ghost_senses_ping";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ghost_wall_attach";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ghost_wall_detach";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "gulag_crowd_boo_loser";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "gulag_crowd_cheer_winner";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_eod_tablet_ui";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_explo_low_02";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_ks_ac130_shake_explo";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_kill_bc_radio";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_mp_kill_bc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_blast_tail";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_blast";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "iw8_nuke_incoming_blast_wave";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "javelin_clu_aquiring_lock";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "laststand_heal_done";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "laststand_heal_start";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "maaws_incoming_lp";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_overcharge_off";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_overcharge_on";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_uplink_ball_out_of_bounds";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_uplink_ball_pass";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mp_uplink_ball_reset";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mugger_got_mugged";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mugger_mugging";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "mugger_you_mugged";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "plr_breath_pain_ong_exh";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "prop_flashbang";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "prop_whistle";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scr_br_infil_ac130_klaxon";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "scr_br_infil_jump_stinger";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "shock_sentry_charge_up";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "sonic_shotgun_debuff";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "talon_reload_plr";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "talon_reload";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "tmp_br_infil_ac130_jumpmaster_go";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "truck_sattruck_engineoff";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "truck_sattruck_initdeploy_os";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "truck_sattruck_initialstartup_os";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "truck_sattruck_scanning_off";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "ui_mp_fire_sale_timer";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_bradley_reload_npc";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_cluster_fire";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_mortar_expl_trans";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_mortar_flare_launch";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_mortar_incoming";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "weap_mortar_load";
    level.lvlstat[l_sfx][level.lvlstat[l_sfx].size] = "WEAP_SHOTGUNATTACH_FIRE_NPC";
    */
}



//++++++++++++++++++++++++++++++
// en : build effect list
// ja : エフェクトリストを構築する
//++++++++++++++++++++++++++++++
effectlistconstruction( )
{
    l_fx = "effectlist";
    l_num = 0;
    level.lvlstat[l_fx] = [];
    
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "money";                                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "juggernaut_crate_vfx";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "equipment_smoke";                                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "equipment_sparks";                                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "claymore_explode";                                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cop_car_explode";                                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "van_explode";                                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "hoopty_explode";                                        level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "med_transport_explode";                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "large_transport_explode";                               level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "little_bird_explode";                                   level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "little_bird_mg_explode";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "white_phosphorus_inair_explosion";                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx";   level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx";              level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "rcxdExplosion";                                         level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "glsmoke";                                               level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "airdrop_crate_impact";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "airdrop_crate_capture";                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "sentry_explode_mp";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "weapon_drop_impact";                                    level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "remote_tank_crate_explode";                             level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "xmike109ThermiteBounce";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadspawn"; level.lvlstat[l_fx][l_num].assetname = "emp_detonation";                                        level.lvlstat[l_fx][l_num].assetdata = level._effect["emp_detonation"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "gos_fireworks";                                         level.lvlstat[l_fx][l_num].assetdata = level._effect["gos_fireworks"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "missile_explode";                                       level.lvlstat[l_fx][l_num].assetdata = level._effect["missile_explode"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "cranked_explode";                                       level.lvlstat[l_fx][l_num].assetdata = level._effect["cranked_explode"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "special";   level.lvlstat[l_fx][l_num].assetname = "nuke";                                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;

    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "atv_explode";                                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "hoopty_truck_explode";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cargo_truck_explode";                                   level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "jeep_explode";                                          level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "pickup_truck_explode";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "tac_rover_explode";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "technical_explode";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cargo_truck_mg_explode";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cargo_truck_susp_explode";                              level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "convoy_truck_explode";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "indigo_explode";                                        level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "motorcycle_explode";                                    level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "open_jeep_explode";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "open_jeep_carpoc_explode";                              level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "open_jeep_carpoc_ramming_sparks";                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vanish";                                                level.lvlstat[l_fx][l_num].assetdata = level._effect["vanish"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_00";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_00"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_01";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_01"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_02";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_02"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_03";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_03"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_04";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_04"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_05";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_05"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_06";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_06"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_07";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_07"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_08";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_08"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_09";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_09"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "score_10";                                              level.lvlstat[l_fx][l_num].assetdata = level._effect["score_10"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vanish_hw_fr";                                          level.lvlstat[l_fx][l_num].assetdata = level._effect["vanish_hw_fr"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vanish_hw_en";                                          level.lvlstat[l_fx][l_num].assetdata = level._effect["vanish_hw_en"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "ghostcat_hw";                                           level.lvlstat[l_fx][l_num].assetdata = level._effect["ghostcat_hw"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "bats_hw";                                               level.lvlstat[l_fx][l_num].assetdata = level._effect["bats_hw"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "bats_fly_hw";                                           level.lvlstat[l_fx][l_num].assetdata = level._effect["bats_fly_hw"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "blood_ceil_hw";                                         level.lvlstat[l_fx][l_num].assetdata = level._effect["blood_ceil_hw"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "blood_floor_hw";                                        level.lvlstat[l_fx][l_num].assetdata = level._effect["blood_floor_hw"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vanish_gos";                                            level.lvlstat[l_fx][l_num].assetdata = level._effect["vanish_gos"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "aalpha12_explo";                                        level.lvlstat[l_fx][l_num].assetdata = level._effect["aalpha12_explo"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_crawling_out_of_vent";                           level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_crawling_out_of_vent"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_base_death";                                     level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_base_death"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_emp_death";                                      level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_emp_death"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_weakpoint_death";                                level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_weakpoint_death"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_emp_pulse";                                      level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_emp_pulse"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_gas_death";                                      level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_gas_death"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zmb_ai_explosion_death";                                level.lvlstat[l_fx][l_num].assetdata = level._effect["zmb_ai_explosion_death"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vfx_numbers_zombie_explosion";                          level.lvlstat[l_fx][l_num].assetdata = level._effect["vfx_numbers_zombie_explosion"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "ghost_soul_pickup";                                     level.lvlstat[l_fx][l_num].assetdata = level._effect["ghost_soul_pickup"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "zombie_splat";                                          level.lvlstat[l_fx][l_num].assetdata = level._effect["zombie_splat"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "explode";                                               level.lvlstat[l_fx][l_num].assetdata = level._effect["explode"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "loadplay";  level.lvlstat[l_fx][l_num].assetname = "vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx";  level.lvlstat[l_fx][l_num].assetdata = level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"];
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "equipment_explode";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "penetration_railgun_impact";                            level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_penetration_railgun_impact";                        level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_flare_launch";                                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_mortar_explosion";                                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_mo_money_cash_exp";                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "mons_screen_ash";                                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "airdrop_crate_destroy";                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "light_tank_land";                                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "light_tank_cannon_dust";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "wristrocket_explode";                                   level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "sentry_shock_explosion";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "emp_shockwave";                                         level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "groundPoundShield_impact";                              level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "battleSlideShield_damage";                              level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_br3_rope_fire";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_nuke_zone_5000_static_s";                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_fulton_explode";                                    level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_br3_pbs_dmg";                                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_city_killer_gas_explosion";                         level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_explosive_bow_explosion";                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_2x_points_victim_explosion";                        level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_killmonger_victim_explosion";                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_golden_loot_explosion_flare";                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "zmb_ai_crawling_out_of_ground";                         level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cursed_chest_super_zombie_flare";                       level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cursed_chest_zombie_death";                             level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "cursed_chest_zombie_soul_absorb_stop";                  level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_br_loot_cache_holiday_coal";                        level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "chopperExfil_gas";                                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_c4_red_light";                                      level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "zombie_trans";                                          level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "ghost_trans";                                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_lava_bomb_gas_explosion";                           level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "satellite_cache_impact";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "vfx_br3_teleport_smoke";                                level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "ball_teleport";                                         level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "rugby_score_explosion";                                 level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "signal_chest_drop";                                     level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "propFlash";                                             level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
    level.lvlstat[l_fx][level.lvlstat[l_fx].size] = spawnstruct( ); l_num = level.lvlstat[l_fx].size - 1; level.lvlstat[l_fx][l_num].typename = "getplay";   level.lvlstat[l_fx][l_num].assetname = "olarideVillainsExfil_bomb";                             level.lvlstat[l_fx][l_num].assetdata = level.lvlstat[l_fx][l_num].assetname;
}



//++++++++++++++++++++++++++++++
// en : create a weapon list
// ja : 武器リストを作成する
//++++++++++++++++++++++++++++++
constructionweaponslist( )
{
    level.lvlstat["wplist_ar"]          = [];
    level.lvlstat["wplist_smg"]         = [];
    level.lvlstat["wplist_lmg"]         = [];
    level.lvlstat["wplist_mr"]          = [];
    level.lvlstat["wplist_sr"]          = [];
    level.lvlstat["wplist_ps"]          = [];
    level.lvlstat["wplist_sg"]          = [];
    level.lvlstat["wplist_exp"]         = [];

    level.lvlstat["wplist_stdgr"]       = [];
    level.lvlstat["wplist_allgr"]       = [];
    level.lvlstat["wplist_ks"]          = [];
    level.lvlstat["wplist_allwp"]       = [];
    level.lvlstat["wplist_allms"]       = [];
    level.lvlstat["wplist_allbt"]       = [];
    level.lvlstat["wplist_t9wp"]        = [];
    level.lvlstat["wplist_s4wp"]        = [];

    // level.lvlstat["wplist_gr"]          = [];
    // level.lvlstat["wplist_cqb"]         = [];
    // level.lvlstat["wplist_tac"]         = [];
    // level.lvlstat["wplist_lnc"]         = [];
    // level.lvlstat["wplist_kf"]          = [];
    // level.lvlstat["wplist_sp"]          = [];
    // level.lvlstat["wplist_normalwp"]    = [];
    // level.lvlstat["wplist_stdmsl"]      = [];
    // level.lvlstat["wplist_spmsl"]       = [];


//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_akilo47_mp"  ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_asierra12_mp";
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_falpha_mp"   ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_galima_mp"   ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_kilo433_mp"  ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_mcharlie_mp" ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_mike4_mp"    ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_falima_mp"   ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_scharlie_mp" ;
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_sierra552_mp";
//    level.lvlstat["wplist_ar"][level.lvlstat["wplist_ar"].size]         = "iw8_ar_tango21_mp"  ;
//
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_augolf_mp"  ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_beta_mp"    ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_charlie9_mp";
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_mpapa5_mp"  ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_papa90_mp"  ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_smgolf45_mp";
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_uzulu_mp"   ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_mpapa7_mp"  ;
//    level.lvlstat["wplist_smg"][level.lvlstat["wplist_smg"].size]       = "iw8_sm_victor_mp"  ;
//
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_dblmg_mp"  ;
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_kilo121_mp";
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_lima86_mp" ;
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_mgolf34_mp";
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_mkilo3_mp" ;
//    level.lvlstat["wplist_lmg"][level.lvlstat["wplist_lmg"].size]       = "iw8_lm_pkilo_mp"  ;
//
//    level.lvlstat["wplist_mr"][level.lvlstat["wplist_mr"].size]         = "iw8_sn_crossbow_mp";
//    level.lvlstat["wplist_mr"][level.lvlstat["wplist_mr"].size]         = "iw8_sn_golf28_mp"  ;
//    level.lvlstat["wplist_mr"][level.lvlstat["wplist_mr"].size]         = "iw8_sn_kilo98_mp"  ;
//    level.lvlstat["wplist_mr"][level.lvlstat["wplist_mr"].size]         = "iw8_sn_sbeta_mp"   ;
//    level.lvlstat["wplist_mr"][level.lvlstat["wplist_mr"].size]         = "iw8_sn_sksierra_mp";
//
//    level.lvlstat["wplist_sr"][level.lvlstat["wplist_sr"].size]         = "iw8_sn_alpha50_mp" ;
//    level.lvlstat["wplist_sr"][level.lvlstat["wplist_sr"].size]         = "iw8_sn_delta_mp"   ;
//    level.lvlstat["wplist_sr"][level.lvlstat["wplist_sr"].size]         = "iw8_sn_hdromeo_mp" ;
//    level.lvlstat["wplist_sr"][level.lvlstat["wplist_sr"].size]         = "iw8_sn_mike14_mp"  ;
//    level.lvlstat["wplist_sr"][level.lvlstat["wplist_sr"].size]         = "iw8_sn_xmike109_mp";
//
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_cpapa_mp"     ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_decho_mp"     ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_golf21_mp"    ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_mike1911_mp"  ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_mike9_mp"     ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_pi_papa320_mp"   ;
//    level.lvlstat["wplist_ps"][level.lvlstat["wplist_ps"].size]         = "iw8_minigunksjugg_mp";
//
//    level.lvlstat["wplist_sg"][level.lvlstat["wplist_sg"].size]         = "iw8_sh_charlie725_mp";
//    level.lvlstat["wplist_sg"][level.lvlstat["wplist_sg"].size]         = "iw8_sh_dpapa12_mp"   ;
//    level.lvlstat["wplist_sg"][level.lvlstat["wplist_sg"].size]         = "iw8_sh_mike26_mp"    ;
//    level.lvlstat["wplist_sg"][level.lvlstat["wplist_sg"].size]         = "iw8_sh_oscar12_mp"   ;
//    level.lvlstat["wplist_sg"][level.lvlstat["wplist_sg"].size]         = "iw8_sh_romeo870_mp"  ;

    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_la_mkilo1_mp"  ;
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_la_walpha2_mp" ;
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_la_m1bravo_mp" ;
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_la_palpha_mp"  ;
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_la_palpha42_mp";
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_pi_raygun_mp";
    level.lvlstat["wplist_exp"][level.lvlstat["wplist_exp"].size]       = "s4_ar_tgun_mp";
    
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_ar"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_smg"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_lmg"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_mr"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_sr"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_ps"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_sg"] );
    level.lvlstat["wplist_allwp"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allwp"] , level.lvlstat["wplist_exp"] );

    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "semtex_bolt_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "mortar_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_firebombing_run_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_ks_ord_ger_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_ks_mortar_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_v2_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_mr_ptango41_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "PTANGO41_grenade";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_frag_usa_mk2_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "s4_smoke_usa_m18_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "nuke_mp";
    level.lvlstat["wplist_stdgr"][level.lvlstat["wplist_stdgr"].size]   = "at_mine_mp";

    level.lvlstat["wplist_allgr"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allgr"] , level.lvlstat["wplist_stdgr"] );
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "c4_empty_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "claymore_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "at_mine_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "thermite_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "emp_bomb_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "deploy_airdrop_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "deploy_airdrop_mp_sticky";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "little_bird_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "dragonsbreath_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "thermite_bolt_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "thermite_bolt_radius_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "semtex_bolt_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "semtex_bolt_splash_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "ks_remote_device_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "ks_remote_gunship_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "iw8_green_beam_mp";
    level.lvlstat["wplist_allgr"][level.lvlstat["wplist_allgr"].size]   = "nuke_mp";


    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "apache_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "white_phosphorus_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "cruise_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "ac130_25mm_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "ac130_40mm_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "ac130_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "ac130_105mm_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "s4_glidebomb_fromeo_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "pop_rocket_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "sam_projectile_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "sentry_shock_missile_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "sentry_shock_grenade_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "death_switch_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "hind_missile_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "hind_bomb_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "remotemissile_projectile_mp";

    //level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "hover_jet_proj_mp";
    //level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "emp_drone_proj_mp";
    //level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "bradley_tow_proj_mp";
    //level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "bradley_tow_proj_ks_mp";

/*
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "pop_rocket_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "tur_bradley_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "lighttank_tur_ks_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "tur_gun_lighttank_ks_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "iw8_turret_50cal_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "drone_hive_projectile_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "jackal_cannon_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "power_exploding_drone_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "fuelstrike_proj_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "stinger_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "jackal_turret_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "hover_jet_turret_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "apache_turret_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "cobra_20mm_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "uplinkball_tracking_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "iw7_uplinkball_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "iw7_tdefball_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "tur_gun_faridah_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "snowball_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "pball_mp";
    level.lvlstat["wplist_ks"][level.lvlstat["wplist_ks"].size]         = "tur_gun_lighttank_mp";
    */
    
    level.lvlstat["wplist_allms"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allms"] , level.lvlstat["wplist_exp"] );
    level.lvlstat["wplist_allms"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allms"] , level.lvlstat["wplist_ks"] );

    level.lvlstat["wplist_allbt"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allbt"] , level.lvlstat["wplist_allms"] );
    //level.lvlstat["wplist_allbt"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allbt"] , level.lvlstat["wplist_sg"] );
    //level.lvlstat["wplist_allbt"]                                       = scripts\engine\utility::array_combine( level.lvlstat["wplist_allbt"] , level.lvlstat["wplist_sr"] );

    
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_stango44_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_fnovember2000_mp";       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_asierra44_mp"    ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_balpha_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_bromeopg_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_chotel41_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_fecho_mp"        ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_voscar_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_bromeo37_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_dpapa27_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_mgolf42_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_tyankee11_mp"    ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_promeo45_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_hyankee44_mp"    ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_malpha7_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_aalpha52_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mg_sindia510_mp"    ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_kgolf40_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_ar_emike1_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_ppapa41_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_mpapa40_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_stango5_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_owhiskey_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_guniform45_mp"   ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_thotel_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_wecho43_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_aromeo43_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_fromeo57_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sm_salpha26_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_kalpha98_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_moscar_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_aromeo99_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_ptango41_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_gecho43_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_m1golf_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_svictor40_mp"    ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_mr_malpha1916_mp"   ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sh_becho_mp"        ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sh_bromeo5_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sh_lindia98_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_sh_mike97_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_pi_luniform08_mp"   ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_pi_malpha96_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_pi_mike1911_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_pi_ttango33_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_rindigo_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_knife_mp"        ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_pi_wecho_mp"        ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_katana_mp"       ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_leiomano_mp"     ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_icepick_mp"      ;       
//    level.lvlstat["wplist_s4wp"][level.lvlstat["wplist_s4wp"].size]     = "s4_me_axe_mp"          ;       
}



















































































































































// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : The original GSC function (emptied to avoid DEV ERROR when called from an external class)
// ja : 元GSCの関数（外部クラスからのコール時のDEV ERROR回避用に空にする）
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



main(){}
_id_5468(){}
_id_0B8E( var_0, var_1 ){}
_id_8281( var_0 ){}
_id_6FD5( var_0, var_1 ){}
_id_A3B4(){}
_id_9652(){}
_id_2B96(){}
_id_2C0B( var_0, var_1 ){}
_id_2C0C( var_0 ){}
_id_2C0D( var_0 ){}
_id_2C0A( var_0 ){}
_id_81D1(){}
_id_81CB(){}
_id_FC7A(){}
_id_B054(){}
_id_B061(){}
_id_BB99(){}
_id_4012( var_0 ){}
_id_4615(){}
_id_AB6C(){}
_id_AB9A(){}
_id_10009( var_0, var_1 ){}
_id_3870(){}
_id_AB6E(){}
_id_AB6F(){}
_id_741F(){}
_id_C5F2( var_0 ){}
_id_7428( var_0, var_1 ){}
_id_FCFA(){}
_id_6E0F(){}
_id_10BE8(){}
_id_F817(){}
_id_827A(){}
_id_825B(){}
_id_44DB(){}
_id_FE56(){}
_id_6D2C( var_0 ){}
_id_402F( var_0, var_1, var_2 ){}
_id_6C67(){}
_id_6BAB( var_0, var_1 ){}
_id_6A01(){}
_id_6C69(){}
_id_AB46( var_0 ){}
_id_B80E(){}
_id_AB91(){}
_id_1091C( var_0, var_1 ){}
_id_108B9( var_0, var_1, var_2 ){}
_id_F3CE( var_0 ){}
_id_6FB8(){}
_id_6F98( var_0, var_1 ){}
_id_6F99(){}
_id_BB94(){}
_id_6C68( var_0 ){}
_id_6F92( var_0 ){}
_id_1084B(){}
_id_AB62( var_0, var_1, var_2, var_3 ){}
_id_2BCB( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 ){}
_id_29D1( var_0 ){}
_id_2B23( var_0, var_1, var_2, var_3, var_4 ){}
_id_2B22( var_0, var_1, var_2, var_3, var_4, var_5, var_6 ){}
_id_2B97( var_0 ){}
_id_2B24( var_0, var_1, var_2 ){}
_id_AB4E( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 ){}
_id_AB2C( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_6883( var_0 ){}
_id_4E46( var_0, var_1 ){}
_id_DD0D(){}
_id_AB50( var_0 ){}
_id_AB5D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ){}
_id_9B6D( var_0 ){}
_id_F994( var_0 ){}
_id_FCF6(){}
_id_7DD1(){}
_id_C240( var_0 ){}
_id_2BBD( var_0 ){}
_id_99DE( var_0 ){}
_id_99FA( var_0 ){}
_id_99DC( var_0 ){}
_id_99E8( var_0 ){}
_id_7C70( var_0, var_1 ){}
_id_A90A( var_0 ){}
_id_8200(){}
_id_10DA8( var_0, var_1 ){}
_id_E6A3( var_0 ){}
_id_44E0( var_0 ){}
_id_71CD( var_0 ){}
_id_44C9(){}
_id_CA22( var_0, var_1, var_2, var_3 ){}
_id_482D( var_0 ){}
_id_FC53( var_0, var_1, var_2 ){}
_id_E2C0( var_0, var_1, var_2 ){}
_id_E39E( var_0 ){}
_id_44B1(){}
_id_ABAD(){}
_id_AB58( var_0 ){}
_id_AA90( var_0 ){}
_id_AB99( var_0 ){}
_id_7405( var_0 ){}
_id_D649( var_0 ){}
_id_2EB9( var_0 ){}
_id_6F9A( var_0 ){}
_id_C5FE(){}
_id_E8FF(){}
_id_6F69( var_0, var_1, var_2 ){}
_id_D64A(){}
_id_6FED( var_0 ){}
_id_6F6B( var_0, var_1, var_2, var_3, var_4 ){}
_id_107D3( var_0, var_1, var_2, var_3 ){}
_id_2ECE( var_0 ){}
_id_C62D(){}
_id_AB34( var_0 ){}
_id_ABA0( var_0 ){}
_id_A3EF(){}
_id_2B84( var_0, var_1 ){}
_id_10E5B( var_0 ){}
_id_7424( var_0 ){}
_id_2B31( var_0, var_1 ){}
_id_64F7( var_0 ){}
_id_AE15(){}
_id_E30B( var_0, var_1 ){}
_id_2C12( var_0 ){}
_id_2C13(){}
_id_2C0F(){}
_id_2BD8( var_0 ){}
_id_2B26(){}
_id_2B27( var_0 ){}
_id_B785(){}
_id_B787(){}
_id_B7CE(){}
_id_B786(){}
_id_A10A(){}
_id_9532(){}
_id_D0AE(){}
_id_2A10(){}
_id_2A29( var_0, var_1 ){}
_id_2A05( var_0, var_1 ){}
_id_2A8C(){}
_id_2A28( var_0 ){}
_id_2BFB( var_0 ){}
_id_385B(){}
_id_2B1E(){}
_id_B693( var_0 ){}
_id_8ACD( var_0 ){}
_id_2C1E( var_0 ){}
_id_87A4( var_0 ){}
_id_6DAA( var_0 ){}
_id_AAFD( var_0, var_1 ){}
_id_2C11( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 ){}
_id_2B93( var_0 ){}
_id_2BAE(){}
_id_2B2E(){}
_id_2B2F(){}
_id_2AE9(){}
_id_2B92(){}
_id_2B2D(){}
_id_2B94(){}
_id_2B2C(){}
_id_2B91(){}
_id_2B90(){}
_id_2C15(){}
_id_2B98( var_0 ){}
_id_E283( var_0 ){}
_id_B690(){}
_id_B691(){}
_id_10AF3(){}
_id_D665( var_0 ){}
_id_D64F( var_0 ){}
_id_0DD7( var_0 ){}
_id_EF72( var_0 ){}
_id_FD3A( var_0 ){}
_id_B657( var_0 ){}
_id_EFAA( var_0, var_1, var_2, var_3 ){}
_id_D6F4( var_0 ){}
_id_532D(){}
_id_ABA1( var_0 ){}
_id_1371( var_0 ){}
_id_1347( var_0 ){}
_id_135B(){}
_id_1359(){}
_id_135A( var_0 ){}
_id_134F( var_0 ){}
_id_1350( var_0 ){}
_id_AB81( var_0 ){}
_id_AB2B( var_0, var_1 ){}
_id_AAE6( var_0, var_1 ){}
_id_ABC8( var_0 ){}
_id_B79D(){}
_id_2C0E( var_0, var_1 ){}
_id_2BC7( var_0 ){}
_id_F99C(){}
_id_A140(){}
_id_10DD0( var_0 ){}
_id_10D9B( var_0 ){}
_id_18D0(){}
_id_B7AE( var_0 ){}
_id_690F(){}
_id_C5F1( var_0 ){}
_id_AADA( var_0 ){}
_id_3ABE( var_0, var_1 ){}
_id_740D( var_0, var_1 ){}
_id_C250( var_0 ){}
_id_740E( var_0, var_1 ){}
_id_FD3C( var_0, var_1, var_2, var_3 ){}
_id_2EBB( var_0 ){}
_id_AB4D(){}
_id_B6D6(){}
_id_FCF3(){}
_id_2AA0(){}
_id_98B8(){}
_id_2A48( var_0 ){}
_id_2A37(){}
_id_29F3(){}
_id_29F4( var_0 ){}
_id_2B2A( var_0 ){}
_id_81C1( var_0 ){}
_id_D44E( var_0 ){}
_id_2BAF( var_0, var_1 ){}
