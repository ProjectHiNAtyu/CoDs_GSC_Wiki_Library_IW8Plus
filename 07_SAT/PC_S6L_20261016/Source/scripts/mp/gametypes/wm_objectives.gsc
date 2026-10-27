// scripts\mp\gametypes\wm_objectives.gsc  (hash_3ce0495c8649ee91.gscc) (size: 86446 Bytes / 0x151ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x693e83c2 (1765704642)
// size ...... 86446 (0x151ae)
// includes .. 37  (offset: 0x13426)
// strings ... 399 (offset: 0x1354e)
// dev strs .. 12  (offset: 0x150fa)
// exports ... 156 (offset: 0xe38a)
// cseg ...... 0x241a + 0xbf70 (0xe38a)
// imports ... 420 (offset: 0xfbea)
// animtree1 . 0   (offset: 0x151ae)
// animtree2 . 0   (offset: 0x151ae)
#using script_35439e42e052044a;
#using scripts\common\callbacks;
#using scripts\common\lighting;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_tracking;
#using scripts\mp\agents\agent_juggernaut;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\equipment\tactical_cover;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\missile_turret;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_captureflag;
#using scripts\mp\gametypes\obj_contestzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\obj_hackzone;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\gametypes\wm_objectives_util;
#using scripts\mp\gametypes\wm_ui;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\samsite;

#namespace wm_objectives;

// Namespace wm_objectives
// Params 0
// Checksum 0x3014ede0, Offset: 0x2438
// Size: 0x4f3
function init_wm_objectives()
{
    init_wm_objectives_vo();
    level.escortvehicles = [];
    level.var_c33d86c8057ff0bb = [];
    level.var_c33d86c8057ff0bb[ 1 ] = "zone";
    level.var_c33d86c8057ff0bb[ 2 ] = "bomb";
    level.var_c33d86c8057ff0bb[ 3 ] = "hostage";
    level.var_c33d86c8057ff0bb[ 4 ] = "destroy";
    level.var_c33d86c8057ff0bb[ 5 ] = "destroyPlant";
    level.var_c33d86c8057ff0bb[ 6 ] = "escort";
    level.var_c33d86c8057ff0bb[ 7 ] = "aiBoss";
    level.var_c33d86c8057ff0bb[ 8 ] = "aiBossZone";
    level.var_c33d86c8057ff0bb[ 9 ] = "hack";
    level.var_c33d86c8057ff0bb[ 11 ] = "escort_wheelson";
    level.var_c33d86c8057ff0bb[ 12 ] = "capture_flag";
    level.var_c33d86c8057ff0bb[ 10 ] = "hack_bomb";
    function_20a9a8ed49bacb32( 1, &init_zone_objective );
    function_20a9a8ed49bacb32( 2, &init_bomb_objective );
    function_20a9a8ed49bacb32( 3, &init_hostage_objective );
    function_20a9a8ed49bacb32( 4, &init_aa_objective );
    function_20a9a8ed49bacb32( 5, &function_5edc8c37e92cd75f );
    function_20a9a8ed49bacb32( 6, &function_a3a180efcc2d036a );
    function_20a9a8ed49bacb32( 7, &init_ai_boss_objective );
    function_20a9a8ed49bacb32( 8, &init_ai_zone_objective );
    function_20a9a8ed49bacb32( 9, &init_hack_objective );
    function_20a9a8ed49bacb32( 11, &function_b7e03fcf97628be9 );
    function_20a9a8ed49bacb32( 12, &init_capture_flag_objective );
    function_20a9a8ed49bacb32( 10, &init_hack_bomb_objective );
    function_bf9b94aee43c1088( 1, &start_zone_objective );
    function_bf9b94aee43c1088( 2, &function_c18f0ffd531442cf );
    function_bf9b94aee43c1088( 3, &function_aca47c867b115134 );
    function_bf9b94aee43c1088( 4, &function_2da58517892c7e21 );
    function_bf9b94aee43c1088( 5, &function_4308862cbf16f689 );
    function_bf9b94aee43c1088( 6, &function_b9156980bb4c0338 );
    function_bf9b94aee43c1088( 7, &function_cf056bf52d8c245b );
    function_bf9b94aee43c1088( 8, &function_2d857d52b8ee3538 );
    function_bf9b94aee43c1088( 9, &function_458ac1844c583106 );
    function_bf9b94aee43c1088( 11, &function_b827ec035df6e37f );
    function_bf9b94aee43c1088( 12, &function_dd26f0e35dd0e6b6 );
    function_bf9b94aee43c1088( 10, &function_e62b17632bfc527 );
    function_b1f034bf9b11e9f1( 1, &end_zone_objective );
    function_b1f034bf9b11e9f1( 2, &function_4201da8177b4cd30 );
    function_b1f034bf9b11e9f1( 3, &function_1c3a2b66d8e504c9 );
    function_b1f034bf9b11e9f1( 4, &function_f5e899b3f4b5ece6 );
    function_b1f034bf9b11e9f1( 5, &function_28fa8ad4d276e140 );
    function_b1f034bf9b11e9f1( 6, &function_2f7a2480c15194f9 );
    function_b1f034bf9b11e9f1( 7, &function_e24c8723d2d480c2 );
    function_b1f034bf9b11e9f1( 8, &function_3593de6105cb07b5 );
    function_b1f034bf9b11e9f1( 9, &function_7573b4588fb87225 );
    function_b1f034bf9b11e9f1( 11, &function_10d1f152a55cff2e );
    function_b1f034bf9b11e9f1( 12, &function_5643296f5aa036e5 );
    function_b1f034bf9b11e9f1( 10, &function_8c8286ef3ae740f6 );
    function_eda5bb209930e06d( 1, &function_90a09c0ed6d6738 );
    function_eda5bb209930e06d( 2, &init_bomb_objective_waypoints );
    function_eda5bb209930e06d( 3, &function_c6d8aaeedb29445d );
    function_eda5bb209930e06d( 4, &function_6cfffa53b41f3ab8 );
    function_eda5bb209930e06d( 5, &function_7d47e57cdadbde7a );
    function_eda5bb209930e06d( 6, &function_91a0a19ccd59317d );
    function_eda5bb209930e06d( 7, &init_ai_boss_waypoints );
    function_eda5bb209930e06d( 8, &function_90a09c0ed6d6738 );
    function_eda5bb209930e06d( 9, &function_754776ffb81c1d93 );
    function_eda5bb209930e06d( 11, &function_91a0a19ccd59317d );
    function_eda5bb209930e06d( 12, &function_633c9032c2524e87 );
    function_eda5bb209930e06d( 10, &function_6641dedb7bf5c086 );
    function_820f41bdd6a1a4ee( 1, &wm_objectives_util::function_67b316ac48344f73 );
    function_820f41bdd6a1a4ee( 2, &wm_objectives_util::function_1873b4024a26afb7 );
    function_820f41bdd6a1a4ee( 5, &wm_objectives_util::function_8ee2d56dd607cfa7 );
    function_820f41bdd6a1a4ee( 6, &wm_objectives_util::function_6aa161da52a5fbe6 );
    function_820f41bdd6a1a4ee( 9, &wm_objectives_util::function_efad2a9c9d82a0f4 );
    function_820f41bdd6a1a4ee( 10, &wm_objectives_util::function_5f3f1056cae339d1 );
    
    if ( isdefined( level.var_8a7f2a9e4e46f498 ) )
    {
        [[ level.var_8a7f2a9e4e46f498 ]]();
    }
    
    foreach ( i, objective in level.var_4d77f7b3add6e7d4 )
    {
        zone = level.zones[ "zone_" + i + 1 ];
        zone.objective = objective;
        [[ level.var_e19e96dbfd41de0b[ objective.objectivetype ] ]]( zone );
        flags::gameflaginit( zone.name + "_objective_start", 0 );
        flags::gameflaginit( zone.name + "_objective_end", 0 );
    }
    
    level thread function_6f9000561835356a();
}

