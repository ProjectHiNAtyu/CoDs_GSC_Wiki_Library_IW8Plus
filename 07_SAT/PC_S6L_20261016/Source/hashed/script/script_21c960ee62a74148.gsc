// script_21c960ee62a74148  (hash_21c960ee62a74148.gscc) (size: 11804 Bytes / 0x2e1c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e3dd224 (2386416164)
// size ...... 11804 (0x2e1c)
// includes .. 18  (offset: 0x28e0)
// strings ... 80  (offset: 0x2970)
// dev strs .. 0   (offset: 0x2e1c)
// exports ... 24  (offset: 0x1a50)
// cseg ...... 0x9be + 0x1092 (0x1a50)
// imports ... 86  (offset: 0x1e10)
// animtree1 . 0   (offset: 0x2e1c)
// animtree2 . 0   (offset: 0x2e1c)
#using script_38b1fdddff7cdad3;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_c39149bef9f95862;

/#

    // Namespace namespace_c39149bef9f95862
    // Params 0
    // Checksum 0x3dc0573c, Offset: 0x9dc
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_c39149bef9f95862
// Params 0, eflags: 0x5
// Checksum 0xdd9d2165, Offset: 0x9e9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_23a0d06d3b2b2f71", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c39149bef9f95862
// Params 0, eflags: 0x4
// Checksum 0x2c486ca, Offset: 0xa12
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_INFIL_PACKING";
    activity_common::registeractivitytype( "OB_LIBRA_INFIL_PACKING", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_PACKING", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_PACKING", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_PACKING", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xc5cc86f6, Offset: 0xa73
// Size: 0x66
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance setup_ui_widget();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x97433c8b, Offset: 0xae1
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance function_57d0abd80fb839cc();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xa0f7ccc3, Offset: 0xb31
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x86a93983, Offset: 0xb55
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
}

/#

    // Namespace namespace_c39149bef9f95862
    // Params 0
    // Checksum 0x7a7af32c, Offset: 0xb6b
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xfd33a946, Offset: 0xb78
// Size: 0x12
function start()
{
    level thread function_3d7457c62e8fc707();
    level thread function_d9458092aa6676f2();
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x2d55530, Offset: 0xb92
// Size: 0x182
function function_57d0abd80fb839cc()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_libra_packing", "flag_igc_answers_done", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_packing", "flag_igc_answers_done", 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "s_supply_cache_libra_packing" );
    case_struct = utility::getstruct( "ability_struct_packing", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_war_machine", "super_annihilator", #"default" );
    }
    
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "upper_packing_waypoint_org", undefined, "upper_packing_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_packing_intro_robotic_arms", "upper_packing_waypoint_org" );
    level thread mp_sat_ob_libra_lighting::function_7ba8f081958256f6( [ "flag_packing_robotic_arms_group_01_group_destroyed", "flag_packing_robotic_arms_group_02_group_destroyed", "flag_packing_robotic_arms_group_03_group_destroyed" ], "flag_igc_answers_start", 256, 8, 4 );
    level thread mp_sat_ob_libra_util::setup_robotic_modules( "packing_robotic_module", "flag_igc_answers_start" );
    level thread packing_entrance_door_opened();
    level thread weapons_free();
    level thread mp_sat_ob_libra_vo::function_63b3f54e8edb4941();
    thread function_1f920a7b21ff51a6();
    level thread function_2443380b1f7ca806();
    level thread namespace_fcc50569ce051cc1::igc_answers_pre_stream( [ "flag_packing_2_combat_done", "flag_all_robotic_packing_modules_destroyed" ] );
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "packing_fan", "roll", 2, "flag_infil_packing_done", %"electronics_fan_box_lg_01_blade" );
    level thread mp_sat_ob_libra_vo::function_fcdbcf5317d4606c();
    level utility::flag_wait( "flag_infil_packing_done" );
    level thread cleanup_storage();
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x76696d68, Offset: 0xd1c
// Size: 0x41
function packing_entrance_door_opened()
{
    packing_entrance_door = getent( "packing_entrance_door", #script_noteworthy );
    
    if ( isdefined( packing_entrance_door ) )
    {
        packing_entrance_door waittill( #"trigger" );
        level utility::flag_set( "flag_packing_entrance_door_opened" );
    }
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x297ed934, Offset: 0xd65
// Size: 0x1d
function weapons_free()
{
    level utility::flag_wait( "flag_packing_entrance_door_opened" );
    wait 1;
    level thread mp_sat_ob_libra_vo::packing_intro_contact_weapons_free();
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x4c7ce1c2, Offset: 0xd8a
// Size: 0xe8
function packing_intro_enemies()
{
    level.var_cbd7b1bb83c3e42c = [];
    ai_spawn_director::array_spawn_function_noteworthy( "packing_intro_enemy_01", &packing_spawn_func );
    ai_spawn_director::array_spawn_function_noteworthy( "packing_intro_enemy_02", &packing_spawn_func );
    ai_spawn_director::array_spawn_function_noteworthy( "packing_intro_enemy_01", &function_525bcbfc86242bf9 );
    ai_spawn_director::array_spawn_function_noteworthy( "packing_intro_enemy_02", &function_525bcbfc86242bf9 );
    ai_spawn_director::array_spawn_function_targetname( "packing_intro_enemies", &function_525bcbfc86242bf9 );
    packing_intro_enemies = ai_spawn_director::array_spawn_targetname( "packing_intro_enemies" );
    level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_intro_enemies );
    packing_intro_enemies_scene_root = utility::getstruct( "packing_intro_enemies_scene_root" );
    packing_intro_enemies_scene_root thread scene::play( packing_intro_enemies, "loop" );
    level.packing_intro_enemy_01.scene_root = packing_intro_enemies_scene_root;
    level.packing_intro_enemy_02.scene_root = packing_intro_enemies_scene_root;
    level thread mp_sat_ob_libra_vo::packing_intro_enemy_conversation();
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xfe68bb55, Offset: 0xe7a
// Size: 0x568
function function_1f920a7b21ff51a6()
{
    level.var_6fae192d5fa4845d = 1;
    level utility::flag_set( "flag_infil_packing_start" );
    level thread packing_intro_enemies();
    level utility::flag_wait( "flag_spawn_packing_room_1" );
    level thread libra_audio::function_ddf1397edd228987();
    
    if ( isdefined( level.packing_intro_enemy_01 ) )
    {
        level.packing_intro_enemy_01 notify( #"stop_conversation" );
    }
    
    if ( isdefined( level.packing_intro_enemy_02 ) )
    {
        level.packing_intro_enemy_02 notify( #"stop_conversation" );
    }
    
    ai_spawn_director::array_spawn_function_targetname( "packing_enemies", &function_525bcbfc86242bf9 );
    packing_enemies = ai_spawn_director::array_spawn_targetname( "packing_enemies" );
    level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies );
    
    if ( level.is_squad_size_small == 0 )
    {
        ai_spawn_director::array_spawn_function_targetname( "packing_enemies_large", &function_525bcbfc86242bf9 );
        packing_enemies_large = ai_spawn_director::array_spawn_targetname( "packing_enemies_large" );
        level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies_large );
    }
    
    thread lower_packing_entrance_door();
    thread function_897707f120d750e8();
    level.audio.var_25e584ceb1945db6[ "packing" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "packing" ] thread libra_audio::combat_walla_oneshot( level.var_cbd7b1bb83c3e42c, "packing", "dxx_libra_coordinated_int", 3, 9, 6 );
    level utility::flag_wait( "flag_packing_wave_1" );
    ai_spawn_director::array_spawn_function_targetname( "packing_enemies_wave2", &function_525bcbfc86242bf9 );
    packing_enemies_wave2 = ai_spawn_director::array_spawn_targetname( "packing_enemies_wave2" );
    level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies_wave2 );
    
    if ( level.is_squad_size_small == 0 )
    {
        ai_spawn_director::array_spawn_function_targetname( "packing_enemies_wave2_large", &function_525bcbfc86242bf9 );
        packing_enemies_wave2_large = ai_spawn_director::array_spawn_targetname( "packing_enemies_wave2_large" );
        level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies_wave2_large );
    }
    
    level utility::flag_wait( "flag_packing_room_3_fallback_1" );
    ai_spawn_director::array_spawn_function_targetname( "packing_enemies_wave3", &function_525bcbfc86242bf9 );
    packing_enemies_wave3 = ai_spawn_director::array_spawn_targetname( "packing_enemies_wave3" );
    level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies_wave3 );
    
    if ( level.is_squad_size_small == 0 )
    {
        ai_spawn_director::array_spawn_function_targetname( "packing_enemies_wave3_large", &function_525bcbfc86242bf9 );
        packing_enemies_wave3_large = ai_spawn_director::array_spawn_targetname( "packing_enemies_wave3_large" );
        level.var_cbd7b1bb83c3e42c = arraycombine( level.var_cbd7b1bb83c3e42c, packing_enemies_wave3_large );
    }
    
    level utility::flag_wait( "flag_packing_intro_robotic_arms" );
    level thread mp_sat_ob_libra_vo::robotic_arm_callout();
    
    if ( !level utility::flag( "flag_packing_robotic_arms_group_01_group_destroyed" ) )
    {
        ob_story_mission_utils::objective_text_show( "OB_LIBRA_INFIL_PACKING" );
        ob_story_mission_utils::function_315d79883d962ba7( level.robotic_packing_modules_destroyed, 1 );
    }
    
    level utility::flag_wait( "flag_packing_wave_2" );
    level.var_c9392b00ae3eae16 = [];
    lower_packing_enemies = ai_spawn_director::array_spawn_targetname( "lower_packing_enemies" );
    level thread libra_audio::function_c0de1a36e5c5791();
    level.var_c9392b00ae3eae16 = arraycombine( level.var_c9392b00ae3eae16, lower_packing_enemies );
    
    if ( level.is_squad_size_small == 0 )
    {
        lower_packing_enemies_large = ai_spawn_director::array_spawn_targetname( "lower_packing_enemies_large" );
        level.var_c9392b00ae3eae16 = arraycombine( level.var_c9392b00ae3eae16, lower_packing_enemies_large );
    }
    
    level utility::flag_wait_any( "flag_packing_robotic_arms_group_02_group_destroyed", "flag_packing_robotic_arms_group_03_group_destroyed" );
    lower_packing_enemies_cradle = ai_spawn_director::array_spawn_targetname( "lower_packing_enemies_cradle" );
    level.var_c9392b00ae3eae16 = arraycombine( level.var_c9392b00ae3eae16, lower_packing_enemies_cradle );
    
    if ( level.is_squad_size_small == 0 )
    {
        wait 1;
        spawners = utility::getstructarray( "lower_packing_enemies_cradle_large", "targetname" );
        
        if ( isdefined( spawners ) )
        {
            lower_packing_enemies_cradle_large = ai_spawn_director::array_spawn_targetname( "lower_packing_enemies_cradle_large" );
            level.var_c9392b00ae3eae16 = arraycombine( level.var_c9392b00ae3eae16, lower_packing_enemies_cradle_large );
        }
    }
    
    level.audio.var_25e584ceb1945db6[ "lower_packing" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "lower_packing" ] thread libra_audio::combat_walla_oneshot( level.var_c9392b00ae3eae16, "lower_packing", "dxx_libra_coordinated_int", 3, 7, 3 );
    level thread mp_sat_ob_libra_util::function_d8b65cd09b5a50bb( level.var_c9392b00ae3eae16, "flag_packing_2_combat_done", 1 );
    level utility::flag_wait_all( "flag_packing_2_combat_done", "flag_all_robotic_packing_modules_destroyed", "flag_packing_nice_work_done" );
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( "packing_door_interact", "flag_packing_door_interacted", &"sat_ob_story_missions/interact_unlock" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "packing_door_interact", undefined, "packing_door_interact_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_packing_door_interacted", "packing_door_interact" );
    level utility::flag_wait( "flag_packing_door_interacted" );
    options = spawnstruct();
    options.triggertargetname = "igc_answers_regroup_trigger";
    igc_answers_regroup_org = utility::getstruct( "igc_answers_regroup_org" );
    
    if ( isdefined( igc_answers_regroup_org ) )
    {
        options.var_ba7c3b8fa9d3823 = igc_answers_regroup_org;
    }
    
    coop::function_164d95b45992525( options );
    function_d21cd9ec01b2df47( 200, "WorldAndHud", ( 0, 0, 0 ) );
    wait 0.25;
    level utility::flag_set( "flag_infil_packing_done" );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xc47cc03e, Offset: 0x13ea
// Size: 0x27
function function_525bcbfc86242bf9()
{
    self waittill( #"death" );
    level.var_cbd7b1bb83c3e42c = utility::array_removedead_or_dying( level.var_cbd7b1bb83c3e42c );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x8f2d47ec, Offset: 0x1419
// Size: 0x119
function lower_packing_entrance_door()
{
    level utility::flag_wait( "flag_robotic_arm_callout_done" );
    level utility::flag_wait( "flag_packing_robotic_arms_group_01_group_destroyed" );
    level utility::flag_set( "flag_enable_lower_packing_entrance_door" );
    level thread mp_sat_ob_libra_vo::robotic_arm_upper_complete();
    level.robotic_packing_modules_destroyed = 0;
    level.var_6fae192d5fa4845d = 2;
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "lower_packing_entrance_door_waypoint_org", undefined, "lower_packing_entrance_door_waypoint_org_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_lower_packing_entrance_door_opened", "lower_packing_entrance_door_waypoint_org" );
    level utility::flag_wait( "flag_lower_packing_entrance_door_opened" );
    level thread mp_sat_ob_libra_vo::one_module_left();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "lower_packing_waypoint_org", undefined, "lower_packing_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_packing_more_robotic_arms", "lower_packing_waypoint_org" );
    level utility::flag_wait( "flag_packing_more_robotic_arms" );
    level thread mp_sat_ob_libra_vo::robotic_arm_second_callout();
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_packing" );
    ob_story_mission_utils::function_315d79883d962ba7( level.robotic_packing_modules_destroyed, 2 );
    level utility::flag_set( "flag_enable_packing_robotic_arms_group_02" );
    level utility::flag_set( "flag_enable_packing_robotic_arms_group_03" );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x8a4d6020, Offset: 0x153a
// Size: 0x9b
function packing_spawn_func()
{
    utility::set_battlechatter( 0 );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        switch ( self.script_noteworthy )
        {
            case #"hash_a922a680887cd040":
                level.packing_intro_enemy_01 = self;
                break;
            case #"hash_a922a980887cd4f9":
                level.packing_intro_enemy_02 = self;
                break;
            default:
                break;
        }
    }
    
    level utility::flag_wait( "flag_packing_entrance_door_opened" );
    self.ignoreall = 0;
    self.ignoreme = 0;
    val::reset( "scene_shot", "death" );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xb6449c99, Offset: 0x15dd
// Size: 0x221
function function_897707f120d750e8()
{
    vol = getent( "bottom_packing_player_vol", "targetname" );
    
    while ( !utility::flag( "all_players_downstairs" ) || !utility::flag( "flag_infil_packing_done" ) )
    {
        players = ob_story_mission_utils::get_playing_players();
        allplayerstouching = 1;
        
        if ( isdefined( vol ) && isdefined( players ) )
        {
            foreach ( player in players )
            {
                if ( !player istouching( vol ) )
                {
                    allplayerstouching = 0;
                    break;
                }
            }
            
            if ( allplayerstouching == 1 )
            {
                utility::flag_set( "all_players_downstairs" );
                break;
            }
        }
        
        wait 1;
    }
    
    level utility::flag_wait_any( "flag_infil_packing_done", "all_players_downstairs" );
    level.var_cbd7b1bb83c3e42c = utility::array_removedead_or_dying( level.var_cbd7b1bb83c3e42c );
    
    foreach ( agent in level.var_cbd7b1bb83c3e42c )
    {
        if ( isdefined( agent ) && ( agent.script_noteworthy == "upper_packing_enemies" || agent.script_noteworthy == "packing_intro_enemy_01" || agent.script_noteworthy == "packing_intro_enemy_02" ) )
        {
            agent.ignoreme = 1;
            agent.dontevershoot = 1;
            agent.nocorpse = 1;
            agent.var_70fbc1727d54c322 = 1;
            agent.battlechatterallowed = 0;
            agent kill();
        }
    }
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x911cb9ca, Offset: 0x1806
// Size: 0xdc
function cleanup_storage()
{
    if ( isdefined( level.var_75dacee2337798ec ) )
    {
        level.var_75dacee2337798ec thread scene::cleanup( 1 );
    }
    
    if ( isdefined( level.var_af192118978d72d9 ) )
    {
        level.var_af192118978d72d9 thread scene::cleanup( 1 );
    }
    
    if ( isdefined( level.var_d33a60801d7aac42 ) )
    {
        level.var_d33a60801d7aac42 thread scene::cleanup( 1 );
    }
    
    if ( isdefined( level.var_d33a5f801d7aaa0f ) )
    {
        level.var_d33a5f801d7aaa0f thread scene::cleanup( 1 );
    }
    
    if ( isdefined( level.var_d33a5e801d7aa7dc ) )
    {
        level.var_d33a5e801d7aa7dc thread scene::cleanup( 1 );
    }
    
    if ( isdefined( level.var_d33a5d801d7aa5a9 ) )
    {
        level.var_d33a5d801d7aa5a9 thread scene::cleanup( 1 );
    }
    
    utility::array_delete( level.crate_clips );
    utility::array_delete( level.var_2e0766b4bf1f8763 );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0xa0561f46, Offset: 0x18ea
// Size: 0x2f
function function_3d7457c62e8fc707()
{
    vista_tube_exit_door = getent( "vista_tube_exit_door", #script_noteworthy );
    
    if ( isdefined( vista_tube_exit_door ) )
    {
        vista_tube_exit_door thread scriptable_door_utility::simple_lock_door();
    }
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x346998ea, Offset: 0x1921
// Size: 0x86
function function_2443380b1f7ca806()
{
    level thread function_360b4ab98a496d91( "flag_packing_robotic_arms_group_01_group_destroyed", "cradle_loader_area_module1", utility::getstruct( "packing_robotic_arms_group_01_group_waypoint_org" ).origin, "flag_igc_answers_start" );
    level thread function_360b4ab98a496d91( "flag_packing_robotic_arms_group_02_group_destroyed", "cradle_loader_area_module2", utility::getstruct( "packing_robotic_arms_group_02_group_waypoint_org" ).origin, "flag_igc_answers_start" );
    level thread function_360b4ab98a496d91( "flag_packing_robotic_arms_group_03_group_destroyed", "cradle_loader_area_module3", utility::getstruct( "packing_robotic_arms_group_03_group_waypoint_org" ).origin, "flag_igc_answers_start" );
}

// Namespace namespace_c39149bef9f95862
// Params 4
// Checksum 0x3c2948c2, Offset: 0x19af
// Size: 0x6e
function function_360b4ab98a496d91( waitflag, explodername, origin, cleanupflag )
{
    level utility::flag_wait( waitflag );
    utility::exploder( explodername );
    level libra_audio::function_65ced7f0b3eaf0d6( explodername );
    level thread namespace_a350a26c6d662a6a::cradle_burst( origin, 450, "heavy", undefined, 200, 1 );
    level utility::flag_wait( cleanupflag );
    utility::kill_exploder( explodername );
}

// Namespace namespace_c39149bef9f95862
// Params 0
// Checksum 0x206bc3de, Offset: 0x1a25
// Size: 0x2b
function function_d9458092aa6676f2()
{
    stor_pack_hal_clips = getentarray( "stor_pack_hal_clip", "targetname" );
    
    if ( isdefined( stor_pack_hal_clips ) )
    {
        utility::array_delete( stor_pack_hal_clips );
    }
}