// Namespace wm_objectives
// Params 0
// Checksum 0xa1f3a30a, Offset: 0x2933
// Size: 0x494
function init_wm_objectives_vo()
{
    game[ "dialog" ][ "obj1_nag_def_launchfacility" ] = "dx_mp_mwm1_mode_spet_ondg";
    game[ "dialog" ][ "obj1_nag_atk_launchfacility" ] = "dx_mp_mwm1_mode_t141_onat";
    game[ "dialog" ][ "obj1_atk_win_launchfacility" ] = "dx_mp_mwm1_mode_t141_owak";
    game[ "dialog" ][ "obj1_def_lost_launchfacility" ] = "dx_mp_mwm1_mode_spet_owin";
    game[ "dialog" ][ "obj1_atk_lost_launchfacility" ] = "dx_mp_mwm1_mode_t141_ofai";
    game[ "dialog" ][ "obj1_def_win_launchfacility" ] = "dx_mp_mwm1_mode_spet_ofae";
    game[ "dialog" ][ "obj1_securing_a_atk" ] = "dx_mp_mwm1_mode_t141_ostk";
    game[ "dialog" ][ "obj1_captured_a_atk" ] = "dx_mp_mwm1_mode_t141_octk";
    game[ "dialog" ][ "obj1_losing_a_def" ] = "dx_mp_mwm1_mode_spet_olad";
    game[ "dialog" ][ "obj1_lost_a_def" ] = "dx_mp_mwm1_mode_spet_olde";
    game[ "dialog" ][ "obj1_securing_b_atk" ] = "dx_mp_mwm1_mode_t141_osbk";
    game[ "dialog" ][ "obj1_captured_b_atk" ] = "dx_mp_mwm1_mode_t141_ocbk";
    game[ "dialog" ][ "obj1_losing_b_def" ] = "dx_mp_mwm1_mode_spet_olbd";
    game[ "dialog" ][ "obj1_lost_b_def" ] = "dx_mp_mwm1_mode_spet_olbf";
    game[ "dialog" ][ "obj1_missile_launch_atk" ] = "dx_mp_mwm1_mode_t141_omla";
    game[ "dialog" ][ "obj1_atk_overtime_launchfacility" ] = "dx_mp_mwm1_mode_t141_ooao";
    game[ "dialog" ][ "obj1_def_overtime_launchfacility" ] = "dx_mp_mwm1_mode_spet_oode";
    game[ "dialog" ][ "obj2_atk_start_launchfacility" ] = "dx_mp_mwm1_mode_t141_obeg";
    game[ "dialog" ][ "obj2_def_start_launchfacility" ] = "dx_mp_mwm1_mode_spet_obgi";
    game[ "dialog" ][ "obj2_nag_atk_launchfacility" ] = "dx_mp_mwm1_mode_t141_ontk";
    game[ "dialog" ][ "obj2_nag_def_launchfacility" ] = "dx_mp_mwm1_mode_spet_ondf";
    game[ "dialog" ][ "obj2_atk_win_launchfacility" ] = "dx_mp_mwm1_mode_t141_owtk";
    game[ "dialog" ][ "obj2_def_lost_launchfacility" ] = "dx_mp_mwm1_mode_spet_owdf";
    game[ "dialog" ][ "obj2_atk_lost_launchfacility" ] = "dx_mp_mwm1_mode_t141_oftk";
    game[ "dialog" ][ "obj2_def_win_launchfacility" ] = "dx_mp_mwm1_mode_spet_ofdf";
    game[ "dialog" ][ "obj2_atk_tank_contested_launchfacility" ] = "dx_mp_mwm1_mode_t141_otck";
    game[ "dialog" ][ "obj2_def_tank_contested_launchfacility" ] = "dx_mp_mwm1_mode_spet_otcd";
    game[ "dialog" ][ "obj2_atk_tank_damaged_launchfacility" ] = "dx_mp_mwm1_mode_t141_otdk";
    game[ "dialog" ][ "obj2_def_tank_damaged_launchfacility" ] = "dx_mp_mwm1_mode_spet_otdf";
    game[ "dialog" ][ "obj2_atk_tank_repaired_launchfacility" ] = "dx_mp_mwm1_mode_t141_otra";
    game[ "dialog" ][ "obj2_def_tank_repaired_launchfacility" ] = "dx_mp_mwm1_mode_spet_otrd";
    game[ "dialog" ][ "obj2_atk_overtime_launchfacility" ] = "dx_mp_mwm1_mode_t141_ootk";
    game[ "dialog" ][ "obj2_def_overtime_launchfacility" ] = "dx_mp_mwm1_mode_spet_oodf";
    game[ "dialog" ][ "obj3_atk_start_launchfacility" ] = "dx_mp_mwm1_mode_t141_obtk";
    game[ "dialog" ][ "obj3_def_start_launchfacility" ] = "dx_mp_mwm1_mode_spet_obdf";
    game[ "dialog" ][ "obj3_nag_atk_launchfacility" ] = "dx_mp_mwm1_mode_t141_onak";
    game[ "dialog" ][ "obj3_nag_def_launchfacility" ] = "dx_mp_mwm1_mode_spet_onde";
    game[ "dialog" ][ "obj3_atk_upload_start_launchfacility" ] = "dx_mp_mwm1_mode_t141_oipk";
    game[ "dialog" ][ "obj3_def_upload_start_launchfacility" ] = "dx_mp_mwm1_mode_spet_oipd";
    game[ "dialog" ][ "obj3_atk_upload_complete_launchfacility" ] = "dx_mp_mwm1_mode_t141_ohpk";
    game[ "dialog" ][ "obj3_def_upload_complete_launchfacility" ] = "dx_mp_mwm1_mode_spet_ohpd";
    game[ "dialog" ][ "obj3_atk_win_launchfacility" ] = "dx_mp_mwm1_mode_t141_owat";
    game[ "dialog" ][ "obj3_def_lost_launchfacility" ] = "dx_mp_mwm1_mode_spet_owde";
    game[ "dialog" ][ "obj3_atk_lost_launchfacility" ] = "dx_mp_mwm1_mode_t141_ofat";
    game[ "dialog" ][ "obj3_def_win_launchfacility" ] = "dx_mp_mwm1_mode_spet_ofad";
    game[ "dialog" ][ "obj3_missile_launch_atk" ] = "dx_mp_mwm1_mode_t141_omlk";
    game[ "dialog" ][ "obj3_atk_overtime_launchfacility" ] = "dx_mp_mwm1_mode_t141_over";
    game[ "dialog" ][ "obj3_def_overtime_launchfacility" ] = "dx_mp_mwm1_mode_spet_oota";
    function_7b86ce41e88cea77( 1, &function_ab7b7d8ad746c5e3 );
    function_7b86ce41e88cea77( 2, &function_c790d9b31174b75 );
    function_7b86ce41e88cea77( 5, &function_1c0215f1c64320aa );
    function_7b86ce41e88cea77( 3, &function_5e1f19acbcc41bce );
    function_7b86ce41e88cea77( 6, &function_2152f8112d70db5a );
    function_7b86ce41e88cea77( 9, &function_c350237db43534d3 );
    function_6dced7d73fed7c6b( 1, "attackers_lost_zone" );
    function_6dced7d73fed7c6b( 2, "attackers_lost_bomb_objective" );
    function_6dced7d73fed7c6b( 5, "attackers_lost_sam_site" );
    function_6dced7d73fed7c6b( 3, "attackers_lost_hostages" );
    function_6dced7d73fed7c6b( 6, "attackers_lost_tank_objective" );
    function_6dced7d73fed7c6b( 9, "obj3_atk_lost_launchfacility" );
    function_fa75f7748fd94c5f( 9, "obj3_def_win_launchfacility" );
    function_7be9180b3ab6f6a7( 2, "attackers_bomb_start", "defenders_bomb_start" );
    function_7be9180b3ab6f6a7( 5, "attackers_sam_start", "defenders_sam_start" );
    function_7be9180b3ab6f6a7( 6, "attackers_tank_escort_start", "defenders_tank_escort_start" );
    function_7be9180b3ab6f6a7( 9, "obj3_atk_start_launchfacility", "obj3_def_start_launchfacility" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xb4b6de26, Offset: 0x2dcf
// Size: 0x57
function function_ab7b7d8ad746c5e3( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "nag_defend_objective", &function_76b7724897450579, 20, 8 );
    function_418d20b3b721ba79( zone, "attackers", "nag_take_objective", &function_5b49a3f20b035346, 20, 8 );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xae2a6efc, Offset: 0x2e2e
// Size: 0x87
function function_c790d9b31174b75( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "nag_protect_bombs", undefined, 20, 8 );
    function_418d20b3b721ba79( zone, "attackers", "nag_defuse_bombs", &no_one_defusing, 20, 8 );
    function_418d20b3b721ba79( zone, "defenders", "alert_enemy_defusing_bombs", "began_defusing_bomb", 2 );
    function_418d20b3b721ba79( zone, "attackers", "alert_team_defusing_bombs", "began_defusing_bomb", 2 );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x3f7fac75, Offset: 0x2ebd
// Size: 0xb7
function function_1c0215f1c64320aa( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "nag_defend_sam_site", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "attackers", "nag_plant_c4", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "defenders", "alert_enemy_planted_c4", "planted_bomb_on_sam_site", 2 );
    function_418d20b3b721ba79( zone, "attackers", "alert_team_planted_c4", "planted_bomb_on_sam_site", 2 );
    function_418d20b3b721ba79( zone, "defenders", "alert_team_defused_c4", "defused_bomb_on_sam_site", 2 );
    function_418d20b3b721ba79( zone, "attackers", "alert_team_defused_c4", "defused_bomb_on_sam_site", 2 );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x676f677b, Offset: 0x2f7c
// Size: 0x4f
function function_5e1f19acbcc41bce( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "nag_defend_hostages", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "attackers", "nag_rescue_hostages", undefined, 14, 8 );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5d98dbb9, Offset: 0x2fd3
// Size: 0x4f
function function_2152f8112d70db5a( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "nag_defenders_defend_tank", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "attackers", "nag_attackers_escort_tank", undefined, 14, 8 );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x17c46ee9, Offset: 0x302a
// Size: 0xf7
function function_c350237db43534d3( zone )
{
    level.var_f0cf9f2aed2a1b6e = undefined;
    function_418d20b3b721ba79( zone, "defenders", "obj3_nag_def_launchfacility", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "attackers", "obj3_nag_atk_launchfacility", undefined, 14, 8 );
    function_418d20b3b721ba79( zone, "attackers", "obj3_missile_launch_atk", "zone_3_missile_launched" );
    function_418d20b3b721ba79( zone, "attackers", "obj3_atk_overtime_launchfacility", "obj_type_9_overtime_launchfacility" );
    function_418d20b3b721ba79( zone, "defenders", "obj3_def_overtime_launchfacility", "obj_type_9_overtime_launchfacility" );
    function_418d20b3b721ba79( zone, "attackers", "obj3_atk_upload_start_launchfacility", "hack_zone_upload_start" );
    function_418d20b3b721ba79( zone, "defenders", "obj3_def_upload_start_launchfacility", "hack_zone_upload_start" );
    function_418d20b3b721ba79( zone, "attackers", "obj3_atk_upload_complete_launchfacility", "hack_zone_upload_complete" );
    function_418d20b3b721ba79( zone, "defenders", "obj3_def_upload_complete_launchfacility", "hack_zone_upload_complete" );
    function_1afe01a54a2a4f3d( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x4300b523, Offset: 0x3129
// Size: 0x9a, Type: bool
function no_one_defusing( zone )
{
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && player.isplanting )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x233855d2, Offset: 0x31cc
// Size: 0xa1, Type: bool
function function_76b7724897450579( zone )
{
    foreach ( capture_zone in zone.capture_zones )
    {
        if ( isdefined( capture_zone.claimplayer ) && !capture_zone.stalemate )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace wm_objectives
// Params 1
// Checksum 0xaad2757f, Offset: 0x3276
// Size: 0x9b, Type: bool
function function_5b49a3f20b035346( zone )
{
    foreach ( capture_zone in zone.capture_zones )
    {
        if ( capture_zone.touchlist[ game[ "attackers" ] ].size > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace wm_objectives
// Params 0
// Checksum 0x1a1eb01e, Offset: 0x331a
// Size: 0xda
function function_6f9000561835356a()
{
    while ( !isdefined( level.aa_sites ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( turret in level.aa_sites )
        {
            if ( !isdefined( turret ) )
            {
                continue;
            }
            
            ent = function_3e10bb7c2407915a( turret );
            
            /#
                print3d( turret.origin, ent.samsitestate, ( 1, 1, 1 ), 1, 1, 1 );
            #/
        }
        
        waitframe();
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xacd9b49, Offset: 0x33fc
// Size: 0x133
function function_7c9707e6bf5ace47( player )
{
    player dlog_recordplayerevent( "dlog_event_wm_player_objective_start", [ "match_guid", getonlinematchid(), "objective_start_time", gettime() / 1000, "map_name", level.script, "player_team", player.team, "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "objective_type", string( level.zone.objectivetype ), "objective_key", self.objectivekey, "objective_id", level.zone.name, "round", "" + game[ "roundsPlayed" ] ] );
}

// Namespace wm_objectives
// Params 2
// Checksum 0x73221e0e, Offset: 0x3537
// Size: 0x17a
function function_ed5eed059c35b842( player, success )
{
    state = "success";
    
    if ( !success )
    {
        state = isalive( player ) ? "cancel" : "dead";
    }
    
    player dlog_recordplayerevent( "dlog_event_wm_player_objective_end", [ "match_guid", getonlinematchid(), "objective_end_time", gettime() / 1000, "map_name", level.script, "player_team", player.team, "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "objective_type", string( level.zone.objectivetype ), "objective_key", self.objectivekey, "objective_id", level.zone.name, "player_end_state", state, "round", "" + game[ "roundsPlayed" ] ] );
}

// Namespace wm_objectives
// Params 5
// Checksum 0xa9d5be00, Offset: 0x36b9
// Size: 0x1ac
function register_wm_objective( objectivetype, objectivekey, objectiveid, targetname, params )
{
    if ( !isdefined( level.var_4d77f7b3add6e7d4 ) )
    {
        level.var_4d77f7b3add6e7d4 = [];
    }
    
    if ( level.var_8534d45d29f17686 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_677b0279e04cc234", -1 ) > 0 )
    {
        var_2e85d7a7b6840424 = getdvarint( @"hash_677b0279e04cc234", -1 );
        objectivetype = var_2e85d7a7b6840424;
        objectivekey = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
        targetname = function_ce994be88a9a8309( objectivetype );
        ents = arraycombine( getentarray( targetname, #targetname ), utility::getstructarray( targetname, "targetname" ), getvehiclenodearray( targetname, #targetname ) );
        objectivekey = utility::array_slice( objectivekey, 0, ents.size );
        objectiveid = "zone_1";
        level.var_8534d45d29f17686 = 1;
    }
    
    objectiveinfo = spawnstruct();
    objectiveinfo.objectivetype = objectivetype;
    objectiveinfo.objectivekey = objectivekey;
    objectiveinfo.objectiveid = objectiveid;
    objectiveinfo.targetname = targetname;
    objectiveinfo.params = params ?? [];
    level.var_4d77f7b3add6e7d4[ level.var_4d77f7b3add6e7d4.size ] = objectiveinfo;
}

// Namespace wm_objectives
// Params 6
// Checksum 0x296b3052, Offset: 0x386d
// Size: 0x15a
function function_118fc536065fd607( objectivetype, objectivekey, objectiveid, targetname, params, forceobjective )
{
    if ( !isdefined( level.var_4d77f7b3add6e7d4 ) )
    {
        return;
    }
    
    objectiveinfo = spawnstruct();
    objectiveinfo.objectivetype = objectivetype;
    objectiveinfo.objectivekey = objectivekey;
    objectiveinfo.objectiveid = objectiveid;
    objectiveinfo.targetname = targetname;
    objectiveinfo.params = params ?? [];
    
    /#
        if ( forceobjective )
        {
            level.var_4d77f7b3add6e7d4 = [];
            level.var_4d77f7b3add6e7d4[ level.var_4d77f7b3add6e7d4.size ] = objectiveinfo;
            return;
        }
    #/
    
    foreach ( i, objective in level.var_4d77f7b3add6e7d4 )
    {
        if ( objective.objectivetype == objectivetype )
        {
            level.var_4d77f7b3add6e7d4[ i ] = objectiveinfo;
            return;
        }
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xa4aa89f3, Offset: 0x39cf
// Size: 0xdf
function function_ce994be88a9a8309( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            return "jup_dam_wb_capture_zone_a";
        case 2:
            return "bombzone";
        case 9:
            return "hack_point";
        case 3:
            return "hostage_trigger";
        case 4:
            return "mp_jup_dam_aa_turret_spawn";
        case 5:
            return "samsite_loc";
        case 6:
            return "wm_escort_tank_path";
        case 7:
            return "wm_boss_spawn";
        case 8:
            if ( game_utility::getmapname() == "mp_jup_airstrip" )
            {
                return "wm_airstrip_capture_zone";
            }
            else
            {
                return "wm_objective_ai_zone";
            }
        default:
            break;
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0x7cf1470f, Offset: 0x3ab6
// Size: 0x39
function function_820f41bdd6a1a4ee( objectivetype, func )
{
    if ( !isdefined( level.var_60eb342aeb0467a5 ) )
    {
        level.var_60eb342aeb0467a5 = [];
    }
    
    level.var_60eb342aeb0467a5[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 0
// Checksum 0xbf6d1fcc, Offset: 0x3af7
// Size: 0x53
function function_176c17ff4882c71a()
{
    if ( !isdefined( level.var_60eb342aeb0467a5 ) )
    {
        return;
    }
    
    var_c8249fcdb5207f0c = level.var_60eb342aeb0467a5[ level.zone.objectivetype ];
    
    if ( isdefined( var_c8249fcdb5207f0c ) )
    {
        level thread function_a92e8348856a4b39( var_c8249fcdb5207f0c, level.zone );
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0xd8d57712, Offset: 0x3b52
// Size: 0x4e
function function_a92e8348856a4b39( func, zone )
{
    level endon( zone.name + "_objective_end" );
    
    while ( true )
    {
        result = [[ func ]]( zone );
        level.canprocessot = result;
        waitframe();
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0xbad4b81c, Offset: 0x3ba8
// Size: 0x39
function function_eda5bb209930e06d( objectivetype, func )
{
    if ( !isdefined( level.var_17249d5fa9da615b ) )
    {
        level.var_17249d5fa9da615b = [];
    }
    
    level.var_17249d5fa9da615b[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 2
// Checksum 0xe6de06d1, Offset: 0x3be9
// Size: 0x39
function function_20a9a8ed49bacb32( objectivetype, func )
{
    if ( !isdefined( level.var_e19e96dbfd41de0b ) )
    {
        level.var_e19e96dbfd41de0b = [];
    }
    
    level.var_e19e96dbfd41de0b[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x68dfc2bb, Offset: 0x3c2a
// Size: 0x39
function function_bf9b94aee43c1088( objectivetype, func )
{
    if ( !isdefined( level.var_c50b39c472783aa1 ) )
    {
        level.var_c50b39c472783aa1 = [];
    }
    
    level.var_c50b39c472783aa1[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x2b03a227, Offset: 0x3c6b
// Size: 0x39
function function_b1f034bf9b11e9f1( objectivetype, func )
{
    if ( !isdefined( level.var_63156b5d1bea415a ) )
    {
        level.var_63156b5d1bea415a = [];
    }
    
    level.var_63156b5d1bea415a[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x376b4809, Offset: 0x3cac
// Size: 0x39
function function_7b86ce41e88cea77( objectivetype, func )
{
    if ( !isdefined( level.var_71378520253690c2 ) )
    {
        level.var_71378520253690c2 = [];
    }
    
    level.var_71378520253690c2[ objectivetype ] = func;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x5c32d6de, Offset: 0x3ced
// Size: 0x62
function function_6dced7d73fed7c6b( objectivetype, voline )
{
    if ( !isdefined( level.var_b50a2a0252afb0c9 ) )
    {
        level.var_b50a2a0252afb0c9 = [];
    }
    
    if ( !isdefined( level.var_b50a2a0252afb0c9[ "attackers" ] ) )
    {
        level.var_b50a2a0252afb0c9[ "attackers" ] = [];
    }
    
    level.var_b50a2a0252afb0c9[ "attackers" ][ objectivetype ] = voline;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x6d97b932, Offset: 0x3d57
// Size: 0x62
function function_fa75f7748fd94c5f( objectivetype, voline )
{
    if ( !isdefined( level.var_b50a2a0252afb0c9 ) )
    {
        level.var_b50a2a0252afb0c9 = [];
    }
    
    if ( !isdefined( level.var_b50a2a0252afb0c9[ "defenders" ] ) )
    {
        level.var_b50a2a0252afb0c9[ "defenders" ] = [];
    }
    
    level.var_b50a2a0252afb0c9[ "defenders" ][ objectivetype ] = voline;
}

// Namespace wm_objectives
// Params 3
// Checksum 0x7827f154, Offset: 0x3dc1
// Size: 0x75
function function_7be9180b3ab6f6a7( objectivetype, var_d6fb37d53b253ee1, var_b68ddf9c81b942f5 )
{
    if ( !isdefined( level.var_6a6acdc6985d1d87 ) )
    {
        level.var_6a6acdc6985d1d87 = [];
    }
    
    level.var_6a6acdc6985d1d87[ objectivetype ] = spawnstruct();
    level.var_6a6acdc6985d1d87[ objectivetype ].attackerline = var_d6fb37d53b253ee1;
    level.var_6a6acdc6985d1d87[ objectivetype ].defenderline = var_b68ddf9c81b942f5;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x48ac61e6, Offset: 0x3e3e
// Size: 0x9c
function function_c9d147f92994b0b3( objectivetype )
{
    if ( isdefined( level.var_b50a2a0252afb0c9[ "attackers" ][ objectivetype ] ) )
    {
        level.var_40e874c343c0b751 = 1;
        utility::delaythread( 2, &dialog::leaderdialog, level.var_b50a2a0252afb0c9[ "attackers" ][ objectivetype ], game[ "attackers" ] );
    }
    
    if ( isdefined( level.var_b50a2a0252afb0c9[ "defenders" ][ objectivetype ] ) )
    {
        level.var_40e874c343c0b751 = 1;
        utility::delaythread( 2, &dialog::leaderdialog, level.var_b50a2a0252afb0c9[ "defenders" ][ objectivetype ], game[ "defenders" ] );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xbc574a88, Offset: 0x3ee2
// Size: 0xa7
function function_90a09c0ed6d6738( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq_enemy" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq_enemy" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq_enemy" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_hq_enemy" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested" + label, 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq_enemy" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xd8336e47, Offset: 0x3f91
// Size: 0x88
function init_bomb_objective_waypoints( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb_defuse" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_planting" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_planting" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x51e5b5e3, Offset: 0x4021
// Size: 0xd0
function function_754776ffb81c1d93( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hack" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_hack" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_UPLOAD_CAPS", "icon_waypoint_hack" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_hacking" + label, 0, "enemy", &"mp_ingame_only/obj_stop_caps", "icon_waypoint_hacking" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse" + label, 0, "friendly", &"mp_ingame_only/obj_uploading_caps", "icon_waypoint_hacking" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_enter_silo_f", 0, "friendly", &"mp_jup_launchfacility/plant_ied", "icon_waypoint_ied_plant" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_enter_silo_e", 0, "enemy", &"mp_jup_launchfacility/plant_ied", "icon_waypoint_ied_plant" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xdf442c37, Offset: 0x40f9
// Size: 0x50
function function_c6d8aaeedb29445d( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", &"mp_ingame_only/obj_rescue_caps", "icon_waypoint_hostage", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hostage_captive", 0 );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xa87fc71, Offset: 0x4151
// Size: 0x50
function function_6cfffa53b41f3ab8( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", &"mp_ingame_only/obj_hvt_caps", "hud_icon_vehicle_samsite", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite", 0 );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xb5d54890, Offset: 0x41a9
// Size: 0x8e
function function_7d47e57cdadbde7a( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", &"mp_ingame_only/obj_plant_caps", "hud_icon_vehicle_samsite", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xed05e3b8, Offset: 0x423f
// Size: 0x5a
function function_91a0a19ccd59317d( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", &"mp_ingame_only/obj_halt_caps", "icon_waypoint_dom" + label, 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + label, 0 );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x7270918c, Offset: 0x42a1
// Size: 0x4e
function init_ai_boss_waypoints( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xc573ae47, Offset: 0x42f7
// Size: 0x118
function function_633c9032c2524e87( label )
{
    precachestring( &"MP_INGAME_ONLY/OBJ_DEPLOY_CAPS" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_take_flag" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_flag" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_kill_flag" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_escort_flag" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_flag", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_deploy" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEPLOY_CAPS", "icon_waypoint_rescue_extract", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_rescue_extract", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq_enemy" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + label, 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq_enemy" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x4ab5b115, Offset: 0x4417
// Size: 0xde
function function_6641dedb7bf5c086( label )
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hack" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_hack" + label, 0, "enemy", &"mp_ingame_only/obj_activate_caps", "icon_waypoint_hack" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_hacking" + label, 0, "enemy", &"mp_ingame_only/obj_stop_caps", "icon_waypoint_hacking" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse" + label, 0, "friendly", &"mp_ingame_only/obj_activating_caps", "icon_waypoint_hacking" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defuse" + label, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb_defuse" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_plant" + label, 0, "enemy", &"mp_ingame_only/obj_plant_caps", "icon_waypoint_bomb" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x2f63232b, Offset: 0x44fd
// Size: 0x17
function init_ai_zone_objective( zone )
{
    init_zone_objective( zone, 1 );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xe3a78c52, Offset: 0x451c
// Size: 0x116
function function_2d857d52b8ee3538( zone )
{
    start_zone_objective( zone );
    objective = level.objectives[ zone.objectives[ 0 ] ];
    
    if ( objective.lockonactivate )
    {
        objective gameobjects::allowuse( "none" );
    }
    
    if ( isdefined( objective.aiobjectives ) )
    {
        foreach ( obj in objective.aiobjectives )
        {
            obj gameobjects::setvisibleteam( "any" );
        }
        
        objective gameobjects::setobjectivestatusicons( "icon_waypoint_locked" );
    }
    
    objective gameobjects::enableobject();
    objective gameobjects::setownerteam( game[ "defenders" ] );
    objective gameobjects::allowuse( "enemy" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9175fe90, Offset: 0x463a
// Size: 0xc
function function_3593de6105cb07b5( objective )
{
    
}

// Namespace wm_objectives
// Params 2
// Checksum 0xe44d0b18, Offset: 0x464e
// Size: 0x639
function init_zone_objective( zone, ailockdown )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetname = objective.targetname;
    function_f58f6b815662a793( objective );
    level.flagcapturetime = dvars::dvarfloatvalue( "flagCaptureTime", 30, 0, 120 );
    
    if ( isdefined( zone.objective.params[ "flagCaptureTime" ] ) )
    {
        level.flagcapturetime = zone.objective.params[ "flagCaptureTime" ];
    }
    
    level.zonecapturetime = level.flagcapturetime;
    
    if ( getdvarint( @"scr_wm_debugmode", 0 ) )
    {
        level.flagcapturetime = 5;
        level.zonecapturetime = level.flagcapturetime;
    }
    
    if ( isarray( targetname ) )
    {
        triggers = [];
        
        foreach ( name in targetname )
        {
            triggers[ triggers.size ] = getent( name, #targetname );
        }
    }
    else
    {
        triggers = getentarray( targetname, #targetname );
    }
    
    if ( !isdefined( triggers ) )
    {
        return;
    }
    
    zone.capture_zones = [];
    
    foreach ( i, trigger in triggers )
    {
        objectivekey = objectivekeys[ i ];
        trigger.objectivekey = objectivekey;
        trigger.script_label = objectivekey;
        capture_zone = obj_zonecapture::setupobjective( trigger );
        capture_zone.iconname = objectivekey;
        level.objectives[ objectivekey ] = capture_zone;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        capture_zone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", zone.objidnum, game[ "defenders" ] );
        capture_zone gameobjects::setvisibleteam( "none" );
        
        if ( !isdefined( level.var_f81a10f3146550e9 ) )
        {
            level.var_f81a10f3146550e9 = [];
        }
        
        level.var_f81a10f3146550e9[ level.var_f81a10f3146550e9.size ] = capture_zone;
        zone.capture_zones[ zone.capture_zones.size ] = capture_zone;
    }
    
    if ( ailockdown )
    {
        structs = utility::getstructarray( "wm_boss_spawn", "targetname" );
        
        foreach ( capture_zone in zone.capture_zones )
        {
            capture_zone gameobjects::setobjectivestatusicons( "icon_waypoint_locked" + objectivekeys[ 0 ] );
            capture_zone.lockonactivate = 1;
            capture_zone.aiobjectives = [];
        }
        
        gamelogic_mp::setwaypointiconinfo( "icon_waypoint_locked" + objectivekeys[ 0 ], 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0 );
        ai_mp_controller::function_37d99639a8500c2f( 1 );
        objectivekeys = [ "_h", "_i" ];
        
        foreach ( i, struct in structs )
        {
            gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + objectivekeys[ i ], 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg" );
            gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + objectivekeys[ i ], 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg" );
            marker = function_bc373fa487f1a3e2( struct, objective, objectivekeys[ i ] );
            
            foreach ( capture_zone in zone.capture_zones )
            {
                capture_zone.aiobjectives[ capture_zone.aiobjectives.size ] = marker;
            }
        }
        
        while ( !level.objectives[ "_h" ].complete || !level.objectives[ "_i" ].complete )
        {
            waitframe();
        }
        
        foreach ( capture_zone in zone.capture_zones )
        {
            capture_zone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
            capture_zone gameobjects::allowuse( "any" );
        }
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0x4ed33c2, Offset: 0x4c8f
// Size: 0x1a9
function start_zone_objective( zone, ailockdown )
{
    function_ee17ba2f6cc82a83( zone );
    level.ontimelimitgraceperiod = getdvarint( @"hash_32868f1020ec5bcb", 9 );
    
    foreach ( capture_zone in zone.capture_zones )
    {
        capture_zone gameobjects::setusetime( level.flagcapturetime );
        capture_zone obj_zonecapture::activatezone( undefined, 1 );
        capture_zone.onuse = &wmzone_onuse;
        capture_zone.onbeginuse = &function_39bc8348386021a0;
        capture_zone.onenduse = &function_95759ebcf4f14e40;
        capture_zone gameobjects::setownerteam( game[ "defenders" ] );
        capture_zone.ignorestomp = !dvars::function_13909a5327c395b9( "zoneReversible", 0 );
        capture_zone.useratemultiplier = 1;
        capture_zone.var_2809cba8dafcf8cf = level.flagreinforcement;
        capture_zone.blockcapdisabled = 1;
        capture_zone thread obj_zonecapture::updatechevrons( game[ "defenders" ] );
        capture_zone gameobjects::enableobject();
        capture_zone gameobjects::setownerteam( game[ "defenders" ] );
        capture_zone gameobjects::allowuse( "enemy" );
        capture_zone.var_b0a668cb588348ad = &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS";
        level thread function_d0714e0e77c5d0fc( capture_zone );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xd1461fba, Offset: 0x4e40
// Size: 0x105
function function_d0714e0e77c5d0fc( capture_zone )
{
    level endon( #"end_zone_objective" );
    
    while ( true )
    {
        wait 5;
        
        if ( capture_zone.stalemate )
        {
            continue;
        }
        
        foreach ( struct in capture_zone.touchlist[ game[ "attackers" ] ] )
        {
            if ( gameobjects::function_e17a356e69f57699( struct.player ) )
            {
                struct.player.owner thread points::doscoreevent( #"hash_ab380575e645f59" );
                continue;
            }
            
            struct.player thread points::doscoreevent( #"hash_8b25c2c59b73eb46" );
        }
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x33ebc39f, Offset: 0x4f4d
// Size: 0x280
function end_zone_objective( zone )
{
    level notify( #"end_zone_objective" );
    level.ontimelimitgraceperiod = 5;
    
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        if ( gameobjects::function_e17a356e69f57699( player ) )
        {
            player.owner thread points::doscoreevent( #"hash_1e81f3e4398c19dd" );
            continue;
        }
        
        player thread points::doscoreevent( #"hash_c2a81e1bb7ec57c2" );
    }
    
    chevrons = getentitylessscriptablearray( "scriptable_hardpoint_chevron", #classname );
    
    foreach ( chevron in chevrons )
    {
        if ( chevron.script_noteworthy == zone.targetname )
        {
            for ( i = 0; i < 1 ; i++ )
            {
                chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), "off" );
            }
        }
    }
    
    objective = zone.objective;
    
    if ( isdefined( objective.params[ "leaderDialogAttackers" ] ) )
    {
        attackersleaderdialog = objective.params[ "leaderDialogAttackers" ];
        utility::delaythread( 2, &dialog::leaderdialog, attackersleaderdialog, game[ "attackers" ] );
    }
    
    if ( isdefined( objective.params[ "leaderDialogDefenders" ] ) )
    {
        defendersleaderdialog = objective.params[ "leaderDialogDefenders" ];
        utility::delaythread( 2, &dialog::leaderdialog, defendersleaderdialog, game[ "defenders" ] );
        return;
    }
    
    utility::delaythread( 2, &dialog::leaderdialog, "defenders_lost_zone", game[ "defenders" ] );
}

// Namespace wm_objectives
// Params 4
// Checksum 0x9aaa42ba, Offset: 0x51d5
// Size: 0x4f
function function_bc5633dd87083184( time, post_time, dialog, team )
{
    level.var_40e874c343c0b751 = 1;
    wait time;
    dialog::leaderdialog( dialog, game[ team ] );
    wait post_time;
    level.var_40e874c343c0b751 = 0;
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf67057cf, Offset: 0x522c
// Size: 0x3b4
function init_aa_objective( zone )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetname = objective.targetname;
    function_f58f6b815662a793( objective );
    structs = utility::getstructarray( targetname, "targetname" );
    
    while ( !isdefined( level.streakglobals ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        waitframe();
    }
    
    level.aa_turrets = [];
    
    foreach ( i, struct in structs )
    {
        objectivekey = objectivekeys[ i ];
        
        if ( !isdefined( objectivekey ) )
        {
            objectivekey = "_a";
        }
        
        turret = spawnturret( "misc_turret", struct.origin, level.missilesettings[ "missile_turret" ].weaponinfo );
        turret.turrettype = "missile_turret";
        turret missile_turret::missileturret_setturretmodel( "placed" );
        turret maketurretinoperable();
        turret setleftarc( 180 );
        turret setrightarc( 180 );
        turret setbottomarc( 50 );
        turret settoparc( 120 );
        turret setconvergencetime( 0.2, "pitch" );
        turret setconvergencetime( 0.2, "yaw" );
        turret setconvergenceheightpercent( 0.65 );
        turret setdefaultdroppitch( -89 );
        turret setdefaultdroppitch( 0 );
        turret setautorotationdelay( 0.2 );
        turret.colmodel = spawn( "script_model", turret.origin );
        turret.colmodel.team = turret.team;
        turret.colmodel.owner = turret.owner;
        turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
        turret.colmodel dontinterpolate();
        turret.shootingpositions = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
        turret setturretmodechangewait( 1 );
        turret setmode( "sentryManual" );
        turret.health = 2000;
        turret.maxhealth = 2000;
        level thread missileturret_watchdamage( turret );
        level thread missileturret_watchdeath( turret );
        marker = struct function_4ee235f8a5ab751f( objectivekey, &"mp_ingame_only/obj_hvt_caps", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite" );
        level.objectives[ objectivekey ] = marker;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        turret.marker = marker;
        level.aa_turrets[ level.aa_turrets.size ] = turret;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x6565883a, Offset: 0x55e8
// Size: 0x15
function function_2da58517892c7e21( zone )
{
    function_ee17ba2f6cc82a83( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x53d4577c, Offset: 0x5605
// Size: 0xc
function function_f5e899b3f4b5ece6( zone )
{
    
}

// Namespace wm_objectives
// Params 1
// Checksum 0xbc4299b, Offset: 0x5619
// Size: 0x3a3
function function_a3a180efcc2d036a( zone )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetname = objective.targetname;
    function_f58f6b815662a793( objective );
    nodes = getvehiclenodearray( targetname, #targetname );
    nodes[ nodes.size ] = getvehiclenode( "wm_stop_2", #script_noteworthy );
    
    foreach ( i, node in nodes )
    {
        objectivekey = objectivekeys[ i ];
        
        if ( !isdefined( objectivekey ) )
        {
            continue;
        }
        
        if ( node.script_noteworthy == "wm_stop_2" )
        {
            level.var_218e63fbb6cefed1 = spawnstruct();
            level.var_218e63fbb6cefed1.node = node;
            level.var_218e63fbb6cefed1.objectivekey = objectivekey;
            level.var_218e63fbb6cefed1.marker = node function_4ee235f8a5ab751f( objectivekey, &"mp_ingame_only/obj_halt_caps", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game[ "attackers" ] );
            level.objectives[ objectivekey ] = level.var_218e63fbb6cefed1.marker;
            level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
            continue;
        }
        
        spawndata = spawnstruct();
        spawndata.cantimeout = 0;
        spawndata.spawnmethod = "place_at_position_unsafe";
        spawndata.origin = node.origin;
        spawndata.angles = node.angles;
        spawndata.team = game[ "attackers" ];
        spawndata.node = node;
        spawndata.objectivekey = objectivekey;
        vehicleref = "light_tank";
        
        if ( isdefined( objective.params[ "vehicleRef" ] ) )
        {
            vehicleref = objective.params[ "vehicleRef" ];
        }
        
        if ( game_utility::getmapname() != "mp_jup_airstrip" )
        {
            spawndata.spawnmethod = "airdrop_at_position_unsafe";
        }
        
        if ( spawndata.spawnmethod == "airdrop_at_position_unsafe" )
        {
            spawndata.vehicleref = vehicleref;
            level.var_94c609d9e3ddd1 = spawndata;
        }
        else
        {
            vehicle = vehicle::spawn( vehicleref, spawndata );
            level.escortvehicles[ level.escortvehicles.size ] = vehicle;
        }
        
        marker = spawndata function_4ee235f8a5ab751f( objectivekey, &"mp_ingame_only/obj_halt_caps", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game[ "attackers" ] );
        level.objectives[ objectivekey ] = marker;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf248a4f0, Offset: 0x59c4
// Size: 0x26e
function function_b9156980bb4c0338( zone )
{
    level.ontimelimitgraceperiod = getdvarint( @"hash_675c1f2b3e4bf7f9", 14 );
    
    if ( isdefined( level.var_94c609d9e3ddd1 ) )
    {
        vehicle = vehicle::spawn( level.var_94c609d9e3ddd1.vehicleref, level.var_94c609d9e3ddd1 );
        level.escortvehicles[ level.escortvehicles.size ] = vehicle;
    }
    
    function_ee17ba2f6cc82a83( zone );
    objective = zone.objective;
    
    if ( isdefined( level.hostage_vehicle ) )
    {
        node = level.var_218e63fbb6cefed1.node;
        spawndata = spawnstruct();
        spawndata.cantimeout = 0;
        spawndata.spawnmethod = "place_at_position_unsafe";
        spawndata.origin = node.origin;
        spawndata.angles = node.angles;
        spawndata.team = game[ "defenders" ];
        endnode = getvehiclenode( "wm_stop_3", #script_noteworthy );
        level thread function_9136fc5c3f0d9275( objective, level.hostage_vehicle, level.var_218e63fbb6cefed1.objectivekey, spawndata, level.var_218e63fbb6cefed1.node, level.var_218e63fbb6cefed1.marker, endnode );
    }
    
    foreach ( vehicle in level.escortvehicles )
    {
        level thread function_9136fc5c3f0d9275( level.zone.objective, vehicle, vehicle.spawndata.objectivekey, vehicle.spawndata, vehicle.spawndata.node, level.objectives[ vehicle.spawndata.objectivekey ] );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xfcdbcfa9, Offset: 0x5c3a
// Size: 0x1e3
function function_2f7a2480c15194f9( zone )
{
    foreach ( player in level.players )
    {
        player.var_5ca1e62c2ae57e4f = undefined;
        player objidpoolmanager::function_101225acbc89c1c1( 0 );
    }
    
    level.ontimelimitgraceperiod = 5;
    objective = zone.objective;
    
    if ( isdefined( objective.params[ "leaderDialogAttackers" ] ) )
    {
        attackersleaderdialog = objective.params[ "leaderDialogAttackers" ];
        utility::delaythread( 2, &dialog::leaderdialog, attackersleaderdialog, game[ "attackers" ] );
    }
    
    if ( isdefined( objective.params[ "leaderDialogDefenders" ] ) )
    {
        defendersleaderdialog = objective.params[ "leaderDialogDefenders" ];
        utility::delaythread( 2, &dialog::leaderdialog, defendersleaderdialog, game[ "defenders" ] );
    }
    
    wm_tank_barrier_entrance = getentarray( "wm_tank_barrier_entrance", #script_noteworthy );
    
    foreach ( ent in wm_tank_barrier_entrance )
    {
        ent hide();
    }
    
    points::function_40522c040a4e7b1( game[ "attackers" ], #"hash_18c44b230263da2c" );
}

// Namespace wm_objectives
// Params 7
// Checksum 0x52f76bdc, Offset: 0x5e25
// Size: 0x4b6
function function_9136fc5c3f0d9275( objective, vehicle, objectivekey, spawndata, node, marker, endnode )
{
    vehicle.marker = marker;
    
    if ( 11 != objective.objectivetype )
    {
        vehicle_interact::allow_use( vehicle, 0 );
    }
    
    setdvar( @"hash_fb517a5a3d736fa0", 1 );
    
    if ( isdefined( objective.params[ "tankNearbyRange" ] ) )
    {
        vehicle.tanknearbyrange = objective.params[ "tankNearbyRange" ];
    }
    
    if ( objective.params[ "canStopByDefenders" ] )
    {
        vehicle.canstopbydefenders = 1;
    }
    
    if ( objective.params[ "canDamageAndRepair" ] )
    {
        vehicle.demigodmode = 1;
        vehicle.var_ebb146a8dd122f11 = 0;
    }
    else
    {
        vehicle.godmode = 1;
    }
    
    vehicle.var_91eefe62b94cf0c6 = 1;
    vehicle vehicleshowonminimap( 0 );
    vehicle.objectivekey = objectivekey;
    vehicle.usep2p = istrue( objective.params[ "useP2P" ] );
    
    if ( !isdefined( endnode ) )
    {
        pathnodes = [];
        
        for ( nextnode = node; isdefined( nextnode ) ; nextnode = undefined )
        {
            pathnodes[ pathnodes.size ] = nextnode;
            
            if ( isdefined( nextnode.target ) )
            {
                nextnode = getvehiclenode( nextnode.target, #targetname );
                continue;
            }
        }
        
        endnode = pathnodes[ pathnodes.size - 1 ];
        vehicle.pathnodes = pathnodes;
        
        if ( !vehicle.usep2p )
        {
            vehicle attachpath( vehicle.pathnodes[ 0 ] );
            vehicle startpath();
        }
        else
        {
            vehicle addcomponent( "p2p" );
            vehicle thread function_3017d7b6cc961f19();
        }
        
        vehicle.stageid = 0;
        vehicle.progress = 0;
        totaldistance = 0;
        vehicle.pathnodes[ 0 ].var_7d71d1774b14f738 = 0;
        
        for ( i = 0; i < vehicle.pathnodes.size - 1 ; i++ )
        {
            currentnode = vehicle.pathnodes[ i ];
            nextnode = vehicle.pathnodes[ i + 1 ];
            totaldistance += distance2d( currentnode.origin, nextnode.origin );
            nextnode.var_7d71d1774b14f738 = totaldistance;
        }
        
        foreach ( pathnode in vehicle.pathnodes )
        {
            pathnode.progress = pathnode.var_7d71d1774b14f738 / totaldistance;
        }
    }
    
    if ( isdefined( level.var_5e324c0dcb36093e ) )
    {
        vehicle.checkpoints = [[ level.var_5e324c0dcb36093e ]]( vehicle );
    }
    
    level notify( #"escort_path_set", vehicle );
    
    if ( level.var_a3e961c27815d334 )
    {
        vehicle thread function_9df7afdaeb7a54c0( endnode, "friendly", 6 );
        vehicle thread function_9df7afdaeb7a54c0( endnode, "enemy", 6 );
    }
    
    if ( isdefined( objective.params[ "vehicleRef" ] ) )
    {
        vehobjzoffset = objective.params[ "vehicleRef.vehObjZOffset" ];
    }
    
    objidpoolmanager::update_objective_onentity( marker.objidnum, vehicle );
    objidpoolmanager::update_objective_setzoffset( marker.objidnum, vehobjzoffset ?? 180 );
    
    if ( objective.params[ "progressByActualDistance" ] )
    {
        if ( 11 != objective.objectivetype )
        {
            level thread function_d4c95c8be5a23d13( vehicle, marker.objidnum );
        }
        else
        {
            level thread function_e71440dd39733479( vehicle, marker.objidnum );
        }
    }
    else
    {
        level thread function_7f03d7c4116ec75d( vehicle, marker.objidnum, endnode );
    }
    
    if ( 11 == objective.objectivetype )
    {
        vehicle thread function_3575b72028a0eb8c();
    }
    else
    {
        vehicle thread function_c6fe6f8b58115825();
    }
    
    level thread tank_stop_and_go( vehicle, marker.objidnum );
}

// Namespace wm_objectives
// Params 0
// Checksum 0xb1c4bda5, Offset: 0x62e3
// Size: 0x28f
function function_c6fe6f8b58115825()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    thread function_10abacb356132c37();
    tank = self;
    var_2df0b027940940e8 = 150;
    var_df5304c7dd403e39 = 240;
    itemcontents = physics_createcontents( [ "physicscontents_item" ] );
    radiusvector = ( var_2df0b027940940e8, var_2df0b027940940e8, 80 );
    var_8f981d2be23d246e = ( var_df5304c7dd403e39, var_df5304c7dd403e39, 80 );
    var_f13dc378ca06868b = [ tank ];
    
    while ( true )
    {
        pointtocheck = tank.origin + rotatevector( ( 30, 0, -30 ), tank.angles );
        aabbmin = pointtocheck - radiusvector;
        aabbmax = pointtocheck + radiusvector;
        
        /#
            level thread utility::draw_line_for_time( aabbmin, aabbmax, 1, 0, 0, 2 );
            level thread utility::draw_circle( pointtocheck, var_2df0b027940940e8, ( 1, 0, 0 ), 1, 0, 2 );
        #/
        
        var_ec87ecb47eabaa0d = pointtocheck - var_8f981d2be23d246e;
        var_adba845d607955cf = pointtocheck + var_8f981d2be23d246e;
        
        /#
            level thread utility::draw_line_for_time( var_ec87ecb47eabaa0d, var_adba845d607955cf, 1, 0, 0, 2 );
            level thread utility::draw_circle( pointtocheck, var_df5304c7dd403e39, ( 1, 0, 0 ), 1, 0, 2 );
        #/
        
        var_a6d0b791e0ea9645 = physics_aabbbroadphasequery( aabbmin, aabbmax, itemcontents, var_f13dc378ca06868b );
        var_5c31a0820e37f412 = physics_aabbbroadphasequery( var_ec87ecb47eabaa0d, var_adba845d607955cf, itemcontents, var_f13dc378ca06868b );
        
        foreach ( ent in var_5c31a0820e37f412 )
        {
            if ( ent.cratetype == "loadout_drop" )
            {
                ent airdrop::destroycrate( 0 );
            }
        }
        
        foreach ( ent in var_a6d0b791e0ea9645 )
        {
            if ( ent.equipmentref == "equip_tac_cover" )
            {
                ent tactical_cover::tac_cover_destroy( undefined, 0 );
            }
        }
        
        waitframe();
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0xba5c2b8a, Offset: 0x657a
// Size: 0xba
function function_10abacb356132c37()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    temppos = self.origin;
    var_42f095c32232b762 = 0;
    
    while ( true )
    {
        wait 0.25;
        
        if ( distancesquared( self.origin, temppos ) < 16 && self.shouldwatchstuck )
        {
            var_42f095c32232b762++;
        }
        else if ( distancesquared( self.origin, temppos ) > 16 )
        {
            var_42f095c32232b762 = 0;
        }
        
        if ( var_42f095c32232b762 >= 2 )
        {
            self startpath( self.pathnodes[ self.var_63ba5ed26f65fcf2 - 1 ] );
            var_42f095c32232b762 = 0;
        }
        
        temppos = self.origin;
    }
}

// Namespace wm_objectives
// Params 3
// Checksum 0x403f9973, Offset: 0x663c
// Size: 0x121
function function_9df7afdaeb7a54c0( node, teamrelative, backgroundtype )
{
    level endon( #"game_ended" );
    waypoint_height_offset = 20;
    position = node.origin + ( 0, 0, waypoint_height_offset );
    waypointid = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_add_objective( waypointid, "active", position, "icon_waypoint_rescue_extract", "icon_regular" );
    objective_setplayintro( waypointid, 1 );
    objective_setbackground( waypointid, backgroundtype );
    objective_setfadedisabled( waypointid, 0 );
    objective_setshowoncompass( waypointid, 1 );
    objective_setshowdistance( waypointid, 1 );
    objective_setownerteam( waypointid, game[ "attackers" ] );
    
    if ( teamrelative == "friendly" )
    {
        objective_setfriendlylabel( waypointid, &"mp_ingame_only/obj_tank_goal_caps" );
        objidpoolmanager::objective_mask_showtoplayerteam( waypointid, self );
    }
    else
    {
        objective_setenemylabel( waypointid, &"mp_ingame_only/obj_tank_goal_caps" );
        objidpoolmanager::objective_mask_showtoenemyteam( waypointid, self );
    }
    
    flags::gameflagwait( level.zone.name + "_objective_end" );
    objidpoolmanager::returnobjectiveid( waypointid );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x3d8c6762, Offset: 0x6765
// Size: 0x11c
function init_ai_boss_objective( zone )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetname = objective.targetname;
    function_f58f6b815662a793( objective );
    structs = utility::getstructarray( targetname, "targetname" );
    
    foreach ( i, struct in structs )
    {
        objectivekey = objectivekeys[ i ];
        function_bc373fa487f1a3e2( struct, objective, objectivekey );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf59038f2, Offset: 0x6889
// Size: 0x15
function function_cf056bf52d8c245b( zone )
{
    function_ee17ba2f6cc82a83( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9170f56, Offset: 0x68a6
// Size: 0xc
function function_e24c8723d2d480c2( zone )
{
    
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9040d4ff, Offset: 0x68ba
// Size: 0x3a5
function function_5edc8c37e92cd75f( zone )
{
    objective = zone.objective;
    level.var_dc5319508ce3eabe = &function_cc663c0d784ce9c0;
    level.var_7af19f06db8f07ab = "offhand_2h_c4_prop_mp";
    namespace_f3c239118aea59ac::function_aca3937c689bb737();
    scriptable::scriptable_addusedcallbackbypart( "usable_left", &namespace_f3c239118aea59ac::function_b4bae45cc0e61ecb );
    scriptable::scriptable_addusedcallbackbypart( "usable_right", &namespace_f3c239118aea59ac::function_b4bae45cc0e61ecb );
    scriptable::scriptable_addusedcallbackbypart( "usable_left_defuse", &function_58f75dc08f7cae29 );
    scriptable::scriptable_addusedcallbackbypart( "usable_right_defuse", &function_58f75dc08f7cae29 );
    level.aa_sites = [];
    zone.turrets = [];
    
    foreach ( struct in utility::getstructarray( "samsite_loc", "targetname" ) )
    {
        turret = sam_spawn_wm( struct );
        turret.missile1 setcandamage( 0 );
        turret.missile2 setcandamage( 0 );
        turret.missile3 setcandamage( 0 );
        level.aa_sites[ level.aa_sites.size ] = turret;
        turret setscriptablepartstate( "usable_left", "usable" );
        turret setscriptablepartstate( "usable_front", "usable" );
        turret setscriptablepartstate( "usable_right", "usable" );
        turret setscriptablepartstate( "usable_left_defuse", "usable" );
        turret setscriptablepartstate( "usable_front_defuse", "usable" );
        turret setscriptablepartstate( "usable_right_defuse", "usable" );
        turret setscriptablepartstate( "usable_front", "unusable" );
        turret function_8c5aeba61f1c9cf1( "plant" );
        zone.turrets[ zone.turrets.size ] = turret;
    }
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    function_f58f6b815662a793( objective );
    callback::add( #"player_spawned", &function_361f4ac007b330b5 );
    
    foreach ( i, sam_site in level.aa_sites )
    {
        objectivekey = objectivekeys[ i ];
        marker = sam_site function_4ee235f8a5ab751f( objectivekey, &"mp_ingame_only/obj_plant_caps", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "hud_icon_vehicle_samsite", undefined, ( 0, 0, 300 ) );
        level.objectives[ objectivekey ] = marker;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        level.objectives[ objectivekey ].turret = sam_site;
        level.objectives[ objectivekey ].turret.objectivekey = objectivekey;
        level.objectives[ objectivekey ] thread function_be6a1751ce410868();
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xe12e5fa2, Offset: 0x6c67
// Size: 0x8e
function function_4308862cbf16f689( zone )
{
    foreach ( sam_site in level.aa_sites )
    {
        sam_site outline_sam_site();
    }
    
    function_ee17ba2f6cc82a83( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x1af19b56, Offset: 0x6cfd
// Size: 0xb1
function function_28fa8ad4d276e140( zone )
{
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        player thread points::doscoreevent( #"hash_f971655f11159a88" );
    }
    
    utility::delaythread( 2, &dialog::leaderdialog, "defenders_lost_sam_site", game[ "defenders" ] );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xdf181c87, Offset: 0x6db6
// Size: 0xae5
function init_hostage_objective( zone )
{
    objective = zone.objective;
    hostagetriggers = getentarray( objective.targetname, #targetname );
    objectivekeys = objective.objectivekey;
    hostagecount = 0;
    level.numhostages = hostagetriggers.size;
    level.returnon = getdvarint( @"scr_rescue_return", 0 );
    level.var_e75dbd0de408eeb0 = getdvarint( @"scr_rescue_version", 0 );
    level.var_fbd77ccb47f2a5f3 = getdvarint( @"hash_20103d7a5a56aac8", 20 );
    level.iconrecover = "rescue_recover";
    level.iconescort = "rescue_escort";
    level.iconreturn = "rescue_escort_return";
    level.iconextract = "rescue_taking_extract";
    level.icondefendextract = "rescue_defend_extract";
    level.iconcaptureextract = "rescue_capture_extract";
    level.showenemycarrier = 0;
    level.var_fc687cb1213eb13e = 1;
    rescue::initanims();
    rescue::function_18096511be9218b7();
    function_f58f6b815662a793( objective );
    level.extractzones = [];
    
    foreach ( i, trigger in hostagetriggers )
    {
        if ( hostagecount >= level.numhostages )
        {
            break;
        }
        
        objectivekey = objectivekeys[ i ];
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ] setmodel( "body_civ_me_male_1_1" );
        visuals[ 0 ] setasgametypeobjective();
        hostage = gameobjects::createcarryobject( game[ "defenders" ], trigger, visuals, ( 0, 0, 16 ), undefined, 1 );
        hostage.iconname = objectivekey;
        hostage.objectivekey = objectivekey;
        level.objectives[ objectivekey ] = hostage;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        head = spawn( "script_model", visuals[ 0 ].origin );
        head setmodel( "head_hostage_hood_01" );
        head linkto( visuals[ 0 ], "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
        hostage.head = head;
        hostage.body = visuals[ 0 ];
        hostage.body solid();
        hostage.head solid();
        tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
        traceend = visuals[ 0 ].origin + ( 0, 0, -100 );
        contentoverride = trace::create_contents( 1, 1, 1, 1, 1, 1, 1 );
        ignoreents = [ visuals[ 0 ], trigger ];
        trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
        
        if ( trace[ "fraction" ] < 1 )
        {
            visuals[ 0 ].origin = trace[ "position" ] + ( 0, 0, 2 );
        }
        
        hostage.body scriptmodelplayanimdeltamotion( "iw9_mp_hostage_ground_idle" );
        hostage gameobjects::requestid( 1, 1 );
        hostage gameobjects::allowuse( "enemy" );
        hostage.cancontestclaim = 0;
        hostage.stalemate = 0;
        hostage.wasstalemate = 1;
        hostage.currprogress = 0;
        hostage.usetime = 0;
        hostage.userate = 1;
        hostage.id = "care_package";
        hostage.exclusiveuse = 0;
        hostage.skiptouching = 1;
        hostage.skipminimapids = 1;
        hostage.curorigin = hostage.body.origin;
        hostage.offset3d = ( 0, 0, 30 );
        hostage.trigger sethintstring( &"mp/hold_to_escort_hostage" );
        hostage.trigger setusepriority( -4 );
        hostage gameobjects::setusetime( 0 );
        hostage gameobjects::setwaitweaponchangeonuse( 0 );
        hostage.allowweapons = 1;
        hostage.onpickup = &rescue::hostage_onpickup;
        hostage.ondrop = &hostage_ondrop;
        hostage.onreset = &rescue::hostage_onreset;
        hostage.pickupchecks = [ &rescue::function_f96679a37c19d78a, &rescue::function_225379ff5d791fb3, &rescue::function_401180d3ce4bfee2, &rescue::function_b21669fa1ec0fa85, &rescue::function_31bb20f046e25088 ];
        hostage.onpickupfailed = &rescue::hostage_onpickupfailed;
        hostage.var_33f32d59e9dbe80b = &rescue::function_f31aee3864b84c05;
        hostage.carryobjectasset = "hostage_rescue";
        
        if ( getdvarint( @"hash_c44109000ed1922d" ) != 0 )
        {
            hostage gameobjects::function_a8c99f0b8d97b750( [ visuals[ 0 ], hostage.head ], undefined, undefined, 32, 180, undefined, 1 );
        }
        
        hostage.objidpingfriendly = 0;
        hostage.objidpingenemy = 0;
        hostage.objpingdelay = 0.05;
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        hostage.var_d4cb0549b5d62bea = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", hostage.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        hostage gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, game[ "defenders" ] );
        hostage.objidpingfriendly = 0;
        hostage.objidpingenemy = 0;
        hostage.objpingdelay = 0.05;
        pingobjid = objidpoolmanager::requestobjectiveid( 99 );
        hostage.var_96cd360a9646d989 = pingobjid;
        objidpoolmanager::objective_add_objective( pingobjid, "done", hostage.origin );
        objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        hostage gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, game[ "attackers" ] );
        hostage thread rescue::function_587451482c30a16b();
        
        if ( !isdefined( level.hostages ) )
        {
            level.hostages = [];
        }
        
        level.hostages[ hostage.objidnum ] = hostage;
        hostage gameobjects::setvisibleteam( "none" );
        hostage gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture" );
        
        if ( level.returnon )
        {
            rescue::function_a980c2c1ebd84bfd( trigger, hostage );
        }
        
        hostagecount++;
    }
    
    hostage_goals = utility::getstructarray( "wm_hostage_vehicle_spawn_loc", "targetname" );
    vehicles = [];
    
    foreach ( struct in hostage_goals )
    {
        spawndata = spawnstruct();
        spawndata.origin = struct.origin;
        spawndata.angles = struct.angles;
        vehicle = vehicle::spawn( "veh9_jltv", spawndata );
        vehicle_interact::allow_use( vehicle, 0 );
        vehicle vehicleshowonminimap( 0 );
        vehicle setcandamage( 0 );
        vehicles[ vehicles.size ] = vehicle;
        level.escortvehicles[ level.escortvehicles.size ] = vehicle;
        dropoff_marker = vehicle function_4ee235f8a5ab751f( "", &"mp_ingame_only/obj_block_exfil_caps", &"mp_ingame_only/obj_dropoff_caps", "icon_waypoint_dom_a" );
        objidpoolmanager::update_objective_ownerteam( dropoff_marker.objidnum, game[ "attackers" ] );
        objidpoolmanager::objective_playermask_showtoall( dropoff_marker.objidnum );
        objidpoolmanager::update_objective_onentity( dropoff_marker.objidnum, vehicles[ 0 ] );
        level.var_523987179ec00ac0 = dropoff_marker;
    }
    
    level.hostage_vehicle = vehicles[ 0 ];
    hostage_seats = utility::getstructarray( "wm_hostage_dropoff_loc", "targetname" );
    hostage_dropoffs = [];
    
    foreach ( struct in hostage_seats )
    {
        forward = vectornormalize( anglestoforward( vehicles[ 0 ].angles ) );
        hostage = spawn( "script_model", struct.origin - ( 0, 0, 3 ) + 16 * forward );
        hostage setmodel( "body_civ_me_male_1_1" );
        hostage.angles = struct.angles;
        hostage linkto( vehicles[ 0 ] );
        head = spawn( "script_model", visuals[ 0 ].origin );
        head setmodel( "head_hostage_hood_01" );
        head linkto( hostage, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
        hostage.head = head;
        hostage_dropoffs[ hostage_dropoffs.size ] = hostage;
        hostage scriptmodelplayanimdeltamotion( "cap_civ_prty_anxious_seat02" );
        hostage.head hide();
        hostage hide();
    }
    
    wm_hostage_dropoff_trigger = getent( "wm_hostage_dropoff_trigger", #targetname );
    wm_hostage_dropoff_trigger enablelinkto();
    wm_hostage_dropoff_trigger linkto( vehicles[ 0 ] );
    wm_hostage_dropoff_trigger sethintstring( &"mp_ingame_only/wm_hostage_dropoff" );
    wm_hostage_dropoff_trigger thread function_b5478869ff8cf06d( hostage_dropoffs, vehicles, dropoff_marker );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x274ce1d0, Offset: 0x78a3
// Size: 0x15
function function_aca47c867b115134( zone )
{
    function_ee17ba2f6cc82a83( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x226fd7a0, Offset: 0x78c0
// Size: 0x53
function function_1c3a2b66d8e504c9( zone )
{
    wm_hostage_dropoff_trigger = getent( "wm_hostage_dropoff_trigger", #targetname );
    wm_hostage_dropoff_trigger delete();
    
    if ( isdefined( level.hostage_vehicle ) )
    {
        level.hostage_vehicle thread vehicle_move_forward_until( "wm_stop_2" );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xe67e7a7e, Offset: 0x791b
// Size: 0x352
function init_bomb_objective( zone )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    triggers = getentarray( objective.targetname, #targetname );
    objectivekeys = objective.objectivekey;
    function_f58f6b815662a793( objective );
    level.var_70fe84415eb002b1 = [];
    objective.bombzones = [];
    
    foreach ( i, trigger in triggers )
    {
        objectivekey = objectivekeys[ i ];
        trigger.objectivekey = objectivekeys[ i ];
        bombzone = obj_bombzone::setupobjective( trigger, 1, 1 );
        bombzone gameobjects::requestid( 1, 1 );
        bombzone.objectivekey = objectivekey;
        bombzone.onbeginuse = &onbeginuse;
        bombzone.onenduse = &onenduse;
        bombzone.onuse = &onuseplantobject;
        bombzone.iconname = objectivekey;
        bombzone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", bombzone.objidnum, game[ "defenders" ] );
        bombzone gameobjects::setvisibleteam( "any" );
        bombzone gameobjects::setownerteam( game[ "defenders" ] );
        bombzone gameobjects::allowuse( "enemy" );
        bombzone gameobjects::setusehinttext( &"mp/hold_to_defuse_explosives" );
        bombzone objidpoolmanager::objective_show_team_progress( bombzone.objidnum, game[ "attackers" ] );
        bombzone objidpoolmanager::objective_show_team_progress( bombzone.objidnum, game[ "defenders" ] );
        bombzone gameobjects::disableobject();
        bombzone gameobjects::allowuse( "none" );
        level.objectives[ objectivekey ] = bombzone;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        level.var_70fe84415eb002b1[ level.var_70fe84415eb002b1.size ] = bombzone;
        zone.bombzones[ objective.bombzones.size ] = bombzone;
    }
    
    ents2 = getentarray( "catwalk_bomb_lights", #targetname );
    
    foreach ( light in ents2 )
    {
        light thread lighting::blink_light( 0.5, 0.3, 0, 1, 0.75, 1 );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9eb1e78e, Offset: 0x7c75
// Size: 0xb4
function function_c18f0ffd531442cf( zone )
{
    function_ee17ba2f6cc82a83( zone );
    
    foreach ( objstr in zone.objectives )
    {
        bombzone = level.objectives[ objstr ];
        bombzone gameobjects::enableobject();
        bombzone gameobjects::allowuse( "enemy" );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x812564ca, Offset: 0x7d31
// Size: 0xb1
function function_4201da8177b4cd30( zone )
{
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        player thread points::doscoreevent( #"hash_57e238c776c8e030" );
    }
    
    utility::delaythread( 2, &dialog::leaderdialog, "defenders_lost_bomb_objective", game[ "defenders" ] );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9d05e2a9, Offset: 0x7dea
// Size: 0x1c6
function init_hack_objective( zone )
{
    obj_hackzone::function_b448a357cd3e4d33();
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    triggers = getentarray( objective.targetname, #targetname );
    objectivekeys = objective.objectivekey;
    function_f58f6b815662a793( objective );
    zone.hackzones = [];
    
    foreach ( i, trigger in triggers )
    {
        objectivekey = objectivekeys[ i ];
        trigger.objectivekey = objectivekeys[ i ];
        usingvisualhintstring = objective.params[ "usingVisualHintString" ];
        hackzone = obj_hackzone::setupobjective( trigger, i, 1, 1, usingvisualhintstring );
        hackzone gameobjects::setvisibleteam( "none" );
        hackzone gameobjects::allowuse( "none" );
        level.objectives[ objectivekey ] = hackzone;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        zone.hackzones[ zone.hackzones.size ] = hackzone;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9319a253, Offset: 0x7fb8
// Size: 0xea
function function_458ac1844c583106( zone )
{
    level.ontimelimitgraceperiod = getdvarint( @"hash_312c816d24ef8e64", 9 );
    
    foreach ( objstr in zone.objectives )
    {
        hackzone = level.objectives[ objstr ];
        hackzone.onbeginuse = &function_c2bebab6e908152;
        hackzone.onenduse = &function_acd533f53c7babf5;
        hackzone gameobjects::setvisibleteam( "any" );
        hackzone gameobjects::allowuse( "enemy" );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xa864b08f, Offset: 0x80aa
// Size: 0x184
function function_7573b4588fb87225( zone )
{
    level notify( #"hash_ceedb371bdc45f31" );
    objective = zone.objective;
    level.ontimelimitgraceperiod = 5;
    
    if ( isdefined( objective.params[ "leaderDialogAttackers" ] ) )
    {
        attackersleaderdialog = objective.params[ "leaderDialogAttackers" ];
        utility::delaythread( 2, &dialog::leaderdialog, attackersleaderdialog, game[ "attackers" ] );
    }
    
    if ( isdefined( objective.params[ "leaderDialogDefenders" ] ) )
    {
        defendersleaderdialog = objective.params[ "leaderDialogDefenders" ];
        utility::delaythread( 2, &dialog::leaderdialog, defendersleaderdialog, game[ "defenders" ] );
    }
    
    foreach ( objstr in zone.objectives )
    {
        hackzone = level.objectives[ objstr ];
        hackzone gameobjects::setvisibleteam( "none" );
        hackzone gameobjects::allowuse( "none" );
    }
    
    points::function_40522c040a4e7b1( game[ "attackers" ], #"hash_6540fe71b5eda3fb" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x44a99569, Offset: 0x8236
// Size: 0x60d
function init_capture_flag_objective( zone )
{
    level.flagmodel = "ctf_game_flag_east";
    level.flagbase = "ctf_game_flag_base";
    level.carryflag = "prop_ctf_game_flag_east";
    obj_captureflag::updategametypedvars();
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetnames = objective.targetname;
    function_f58f6b815662a793( objective );
    objectivekey = objectivekeys[ 0 ];
    flagpoints = [];
    
    if ( isarray( targetnames ) )
    {
        foreach ( targetname in targetnames )
        {
            if ( issubstr( targetname, "flag_begin" ) )
            {
                flagpoints = getentarray( targetname, #targetname );
                assert( flagpoints.size != 0, "<dev string:x24>" + targetname );
                continue;
            }
            
            if ( issubstr( targetname, "flag_end" ) )
            {
                flagzone = getent( targetname, #targetname );
                assert( isdefined( flagzone ), "<dev string:x24>" + targetname );
                continue;
            }
            
            if ( issubstr( targetname, "capture_zone" ) )
            {
                capturezone = getent( targetname, #targetname );
                assert( isdefined( capturezone ), "<dev string:x24>" + targetname );
                continue;
            }
            
            assertmsg( "<dev string:x49>" + targetname );
        }
    }
    else if ( issubstr( targetnames, "flag_begin" ) )
    {
        flagpoints = getentarray( targetnames, #targetname );
        assert( flagpoints.size != 0, "<dev string:x24>" + targetnames );
    }
    else if ( issubstr( targetnames, "flag_end" ) )
    {
        flagzone = getent( targetnames, #targetname );
        assert( flagzone != 0, "<dev string:x24>" + targetnames );
    }
    else if ( issubstr( targetname, "capture_zone" ) )
    {
        capturezone = getent( targetname, #targetname );
        assert( isdefined( capturezone ), "<dev string:x24>" + targetname );
    }
    else
    {
        assertmsg( "<dev string:x49>" + targetnames );
    }
    
    alltriggers = arraycombine( flagpoints, [ flagzone ] );
    alltriggers[ alltriggers.size ] = capturezone;
    
    foreach ( i, trigger in alltriggers )
    {
        trigger.objectivekey = objectivekeys[ i ];
        trigger.script_label = objectivekeys[ i ];
    }
    
    zone.captureflags = obj_captureflag::function_a646823403efa442( flagpoints );
    zone.flagzone = obj_captureflag::createflagzone( flagzone );
    zone.flagcheckpoints = utility::getstructarray( "flag_checkpoint", "targetname" );
    index = 0;
    
    foreach ( captureflag in zone.captureflags )
    {
        objectivekey = objectivekeys[ index ];
        level.objectives[ objectivekey ] = captureflag;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        index++;
    }
    
    objectivekey = objectivekeys[ index ];
    level.objectives[ objectivekey ] = zone.flagzone;
    level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
    index++;
    level.zonecapturetime = level.var_d270257bdeebcb9;
    objectivekey = objectivekeys[ index ];
    capturezone.objectivekey = objectivekey;
    capturezone.script_label = objectivekey;
    var_842eed1a6764560d = obj_zonecapture::setupobjective( capturezone );
    var_842eed1a6764560d obj_zonecapture::activatezone( undefined, 1 );
    var_842eed1a6764560d.iconname = objectivekey;
    var_842eed1a6764560d gameobjects::setusetime( level.zonecapturetime );
    var_842eed1a6764560d.onuse = &wmzone_onuse;
    var_842eed1a6764560d.onbeginuse = &function_39bc8348386021a0;
    var_842eed1a6764560d.onenduse = &function_95759ebcf4f14e40;
    var_842eed1a6764560d.ignorestomp = !dvars::function_13909a5327c395b9( "zoneReversible", 0 );
    var_842eed1a6764560d.useratemultiplier = 1;
    var_842eed1a6764560d.var_2809cba8dafcf8cf = level.flagreinforcement;
    var_842eed1a6764560d.blockcapdisabled = 1;
    var_842eed1a6764560d gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", zone.objidnum, game[ "attackers" ] );
    var_842eed1a6764560d gameobjects::setvisibleteam( "none" );
    var_842eed1a6764560d.var_b0a668cb588348ad = &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS";
    zone.flag_capture_zone = var_842eed1a6764560d;
    level.objectives[ objectivekey ] = var_842eed1a6764560d;
    level.objectives[ objectivekey ].objectivetype = 1;
    zone.completeflagcount = 0;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x82452c5a, Offset: 0x884b
// Size: 0x7c
function function_dd26f0e35dd0e6b6( zone )
{
    level.objectivescaler = 1;
    obj_captureflag::function_c4c6124c369e4564();
    flagzone = level.zone.flagzone;
    flagzone gameobjects::allowuse( "friendly" );
    flagzone gameobjects::setvisibleteam( "none" );
    level.zonecapturetime = level.var_d270257bdeebcb9;
    zone.currentphase = "capture_flag";
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf1eec0ac, Offset: 0x88cf
// Size: 0x16
function function_5643296f5aa036e5( zone )
{
    level.objectivescaler = undefined;
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf9667a62, Offset: 0x88ed
// Size: 0x2d6
function init_hack_bomb_objective( zone )
{
    obj_hackzone::function_b448a357cd3e4d33();
    objective = zone.objective;
    objectivekeys = objective.objectivekey;
    function_f58f6b815662a793( objective );
    zone.hackzones = [];
    triggers = getentarray( objective.params[ "hackObjective" ][ "targetname" ], #targetname );
    objectivekeyindex = 0;
    
    foreach ( i, trigger in triggers )
    {
        objectivekey = objectivekeys[ i ];
        trigger.objectivekey = objectivekeys[ i ];
        usingvisualhintstring = objective.params[ "usingVisualHintString" ];
        hackzone = obj_hackzone::setupobjective( trigger, i, 1, 1, usingvisualhintstring );
        hackzone gameobjects::setvisibleteam( "none" );
        hackzone gameobjects::allowuse( "none" );
        level.objectives[ objectivekey ] = hackzone;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        zone.hackzones[ zone.hackzones.size ] = hackzone;
        objectivekeyindex = i;
    }
    
    objectivekeyindex += 1;
    zone.contestzones = [];
    triggers = getentarray( objective.params[ "bombObjective" ][ "targetname" ], #targetname );
    
    foreach ( i, trigger in triggers )
    {
        objectivekey = objectivekeys[ i + objectivekeyindex ];
        trigger.objectivekey = objectivekeys[ i + objectivekeyindex ];
        contestzone = obj_contestzone::setupobjective( trigger );
        contestzone gameobjects::setvisibleteam( "none" );
        contestzone gameobjects::allowuse( "none" );
        level.objectives[ objectivekey ] = contestzone;
        level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
        zone.contestzones[ zone.contestzones.size ] = contestzone;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x87826968, Offset: 0x8bcb
// Size: 0xb5
function function_e62b17632bfc527( zone )
{
    foreach ( hackzone in zone.hackzones )
    {
        hackzone gameobjects::setvisibleteam( "any" );
        hackzone gameobjects::allowuse( "enemy" );
    }
    
    zone.currentphase = "hack";
    level thread function_c28e8b3882bd3b1e( zone );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x310490dd, Offset: 0x8c88
// Size: 0xd7
function function_c28e8b3882bd3b1e( zone )
{
    level endon( #"game_ended" );
    level waittill( #"hack_zone_upload_full_complete" );
    zone.currentphase = "bomb";
    
    foreach ( contestzone in zone.contestzones )
    {
        contestzone gameobjects::setvisibleteam( "any" );
        contestzone gameobjects::allowuse( "enemy" );
        contestzone gameobjects::setobjectivestatusicons( "waypoint_bomb_defuse", "waypoint_bomb_plant" );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x1246085b, Offset: 0x8d67
// Size: 0x14b
function function_8c8286ef3ae740f6( zone )
{
    objective = zone.objective;
    
    if ( isdefined( objective.params[ "leaderDialogAttackers" ] ) )
    {
        attackersleaderdialog = objective.params[ "leaderDialogAttackers" ];
        utility::delaythread( 2, &dialog::leaderdialog, attackersleaderdialog, game[ "attackers" ] );
    }
    
    if ( isdefined( objective.params[ "leaderDialogDefenders" ] ) )
    {
        defendersleaderdialog = objective.params[ "leaderDialogDefenders" ];
        utility::delaythread( 2, &dialog::leaderdialog, defendersleaderdialog, game[ "defenders" ] );
    }
    
    foreach ( objstr in zone.objectives )
    {
        zone = level.objectives[ objstr ];
        zone gameobjects::setvisibleteam( "none" );
        zone gameobjects::allowuse( "none" );
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0x70119831, Offset: 0x8eba
// Size: 0xc1
function function_ab807479f577b3fc()
{
    remains = level.zone.hackzones.size;
    
    foreach ( hackzone in level.zone.hackzones )
    {
        if ( level.objectives[ hackzone.objectivekey ].complete )
        {
            remains--;
        }
    }
    
    return remains;
}

// Namespace wm_objectives
// Params 0
// Checksum 0x3662e67, Offset: 0x8f84
// Size: 0x15
function function_166b889d13f5f736()
{
    return level.zone.currentphase;
}

// Namespace wm_objectives
// Params 3
// Checksum 0xc4930201, Offset: 0x8fa2
// Size: 0x88
function function_bc373fa487f1a3e2( struct, objective, objectivekey )
{
    marker = struct function_4ee235f8a5ab751f( objectivekey, &"MP_INGAME_ONLY/OBJ_KILL_CAPS", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_jugg" );
    level.objectives[ objectivekey ] = marker;
    level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
    level thread function_93d5fa5a4d3bc9a4( struct, marker, objectivekey );
    return marker;
}

// Namespace wm_objectives
// Params 3
// Checksum 0xa147fcb0, Offset: 0x9033
// Size: 0x17d
function function_93d5fa5a4d3bc9a4( spawndata, marker, objectivekey )
{
    while ( !isdefined( level.agentarray ) || level.agentarray.size == 0 )
    {
        waitframe();
    }
    
    if ( !isnavmeshloaded() )
    {
        return;
    }
    
    agent = mp_agent::spawnnewagentaitype( "actor_jup_exgm_enemy_warlord_test_jugg", spawndata.origin, spawndata.angles, game[ "defenders" ] );
    agent agent_juggernaut::function_f8400804ad5435ab();
    player_max_health = getmatchrulesdata( "commonOption", "maxHealth" );
    multiplier = 150;
    var_623d079c6a05daf2 = int( player_max_health * multiplier );
    agent mp_agent::set_agent_health( var_623d079c6a05daf2 );
    objidpoolmanager::update_objective_onentity( marker.objidnum, agent );
    objidpoolmanager::update_objective_setzoffset( marker.objidnum, 110 );
    objidpoolmanager::objective_pin_global( marker.objidnum, 1 );
    agent.agentdamagefeedback = 1;
    agent thread function_409de1757541e837( marker, spawndata );
    
    if ( isdefined( spawndata.target ) )
    {
        volume = getnoentvolumearray( spawndata.target, #targetname )[ 0 ];
        agent setgoalvolumeauto( volume );
    }
    
    agent waittill( #"death" );
    level.objectives[ objectivekey ].complete = 1;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x342768cd, Offset: 0x91b8
// Size: 0x119
function function_409de1757541e837( marker, spawndata )
{
    self endon( #"death" );
    agent = self;
    
    while ( true )
    {
        agent function_2ef9eb3349906d00( 550 );
        agent setgoalpos( spawndata.origin );
        
        foreach ( player in level.players )
        {
            health = agent.health / agent.maxhealth;
            
            if ( health < 0 )
            {
                health = 0;
            }
            
            objidpoolmanager::objective_show_progress( marker.objidnum, 1 );
            objidpoolmanager::objective_set_progress( marker.objidnum, health );
        }
        
        wait 0.25;
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0xb39205a3, Offset: 0x92d9
// Size: 0x88
function function_2b6f725cb70abf30()
{
    while ( !isdefined( level.var_a7bf93687486b5ba ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.var_a7bf93687486b5ba[ "light_tank" ] ) )
    {
        waitframe();
    }
    
    level.var_a7bf93687486b5ba[ "light_tank" ].interact.var_30c65d47028f9ff4 = [ "gunner" ];
    level.var_a7bf93687486b5ba[ "light_tank" ].interact.seatswitcharray = [ "gunner" ];
}

// Namespace wm_objectives
// Params 0
// Checksum 0xf67a02e5, Offset: 0x9369
// Size: 0x104
function tankscoreevent()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( #"reached_goal" );
    
    while ( true )
    {
        wait 5;
        
        if ( self vehicle_getspeed() <= 0 || self.contested )
        {
            continue;
        }
        
        attackers = teams::getteamdata( game[ "attackers" ], "alivePlayers" );
        nearbyattackers = sortbydistancecullbyradius( attackers, self.origin, self.tanknearbyrange );
        
        foreach ( player in nearbyattackers )
        {
            player points::doscoreevent( #"wm_escort_tank" );
        }
    }
}

/#

    // Namespace wm_objectives
    // Params 0
    // Checksum 0x82ebe7a0, Offset: 0x9475
    // Size: 0x28, Type: dev
    function debug_drawtrigger()
    {
        self endon( #"death" );
        
        while ( true )
        {
            box( self.origin );
            waitframe();
        }
    }

#/

// Namespace wm_objectives
// Params 2
// Checksum 0x7fc44fc8, Offset: 0x94a5
// Size: 0x7b2
function tank_stop_and_go( tank, objidnum )
{
    tank endon( #"entitydeleted" );
    tank endon( #"reached_goal" );
    tank vehicle_turnengineon();
    tank thread function_d28964ae443a0fe0();
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( isdefined( tank.var_b3a83492c119250c ) && !tank.var_b3a83492c119250c[ "wm_stop_2" ] )
    {
        waitframe();
    }
    
    if ( !isdefined( tank.tanknearbyrange ) )
    {
        tank.tanknearbyrange = 500;
    }
    
    tank thread tankscoreevent();
    var_8548eeaa2bbca201 = dvars::function_13909a5327c395b9( "tankReversible", 1 );
    
    if ( game_utility::getmapname() == "mp_jup_skydiving" )
    {
        defaultspeed = getdvarfloat( @"hash_e139339789e60d2f", 4 );
    }
    else
    {
        defaultspeed = dvars::function_80a5871795f1cd82( "tankSpeed", 15 );
    }
    
    setspeed = defaultspeed;
    tank.var_1d982a0a9bb102b3 = [];
    tank.directionblocked = [];
    
    foreach ( player in level.players )
    {
        player.var_aa8387424ff91f14 = 0;
    }
    
    while ( true )
    {
        shouldmove = 0;
        nearbyrange = tank.tanknearbyrange;
        tank.shouldjump = 0;
        tank.shouldwatchstuck = 0;
        attackers = teams::getteamdata( game[ "attackers" ], "alivePlayers" );
        nearbyattackers = sortbydistancecullbyradius( attackers, tank.origin, nearbyrange );
        
        if ( nearbyattackers.size > 0 )
        {
            shouldmove = 1;
        }
        
        defenders = teams::getteamdata( game[ "defenders" ], "alivePlayers" );
        nearbydefenders = sortbydistancecullbyradius( defenders, tank.origin, nearbyrange );
        fullyhalt = tank.var_ebb146a8dd122f11 || tank.var_4e15a2bc8cfff891 || tank.var_1d34b4d9f078cf7c;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.var_aa8387424ff91f14 ) )
            {
                player.var_aa8387424ff91f14 = 0;
            }
            
            var_5a73417b4c69b443 = player.var_aa8387424ff91f14;
            
            if ( game[ "attackers" ] == player.team )
            {
                player.var_aa8387424ff91f14 = arraycontains( nearbyattackers, player );
            }
            else
            {
                player.var_aa8387424ff91f14 = arraycontains( nearbydefenders, player );
            }
            
            if ( var_5a73417b4c69b443 != player.var_aa8387424ff91f14 )
            {
                if ( var_5a73417b4c69b443 )
                {
                    tank function_ed5eed059c35b842( player, 1 );
                    continue;
                }
                
                tank function_7c9707e6bf5ace47( player );
            }
        }
        
        tank.contested = 0;
        
        if ( tank.canstopbydefenders )
        {
            if ( shouldmove && nearbydefenders.size > 0 )
            {
                tank.contested = 1;
                shouldmove = 0;
            }
            
            if ( var_8548eeaa2bbca201 )
            {
                backwardcheck = 0;
                
                if ( isdefined( tank.stageid ) && isdefined( tank.checkpoints[ tank.stageid - 1 ] ) )
                {
                    backwardcheck = tank.checkpoints[ tank.stageid - 1 ].progress;
                }
                
                if ( !fullyhalt && !isdefined( tank.overridespeed ) )
                {
                    if ( tank.progress - backwardcheck > 0.004 && nearbydefenders.size > 0 && nearbyattackers.size == 0 )
                    {
                        shouldmove = 1;
                        
                        if ( !tank.shouldreverse )
                        {
                            tank.shouldreverse = 1;
                            setspeed = defaultspeed / 2;
                            tank.veh_pathdir = "reverse";
                            tank.veh_transmission = "reverse";
                            tank notify( #"reverse_changed" );
                        }
                    }
                    else if ( nearbydefenders.size == 0 && nearbyattackers.size > 0 )
                    {
                        if ( tank.shouldreverse )
                        {
                            tank.shouldreverse = 0;
                            setspeed = defaultspeed;
                            tank.veh_pathdir = "forward";
                            tank.veh_transmission = "forward";
                            tank notify( #"reverse_changed" );
                        }
                    }
                }
            }
        }
        
        foreach ( player in level.players )
        {
            player function_56fb18e11dd5a1c0( objidnum, tank );
        }
        
        tank.var_c5589eb5d48962b6 = 0;
        
        if ( isdefined( tank.var_1d982a0a9bb102b3 ) )
        {
            foreach ( index, trapped in tank.var_1d982a0a9bb102b3 )
            {
                if ( trapped )
                {
                    tank.var_c5589eb5d48962b6 = 1;
                    
                    if ( tank.directionblocked[ index ] == "forward" && !tank.shouldreverse )
                    {
                        shouldmove = 0;
                        break;
                    }
                    
                    if ( tank.directionblocked[ index ] == "backward" && tank.shouldreverse )
                    {
                        shouldmove = 0;
                        break;
                    }
                }
            }
        }
        
        function_be51a1ad4c5f184f( tank, objidnum );
        
        if ( fullyhalt )
        {
            tank.shouldwatchstuck = 0;
            currentspeed = tank tank_get_speed();
            
            if ( currentspeed != 0 )
            {
                currentspeed -= 0.9;
                tank.shouldjump = 1;
                
                if ( currentspeed < 0 )
                {
                    currentspeed = 0;
                    tank.shouldjump = 0;
                }
                
                tank tank_set_speed( currentspeed );
            }
        }
        else if ( isdefined( tank.overridespeed ) )
        {
            tank.shouldwatchstuck = 0;
            tank tank_set_speed( tank.overridespeed );
            tank.shouldjump = 1;
        }
        else if ( !shouldmove )
        {
            tank.shouldwatchstuck = 0;
            tank tank_set_speed( 0 );
            tank.shouldjump = 0;
            tank notify( #"tank_stop" );
        }
        else
        {
            tank.shouldwatchstuck = 1;
            tank tank_set_speed( setspeed );
            tank.shouldjump = 1;
            tank notify( #"tank_moving" );
        }
        
        wait 0.25;
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0xde6e381d, Offset: 0x9c5f
// Size: 0x100
function function_56fb18e11dd5a1c0( objidnum, tank )
{
    state = 0;
    text = undefined;
    
    if ( self.var_aa8387424ff91f14 )
    {
        if ( tank.var_c5589eb5d48962b6 )
        {
            state = 4;
            text = &"mp_ingame_only/obj_blocked_hedgehog_caps";
        }
        else if ( tank.var_1d34b4d9f078cf7c )
        {
            state = 4;
            text = &"mp_ingame_only/obj_halt_caps";
        }
        else if ( tank.contested )
        {
            state = 3;
            text = &"mp_ingame_only/obj_contesting_caps";
        }
        else if ( self.team == game[ "attackers" ] )
        {
            state = 1;
            text = &"mp_ingame_only/obj_escorting_caps";
        }
        else
        {
            state = 2;
            text = &"mp_ingame_only/obj_forcing_back_caps";
        }
    }
    
    if ( self.var_5ca1e62c2ae57e4f != state )
    {
        thread function_ac861ecdc4a17084( objidnum, state, text, !istrue( tank.var_1d34b4d9f078cf7c ) );
        self.var_5ca1e62c2ae57e4f = state;
    }
}

// Namespace wm_objectives
// Params 4
// Checksum 0xe22f1588, Offset: 0x9d67
// Size: 0x86
function function_ac861ecdc4a17084( objidnum, var_5ca1e62c2ae57e4f, text, pinnedallowed )
{
    if ( isdefined( self.var_5ca1e62c2ae57e4f ) && self.var_5ca1e62c2ae57e4f != 0 )
    {
        objidpoolmanager::objective_unpin_player( objidnum, self );
        objective_setpinnedprogressbartext( "", self );
        waitframe();
    }
    
    if ( pinnedallowed )
    {
        if ( var_5ca1e62c2ae57e4f != 0 )
        {
            objidpoolmanager::objective_pin_player( objidnum, self );
        }
        
        if ( self.var_aa8387424ff91f14 )
        {
            objidpoolmanager::function_101225acbc89c1c1( 1, text );
        }
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x3d8e31fc, Offset: 0x9df5
// Size: 0xab
function tank_set_speed( speed )
{
    if ( speed < 0 )
    {
        speed = 0;
    }
    
    if ( speed == 0 )
    {
        setomnvar( "ui_wm_escort_dir", 0 );
    }
    else
    {
        setomnvar( "ui_wm_escort_dir", self.veh_pathdir == "forward" ? 1 : -1 );
    }
    
    if ( self.usep2p )
    {
        if ( speed == 0 )
        {
            self function_eb88c4e66edbc855( "p2p", "pause", 1 );
        }
        else
        {
            self function_eb88c4e66edbc855( "p2p", "resume", 1 );
        }
        
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed ) );
        return;
    }
    
    self vehicle_setspeed( speed );
}

// Namespace wm_objectives
// Params 0
// Checksum 0x578a0604, Offset: 0x9ea8
// Size: 0x2d
function tank_get_speed()
{
    if ( self.usep2p )
    {
        return ( self function_24e10bf6894fa869( "p2p", "manualSpeed" ) * 0.056818 );
    }
    
    return self vehicle_getspeed();
}

// Namespace wm_objectives
// Params 0
// Checksum 0xa663696b, Offset: 0x9edd
// Size: 0x186
function function_3017d7b6cc961f19()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    
    if ( !isdefined( self.pathnodes ) || self.pathnodes.size == 0 )
    {
        return;
    }
    
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 0 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 10 );
    nodeid = 0;
    targetnode = self.pathnodes[ nodeid ];
    self.var_63ba5ed26f65fcf2 = 0;
    
    while ( isdefined( targetnode ) )
    {
        self function_eb88c4e66edbc855( "p2p", "goalPoint", targetnode.origin );
        self function_eb88c4e66edbc855( "p2p", "goalAngles", targetnode.angles );
        msg = utility::waittill_any_return( "near_goal", "path_blocked", "reverse_changed" );
        
        if ( msg == "path_blocked" )
        {
            continue;
        }
        else if ( msg == "reverse_changed" )
        {
            if ( self.shouldreverse )
            {
                self function_eb88c4e66edbc855( "p2p", "checkStuck", 0 );
                self function_eb88c4e66edbc855( "p2p", "reverseForBehindGoal", 1 );
            }
            else
            {
                self function_eb88c4e66edbc855( "p2p", "checkStuck", 1 );
                self function_eb88c4e66edbc855( "p2p", "reverseForBehindGoal", 0 );
            }
        }
        
        if ( self.shouldreverse )
        {
            nodeid--;
        }
        else
        {
            nodeid++;
        }
        
        targetnode = self.pathnodes[ nodeid ];
        self.var_63ba5ed26f65fcf2 = nodeid;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x746bd9aa, Offset: 0xa06b
// Size: 0x2b1
function function_d28964ae443a0fe0( var_e034569c8f060398 )
{
    self endon( #"entitydeleted" );
    self endon( #"reached_goal" );
    
    if ( self.vehicletype == "veh_jup_mil_lnd_tank_cougar_mg_physics" )
    {
        var_e034569c8f060398 = spawn( "script_model", self.origin );
        var_e034569c8f060398 linkto( self, "tag_origin", ( -80, 0, 45 ), ( 0, 0, 0 ) );
        
        while ( true )
        {
            if ( self vehicle_getspeed() > 0 )
            {
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        player clearsoundsubmix( "jup_mode_wm_tank_engine", 0.2 );
                    }
                }
                
                var_e034569c8f060398 stopsounds();
                var_e034569c8f060398 playsoundonmovingent( "veh_jup_mil_lnd_cougar_tank_wm_start" );
                self waittill( #"tank_stop" );
            }
            else
            {
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        player setsoundsubmix( "jup_mode_wm_tank_engine", 0.2, 1 );
                    }
                }
                
                var_e034569c8f060398 stopsounds();
                var_e034569c8f060398 playsoundonmovingent( "veh_jup_mil_lnd_cougar_tank_wm_stop" );
                self waittill( #"tank_moving" );
            }
            
            waitframe();
        }
        
        return;
    }
    
    if ( self.vehicletype == "veh_pac_sentry_amphibious_mp_skydiving" )
    {
        self.var_e034569c8f060398 = spawn( "script_model", self.origin );
        self.var_e034569c8f060398 linkto( self, "tag_origin", ( 0, 0, 15 ), ( 0, 0, 0 ) );
        
        while ( true )
        {
            if ( self vehicle_getspeed() > 0 )
            {
                self.var_e034569c8f060398 playsoundonmovingent( "veh_jup_kls_wheelson_engine_start" );
                wait 0.5;
                self.var_e034569c8f060398 playloopsound( "veh_jup_kls_wheelson_engine_lp" );
                self waittill( #"tank_stop" );
            }
            else
            {
                self.var_e034569c8f060398 stoploopsound( "veh_jup_kls_wheelson_engine_lp" );
                self.var_e034569c8f060398 playsoundonmovingent( "veh_jup_kls_wheelson_engine_stop" );
                self waittill( #"tank_moving" );
            }
            
            waitframe();
        }
        
        return;
    }
    
    return;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x62021a10, Offset: 0xa324
// Size: 0xf3
function function_be51a1ad4c5f184f( tank, objidnum )
{
    objidpoolmanager::update_objective_sethot( objidnum, tank.contested || tank.var_c5589eb5d48962b6 );
    
    if ( tank.var_c5589eb5d48962b6 )
    {
        objidpoolmanager::update_objective_setenemylabel( objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
        objidpoolmanager::update_objective_setfriendlylabel( objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
    }
    else if ( tank.contested )
    {
        objidpoolmanager::update_objective_setenemylabel( objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS" );
        objidpoolmanager::update_objective_setfriendlylabel( objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS" );
    }
    else
    {
        objidpoolmanager::update_objective_setfriendlylabel( objidnum, &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS" );
        objidpoolmanager::update_objective_setenemylabel( objidnum, &"mp_ingame_only/obj_halt_caps" );
    }
    
    if ( tank.var_c5589eb5d48962b6 )
    {
        objidpoolmanager::update_objective_icon( objidnum, "icon_waypoint_tank_blocked" );
        return;
    }
    
    objidpoolmanager::update_objective_icon( objidnum, "icon_waypoint_escort_tank" );
}

// Namespace wm_objectives
// Params 3
// Checksum 0xfa250523, Offset: 0xa41f
// Size: 0x100
function function_7f03d7c4116ec75d( vehicle, objidnum, pathend )
{
    progress = 1;
    totaldistance = distance2d( vehicle.spawndata.node.origin, pathend.origin );
    objidpoolmanager::objective_set_show_progress( objidnum, 0 );
    objidpoolmanager::objective_set_progress_team( objidnum, game[ "defenders" ] );
    
    while ( distance2d( vehicle.origin, pathend.origin ) > 64 )
    {
        if ( !isdefined( vehicle.origin ) )
        {
            return;
        }
        
        progress = 1 - distance( vehicle.origin, pathend.origin ) / totaldistance;
        
        if ( progress < 0 )
        {
            progress = 0;
        }
        
        objidpoolmanager::objective_set_progress( objidnum, progress );
        vehicle.progress = progress;
        waitframe();
    }
    
    function_98835ce975f57cef( vehicle );
}

// Namespace wm_objectives
// Params 2
// Checksum 0xd26429f7, Offset: 0xa527
// Size: 0x426
function function_d4c95c8be5a23d13( vehicle, objidnum )
{
    level endon( #"game_ended" );
    assert( vehicle.pathnodes.size > 0 );
    endnode = vehicle.pathnodes[ vehicle.pathnodes.size - 1 ];
    totaldistance = endnode.var_7d71d1774b14f738;
    vehicle.var_4f6ccc87c3912e74 = 1 / totaldistance;
    
    /#
        level thread function_d0d3171f2840655( vehicle, vehicle.pathnodes );
    #/
    
    if ( vehicle.spawndata.spawnmethod == "airdrop_at_position_unsafe" )
    {
        vehicle waittill( #"landed" );
    }
    
    objidpoolmanager::objective_set_show_progress( objidnum, 0 );
    objidpoolmanager::objective_set_progress_team( objidnum, game[ "defenders" ] );
    var_8ede98cb669fd389 = 900;
    
    while ( vehicle.progress != 1 )
    {
        waitframe();
        
        if ( !vehicle.usep2p )
        {
            if ( !isdefined( vehicle.var_63ba5ed26f65fcf2 ) )
            {
                vehicle.var_63ba5ed26f65fcf2 = 1;
            }
            
            var_4e649fe1840782ee = distance2dsquared( vehicle.pathnodes[ vehicle.var_63ba5ed26f65fcf2 ].origin, vehicle.origin );
            var_54b2a20d00cbc49b = distance2dsquared( vehicle.pathnodes[ vehicle.var_63ba5ed26f65fcf2 - 1 ].origin, vehicle.origin );
            
            if ( vehicle.var_63ba5ed26f65fcf2 + 1 < vehicle.pathnodes.size && var_4e649fe1840782ee < var_8ede98cb669fd389 && !vehicle.shouldreverse )
            {
                vehicle.var_63ba5ed26f65fcf2++;
            }
            else if ( vehicle.var_63ba5ed26f65fcf2 > 0 && var_54b2a20d00cbc49b < var_8ede98cb669fd389 && vehicle.shouldreverse )
            {
                vehicle.var_63ba5ed26f65fcf2--;
            }
            
            /#
                print3d( vehicle.origin + ( 0, 0, 200 ), var_4e649fe1840782ee, ( 1, 0, 0 ) );
            #/
        }
        
        var_dcbbd1ab56484f24 = vehicle.var_63ba5ed26f65fcf2 - 1;
        backnode = vehicle.pathnodes[ var_dcbbd1ab56484f24 ];
        
        if ( !isdefined( backnode ) )
        {
            continue;
        }
        
        cachedistance = distance2d( vehicle.origin, backnode.origin );
        progress = ( backnode.var_7d71d1774b14f738 + cachedistance ) / totaldistance;
        
        if ( progress > 1 )
        {
            progress = 1;
        }
        else if ( vehicle.var_63ba5ed26f65fcf2 >= vehicle.pathnodes.size - 1 )
        {
            var_4349a4f6daf0c1 = distancesquared( vehicle.pathnodes[ vehicle.pathnodes.size - 1 ].origin, vehicle.origin ) < var_8ede98cb669fd389;
            
            if ( var_4349a4f6daf0c1 )
            {
                progress = 1;
            }
        }
        
        vehicle.progress = progress;
        
        if ( isdefined( vehicle.checkpoints[ vehicle.stageid ] ) )
        {
            if ( vehicle.progress >= vehicle.checkpoints[ vehicle.stageid ].progress )
            {
                vehicle.stageid++;
            }
        }
        
        objidpoolmanager::objective_set_progress( objidnum, progress );
        
        /#
            print3d( vehicle.origin + ( 0, 0, 72 ), "<dev string:x5f>" + int( cachedistance ) + "<dev string:x67>" + backnode.var_7d71d1774b14f738 + "<dev string:x73>" + distance2d( vehicle.origin, vehicle.pathnodes[ var_dcbbd1ab56484f24 + 1 ].origin ) );
        #/
    }
    
    function_98835ce975f57cef( vehicle );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x1f7115b1, Offset: 0xa955
// Size: 0x84
function function_98835ce975f57cef( vehicle )
{
    if ( !vehicle.var_455fd84d1193d00c )
    {
        level.objectives[ vehicle.objectivekey ].complete = 1;
        level.objectives[ vehicle.objectivekey ] gameobjects::setvisibleteam( "none" );
        vehicle notify( #"reached_goal" );
        vehicle vehicle_setspeed( 0, 0, 1 );
        vehicle.var_455fd84d1193d00c = 1;
    }
}

/#

    // Namespace wm_objectives
    // Params 2
    // Checksum 0xa7980ab8, Offset: 0xa9e1
    // Size: 0xd5, Type: dev
    function function_d0d3171f2840655( vehicle, pathnodes )
    {
        level endon( #"game_ended" );
        vehicle endon( #"reached_goal" );
        
        while ( true )
        {
            for ( i = 0; i < pathnodes.size ; i++ )
            {
                print3d( pathnodes[ i ].origin + ( 0, 0, 50 ), "<dev string:x7b>" + i + "<dev string:x81>" + pathnodes[ i ].var_7d71d1774b14f738 );
                print3d( pathnodes[ i ].origin + ( 0, 0, 36 ), "<dev string:x84>" + int( pathnodes[ i ].progress * 100 ) + "<dev string:x85>" );
            }
            
            waitframe();
        }
    }

#/

// Namespace wm_objectives
// Params 3
// Checksum 0x1a5b76ee, Offset: 0xaabe
// Size: 0x2ca, Type: bool
function function_cc663c0d784ce9c0( c4, samsite, player )
{
    if ( !c4.var_70cd500a8c9cc0b5 )
    {
        samsite function_8c5aeba61f1c9cf1( "plant" );
        return false;
    }
    
    player thread points::doscoreevent( #"hash_d9283d3795ee1ca0" );
    level notify( #"planted_bomb_on_sam_site" );
    samsite endon( #"hash_ac064f6965566f5b" );
    currenttime = gettime();
    totaltime = 15000;
    bombendtime = int( currenttime + totaltime );
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    objidnum = level.objectives[ samsite.entity.objectivekey ].objidnum;
    level.objectives[ samsite.entity.objectivekey ] gameobjects::setobjectivestatusicons( "waypoint_defuse", "waypoint_defend", objidnum );
    level childthread function_b331c65ac06e5d( objidnum, bombendtime, totaltime );
    samsite function_8c5aeba61f1c9cf1( "defuse" );
    
    while ( var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 < 1500 )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                if ( soundexists( "breach_warning_beep_05" ) )
                {
                    c4 playsound( "breach_warning_beep_05" );
                }
            }
            else if ( var_f4f3f0356fef8102 < 500 )
            {
                if ( soundexists( "breach_warning_beep_04" ) )
                {
                    c4 playsound( "breach_warning_beep_04" );
                }
            }
            else if ( var_f4f3f0356fef8102 < 1500 )
            {
                if ( soundexists( "breach_warning_beep_03" ) )
                {
                    c4 playsound( "breach_warning_beep_03" );
                }
            }
            else if ( soundexists( "breach_warning_beep_02" ) )
            {
                c4 playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
        }
        else if ( var_f4f3f0356fef8102 < 3500 )
        {
            if ( soundexists( "breach_warning_beep_02" ) )
            {
                c4 playsound( "breach_warning_beep_02" );
            }
            
            wait 0.5;
        }
        else
        {
            if ( soundexists( "breach_warning_beep_01" ) )
            {
                c4 playsound( "breach_warning_beep_01" );
            }
            
            wait 1;
        }
        
        if ( var_f4f3f0356fef8102 < 0 )
        {
            break;
        }
    }
    
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        player thread points::doscoreevent( #"hash_9b82ab032940a3d6" );
    }
    
    samsite notify( #"samsite_bomb_detonated" );
    samsite.entity thread samsite::sam_explode( player, "samsite_base_mp" );
    return true;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x1a5e5476, Offset: 0xad91
// Size: 0x1ad
function function_8c5aeba61f1c9cf1( state )
{
    turret = self;
    ent = function_3e10bb7c2407915a( turret );
    ent.samsitestate = state;
    
    if ( state == "plant" )
    {
        turret setscriptablepartstate( "usable_left", "usable" );
        turret setscriptablepartstate( "usable_front", "usable" );
        turret setscriptablepartstate( "usable_right", "usable" );
        turret setscriptablepartstate( "usable_left_defuse", "unusable" );
        turret setscriptablepartstate( "usable_front_defuse", "unusable" );
        turret setscriptablepartstate( "usable_right_defuse", "unusable" );
    }
    else
    {
        turret setscriptablepartstate( "usable_left", "unusable" );
        turret setscriptablepartstate( "usable_front", "unusable" );
        turret setscriptablepartstate( "usable_right", "unusable" );
        turret setscriptablepartstate( "usable_left_defuse", "usable" );
        turret setscriptablepartstate( "usable_front_defuse", "usable" );
        turret setscriptablepartstate( "usable_right_defuse", "usable" );
    }
    
    turret setscriptablepartstate( "usable_front", "unusable" );
    turret setscriptablepartstate( "usable_front_defuse", "unusable" );
    
    foreach ( player in level.players )
    {
        turret function_e27b574b6d3c21e3( player );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5077b8eb, Offset: 0xaf46
// Size: 0xe5
function function_e27b574b6d3c21e3( player )
{
    turret = self;
    ent = function_3e10bb7c2407915a( turret );
    state = ent.samsitestate;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        if ( state == "plant" )
        {
            turret function_ee6473bfedaf745e( player, 1 );
            turret function_80e57e808391524d( player, 0 );
        }
        
        if ( state == "defuse" )
        {
            turret function_ee6473bfedaf745e( player, 0 );
            turret function_80e57e808391524d( player, 0 );
        }
        
        return;
    }
    
    if ( state == "plant" )
    {
        turret function_ee6473bfedaf745e( player, 0 );
        turret function_80e57e808391524d( player, 0 );
    }
    
    if ( state == "defuse" )
    {
        turret function_ee6473bfedaf745e( player, 0 );
        turret function_80e57e808391524d( player, 1 );
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xd2166c98, Offset: 0xb033
// Size: 0x32
function function_3e10bb7c2407915a( turret )
{
    if ( turret.classname == "misc_turret" )
    {
        return turret;
    }
    
    return turret.entity;
}

// Namespace wm_objectives
// Params 2
// Checksum 0x126313af, Offset: 0xb06d
// Size: 0x6b
function function_ee6473bfedaf745e( player, bool = 1 )
{
    turret = self;
    
    if ( bool )
    {
        turret enablescriptablepartplayeruse( "usable_left", player );
        turret enablescriptablepartplayeruse( "usable_right", player );
        return;
    }
    
    turret disablescriptablepartplayeruse( "usable_left", player );
    turret disablescriptablepartplayeruse( "usable_right", player );
}

// Namespace wm_objectives
// Params 2
// Checksum 0xb59c5dc3, Offset: 0xb0e0
// Size: 0x62
function function_80e57e808391524d( player, bool )
{
    turret = self;
    
    if ( bool )
    {
        turret enablescriptablepartplayeruse( "usable_left_defuse", player );
        turret enablescriptablepartplayeruse( "usable_right_defuse", player );
        return;
    }
    
    turret disablescriptablepartplayeruse( "usable_left_defuse", player );
    turret disablescriptablepartplayeruse( "usable_right_defuse", player );
}

// Namespace wm_objectives
// Params 6
// Checksum 0x843d0a47, Offset: 0xb14a
// Size: 0xe4
function function_58f75dc08f7cae29( instance, part, state, player, bautouse, usestring )
{
    player thread points::doscoreevent( #"hash_fbc15faadfadee5d" );
    objidnum = level.objectives[ instance.entity.objectivekey ].objidnum;
    objidpoolmanager::objective_set_progress( objidnum, 1 );
    level.objectives[ instance.entity.objectivekey ] gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", objidnum );
    instance notify( #"hash_ac064f6965566f5b" );
    instance function_8c5aeba61f1c9cf1( "plant" );
    level notify( #"defused_bomb_on_sam_site" );
}

// Namespace wm_objectives
// Params 3
// Checksum 0x17adc56a, Offset: 0xb236
// Size: 0x98
function function_b331c65ac06e5d( objidnum, bombendtime, totaltime )
{
    progress = 1;
    
    while ( progress > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        progress = max( 0, var_f4f3f0356fef8102 / totaltime );
        objidpoolmanager::objective_set_progress( objidnum, progress );
        objidpoolmanager::objective_set_progress_team( objidnum, game[ "attackers" ] );
        objidpoolmanager::objective_show_team_progress( objidnum, game[ "defenders" ] );
        objidpoolmanager::objective_show_team_progress( objidnum, game[ "attackers" ] );
        waitframe();
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5687893e, Offset: 0xb2d6
// Size: 0x8d
function sam_spawn_wm( struct )
{
    turret = samsite::function_5772afed0d0a7557( struct, "military_samsite_01_rig_skeleton_war_mode_mp" );
    samsite::function_e223076ba8697313( turret );
    turret.target_entity = spawn( "script_model", turret.origin + ( 0, 0, 900 ) + anglestoforward( turret.angles ) * 1000 );
    turret settargetentity( turret.target_entity );
    turret thread function_823e40976c04f6f3();
    return turret;
}

// Namespace wm_objectives
// Params 0
// Checksum 0x56410914, Offset: 0xb36c
// Size: 0xc0
function function_823e40976c04f6f3()
{
    self endon( #"hash_1c3f71ac236fabac" );
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    self.dmgtaken = 0;
    self.var_19f6c7c935cb45e0 = 750;
    attacker = undefined;
    self.health = 9999999;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon );
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0x8fd4425, Offset: 0xb434
// Size: 0x36
function function_be6a1751ce410868()
{
    while ( true )
    {
        self.turret waittill( #"samsite_dead" );
        gameobjects::setvisibleteam( "none" );
        self.complete = 1;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xad37d8e3, Offset: 0xb472
// Size: 0xbd
function function_361f4ac007b330b5( params )
{
    player = self;
    
    foreach ( turret in level.aa_sites )
    {
        if ( !isdefined( turret ) )
        {
            continue;
        }
        
        turret function_e27b574b6d3c21e3( player );
        
        if ( level.zone.objectivetype == 5 )
        {
            turret outline_sam_site();
        }
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0xe30ecd6f, Offset: 0xb537
// Size: 0x5a
function outline_sam_site()
{
    turret = self;
    turret hudoutlineenable( "outline_depth_red" );
    turret.missile1 hudoutlineenable( "outline_depth_red" );
    turret.missile2 hudoutlineenable( "outline_depth_red" );
    turret.missile3 hudoutlineenable( "outline_depth_red" );
}

// Namespace wm_objectives
// Params 6
// Checksum 0xab9094bc, Offset: 0xb599
// Size: 0x13a
function function_4ee235f8a5ab751f( objectivekey, attackermsg, defendermsg, objectiveicon, overrideownerteam, offset )
{
    struct = self;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 84 );
    }
    
    team = game[ "defenders" ];
    
    if ( isdefined( overrideownerteam ) )
    {
        team = overrideownerteam;
    }
    
    marker = gameobjects::createobjidobject( struct.origin, team, offset, undefined, "all", 0 );
    marker.iconname = objectivekey;
    marker.objectivekey = objectivekey;
    marker gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", marker.objidnum, team );
    objidpoolmanager::update_objective_icon( marker.objidnum, objectiveicon );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, team );
    objidpoolmanager::update_objective_setenemylabel( marker.objidnum, attackermsg );
    objidpoolmanager::update_objective_setfriendlylabel( marker.objidnum, defendermsg );
    objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    return marker;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5fb615b4, Offset: 0xb6dc
// Size: 0x6b
function missileturret_watchdamage( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    level endon( #"game_ended" );
    turret thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( turret.maxhealth, "hitequip", &missile_turret::missileturret_handledeathdamage, &missile_turret::missileturret_modifydamage, 1 );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x6f0fdfb8, Offset: 0xb74f
// Size: 0x120
function missileturret_watchdeath( turret )
{
    turret endon( #"carried" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed );
    level.objectives[ turret.marker.objectivekey ].complete = 1;
    turret missileturret_setturretmodel( "destroyed" );
    turret setturretowner( undefined );
    turret playsound( "mp_equip_destroyed" );
    
    if ( isdefined( turret.useownerobj ) )
    {
        turret.useownerobj delete();
    }
    
    if ( isdefined( turret.useotherobj ) )
    {
        turret.useotherobj delete();
    }
    
    if ( isdefined( turret.colmodel ) )
    {
        turret.colmodel delete();
    }
    
    if ( isdefined( turret.marker ) )
    {
        objidpoolmanager::objective_playermask_hidefromall( turret.marker.objidnum );
    }
    
    wait 0.2;
    turret delete();
}

// Namespace wm_objectives
// Params 1
// Checksum 0xc951dce0, Offset: 0xb877
// Size: 0x7d
function missileturret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "placed" )
    {
        turretmodel = level.missilesettings[ self.turrettype ].modelbaseground;
    }
    else
    {
        turretmodel = level.missilesettings[ self.turrettype ].modeldestroyedground;
    }
    
    assert( isdefined( turretmodel ), "<dev string:x87>" );
    self setmodel( turretmodel );
}

// Namespace wm_objectives
// Params 3
// Checksum 0xfcf31c5d, Offset: 0xb8fc
// Size: 0x4eb
function function_b5478869ff8cf06d( hostage_dropoffs, vehicles, dropoff_marker )
{
    wm_escort_hostage_path = getvehiclenode( "wm_escort_hostage_path", #targetname );
    
    foreach ( vehicle in vehicles )
    {
        vehicle attachpath( wm_escort_hostage_path );
        vehicle startpath();
    }
    
    foreach ( vehicle in vehicles )
    {
        vehicle vehicle_setspeed( 0 );
    }
    
    while ( !flags::gameflagexists( "infil_will_run" ) )
    {
        waitframe();
    }
    
    if ( flags::gameflag( "infil_will_run" ) )
    {
        flags::gameflagwait( "infil_started" );
    }
    else
    {
        while ( !level.prematchstarted )
        {
            waitframe();
        }
    }
    
    foreach ( vehicle in vehicles )
    {
        vehicle thread vehicle_move_forward_until( "wm_stop_1" );
    }
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !player.hashostage )
        {
            continue;
        }
        
        remainingspots = [];
        level.objectives[ player.carryobject.objectivekey ].complete = 1;
        player.carryobject deposithostage( player );
        player.carryobject gameobjects::setvisibleteam( "none" );
        player.carryobject gameobjects::setvisibleteam( "none", self.var_d4cb0549b5d62bea );
        player.carryobject gameobjects::setvisibleteam( "none", self.var_96cd360a9646d989 );
        
        if ( isdefined( player ) )
        {
            foreach ( hostage in level.hostages )
            {
                if ( !isdefined( hostage.carrier ) )
                {
                    hostage.trigger enableplayeruse( player );
                }
            }
        }
        
        if ( isdefined( player.carryobject.trackedobject ) )
        {
            if ( isdefined( player.carryobject.trackedobject.pingobjidnum ) )
            {
                objidpoolmanager::returnobjectiveid( player.carryobject.trackedobject.pingobjidnum );
                player.carryobject.trackedobject.pingobjidnum = undefined;
            }
            
            player.carryobject.trackedobject gameobjects::deletetrackedobject();
            player.carryobject.trackedobject = undefined;
        }
        
        player.carryobject gameobjects::deletetrackedobject();
        player.carryobject = undefined;
        player.hashostage = undefined;
        
        foreach ( hostage in hostage_dropoffs )
        {
            if ( !hostage.saved )
            {
                remainingspots[ remainingspots.size ] = hostage;
            }
        }
        
        var_b42f9f3d20c668cb = function_47c86977a18df38b( remainingspots, player.origin );
        var_b42f9f3d20c668cb show();
        var_b42f9f3d20c668cb.head show();
        var_b42f9f3d20c668cb.saved = 1;
        var_b42f9f3d20c668cb scriptmodelplayanimdeltamotion( "cap_civ_prty_anxious_seat02" );
        
        if ( remainingspots.size == 1 )
        {
            break;
        }
    }
    
    dropoff_marker objidpoolmanager::objective_playermask_hidefromall( dropoff_marker.objidnum );
}

// Namespace wm_objectives
// Params 1
// Checksum 0xabc7cc77, Offset: 0xbdef
// Size: 0xa4
function deposithostage( player )
{
    self notify( #"prompt_cleanup" );
    player notify( #"remove_rig" );
    self notify( #"remove_rig" );
    self notify( #"hostage_pickup" );
    self notify( #"manual_drop_cleanup" );
    player val::reset_all( "carry" );
    
    if ( isdefined( player.givenweapon ) )
    {
        player takeweapon( player.givenweapon );
        player.givenweapon = undefined;
    }
    
    if ( isdefined( player.switchweapon ) )
    {
        player.switchweapon = undefined;
    }
    
    player resetcarryobject();
}

// Namespace wm_objectives
// Params 1
// Checksum 0xe18be4bf, Offset: 0xbe9b
// Size: 0xb0
function vehicle_move_forward_until( name )
{
    vehicle = self;
    vehicle notify( #"vehicle_move_forward_until" );
    vehicle endon( #"vehicle_move_forward_until" );
    
    if ( !isdefined( vehicle.var_b3a83492c119250c ) )
    {
        vehicle.var_b3a83492c119250c = [];
    }
    
    endnode = getvehiclenode( name, #script_noteworthy );
    vehicle vehicle_setspeed( 7.5 );
    
    while ( distance2d( vehicle.origin, endnode.origin ) > 64 )
    {
        waitframe();
    }
    
    vehicle vehicle_setspeed( 0 );
    vehicle.var_b3a83492c119250c[ name ] = 1;
}

// Namespace wm_objectives
// Params 3
// Checksum 0xb4ecf5b2, Offset: 0xbf53
// Size: 0x43
function hostage_ondrop( player, var_b34b3f5caaa6435b, manualdrop )
{
    rescue::hostage_ondrop( player, var_b34b3f5caaa6435b, manualdrop );
    gameobjects::setownerteam( game[ "defenders" ] );
    gameobjects::setvisibleteam( "enemy" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x31011490, Offset: 0xbf9e
// Size: 0x7b
function function_f58f6b815662a793( objective )
{
    objectivekeys = objective.objectivekey;
    objectivezone = objective.objectiveid;
    zone = level.zones[ objectivezone ];
    
    if ( !isdefined( zone ) )
    {
        return;
    }
    
    zone.objectives = objectivekeys;
    zone.objectivetype = objective.objectivetype;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x938cc289, Offset: 0xc021
// Size: 0xea
function function_c8300b794535b6fa( objectivekey )
{
    dlog_recordevent( "dlog_event_wm_server_sub_objective_start", [ "match_guid", getonlinematchid(), "map_name", level.script, "objective_type", string( level.zone.objectivetype ), "objective_id", level.zone.name, "sub_objective_time", gettime() / 1000, "sub_objective_key", objectivekey, "round", "" + game[ "roundsPlayed" ] + 1 ] );
    
    if ( !isdefined( level.var_fd4520f27b52f5ca ) )
    {
        level.var_fd4520f27b52f5ca = [];
    }
    
    level.var_fd4520f27b52f5ca[ objectivekey ] = 1;
}

// Namespace wm_objectives
// Params 3
// Checksum 0x768ccbce, Offset: 0xc113
// Size: 0x146
function function_52ac9e302f5b92ef( objectivekey, objectivestatus, var_278f49fd481c93f )
{
    if ( !isdefined( level.var_fd4520f27b52f5ca ) )
    {
        return;
    }
    
    status = "Completed";
    
    if ( isdefined( objectivestatus ) )
    {
        status = objectivestatus;
    }
    
    if ( var_278f49fd481c93f )
    {
        roundsplay = game[ "roundsPlayed" ];
    }
    else
    {
        roundsplay = game[ "roundsPlayed" ] + 1;
    }
    
    if ( level.var_fd4520f27b52f5ca[ objectivekey ] )
    {
        dlog_recordevent( "dlog_event_wm_server_sub_objective_end", [ "match_guid", getonlinematchid(), "map_name", level.script, "objective_type", string( level.zone.objectivetype ), "objective_id", level.zone.name, "sub_objective_time", gettime() / 1000, "sub_objective_key", objectivekey, "round", string( roundsplay ), "status", status ] );
        level.var_fd4520f27b52f5ca[ objectivekey ] = undefined;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xc5a60ae2, Offset: 0xc261
// Size: 0x2b
function function_39bc8348386021a0( player )
{
    obj_zonecapture::zone_onusebegin( player );
    level notify( #"hash_328c1602198fe0e7", self );
    function_7c9707e6bf5ace47( player );
}

// Namespace wm_objectives
// Params 3
// Checksum 0x51a78dc8, Offset: 0xc294
// Size: 0x33
function function_95759ebcf4f14e40( team, player, success )
{
    obj_zonecapture::zone_onuseend( team, player, success );
    function_ed5eed059c35b842( player, success );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x9102f92a, Offset: 0xc2cf
// Size: 0x193
function wmzone_onuse( player )
{
    zone = self;
    function_d83319e9225b8d86( zone.objectivekey );
    zone obj_zonecapture::deactivatezone();
    zone thread obj_zonecapture::updatechevrons( "off" );
    zone gameobjects::disableobject();
    level notify( #"wm_zone_captured", zone );
    
    if ( isdefined( level.zone.capture_zones ) && isdefined( level.var_8022446805d6bec3 ) )
    {
        complete = 0;
        
        foreach ( capture_zone in level.zone.capture_zones )
        {
            if ( capture_zone.complete )
            {
                complete++;
            }
        }
        
        if ( complete < level.zone.capture_zones.size )
        {
            [[ level.var_8022446805d6bec3 ]]( player );
        }
    }
    
    if ( level.zone.objectives.size > function_337e792092efa905() )
    {
        points::function_40522c040a4e7b1( game[ "attackers" ], #"wm_capture_zone" );
        thread print::printandsoundoneveryone( game[ "attackers" ], game[ "defenders" ], undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost" );
        return;
    }
    
    return;
}

// Namespace wm_objectives
// Params 0
// Checksum 0xeef5b100, Offset: 0xc46a
// Size: 0xa5
function function_337e792092efa905()
{
    score = 0;
    
    foreach ( objstr in level.zone.objectives )
    {
        if ( level.objectives[ objstr ].complete )
        {
            score++;
        }
    }
    
    return score;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x69bd71fe, Offset: 0xc518
// Size: 0x1e
function function_c2bebab6e908152( player )
{
    obj_hackzone::hackzone_onbeginuse( player );
    function_7c9707e6bf5ace47( player );
}

// Namespace wm_objectives
// Params 3
// Checksum 0x5be7787f, Offset: 0xc53e
// Size: 0x33
function function_acd533f53c7babf5( team, player, result )
{
    obj_hackzone::hackzone_onenduse( team, player, result );
    function_ed5eed059c35b842( player, result );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x57a9c4e8, Offset: 0xc579
// Size: 0x34
function function_b3879d08a66cf7ff( player )
{
    level.objectives[ self.objectivekey ].complete = 1;
    obj_dom::removeobjective( self );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5ebae0fe, Offset: 0xc5b5
// Size: 0x33
function onbeginuse( player )
{
    level notify( #"began_defusing_bomb", player );
    obj_bombzone::bombzone_onbeginuse( player );
    player objidpoolmanager::function_101225acbc89c1c1( 2, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x32916dc9, Offset: 0xc5f0
// Size: 0x46
function onuseplantobject( player )
{
    gameobjects::setvisibleteam( "none" );
    gameobjects::allowuse( "none" );
    player thread points::doscoreevent( #"hash_ec8a2dc2f4e07935" );
    function_d83319e9225b8d86( self.objectivekey );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x35328dc8, Offset: 0xc63e
// Size: 0x25
function function_d83319e9225b8d86( objectivekey )
{
    level.objectives[ objectivekey ].complete = 1;
}

// Namespace wm_objectives
// Params 3
// Checksum 0x44893bc, Offset: 0xc66b
// Size: 0xcb
function onenduse( team, player, result )
{
    player thread obj_bombzone::allowedwhileplanting( 1 );
    player.bombplantweapon = undefined;
    player.isplanting = 0;
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            player notify( #"finished_use" );
        }
    }
    
    if ( result )
    {
        wm_ui::function_f63d60dd5fbd6c58();
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x5eb2f59a, Offset: 0xc73e
// Size: 0x96
function function_ee17ba2f6cc82a83( zone )
{
    foreach ( objstr in zone.objectives )
    {
        level.objectives[ objstr ] gameobjects::setvisibleteam( "any" );
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0x68d916d1, Offset: 0xc7dc
// Size: 0x2
function sdhack()
{
    
}

// Namespace wm_objectives
// Params 7
// Checksum 0x5af380ad, Offset: 0xc7e6
// Size: 0xa3
function function_418d20b3b721ba79( zone, team, dialog, condition, cooldown, delaystart, initialcooldown )
{
    struct = spawnstruct();
    struct.dialog = dialog;
    struct.cooldown = cooldown;
    struct.condition = condition;
    struct.delaystart = delaystart;
    struct.initialcooldown = initialcooldown;
    function_307f1f4e94146f25( zone, team, struct );
}

// Namespace wm_objectives
// Params 3
// Checksum 0xe119e76, Offset: 0xc891
// Size: 0xc4
function function_307f1f4e94146f25( zone, team, struct )
{
    if ( !isdefined( struct.delaystart ) )
    {
        struct.delaystart = 0;
    }
    
    objectivetype = zone.objectivetype;
    
    if ( !isdefined( level.var_f0cf9f2aed2a1b6e ) )
    {
        level.var_f0cf9f2aed2a1b6e = [];
    }
    
    if ( !isdefined( level.var_f0cf9f2aed2a1b6e[ objectivetype ] ) )
    {
        level.var_f0cf9f2aed2a1b6e[ objectivetype ] = [];
    }
    
    if ( !isdefined( level.var_f0cf9f2aed2a1b6e[ objectivetype ][ team ] ) )
    {
        level.var_f0cf9f2aed2a1b6e[ objectivetype ][ team ] = [];
    }
    
    level.var_f0cf9f2aed2a1b6e[ objectivetype ][ team ][ level.var_f0cf9f2aed2a1b6e[ objectivetype ][ team ].size ] = struct;
}

// Namespace wm_objectives
// Params 2
// Checksum 0xc2693760, Offset: 0xc95d
// Size: 0x15f
function function_1afe01a54a2a4f3d( zone, objectivetype )
{
    foreach ( var_4c8d38b2672d90a2 in level.var_f0cf9f2aed2a1b6e )
    {
        foreach ( team, var_8df27d8fe0c8d7c0 in var_4c8d38b2672d90a2 )
        {
            foreach ( callback in var_8df27d8fe0c8d7c0 )
            {
                level thread function_738f476f6e3d2cdc( zone, callback, team );
            }
        }
    }
}

// Namespace wm_objectives
// Params 3
// Checksum 0x8c1b7408, Offset: 0xcac4
// Size: 0x185
function function_738f476f6e3d2cdc( zone, callback, team )
{
    level endon( #"game_ended" );
    level endon( #"start_game_ended" );
    voline = callback.dialog;
    cooldown = callback.cooldown;
    condition = callback.condition;
    delaystart = callback.delaystart;
    initialcooldown = callback.initialcooldown;
    conditionobject = callback.conditionobject;
    group = callback.group;
    flags::gameflagwait( "prematch_done" );
    
    if ( initialcooldown > 0 )
    {
        wait initialcooldown;
    }
    
    while ( true )
    {
        if ( isdefined( condition ) )
        {
            if ( isstring( condition ) )
            {
                level waittill( condition, object );
                
                if ( isdefined( object ) && isdefined( conditionobject ) && object != conditionobject )
                {
                    continue;
                }
            }
            
            if ( isfunction( condition ) )
            {
                result = [[ condition ]]( zone );
                
                if ( !result )
                {
                    wait 1;
                    continue;
                }
            }
        }
        
        while ( level.var_40e874c343c0b751 )
        {
            waitframe();
        }
        
        if ( delaystart > 0 )
        {
            wait delaystart;
        }
        
        if ( level.zone != zone )
        {
            return;
        }
        
        dialog::leaderdialog( voline, game[ team ], group );
        
        if ( cooldown > 0 )
        {
            wait cooldown;
        }
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0xf63009df, Offset: 0xcc51
// Size: 0x35, Type: bool
function function_b59ef9dd289a9d36( zone )
{
    if ( zone.objectivetype == 6 )
    {
        return istrue( level.escortvehicles[ 0 ].contested );
    }
    
    return false;
}

// Namespace wm_objectives
// Params 0
// Checksum 0x18ba256f, Offset: 0xcc8f
// Size: 0xb8
function function_918d2f8f04e8780c()
{
    remains = level.zone.objectives.size;
    
    foreach ( objstr in level.zone.objectives )
    {
        if ( level.objectives[ objstr ].complete )
        {
            remains--;
        }
    }
    
    return remains;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x2e80a420, Offset: 0xcd50
// Size: 0x571
function function_b7e03fcf97628be9( zone )
{
    objective = zone.objective;
    
    if ( !isarray( objective.objectivekey ) )
    {
        objective.objectivekey = [ objective.objectivekey ];
    }
    
    objectivekeys = objective.objectivekey;
    targetname = objective.targetname[ 0 ];
    function_f58f6b815662a793( objective );
    node = getvehiclenode( targetname, #targetname );
    objectivekey = objectivekeys[ 0 ];
    var_2d8b654076d9a49d = utility::array_slice( objective.targetname, 1 );
    var_3bb2e3fb3c290d0e = utility::array_slice( objectivekeys, 1 );
    assert( var_2d8b654076d9a49d.size > 0, "<dev string:xcc>" );
    assert( var_3bb2e3fb3c290d0e.size > 0, "<dev string:xf5>" );
    
    if ( !isdefined( objectivekey ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = node.origin;
    spawndata.angles = node.angles;
    spawndata.spawntype = "veh_pac_sentry_amphibious_mp_skydiving";
    spawndata.ownerteam = game[ "attackers" ];
    spawndata.team = game[ "attackers" ];
    spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_mp";
    spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_skydiving";
    spawndata.targetname = "remote_tank";
    spawndata.cancapture = 0;
    spawndata.cancaptureimmediately = 0;
    spawndata.activateimmediately = 1;
    spawndata.objectivekey = objectivekey;
    spawndata.node = node;
    objective.spawndata = spawndata;
    marker = spawndata function_4ee235f8a5ab751f( objectivekey, &"mp_ingame_only/obj_halt_caps", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom" + objectivekey, game[ "attackers" ] );
    level.objectives[ objectivekey ] = marker;
    level.objectives[ objectivekey ].objectivetype = objective.objectivetype;
    level.var_47db09d3481c4b22 = getdvarfloat( @"hash_6cc435c9e8e9abd6", 30 );
    level.wheelsoncapturetime = dvars::dvarfloatvalue( "wheelsonCaptureTime", 30, 0, 120 );
    
    if ( isdefined( zone.objective.params[ "wheelsonCaptureTime" ] ) )
    {
        level.wheelsoncapturetime = zone.objective.params[ "wheelsonCaptureTime" ];
    }
    
    level.zonecapturetime = level.wheelsoncapturetime;
    pseudozone = spawnstruct();
    var_a7c598883b712c9d = spawnstruct();
    var_a7c598883b712c9d.objectivetype = 1;
    var_a7c598883b712c9d.objectivekey = var_3bb2e3fb3c290d0e;
    var_a7c598883b712c9d.objectiveid = "zone_2";
    var_a7c598883b712c9d.targetname = var_2d8b654076d9a49d;
    var_a7c598883b712c9d.params = [];
    pseudozone.objective = var_a7c598883b712c9d;
    pseudozone.objectives = var_3bb2e3fb3c290d0e;
    triggers = [];
    
    foreach ( name in var_a7c598883b712c9d.targetname )
    {
        triggers[ triggers.size ] = getent( name, #targetname );
    }
    
    pseudozone.capture_zones = [];
    
    foreach ( i, trigger in triggers )
    {
        var_20df0114caef6de4 = var_a7c598883b712c9d.objectivekey[ i ];
        trigger.objectivekey = var_20df0114caef6de4;
        trigger.script_label = var_20df0114caef6de4;
        capture_zone = obj_zonecapture::setupobjective( trigger, undefined, 0, 1 );
        capture_zone gameobjects::requestid( 1, 0 );
        capture_zone.iconname = var_20df0114caef6de4;
        level.objectives[ var_20df0114caef6de4 ] = capture_zone;
        level.objectives[ var_20df0114caef6de4 ].objectivetype = var_a7c598883b712c9d.objectivetype;
        capture_zone.id = "hack";
        capture_zone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_capture", capture_zone.objidnum, game[ "defenders" ] );
        capture_zone gameobjects::setvisibleteam( "none" );
        pseudozone.capture_zones[ pseudozone.capture_zones.size ] = capture_zone;
    }
    
    zone.var_6560dd6d652396f7 = pseudozone;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x56341701, Offset: 0xd2c9
// Size: 0x97
function function_b827ec035df6e37f( zone )
{
    var_a67927fb315679f0 = getent( "wheelson_airdrop", #script_noteworthy );
    destination_offset = zone.objective.params[ "airdrop_offset" ];
    
    if ( !isdefined( destination_offset ) )
    {
        destination_offset = ( 0, 0, 0 );
    }
    
    destination = var_a67927fb315679f0.origin + destination_offset;
    init_wheelson_airdrop();
    level thread airdrop_wheelson( var_a67927fb315679f0, destination );
    level thread function_6c8650a0ed96fa34( zone );
}

// Namespace wm_objectives
// Params 0
// Checksum 0xe7c26341, Offset: 0xd368
// Size: 0xd9
function function_3575b72028a0eb8c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level waittill( #"wheelson_spawn" );
    temppos = self.origin;
    var_42f095c32232b762 = 0;
    
    while ( true )
    {
        wait 0.25;
        
        if ( distancesquared( self.origin, temppos ) < 16 && self.shouldjump && !self.var_a95f4daa854f194f )
        {
            var_42f095c32232b762++;
        }
        else if ( distancesquared( self.origin, temppos ) > 16 )
        {
            var_42f095c32232b762 = 0;
        }
        
        if ( var_42f095c32232b762 >= 2 )
        {
            self.origin += ( 0, 0, 10 );
            var_42f095c32232b762 = 0;
        }
        
        temppos = self.origin;
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x6fdc5ec0, Offset: 0xd449
// Size: 0x14b
function function_10d1f152a55cff2e( zone )
{
    foreach ( player in level.players )
    {
        player.var_5ca1e62c2ae57e4f = undefined;
        player objidpoolmanager::function_101225acbc89c1c1( 0 );
    }
    
    objective = zone.objective;
    
    if ( isdefined( objective.params[ "leaderDialogAttackers" ] ) )
    {
        attackersleaderdialog = objective.params[ "leaderDialogAttackers" ];
        utility::delaythread( 2, &dialog::leaderdialog, attackersleaderdialog, game[ "attackers" ] );
    }
    
    if ( isdefined( objective.params[ "leaderDialogDefenders" ] ) )
    {
        defendersleaderdialog = objective.params[ "leaderDialogDefenders" ];
        utility::delaythread( 2, &dialog::leaderdialog, defendersleaderdialog, game[ "defenders" ] );
    }
    
    points::function_40522c040a4e7b1( game[ "attackers" ], #"hash_18c44b230263da2c" );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x4e91bd97, Offset: 0xd59c
// Size: 0x252
function function_d7e69fb3cfd09e87( var_6560dd6d652396f7 )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    var_6412832bdff2a59b = 0;
    
    foreach ( capturezone in var_6560dd6d652396f7.capture_zones )
    {
        /#
            capturezone.trigger thread debug_drawtrigger();
        #/
        
        var_6412832bdff2a59b++;
        
        if ( var_6412832bdff2a59b <= 1 )
        {
            function_13cf0b02e49da2ea( capturezone.trigger, 40000 );
            flags::gameflagset( "wheelson_reach_hack_point" );
        }
        
        function_13cf0b02e49da2ea( capturezone.trigger, 1600 );
        level.zonecapturetime = level.wheelsoncapturetime;
        capturezone gameobjects::setusetime( level.zonecapturetime );
        capturezone obj_zonecapture::activatezone( undefined, 1 );
        capturezone.onuse = &wmzone_onuse;
        capturezone.onbeginuse = &function_39bc8348386021a0;
        capturezone.onenduse = &function_95759ebcf4f14e40;
        capturezone.onuseupdate = &function_b3aa6e76db7d553;
        capturezone gameobjects::setownerteam( game[ "defenders" ] );
        capturezone.ignorestomp = 1;
        capturezone.useratemultiplier = 1;
        capturezone.var_2809cba8dafcf8cf = level.flagreinforcement;
        capturezone.blockcapdisabled = 1;
        capturezone thread obj_zonecapture::updatechevrons( game[ "defenders" ] );
        capturezone gameobjects::enableobject();
        capturezone gameobjects::setownerteam( game[ "defenders" ] );
        capturezone gameobjects::allowuse( "enemy" );
        capturezone.var_b0a668cb588348ad = &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS";
        capturezone.pointidx = var_6412832bdff2a59b;
        self.var_1d34b4d9f078cf7c = 1;
        level waittill( #"wm_zone_captured" );
        self notify( "point_" + var_6412832bdff2a59b + "_hacked" );
        self.var_1d34b4d9f078cf7c = 0;
    }
    
    self.var_c056afd1f782e807 = 1;
}

// Namespace wm_objectives
// Params 2
// Checksum 0xf4014159, Offset: 0xd7f6
// Size: 0x3f
function function_13cf0b02e49da2ea( trigger, distsquared )
{
    while ( true )
    {
        if ( distancesquared( self.origin, trigger.origin ) <= distsquared )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace wm_objectives
// Params 4
// Checksum 0xa991295, Offset: 0xd83d
// Size: 0xe0
function function_b3aa6e76db7d553( team, progress, change, capplayer )
{
    obj_zonecapture::zone_onuseupdate( team, progress, change, capplayer );
    
    if ( !isdefined( level.escortvehicles ) || level.escortvehicles.size < 1 )
    {
        return;
    }
    
    if ( progress >= 0.3 && !self.firstnotified )
    {
        level.escortvehicles[ 0 ] notify( "point_" + self.pointidx + "_30_percent" );
        self.firstnotified = 1;
    }
    
    if ( progress >= 0.8 && !self.secondnotified )
    {
        level.escortvehicles[ 0 ] notify( "point_" + self.pointidx + "_80_percent" );
        self.secondnotified = 1;
    }
}

// Namespace wm_objectives
// Params 2
// Checksum 0x10a28af3, Offset: 0xd925
// Size: 0x44a
function function_e71440dd39733479( vehicle, objidnum )
{
    level endon( #"game_ended" );
    assert( vehicle.pathnodes.size > 0 );
    endnode = vehicle.pathnodes[ vehicle.pathnodes.size - 1 ];
    totaldistance = endnode.var_7d71d1774b14f738;
    vehicle.var_4f6ccc87c3912e74 = 1 / totaldistance;
    
    /#
        level thread function_d0d3171f2840655( vehicle, vehicle.pathnodes );
    #/
    
    if ( vehicle.spawndata.spawnmethod == "airdrop_at_position_unsafe" )
    {
        vehicle waittill( #"landed" );
    }
    
    objidpoolmanager::objective_set_show_progress( objidnum, 0 );
    objidpoolmanager::objective_set_progress_team( objidnum, game[ "defenders" ] );
    var_8ede98cb669fd389 = 900;
    
    while ( vehicle.progress != 1 )
    {
        waitframe();
        
        if ( !vehicle.usep2p )
        {
            if ( !isdefined( vehicle.var_63ba5ed26f65fcf2 ) )
            {
                vehicle.var_63ba5ed26f65fcf2 = 1;
            }
            
            var_4e649fe1840782ee = distance2dsquared( vehicle.pathnodes[ vehicle.var_63ba5ed26f65fcf2 ].origin, vehicle.origin );
            var_54b2a20d00cbc49b = distance2dsquared( vehicle.pathnodes[ vehicle.var_63ba5ed26f65fcf2 - 1 ].origin, vehicle.origin );
            
            if ( vehicle.var_63ba5ed26f65fcf2 + 1 < vehicle.pathnodes.size && var_4e649fe1840782ee < var_8ede98cb669fd389 && !vehicle.shouldreverse )
            {
                vehicle.var_63ba5ed26f65fcf2++;
            }
            else if ( vehicle.var_63ba5ed26f65fcf2 > 0 && var_54b2a20d00cbc49b < var_8ede98cb669fd389 && vehicle.shouldreverse )
            {
                vehicle.var_63ba5ed26f65fcf2--;
            }
            
            /#
                print3d( vehicle.origin + ( 0, 0, 200 ), var_4e649fe1840782ee, ( 1, 0, 0 ) );
            #/
        }
        
        var_dcbbd1ab56484f24 = vehicle.var_63ba5ed26f65fcf2 - 1;
        backnode = vehicle.pathnodes[ var_dcbbd1ab56484f24 ];
        
        if ( !isdefined( backnode ) )
        {
            continue;
        }
        
        cachedistance = distance2d( vehicle.origin, backnode.origin );
        progress = ( backnode.var_7d71d1774b14f738 + cachedistance ) / totaldistance;
        
        if ( progress > 1 )
        {
            progress = 1;
        }
        else if ( vehicle.var_63ba5ed26f65fcf2 >= vehicle.pathnodes.size - 1 )
        {
            var_4349a4f6daf0c1 = distancesquared( vehicle.pathnodes[ vehicle.pathnodes.size - 1 ].origin, vehicle.origin ) < var_8ede98cb669fd389;
            
            if ( var_4349a4f6daf0c1 )
            {
                progress = 1;
            }
        }
        
        if ( vehicle.var_c056afd1f782e807 )
        {
            progress = 1;
        }
        else if ( 1 == progress )
        {
            progress = 0.99;
        }
        
        vehicle.progress = progress;
        
        if ( isdefined( vehicle.checkpoints[ vehicle.stageid ] ) )
        {
            if ( vehicle.progress >= vehicle.checkpoints[ vehicle.stageid ].progress )
            {
                vehicle.stageid++;
            }
        }
        
        objidpoolmanager::objective_set_progress( objidnum, progress );
        
        /#
            print3d( vehicle.origin + ( 0, 0, 72 ), "<dev string:x5f>" + int( cachedistance ) + "<dev string:x67>" + backnode.var_7d71d1774b14f738 + "<dev string:x73>" + distance2d( vehicle.origin, vehicle.pathnodes[ var_dcbbd1ab56484f24 + 1 ].origin ) );
        #/
    }
    
    function_98835ce975f57cef( vehicle );
}

// Namespace wm_objectives
// Params 1
// Checksum 0x68084fcc, Offset: 0xdd77
// Size: 0x23e
function function_6c8650a0ed96fa34( zone )
{
    level endon( #"game_ended" );
    level endon( zone.name + "_objective_end" );
    flags::gameflagwait( "zone_2" + "_objective_start" );
    var_cbde44f7ece7a0db = getentarray( "wheelson_route", #targetname );
    
    foreach ( var_9bb574a7515bceca in var_cbde44f7ece7a0db )
    {
        var_9bb574a7515bceca hide();
    }
    
    level waittill( #"wheelson_spawn", vehicle );
    
    foreach ( var_9bb574a7515bceca in var_cbde44f7ece7a0db )
    {
        var_9bb574a7515bceca show();
    }
    
    while ( true )
    {
        foreach ( var_9bb574a7515bceca in var_cbde44f7ece7a0db )
        {
            if ( isdefined( var_9bb574a7515bceca.script_noteworthy ) && vehicle.progress > 0 && float( var_9bb574a7515bceca.script_noteworthy ) < vehicle.progress )
            {
                var_9bb574a7515bceca hide();
                continue;
            }
            
            if ( isdefined( var_9bb574a7515bceca.script_noteworthy ) && vehicle.progress > 0 && float( var_9bb574a7515bceca.script_noteworthy ) > vehicle.progress )
            {
                var_9bb574a7515bceca show();
            }
        }
        
        waitframe();
    }
}

// Namespace wm_objectives
// Params 0
// Checksum 0x72b15fcf, Offset: 0xdfbd
// Size: 0x136
function init_wheelson_airdrop()
{
    leveldata = airdrop::getleveldata( "wheelson_drop" );
    leveldata.capturestring = &"mp/br_crate_loadout";
    leveldata.basemodel = "military_carepackage_03_mp";
    leveldata.supportsownercapture = 1;
    leveldata.headicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.minimapicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.usepriority = -1;
    leveldata.usefov = 360;
    leveldata.timeout = 1000;
    leveldata.friendlyuseonly = 1;
    leveldata.maxusage = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 0.5;
    leveldata.activatecallback = &function_788635e6d716c36c;
    leveldata.capturecallback = &function_76b1a9fefb95616b;
    leveldata.destroyoncapture = 1;
    leveldata.onecaptureperplayer = 1;
    leveldata.isteamonlycrate = 1;
}

// Namespace wm_objectives
// Params 1
// Checksum 0x80ed942d, Offset: 0xe0fb
// Size: 0x48
function function_788635e6d716c36c( isfirstactivation )
{
    if ( isfirstactivation )
    {
        if ( utility::issharedfuncdefined( #"airdrop", #"registercrateforcleanup" ) )
        {
            [[ utility::getsharedfunc( #"airdrop", #"registercrateforcleanup" ) ]]( self );
        }
    }
}

// Namespace wm_objectives
// Params 1
// Checksum 0x13b2e376, Offset: 0xe14b
// Size: 0x164
function function_76b1a9fefb95616b( player )
{
    spawndata = level.zone.objective.spawndata;
    vehicle = vehicle_tracking::spawn_vehicle( spawndata );
    level.escortvehicles[ level.escortvehicles.size ] = vehicle;
    vehicle.team = game[ "attackers" ];
    vehicle.teamfriendlyto = game[ "attackers" ];
    function_ee17ba2f6cc82a83( level.zone );
    
    if ( isdefined( level.zone.var_6560dd6d652396f7 ) )
    {
        vehicle thread function_d7e69fb3cfd09e87( level.zone.var_6560dd6d652396f7 );
    }
    
    level thread function_9136fc5c3f0d9275( level.zone.objective, vehicle, vehicle.spawndata.objectivekey, vehicle.spawndata, vehicle.spawndata.node, level.objectives[ vehicle.spawndata.objectivekey ] );
    vehicle.var_4e15a2bc8cfff891 = 1;
    wait 1;
    vehicle.var_4e15a2bc8cfff891 = 0;
    level notify( #"wheelson_spawn", vehicle );
}

// Namespace wm_objectives
// Params 2
// Checksum 0x293aed11, Offset: 0xe2b7
// Size: 0xd3
function airdrop_wheelson( var_a67927fb315679f0, destination )
{
    level endon( #"game_ended" );
    level endon( level.zone.name + "_objective_end" );
    
    while ( true )
    {
        [ fakeowner ] = teams::getteamdata( game[ "attackers" ], "players" );
        
        if ( isdefined( fakeowner ) )
        {
            break;
        }
        
        waitframe();
    }
    
    level.cratedropdata.heliheight = destination[ 2 ];
    var_e0b7389ffa077ef4 = airdrop::dropcratefromscriptedheli( fakeowner, game[ "attackers" ], "wheelson_drop", var_a67927fb315679f0.origin, var_a67927fb315679f0.angles, destination, airdrop::getleveldata( "wheelson_drop" ) );
}

