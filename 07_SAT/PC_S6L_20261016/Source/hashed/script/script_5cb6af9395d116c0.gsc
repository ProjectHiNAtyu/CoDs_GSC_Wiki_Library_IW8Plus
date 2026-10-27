// script_5cb6af9395d116c0  (hash_5cb6af9395d116c0.gscc) (size: 46180 Bytes / 0xb464 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7e8a6df (3353913055)
// size ...... 46180 (0xb464)
// includes .. 24  (offset: 0xa108)
// strings ... 301 (offset: 0xa1c8)
// dev strs .. 5   (offset: 0xb428)
// exports ... 66  (offset: 0x79a4)
// cseg ...... 0x1ab7 + 0x5eed (0x79a4)
// imports ... 205 (offset: 0x83f4)
// animtree1 . 0   (offset: 0xb464)
// animtree2 . 0   (offset: 0xb464)
#using script_191ba368ff79359f;
#using script_24ca45b70d66c3c3;
#using script_4e2becc40a3e7251;
#using script_636bd827a012af12;
#using script_cdbbc61db6e8ab4;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\gametypes\ob;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\overlord;

#namespace scorpio;

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0x44c13db0, Offset: 0x1ad5
    // Size: 0x5, Type: dev
    function function_765d5611b3f752e()
    {
        
    }

#/

// Namespace scorpio
// Params 0, eflags: 0x5
// Checksum 0xe9eabbf, Offset: 0x1ae2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e3da154112af8c29", undefined, undefined, &post_main );
}

// Namespace scorpio
// Params 0, eflags: 0x1
// Checksum 0x4662d37d, Offset: 0x1b03
// Size: 0xd
function autoexec init()
{
    level.var_f101738a21c4e19 = 1;
}

// Namespace scorpio
// Params 0
// Checksum 0xa835065e, Offset: 0x1b18
// Size: 0x162
function post_main()
{
    if ( function_4ab01cfee124a691() )
    {
        return;
    }
    
    utility::add_fx( "dust_kickup", "vfx_sat_sco_robot_footstep_dust_3" );
    utility::add_fx( "scorpio_laser", "vfx_sat_sco_eye_beam_1" );
    utility::add_fx( "scorpio_pad_enabled", "vfx_sat_ob_scorpio_footstomp_indicator" );
    utility::add_fx( "scorpio_pad_disabled", "vfx_sat_levels_mp_sat_scar_electrical_fire_1" );
    utility::add_fx( "scorpio_summon_portal", "vfx_sat_sco_robot_summon_portal_1" );
    utility::add_fx( "scorpio_summon_dust", "vfx_sat_sco_robot_summon_dust_1_chd_1" );
    utility::add_fx( "scorpio_summon_laser", "vfx_sat_sco_robot_summon_laser_1" );
    utility::add_fx( "headlaunch_start", "vfx_sat_sco_robot_headlaunch_start" );
    utility::add_fx( "headlaunch_eject", "vfx_sat_sco_robot_headlaunch_eject" );
    utility::add_fx( "headlaunch_wind_down", "vfx_sat_sco_robot_headlaunch_wind_down_1" );
    utility::add_fx( "vfx_sat_sco_robot_ext_pad_pulse_1", "vfx_sat_sco_robot_ext_pad_pulse_1" );
    utility::add_fx( "scorpio_portal_start", "vfx_sat_sco_cradle_portal_1_start" );
    utility::add_fx( "scorpio_portal_loop", "vfx_sat_sco_cradle_portal_1_loop" );
    utility::add_fx( "scorpio_portal_end", "vfx_sat_sco_cradle_portal_1_end" );
    utility::add_fx( "scorpio_back_thrusters", "vfx_sat_sco_robot_exit_eject_back_1" );
    utility::add_fx( "scorpio_calf_thrusters", "vfx_sat_sco_robot_exit_eject_back_2" );
    utility::add_fx( "scorpio_foot_thrusters", "vfx_sat_sco_robot_exit_eject" );
    function_7d36e012de961e91();
    level thread scorpio_debug::function_b94262a07ef51ab8();
    level thread function_6f222930cea290e2();
    level thread audio_utility::snd_transient_load( "mp_sat_ob_scorpio" );
    activity_common::registeractivitytype( "REV_OB_SCORPIO_UNLOCK", &scorpio_unlock::activity_type_init );
}

// Namespace scorpio
// Params 0, eflags: 0x4
// Checksum 0x9304ad60, Offset: 0x1c82
// Size: 0x43, Type: bool
function private function_4ab01cfee124a691()
{
    if ( getdvarint( @"hash_966b52e88462c2bb", 0 ) != 0 )
    {
        return false;
    }
    
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( !isdefined( var_bb86f77304f193c4 ) || var_bb86f77304f193c4.var_69c82bbd1c5287e8 )
    {
        return false;
    }
    
    return true;
}

// Namespace scorpio
// Params 0
// Checksum 0xd67b3955, Offset: 0x1cce
// Size: 0x80
function function_6f222930cea290e2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        force_unlock = getdvarint( @"hash_2c79bf8106ddb5da", 0 );
        
        if ( force_unlock != 0 )
        {
            if ( force_unlock == 1 )
            {
                level.scorpio_path_chosen = "path_01";
            }
            else if ( force_unlock == 2 )
            {
                level.scorpio_path_chosen = "path_02";
            }
            else
            {
                waitframe();
                continue;
            }
            
            level thread function_2737405cf9fb2a23();
            function_41c0ac831f272407();
            break;
        }
        
        waitframe();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x3044a051, Offset: 0x1d56
// Size: 0xe1
function function_41c0ac831f272407()
{
    level endon( #"game_ended" );
    level.var_2269853965fd4bfd = [];
    utility::flag_wait( "scriptables_ready" );
    utility::flag_wait( "scorpio_portal_hold_complete" );
    level thread scorpio_exterior::function_e42b96423718d54d();
    level thread setup_scorpio_rig();
    utility::flag_wait( "scorpio_setup_complete" );
    
    if ( level.scorpio_path_chosen == "path_01" )
    {
        thread function_3cffc07b3e2ef150( 1 );
    }
    else if ( level.scorpio_path_chosen == "path_02" )
    {
        thread function_3cffc37b3e2ef7e9( 1 );
    }
    
    wait 13;
    level thread function_f9203494383ed4b1();
    level thread function_f98e0d774c4f64f7();
    scorpio_spawn_vo = [ "scorpio_arrival_5050", "scorpio_arrival_samy", "scorpio_arrival_davi", "scorpio_arrival_harp" ];
    overlord::playevent( utility::array_random( scorpio_spawn_vo ), level.players );
}

// Namespace scorpio
// Params 0
// Checksum 0xd5f57599, Offset: 0x1e3f
// Size: 0x8a
function draw_tag_origin()
{
    while ( true )
    {
        tag_origin = level.scorpio_skel gettagorigin( "tag_origin" );
        tag_j_head_offset = level.scorpio_skel gettagorigin( "j_head" );
        tag_j_head_offset = ( tag_j_head_offset[ 0 ], tag_j_head_offset[ 1 ], tag_origin[ 2 ] );
        
        /#
            sphere( tag_origin, 64, ( 1, 0, 0 ), 0, 1000 );
            sphere( tag_j_head_offset, 64, ( 0, 1, 0 ), 0, 1000 );
        #/
        
        waitframe();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x4de84173, Offset: 0x1ed1
// Size: 0x11a
function function_f9203494383ed4b1()
{
    level endon( #"game_ended" );
    level.scorpio_obj_id = spawnstruct();
    level.scorpio_obj_id.var_9be376218db54aba = "sat_ob_objectivemarker_scorpio";
    level.scorpio_obj_id ob_story_mission_utils::function_804834359f20ef5a( level.scorpio_head, 1000 );
    function_2b8e3d3ae2a6414a( level.scorpio_obj_id.a_obj_id[ 0 ], 0 );
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_we_scorpio" );
    function_3f1a6a0ae5901866( level.scorpio_obj_id.a_obj_id[ 0 ], hovercardid );
    function_771fb62e0d43ad8( level.scorpio_obj_id.a_obj_id[ 0 ], &"sat_ob_activities/scorpio_unlock" );
    level.scorpio_skel utility::waittill_any( "scorpio_reached_end", "head_launch_started", "scorpio_deleted" );
    level.scorpio_obj_id ob_story_mission_utils::objective_marker_clear( level.scorpio_obj_id.a_obj_id[ 0 ] );
    level.scorpio_obj_id = undefined;
}

// Namespace scorpio
// Params 0
// Checksum 0x4ff780dc, Offset: 0x1ff3
// Size: 0x186
function function_2737405cf9fb2a23()
{
    var_923925d65caa7ceb = ( 0, 0, 73000 );
    portal_angles = ( 0, 90, 0 );
    
    if ( level.scorpio_path_chosen == "path_01" )
    {
        var_923925d65caa7ceb = ( 13500.6, -1978.49, 23000.2 );
    }
    else if ( level.scorpio_path_chosen == "path_02" )
    {
        var_923925d65caa7ceb = ( 58993.4, 25661.6, 23770.9 );
    }
    
    portal_fx_point = utility::spawn_tag_origin( var_923925d65caa7ceb, portal_angles );
    portal_fx_point forcenetfieldhighlod( 1 );
    portal_fx_point show();
    var_658718c7ae46b119 = utility::spawn_tag_origin( var_923925d65caa7ceb, portal_angles );
    var_658718c7ae46b119 forcenetfieldhighlod( 1 );
    var_658718c7ae46b119 show();
    portal_start_fx = playfxontag( utility::getfx( "scorpio_portal_start" ), portal_fx_point, "tag_origin" );
    portal_loop_fx = playfxontag( utility::getfx( "scorpio_portal_loop" ), var_658718c7ae46b119, "tag_origin" );
    var_67e45f42f4102a9 = spawnquestcircle( "scorpio_landing_danger_zone", var_923925d65caa7ceb[ 0 ], var_923925d65caa7ceb[ 1 ], 2500 );
    var_67e45f42f4102a9 show();
    wait 10;
    utility::flag_set( "scorpio_portal_hold_complete" );
    utility::flag_wait( "scorpio_setup_complete" );
    wait 11.65;
    var_67e45f42f4102a9 questcirclefadeout( 0.3 );
    var_658718c7ae46b119 delete();
    portal_end_fx = playfxontag( utility::getfx( "scorpio_portal_end" ), portal_fx_point, "tag_origin" );
    wait 2;
    portal_fx_point delete();
    var_67e45f42f4102a9 delete();
}

// Namespace scorpio
// Params 0
// Checksum 0x6231b9f8, Offset: 0x2181
// Size: 0xb7
function function_7d36e012de961e91()
{
    setdvarifuninitialized( @"hash_966b52e88462c2bb", 0 );
    setdvarifuninitialized( @"hash_94cbb4c508c0230c", 0 );
    setdvarifuninitialized( @"hash_a407eeb293c5adca", 0 );
    setdvarifuninitialized( @"hash_26c0d3d10c872389", 0 );
    setdvarifuninitialized( @"hash_2c79bf8106ddb5da", 0 );
    setdvarifuninitialized( @"hash_c5e11249d8a43d1c", 0 );
    setdvarifuninitialized( @"hash_24890fbfc9921ecf", 0 );
    setdvarifuninitialized( @"hash_b3516b8c376d659e", 1 );
    setdvarifuninitialized( @"hash_e13b1ba78c68a912", 9 );
    setdvarifuninitialized( @"hash_f4cd847bec922ddc", 25 );
    setdvarifuninitialized( @"hash_df1d7e89e4403500", 0.89 );
}

// Namespace scorpio
// Params 0
// Checksum 0x4f2c2301, Offset: 0x2240
// Size: 0xda
function function_85339b0492d85e19()
{
    level.var_56174d118d349e38 = [ "J_Ball_RI", "J_Ball_LE", "J_Knee_RI", "J_Knee_LE", "J_Knee_RI_01", "J_Knee_LE_01", "J_Hip_RI", "J_Hip_LE", "J_SpineLower", "J_SpineLower_01", "J_SpineLower_02", "J_Neck", "J_Head", "J_Head_01", "J_Head_02", "J_Shoulder_RI", "J_Shoulder_LE", "J_Elbow_RI", "J_Elbow_LE", "J_Wrist_RI", "J_Wrist_LE" ];
    level thread function_13d9f2ae0850110f( level.var_56174d118d349e38 );
}

// Namespace scorpio
// Params 0
// Checksum 0x31a7fcd1, Offset: 0x2322
// Size: 0x109
function function_f98e0d774c4f64f7()
{
    activity_common::registeractivitytype( "OB_SCORPIO_INTERIOR", &scorpio_interior::activity_type_init );
    activity_definition_utils::function_2c1f6f3cc3322582( [ "OB_SCORPIO_INTERIOR" ] );
    
    if ( isdefined( level.activities.definitions[ "OB_SCORPIO_INTERIOR" ] ) )
    {
        activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ "OB_SCORPIO_INTERIOR" ];
        
        if ( activity_info )
        {
            level.scorpio_interior_activity = ob_activity_manager::ob_activity_instance_init( activity_info, undefined );
        }
        else
        {
            level.scorpio_interior_activity = activity_instance_common::createactivityinstance( "OB_SCORPIO_INTERIOR", "OB_SCORPIO_INTERIOR", undefined, undefined );
        }
        
        capacity_trigger = getent( "scorpio_interior_capacity_trigger", #targetname );
        
        if ( capacity_trigger )
        {
            trigger::makeenterexittrigger( capacity_trigger, &scorpio_interior::function_f9500965257e57b, &scorpio_interior::function_9fbddfbbf295038d );
            level.scorpio_skel.capacity_trigger = capacity_trigger;
        }
        
        /#
            if ( getdvarint( @"hash_26c0d3d10c872389", 0 ) )
            {
                level thread function_3fd71c50516e7d68();
            }
        #/
        
        level thread scorpio_interior::jump_pad_setup();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x29d8525b, Offset: 0x2433
// Size: 0x9c
function function_3fd71c50516e7d68()
{
    level.scorpio_skel endon( #"scorpio_reached_end" );
    
    while ( true )
    {
        level.scorpio_skel waittill( #"hash_18cd2e6280f3513f" );
        currentactivitystate = level.scorpio_interior_activity.state;
        
        if ( level.scorpio_interior_activity && currentactivitystate == "Active" )
        {
            activity_instance_common::endactivity( level.scorpio_interior_activity, 0 );
        }
        
        wait 3;
        level.scorpio_interior_activity = activity_instance_common::createactivityinstance( "OB_SCORPIO_INTERIOR", "OB_SCORPIO_INTERIOR", undefined, undefined );
    }
}

// Namespace scorpio
// Params 0
// Checksum 0xcdbdbac1, Offset: 0x24d7
// Size: 0x411
function function_96429c231e4af458()
{
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    utility::flag_wait( "scorpio_exterior_setup_complete" );
    
    if ( activity_instance_common::getactivitystate( level.scorpio_interior_activity ) == "Active" )
    {
        activity_instance_common::endactivity( level.scorpio_interior_activity, 0 );
    }
    
    if ( activity_instance_common::getactivitystate( level.scorpio_unlock_activity ) == "Active" )
    {
        activity_instance_common::endactivity( level.scorpio_unlock_activity, 0 );
    }
    
    if ( isdefined( level.scorpio_skel.laser_target ) )
    {
        level notify( #"scorpio_beam_stop" );
        
        if ( isent( level.scorpio_skel.fx_laser ) )
        {
            level.scorpio_skel.fx_laser delete();
        }
        
        if ( isdefined( level.scorpio_skel.laser_target ) )
        {
            level.scorpio_skel.laser_target delete();
        }
    }
    
    var_6af9eb55dc6272f7 = function_6ea883a716590a21();
    
    foreach ( values in var_6af9eb55dc6272f7 )
    {
        clip_ents = getentarray( tolower( values[ 0 ] ), #script_noteworthy );
        
        foreach ( var_c56d251fe3f8651a in clip_ents )
        {
            var_c56d251fe3f8651a delete();
        }
    }
    
    foreach ( ent in level.scorpio_ents )
    {
        ent delete();
    }
    
    scorpio_exterior::clean_up_exterior();
    utility::flag_wait( "scorpio_exterior_clean_up_complete" );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    scorpio_trigger_volumes = get_scorpio_interior_volumes();
    
    foreach ( clean_up in scorpio_trigger_volumes )
    {
        clean_up delete();
    }
    
    level.var_6b79638bcf01eb70 = level.scorpio_skel gettagorigin( "tag_portal" );
    level.var_f13489770f3b6129 = level.scorpio_skel.angles;
    level.scorpio_skel delete();
    level thread audio_utility::snd_transient_unload( "mp_sat_ob_scorpio" );
    level.scorpio_headlaunch_skel delete();
    level.scorpio_animnode = undefined;
    level.scorpio_headlaunch_animnode = undefined;
    level notify( #"scorpio_deleted" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0xc2dbec85, Offset: 0x28f0
    // Size: 0x5, Type: dev
    function function_a56f62cf3cc7e2f7()
    {
        
    }

#/

// Namespace scorpio
// Params 1
// Checksum 0x65941b92, Offset: 0x28fd
// Size: 0xa9
function function_e9bb3f083bad9058( animrate )
{
    self notify( #"hash_4f85ba06340418e2" );
    self endon( #"hash_4f85ba06340418e2" );
    self endon( #"scorpio_walk_stop" );
    var_d95317a1d6284fea = undefined;
    
    while ( true )
    {
        /#
            while ( scorpio_debug::function_8d8e52699754b9c7( self ) )
            {
                waitframe();
            }
        #/
        
        currentanim = level.scorpio_animnode.scenedata.sceneobjectdata[ 0 ].activeanimation;
        
        if ( !( currentanim == var_d95317a1d6284fea ) && isdefined( currentanim ) )
        {
            var_d95317a1d6284fea = currentanim;
            self setanimrate( currentanim, animrate );
            continue;
        }
        
        waitframe();
    }
}

// Namespace scorpio
// Params 1
// Checksum 0xce2963a4, Offset: 0x29ae
// Size: 0xb17
function function_3cffc07b3e2ef150( var_a52b9e940257c2f7 )
{
    self notify( #"hash_61f09d505c6ed829" );
    self endon( #"hash_61f09d505c6ed829" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    if ( !var_a52b9e940257c2f7 )
    {
        function_731dc0dcbf1e744b();
    }
    
    level endon( #"scorpio_scene_stopped" );
    level endon( #"scorpio_deleted" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path01" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_loop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_beam_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_beam_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_walk_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_walk_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_path_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_slow_down", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_pause", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_attack_beam", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_foot_thruster_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_back_thruster_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_calf_thruster_left_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_calf_thruster_right_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_footstep_notify_left", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_footstep_notify_right", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_landed_notify_note_left", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_landed_notify_note_right", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_special_stomp_attack_notify_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_special_stomp_retract_notify_note", "scorpio", 1 );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ] );
    wait 10;
    level scorpio_show();
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path01_a";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        return;
    }
    
    utility::flag_set( "scorpio_in_attack_anim" );
    level.scorpio_skel notify( #"scorpio_stomp_a" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 12, 13 ] );
    wait 10.133;
    wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
    level.scorpio_skel notify( #"scorpio_laser_a" );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 14 ] );
    level notify( #"scorpio_attack_beam" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 15, 16 ] );
    wait 11.3333;
    level.scorpio_skel thread function_232cdd9c622061e4();
    wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 17 ] );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 ] );
    utility::flag_clear( "scorpio_in_attack_anim" );
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path_01_b";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        return;
    }
    
    utility::flag_set( "scorpio_in_attack_anim" );
    level.scorpio_skel notify( #"scorpio_stomp_b" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 32, 33 ] );
    wait 10.133;
    wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
    level.scorpio_skel notify( #"scorpio_laser_b" );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 34 ] );
    level notify( #"scorpio_attack_beam" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 35, 36 ] );
    wait 11.3447;
    level.scorpio_skel thread function_232cdd9c622061e4();
    wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 37 ] );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54 ] );
    utility::flag_clear( "scorpio_in_attack_anim" );
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    level.scorpio_skel notify( #"scorpio_reached_end" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path_01_c";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 55, 56 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 57 ] );
        return;
    }
    
    level.scorpio_animnode scene::stop();
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 58 ] );
    level thread scorpio_no_collision();
    level.scorpio_skel thread function_aca4d0dab8ca4783();
    level.scorpio_skel waittill( #"scorpio_exit_finish" );
    level thread scorpio_hide();
    level thread function_7506e332e0d6fc61();
    
    if ( !getdvarint( @"hash_26c0d3d10c872389", 0 ) )
    {
        function_96429c231e4af458();
        return;
    }
}

// Namespace scorpio
// Params 1
// Checksum 0xadd5611e, Offset: 0x34cd
// Size: 0xb05
function function_3cffc37b3e2ef7e9( var_a52b9e940257c2f7 )
{
    self notify( #"hash_3d56322bf1960670" );
    self endon( #"hash_3d56322bf1960670" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    if ( !var_a52b9e940257c2f7 )
    {
        function_731dc0dcbf1e744b();
    }
    
    level endon( #"scorpio_scene_stopped" );
    level endon( #"scorpio_deleted" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path02" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_loop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_beam_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_beam_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_walk_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_walk_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_path_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_slow_down", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_pause", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_attack_beam", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_foot_thruster_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_back_thruster_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_calf_thruster_left_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_calf_thruster_right_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_footstep_notify_left", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_footstep_notify_right", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_landed_notify_note_left", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level, "scorpio_landed_notify_note_right", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_special_stomp_attack_notify_note", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_special_stomp_retract_notify_note", "scorpio", 1 );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ] );
    wait 10;
    level scorpio_show();
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path_02_a";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        return;
    }
    
    utility::flag_set( "scorpio_in_attack_anim" );
    level.scorpio_skel notify( #"scorpio_stomp_a" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 12, 13 ] );
    wait 10.133;
    wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
    level.scorpio_skel notify( #"scorpio_laser_a" );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 14 ] );
    level notify( #"scorpio_attack_beam" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 15, 16 ] );
    wait 11.3333;
    level.scorpio_skel thread function_232cdd9c622061e4();
    wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 17 ] );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 ] );
    utility::flag_clear( "scorpio_in_attack_anim" );
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path_02_b";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        return;
    }
    
    utility::flag_set( "scorpio_in_attack_anim" );
    level.scorpio_skel notify( #"scorpio_stomp_b" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 32, 33 ] );
    wait 10.133;
    wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
    level.scorpio_skel notify( #"scorpio_laser_b" );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 34 ] );
    level notify( #"scorpio_attack_beam" );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 35, 36 ] );
    wait 11.3447;
    level.scorpio_skel thread function_232cdd9c622061e4();
    wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
    level.scorpio_animnode scene::play( level.scorpio_skel, [ 37 ] );
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51 ] );
    utility::flag_clear( "scorpio_in_attack_anim" );
    level.scorpio_skel waittill( #"scorpio_walk_stop" );
    level.scorpio_skel notify( #"scorpio_reached_end" );
    
    if ( utility::flag( "scorpio_completed" ) )
    {
        level.var_c1808a4a618b4b31 = "xcam_path_02_c";
        level thread function_7b0eafec10ba8ea7();
        utility::flag_set( "scorpio_headlaunch_ready" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 52, 53 ] );
        utility::flag_wait( "scorpio_headlaunch_complete" );
        wait 1;
        utility::flag_set( "play_head_launch_xcam" );
        level.scorpio_animnode scene::stop();
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 54 ] );
        return;
    }
    
    level.scorpio_animnode scene::stop();
    level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 55 ] );
    level thread scorpio_no_collision();
    level.scorpio_skel thread function_aca4d0dab8ca4783();
    level.scorpio_skel waittill( #"scorpio_exit_finish" );
    level thread scorpio_hide();
    level thread function_7506e332e0d6fc61();
    
    if ( !getdvarint( @"hash_26c0d3d10c872389", 0 ) )
    {
        function_96429c231e4af458();
        return;
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x4988917f, Offset: 0x3fda
// Size: 0x321
function function_876f13f543032ce2()
{
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    waittillframeend();
    
    if ( utility::flag( "scorpio_headlaunch_ready" ) )
    {
        return;
    }
    
    level.scorpio_skel notify( #"head_launch_started" );
    headlaunch_wind_down = playfxontag( utility::getfx( "headlaunch_wind_down" ), level.scorpio_skel, "j_neck" );
    level.scorpio_skel utility::playsoundontag( "evt_scorpio_head_steam_manual", "j_neck" );
    var_6b9b924693dc6215 = level.scorpio_skel gettagorigin( "TAG_HEAD_THRUSTER", 0, 1, 0 );
    fx_ang = level.scorpio_skel gettagangles( "TAG_HEAD_THRUSTER", 0, 1, 0 );
    var_e1c8af41d301fdd2 = utility::spawn_tag_origin( var_6b9b924693dc6215, fx_ang + ( -90, 0, -35 ) );
    var_e1c8af41d301fdd2 forcenetfieldhighlod( 1 );
    var_e1c8af41d301fdd2 show();
    var_e1c8af41d301fdd2 linkto( level.scorpio_head );
    var_d4e6fd811a785f39 = utility::spawn_tag_origin( var_6b9b924693dc6215, fx_ang + ( -90, 0, 90 ) );
    var_d4e6fd811a785f39 forcenetfieldhighlod( 1 );
    var_d4e6fd811a785f39 show();
    var_d4e6fd811a785f39 linkto( level.scorpio_head, "tag_origin", ( 0, 0, -255 ), ( -90, -20, 90 ) );
    level.scorpio_head notify( #"hash_8b72a8ba4c61c21a" );
    level.scorpio_headlaunch_animnode scene::set_scriptbundle( "sat_wc_cin_scorpio_head_launch_modular" );
    level.scorpio_headlaunch_animnode scene::add_spawn_function( &function_4188585d548a9f7b, "root_model" );
    level.scorpio_head.animname = "visible_head_model";
    var_9870354b7527f8ac = level.scorpio_skel gettagangles( "tag_origin", 0, 0, 0 );
    composite_angles = ( level.scorpio_head.angles[ 2 ], var_9870354b7527f8ac[ 1 ], level.scorpio_head.angles[ 0 ] );
    level.scorpio_headlaunch_animnode.origin = level.scorpio_head.origin;
    level.scorpio_headlaunch_animnode.angles = composite_angles;
    level.scorpio_headlaunch_animnode thread scene::play( level.scorpio_head );
    utility::flag_set( "play_head_launch_xcam" );
    level thread function_de01b83522af2d22();
    level thread function_7b0eafec10ba8ea7();
    waitframe();
    waitframe();
    headlaunch_start = playfxontag( utility::getfx( "headlaunch_start" ), var_e1c8af41d301fdd2, "tag_origin" );
    headlaunch_eject = playfxontag( utility::getfx( "headlaunch_eject" ), var_d4e6fd811a785f39, "tag_origin" );
    wait 5;
    var_e1c8af41d301fdd2 delete();
    wait 7;
    var_d4e6fd811a785f39 delete();
    level.scorpio_head hide();
    level.scorpio_head notify( #"cleanup_root_model" );
}

// Namespace scorpio
// Params 0
// Checksum 0x62bdaec4, Offset: 0x4303
// Size: 0x75
function function_de01b83522af2d22()
{
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    level endon( #"stop_scorpio_pause" );
    level.scorpio_skel waittill( #"scorpio_slow_down" );
    level.scorpio_skel childthread function_e9bb3f083bad9058( 0.65 );
    level.scorpio_skel waittill( #"scorpio_pause" );
    level.scorpio_animnode scene::pause();
}

// Namespace scorpio
// Params 0
// Checksum 0x480e6d68, Offset: 0x4380
// Size: 0x47
function function_4188585d548a9f7b()
{
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    
    if ( !isdefined( self ) )
    {
        waitframe();
    }
    
    self hide();
    level.scorpio_head waittill( #"cleanup_root_model" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x53bcb540, Offset: 0x43cf
// Size: 0x200
function function_aca4d0dab8ca4783()
{
    var_afe25c4f31a4fc40 = [ "TAG_CALF_THRUSTER_INNER_LE", "TAG_CALF_THRUSTER_OUTER_LE", "TAG_CALF_THRUSTER_INNER_RI", "TAG_CALF_THRUSTER_OUTER_RI", "TAG_BACK_THRUSTER_LE", "TAG_BACK_THRUSTER_RI", "J_Ankle_LE", "J_Ankle_RI" ];
    
    foreach ( thruster_tag in var_afe25c4f31a4fc40 )
    {
        thruster_fx_ent = utility::spawn_tag_origin( level.scorpio_skel gettagorigin( thruster_tag ), level.scorpio_skel gettagangles( thruster_tag ) );
        thruster_fx_ent forcenetfieldhighlod( 1 );
        level.var_38f02e29dcc94c06 = arraycombine( [ thruster_fx_ent ], level.var_38f02e29dcc94c06 );
        thruster_fx_ent show();
        thruster_fx_ent.origin = level.scorpio_skel gettagorigin( thruster_tag, 0, 0, 0 );
        thruster_fx_ent thread function_178c8c256e3e4af3( level.scorpio_skel, thruster_tag );
        
        if ( thruster_tag == "TAG_BACK_THRUSTER_LE" || thruster_tag == "TAG_BACK_THRUSTER_RI" )
        {
            level.scorpio_skel thread function_10db406f78a390dc( thruster_fx_ent );
        }
        
        if ( thruster_tag == "J_Ankle_LE" )
        {
            level.scorpio_skel thread function_7b42ec57ceb32feb( thruster_fx_ent );
        }
        
        if ( thruster_tag == "J_Ankle_RI" )
        {
            level.scorpio_skel thread function_7b42ec57ceb32feb( thruster_fx_ent );
        }
        
        if ( thruster_tag == "TAG_CALF_THRUSTER_INNER_LE" || thruster_tag == "TAG_CALF_THRUSTER_OUTER_LE" )
        {
            level.scorpio_skel thread function_695b9abfb190b4e9( thruster_fx_ent );
        }
        
        if ( thruster_tag == "TAG_CALF_THRUSTER_INNER_RI" || thruster_tag == "TAG_CALF_THRUSTER_OUTER_RI" )
        {
            level.scorpio_skel thread function_9fd1c96e5bd03012( thruster_fx_ent );
        }
    }
}

// Namespace scorpio
// Params 1
// Checksum 0x52cf4d0d, Offset: 0x45d7
// Size: 0x4c
function function_10db406f78a390dc( var_c16e8946d253c0ce )
{
    utility::waittill_any( "scorpio_back_thruster_note" );
    waitframe();
    playfxontag( utility::getfx( "scorpio_back_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
    destroynavobstacle( self.left_foot_obstacle );
    destroynavobstacle( self.right_foot_obstacle );
}

// Namespace scorpio
// Params 1
// Checksum 0x681539e4, Offset: 0x462b
// Size: 0x30
function function_7b42ec57ceb32feb( var_c16e8946d253c0ce )
{
    utility::waittill_any( "scorpio_foot_thruster_note" );
    waitframe();
    playfxontag( utility::getfx( "scorpio_foot_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
}

// Namespace scorpio
// Params 1
// Checksum 0x58afcebf, Offset: 0x4663
// Size: 0x30
function function_695b9abfb190b4e9( var_c16e8946d253c0ce )
{
    utility::waittill_any( "scorpio_calf_thruster_right_note" );
    waitframe();
    playfxontag( utility::getfx( "scorpio_calf_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
}

// Namespace scorpio
// Params 1
// Checksum 0xcd39dab8, Offset: 0x469b
// Size: 0x30
function function_9fd1c96e5bd03012( var_c16e8946d253c0ce )
{
    utility::waittill_any( "scorpio_calf_thruster_left_note" );
    waitframe();
    playfxontag( utility::getfx( "scorpio_calf_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
}

// Namespace scorpio
// Params 2
// Checksum 0x1e763fab, Offset: 0x46d3
// Size: 0x5f
function function_178c8c256e3e4af3( skel_ent, bone_name )
{
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    
    while ( self )
    {
        if ( skel_ent && self )
        {
            self.origin = skel_ent gettagorigin( bone_name );
            self.angles = skel_ent gettagangles( bone_name );
        }
        
        waitframe();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0xbf65b2e8, Offset: 0x473a
// Size: 0xbe
function function_7506e332e0d6fc61()
{
    foreach ( var_c16e8946d253c0ce in level.var_38f02e29dcc94c06 )
    {
        killfxontag( utility::getfx( "scorpio_back_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
        killfxontag( utility::getfx( "scorpio_calf_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
        killfxontag( utility::getfx( "scorpio_foot_thrusters" ), var_c16e8946d253c0ce, "tag_origin" );
        var_c16e8946d253c0ce delete();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0xa491839a, Offset: 0x4800
// Size: 0xc7
function function_731dc0dcbf1e744b()
{
    level notify( #"scorpio_scene_stopped" );
    level.scorpio_animnode scene::set_scriptbundle( "" );
    utility::flag_clear( "scorpio_headlaunch_ready" );
    utility::flag_clear( "scorpio_headlaunch_complete" );
    level thread scorpio_show();
    
    if ( isdefined( level.scorpio_skel.laser_target ) )
    {
        level notify( #"scorpio_beam_stop" );
        
        if ( isent( level.scorpio_skel.fx_laser ) )
        {
            level.scorpio_skel.fx_laser delete();
        }
        
        if ( isdefined( level.scorpio_skel.laser_target ) )
        {
            level.scorpio_skel.laser_target delete();
        }
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x20642d0f, Offset: 0x48cf
// Size: 0xae
function function_7b0eafec10ba8ea7()
{
    clip_ents = getentarray( "j_head_geo_high", #script_noteworthy );
    
    while ( clip_ents[ 0 ].origin[ 2 ] < 18000 )
    {
        wait 0.5;
    }
    
    foreach ( var_c56d251fe3f8651a in clip_ents )
    {
        var_c56d251fe3f8651a delete();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0x796cd4ce, Offset: 0x4985
// Size: 0x1b0
function scorpio_no_collision()
{
    while ( level.scorpio_skel.origin[ 2 ] < 18000 )
    {
        wait 0.5;
    }
    
    var_6af9eb55dc6272f7 = function_6ea883a716590a21();
    
    foreach ( values in var_6af9eb55dc6272f7 )
    {
        clip_ents = getentarray( tolower( values[ 0 ] ), #script_noteworthy );
        
        foreach ( var_c56d251fe3f8651a in clip_ents )
        {
            var_c56d251fe3f8651a notsolid();
        }
    }
    
    foreach ( ent in level.scorpio_ents )
    {
        ent notsolid();
    }
    
    level.scorpio_skel notsolid();
}

// Namespace scorpio
// Params 0
// Checksum 0x6eec4b35, Offset: 0x4b3d
// Size: 0x87
function scorpio_show()
{
    foreach ( ent in level.scorpio_ents )
    {
        ent show();
    }
    
    level.scorpio_skel show();
}

// Namespace scorpio
// Params 0
// Checksum 0xf87b591f, Offset: 0x4bcc
// Size: 0x87
function scorpio_hide()
{
    foreach ( ent in level.scorpio_ents )
    {
        ent hide();
    }
    
    level.scorpio_skel hide();
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0x928c66d3, Offset: 0x4c5b
    // Size: 0x5, Type: dev
    function function_c79dfc254c6cfc4()
    {
        
    }

#/

// Namespace scorpio
// Params 0
// Checksum 0x72fa09d5, Offset: 0x4c68
// Size: 0x5ea
function setup_scorpio_rig()
{
    var_7237854e3be197ca = level.scorpio_skel;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = level.scorpio_ents;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    level.var_f7f8f6d519018446 = 0;
    level.var_f4511c44e8417f98 = 1;
    var_6af9eb55dc6272f7 = function_6ea883a716590a21();
    level.scorpio_ents = [];
    level.scorpio_skel = spawn( "script_model", ( 0, 0, 0 ) );
    level.scorpio_skel setmodel( "c_sat_scorpio_skeleton" );
    level.scorpio_skel.animname = "scorpio";
    level.scorpio_skel.team = "neutral";
    level.scorpio_skel hide();
    level.scorpio_headlaunch_skel = spawn( "script_model", ( 0, 0, 0 ) );
    level.scorpio_headlaunch_skel setmodel( "c_sat_scorpio_skeleton_head" );
    level.scorpio_headlaunch_skel.animname = "Prop 1";
    level.scorpio_headlaunch_skel.team = "neutral";
    utility::flag_set( "scorpio_skel_setup_complete" );
    utility::flag_wait( "scorpio_exterior_setup_complete" );
    level thread function_85339b0492d85e19();
    
    foreach ( values in var_6af9eb55dc6272f7 )
    {
        part_ent = spawn( "script_model", ( 0, 0, -1400 ) );
        part_ent setmodel( values[ 0 ] );
        part_ent hide();
        
        if ( values[ 0 ] == "J_Head_Geo_high" )
        {
            level.scorpio_head = part_ent;
        }
        
        level.scorpio_ents = arraycombine( [ part_ent ], level.scorpio_ents );
        level.var_2269853965fd4bfd = arraycombine( [ part_ent ], level.var_2269853965fd4bfd );
        clip_ents = getentarray( tolower( values[ 0 ] ), #script_noteworthy );
        
        foreach ( var_c56d251fe3f8651a in clip_ents )
        {
            if ( isdefined( var_c56d251fe3f8651a ) )
            {
                if ( isdefined( var_c56d251fe3f8651a.targetname ) && var_c56d251fe3f8651a.targetname == "no_col_texture" )
                {
                    if ( level.var_f1fd259803435d19 )
                    {
                        var_c56d251fe3f8651a linkto( part_ent );
                        var_c56d251fe3f8651a hide();
                    }
                    else
                    {
                        var_c56d251fe3f8651a delete();
                    }
                }
                else if ( isdefined( var_c56d251fe3f8651a.targetname ) && var_c56d251fe3f8651a.targetname == "scorpio_link_point" )
                {
                    continue;
                }
                else
                {
                    var_c56d251fe3f8651a linkto( part_ent );
                    var_c56d251fe3f8651a.vehiclename = "scorpio_test_veh";
                    var_c56d251fe3f8651a thread function_34f0f3b16a0b7c97();
                    var_c56d251fe3f8651a setmoverantilagged( 1 );
                }
            }
            
            if ( var_c56d251fe3f8651a.script_noteworthy == "j_ankle_le_geo_high" )
            {
                level.scorpio_left_foot = var_c56d251fe3f8651a;
                var_c56d251fe3f8651a.unresolved_collision_func = &unresolved_collision_kill_player;
                continue;
            }
            
            if ( var_c56d251fe3f8651a.script_noteworthy == "j_ankle_ri_geo_high" )
            {
                level.scorpio_right_foot = var_c56d251fe3f8651a;
                var_c56d251fe3f8651a.unresolved_collision_func = &unresolved_collision_kill_player;
                continue;
            }
            
            if ( var_c56d251fe3f8651a.script_noteworthy == "j_leg_compress_le_geo_high" || var_c56d251fe3f8651a.script_noteworthy == "j_leg_compress_ri_geo_high" )
            {
                var_c56d251fe3f8651a.unresolved_collision_func = &unresolved_collision_kill_player;
            }
        }
        
        pos_offset = ( 0, 0, 0 );
        ang_offset_x = float( values[ 6 ] );
        ang_offset_y = float( values[ 7 ] );
        ang_offset_z = float( values[ 5 ] );
        var_1028413d7ababab0 = ( ang_offset_x, ang_offset_y, ang_offset_z );
        part_ent thread function_3c86a59378a171f( level.scorpio_skel, values[ 1 ], pos_offset, var_1028413d7ababab0 );
        part_ent forcenetfieldhighlod( 1 );
        part_ent setmoverantilagged( 1 );
        part_ent thread damage::monitordamage( 2147483647, "hitimmune", &scorpio_damaged, &scorpio_damaged, undefined, 0, 1 );
    }
    
    function_81effa23eda42791( "scorpio_test_veh" );
    level.var_2269853965fd4bfd = arraycombine( [ level.scorpio_skel ], level.var_2269853965fd4bfd );
    level.scorpio_skel thread function_90eee51e64ba9e42( "J_Ball_LE" );
    level.scorpio_skel thread function_ea34548cd78f07cf( "J_Ball_RI" );
    level.scorpio_skel thread function_4237f05f53dfdef4();
    level.scorpio_animnode = spawnstruct();
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_headlaunch_animnode = spawnstruct();
    level.scorpio_headlaunch_animnode.angles = ( 0, 0, 0 );
    level.scorpio_headlaunch_animnode.origin = ( 0, 0, 0 );
    level.scorpio_skel thread function_2289c16ab4a4b898();
    level.scorpio_skel thread function_5c95468373a5468c();
    utility::flag_set( "scorpio_setup_complete" );
}

// Namespace scorpio
// Params 0, eflags: 0x4
// Checksum 0x2f18617, Offset: 0x525a
// Size: 0x5c8
function private function_6ea883a716590a21()
{
    var_6af9eb55dc6272f7 = [ [ "J_Ankle_LE_Geo_high", "J_Ball_LE", "-232.1853406043988", "128.29688993141966", "-454.8786565557819", "110.42455156086271", "-89.59180452105325", "-20.59906121540923" ], [ "J_Ankle_RI_Geo_high", "J_Ball_RI", "-225.9563828513629", "125.52951743061608", "459.6289969103938", "116.85271445733652", "-89.55407378572016", "-27.02902468818914" ], [ "J_Elbow_LE_Geo_high", "J_Elbow_LE", "1765.58726498822", "-1448.2023412000779", "-830.9233716227413", "-67.83370473275728", "7.232285539782697", "77.1802381276759" ], [ "J_Elbow_RI_Geo_high", "J_Elbow_RI", "1742.2245674333378", "814.8252017351506", "1548.5011806099715", "164.57163568331973", "-73.00191471891901", "-141.25382356730606" ], [ "J_Head_Geo_high", "J_Head", "-470.2143860710775", "-3320.642834090358", "40.56192128459146", "-134.15964111661555", "88.67203854313382", "-44.13946581072073" ], [ "J_Hip_Geo_high", "J_Pelvis", "-1999.9999642461325", "251.63020593145833", "2.5000006455753076e-06", "0.0", "90.0", "0.0" ], [ "J_Hip_LE_Geo_high", "J_Hip_LE", "1926.0777799331104", "594.2095410924941", "-458.5244562448424", "10.000114612226616", "-89.99987576122015", "0.0" ], [ "J_Hip_RI_Geo_high", "J_Hip_RI", "1926.077939931766", "594.2096901610048", "458.5189040798338", "10.000114612226556", "-89.99994030131734", "0.0" ], [ "J_Knee_LE_Geo_high", "J_Knee_LE", "1239.235660510381", "181.29941675246593", "-458.52530598943684", "-9.999885387631375", "-89.99987332312513", "0.0" ], [ "J_Knee_RI_Geo_high", "J_Knee_RI", "1239.2389614340489", "181.29487108581554", "458.5178461786348", "-9.999965831586143", "-89.99975791894587", "0.0" ], [ "J_Leg_Compress_LE_Geo_high", "J_Knee_LE", "1239.235660510381", "181.29941675246593", "-458.52530598943684", "-9.999885387631375", "-89.99987332312513", "0.0" ], [ "J_Leg_Compress_RI_Geo_high", "J_Knee_RI", "1239.2389614340489", "181.29487108581554", "458.5178461786348", "-9.999965831586143", "-89.99975791894587", "0.0" ], [ "J_Shoulder_LE_Geo_high", "J_Shoulder_LE", "2648.0265812741827", "-171.07865071138446", "-1423.4937900356163", "-8.422610066882356", "-75.99733086157912", "1.4129501918671075" ], [ "J_Shoulder_RI_Geo_high", "J_Shoulder_RI", "2620.9414070941566", "-174.06147821180198", "1524.1199372698793", "162.80276196205352", "-73.61604647632096", "-169.49787290865711" ], [ "J_Torso_01_Geo_high", "J_Spine4", "-2989.8364207378404", "251.64217149258613", "48.15547004282036", "1.7340345210307746", "90.9253543954188", "1.7340297770400386" ], [ "J_Torso_02_Geo_high", "J_SpineMid", "-2633.2104355979213", "251.63015342533336", "4.999999991935137e-06", "0.0", "90.0", "0.0" ], [ "J_Torso_03_Geo_high", "J_SpineLower", "-2139.5407210440053", "251.6301534253332", "4.999999991934458e-06", "0.0", "90.0", "0.0" ], [ "J_Wrist_LE_Geo_high", "J_Wrist_LE", "986.4046832186383", "-1426.077065095132", "-868.4378496988425", "-67.49588176820285", "5.778570483631819", "77.21844764807734" ], [ "J_Wrist_RI_Geo_high", "J_Wrist_RI", "963.0349440997492", "1526.7633511879355", "-854.9562233823609", "-67.56942503157538", "-9.092408434769018", "103.34960755203133" ] ];
    return var_6af9eb55dc6272f7;
}

// Namespace scorpio
// Params 0, eflags: 0x4
// Checksum 0xe45bdd87, Offset: 0x582b
// Size: 0xa1
function private get_scorpio_interior_volumes()
{
    scorpio_trigger_volumes = [];
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "ob_scorpio_interior_plate_01_trigger", #targetname );
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "ob_scorpio_interior_plate_02_trigger", #targetname );
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "ob_scorpio_interior_plate_03_trigger", #targetname );
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "scorpio_interior_portal_head_entrance", #targetname );
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "scorpio_interior_capacity_trigger", #targetname );
    scorpio_trigger_volumes[ scorpio_trigger_volumes.size ] = getent( "scorpio_interior_entrance_trigger", #targetname );
    return scorpio_trigger_volumes;
}

// Namespace scorpio
// Params 4
// Checksum 0x7c3a7378, Offset: 0x58d5
// Size: 0xa2
function function_3c86a59378a171f( var_3e5094152b7eaf6d, bone, position_offset, angles_offset )
{
    level endon( #"scorpio_deleted" );
    self endon( #"hash_8b72a8ba4c61c21a" );
    
    if ( !isdefined( angles_offset ) )
    {
        angles_offset = ( 0, 0, 0 );
    }
    
    utility::flag_wait( "scorpio_setup_complete" );
    
    while ( var_3e5094152b7eaf6d )
    {
        self.origin = var_3e5094152b7eaf6d gettagorigin( bone ) + position_offset;
        bone_ang = var_3e5094152b7eaf6d gettagangles( bone, 0, 1, 0 );
        self.angles = combineangles( bone_ang, angles_offset );
        waitframe();
    }
}

// Namespace scorpio
// Params 0
// Checksum 0xa28eecbb, Offset: 0x597f
// Size: 0x32
function axis_follow()
{
    while ( true )
    {
        /#
            debugaxis( self.origin, self.angles, 200, 1, 0, 1 );
        #/
        
        waitframe();
    }
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0x8644f63a, Offset: 0x59b9
    // Size: 0x5, Type: dev
    function function_ad2a01ce70005376()
    {
        
    }

#/

// Namespace scorpio
// Params 0
// Checksum 0xfb78bb3c, Offset: 0x59c6
// Size: 0x4f9
function function_4237f05f53dfdef4()
{
    level utility::waittill_any_timeout( 11.6, "scorpio_landed_notify_note_left", "scorpio_landed_notify_note_right" );
    self notify( #"scorpio_landing_finished" );
    var_abef4f71bf4ecef6 = 1024;
    var_a4fdaae20ef484b5 = 1024;
    var_7b6e6c3c3f77a363 = 1024;
    tag_angles = self gettagangles( "tag_origin" );
    v_forward = anglestoforward( tag_angles );
    v_up = anglestoup( tag_angles );
    var_46439e0874b51edf = 1024;
    rotate_vals = [ 0, 45, 90, 135, 180 ];
    damage_origins = [];
    damage_origin = level.scorpio_skel.origin;
    var_63b836d44b8f3c4c = vectornormalize( v_forward ) * 650;
    
    if ( level.scorpio_path_chosen == "path_01" )
    {
        damage_origin_right_offset = vectornormalize( vectorcross( v_forward, v_up ) ) * -250;
        damage_origin_vertical_offset = ( 0, 0, -600 );
    }
    else if ( level.scorpio_path_chosen == "path_02" )
    {
        damage_origin_right_offset = vectornormalize( vectorcross( v_forward, v_up ) ) * -500;
        damage_origin_vertical_offset = ( 0, 0, 0 );
    }
    
    damage_origin = damage_origin + var_63b836d44b8f3c4c + damage_origin_right_offset + damage_origin_vertical_offset;
    pdl_origins = level.scorpio_skel.origin;
    players = getplayersinradius( level.scorpio_skel.origin, var_a4fdaae20ef484b5 * 2, 500 );
    
    foreach ( player in players )
    {
        earthquake( 0.375, 1.5, player.origin, 100 );
        player playrumbleonentity( "heavy_3s" );
    }
    
    foreach ( val in rotate_vals )
    {
        damage_origin_small = damage_origin + rotatevector( v_forward * var_46439e0874b51edf, ( 0, val, 0 ) );
        damage_origins[ damage_origins.size ] = damage_origin_small;
        damage_origin_small = damage_origin - rotatevector( v_forward * var_46439e0874b51edf, ( 0, val, 0 ) );
        damage_origins[ damage_origins.size ] = damage_origin_small;
    }
    
    self radiusdamage( damage_origin, var_abef4f71bf4ecef6, 9999, 9999, self, "MOD_EXPLOSIVE", undefined, 1, 0, 1, 1 );
    self radiusdamage( damage_origin, var_a4fdaae20ef484b5, 9999, 9999, self, "MOD_EXPLOSIVE", undefined, 0, 0, 0, 1 );
    
    foreach ( var_cae7db7943432c9d in damage_origins )
    {
        self radiusdamage( var_cae7db7943432c9d, var_7b6e6c3c3f77a363, 300, 70, self, "MOD_EXPLOSIVE", undefined, 0, 0, 0, 1 );
        
        /#
            sphere( var_cae7db7943432c9d, var_7b6e6c3c3f77a363, ( 0, 1, 1 ), 0, 1000 );
        #/
    }
    
    /#
        sphere( damage_origin, var_abef4f71bf4ecef6, ( 1, 0, 0 ), 0, 1000 );
        sphere( damage_origin, var_a4fdaae20ef484b5, ( 0, 1, 0 ), 0, 1000 );
    #/
    
    players = getplayersinradius( damage_origin, var_a4fdaae20ef484b5 + var_7b6e6c3c3f77a363 );
    agents = function_10926c30e8c04655( damage_origin, var_a4fdaae20ef484b5 + var_7b6e6c3c3f77a363 );
    knockback_targets = arraycombine( players, agents );
    
    foreach ( target in knockback_targets )
    {
        direction_vector = target.origin - damage_origin;
        
        if ( direction_vector == ( 0, 0, 0 ) )
        {
            direction_vector += ( 0, 0, 0.01 );
        }
        
        knockback_multiplier = 10;
        vector_magnitude = var_abef4f71bf4ecef6 * 90 / length( direction_vector ) * knockback_multiplier;
        target knockback( direction_vector, vector_magnitude, 0 );
    }
}

// Namespace scorpio
// Params 1
// Checksum 0x3d3caaf2, Offset: 0x5ec7
// Size: 0x12d
function function_90eee51e64ba9e42( bone_name )
{
    level endon( #"scorpio_deleted" );
    
    while ( true )
    {
        utility::waittill_any( "scorpio_footstep_notify_left", "scorpio_special_stomp_attack_notify_note", "scorpio_special_stomp_retract_notify_note", "scorpio_landing_finished" );
        bone_pos = self gettagorigin( bone_name );
        ground_pos = bone_pos + ( 0, 0, -175 );
        function_ea68b192b3cfd8dd( ground_pos, bone_name );
        players = getplayersinradius( ground_pos, 750, 10 );
        
        foreach ( player in players )
        {
            earthquake( 0.375, 1.5, player.origin, 100 );
            player playrumbleonentity( "heavy_2s" );
        }
        
        waitframe();
        self.left_foot_obstacle = updatenavobstaclebyent( level.scorpio_left_foot );
    }
}

// Namespace scorpio
// Params 1
// Checksum 0xb123723, Offset: 0x5ffc
// Size: 0x123
function function_ea34548cd78f07cf( bone_name )
{
    level endon( #"scorpio_deleted" );
    
    while ( true )
    {
        utility::waittill_any( "scorpio_footstep_notify_right", "scorpio_landing_finished" );
        bone_pos = self gettagorigin( bone_name );
        ground_pos = bone_pos + ( 0, 0, -175 );
        function_ea68b192b3cfd8dd( ground_pos, bone_name );
        players = getplayersinradius( ground_pos, 750, 10 );
        
        foreach ( player in players )
        {
            earthquake( 0.375, 1.5, player.origin, 100 );
            player playrumbleonentity( "heavy_2s" );
        }
        
        waitframe();
        self.right_foot_obstacle = updatenavobstaclebyent( level.scorpio_right_foot );
    }
}

// Namespace scorpio
// Params 1
// Checksum 0x51a356d0, Offset: 0x6127
// Size: 0x17c
function function_1e9d60aeab58a5ed( bone_name )
{
    level endon( #"scorpio_deleted" );
    level.var_f5bd3edaf5aaa22f = [];
    foot_down_flag = "foot_down_";
    foot_down_flag += bone_name;
    utility::flag_set( foot_down_flag );
    
    while ( true )
    {
        bone_pos = self gettagorigin( bone_name );
        ground_pos = bone_pos + ( 0, 0, -175 );
        scorpio_foot_down = is_scorpio_foot_down( bone_name, foot_down_flag );
        
        if ( !utility::flag( foot_down_flag ) && scorpio_foot_down )
        {
            utility::flag_set( foot_down_flag );
            self notify( #"scorpio_foot_down" );
            function_ea68b192b3cfd8dd( ground_pos, bone_name );
            players = getplayersinradius( ground_pos, 750, 10 );
            
            foreach ( player in players )
            {
                earthquake( 0.375, 1.5, player.origin, 100 );
                player playrumbleonentity( "heavy_2s" );
            }
        }
        else if ( utility::flag( foot_down_flag ) && !scorpio_foot_down )
        {
            utility::flag_clear( foot_down_flag );
        }
        
        waitframe();
    }
}

// Namespace scorpio
// Params 2
// Checksum 0x6b73338d, Offset: 0x62ab
// Size: 0x159
function is_scorpio_foot_down( bone_name, foot_down_flag )
{
    start_pos = self gettagorigin( bone_name ) + ( 0, 10, 0 );
    end_pos = start_pos + ( 0, 0, -1000 );
    var_ba81bbe32d3c59 = trace::ray_trace( start_pos, end_pos, level.var_2269853965fd4bfd, trace::create_contents( 0, 1, 0, 0 ), 1, 1, 0 );
    var_efbffb4b30187270 = distancesquared( start_pos, var_ba81bbe32d3c59[ "position" ] );
    var_1f244d81f27f72aa = squared( 250 );
    
    if ( var_efbffb4b30187270 < var_1f244d81f27f72aa && var_ba81bbe32d3c59[ "surfacetype" ] != "surftype_metal_thick" && var_ba81bbe32d3c59[ "surfacetype" ] != "surftype_none" )
    {
        if ( !utility::flag( foot_down_flag ) )
        {
            /#
                if ( getdvarint( @"hash_94cbb4c508c0230c", 0 ) )
                {
                    trace::draw_trace( var_ba81bbe32d3c59, ( 1, 0, 1 ), 1, 600 );
                }
            #/
            
            /#
                if ( getdvarint( @"hash_94cbb4c508c0230c", 0 ) )
                {
                    var_da9ad1c66014b0b6 = "<dev string:x34>" + string( sqrt( var_efbffb4b30187270 ) );
                    print3d( var_ba81bbe32d3c59[ "<dev string:x48>" ], var_da9ad1c66014b0b6, undefined, undefined, 3, 600 );
                }
            #/
        }
        
        return 1;
    }
    
    if ( var_efbffb4b30187270 >= var_1f244d81f27f72aa )
    {
        return 0;
    }
}

// Namespace scorpio
// Params 4
// Checksum 0x52d47e1f, Offset: 0x640d
// Size: 0x1ca
function spawn_fx_in_circle( circle_center, circle_radius, num_points, b_print_debug )
{
    /#
        if ( getdvarint( @"hash_94cbb4c508c0230c", 0 ) )
        {
            iprintlnbold( "<dev string:x51>" );
        }
    #/
    
    foreach ( the_fx in level.var_f5bd3edaf5aaa22f )
    {
        the_fx delete();
    }
    
    circle_normal = ( 0, 0, 1 );
    
    for ( i = 0; i < num_points ; i++ )
    {
        angle = 6.28 / num_points * i;
        angle *= 57.3248;
        x_pos = circle_center[ 0 ] + circle_radius * cos( angle );
        y_pos = circle_center[ 1 ] + circle_radius * sin( angle );
        var_87a8cb2d30497b41 = circle_center[ 2 ];
        new_point_pos = ( x_pos, y_pos, var_87a8cb2d30497b41 );
        
        /#
            if ( getdvarint( @"hash_94cbb4c508c0230c", 0 ) )
            {
                print3d( new_point_pos, new_point_pos, undefined, undefined, 5, 240 );
            }
        #/
        
        forward_dir = new_point_pos - circle_center;
        var_c16e8946d253c0ce = spawnfx( level._effect[ "dust_kickup" ], new_point_pos, forward_dir );
        level.var_f5bd3edaf5aaa22f = arraycombine( [ var_c16e8946d253c0ce ], level.var_f5bd3edaf5aaa22f );
        triggerfx( var_c16e8946d253c0ce );
    }
}

// Namespace scorpio
// Params 2
// Checksum 0x1b193be5, Offset: 0x65df
// Size: 0x3da
function function_ea68b192b3cfd8dd( damage_origin, bone_tag )
{
    tag_angles = self gettagangles( bone_tag );
    v_forward = anglestoforward( tag_angles );
    damage_origin += ( 0, 0, -75 );
    damage_origin_one = damage_origin + v_forward * 200;
    damage_origin_two = damage_origin + v_forward * -200;
    damage_origin_three = damage_origin + v_forward * 600;
    pdl_origins = [ damage_origin_one, damage_origin_three ];
    damage_origins = [ damage_origin_one, damage_origin_two, damage_origin_three ];
    var_abef4f71bf4ecef6 = 1024;
    damage_circle_radius = 310;
    waitframe();
    waitframe();
    
    foreach ( dmg_origin in pdl_origins )
    {
        self radiusdamage( dmg_origin, var_abef4f71bf4ecef6, 9999, 9999, self, "MOD_EXPLOSIVE", undefined, 1, 0, 1, 1 );
        
        /#
        #/
    }
    
    foreach ( dmg_origin in damage_origins )
    {
        players = getplayersinradius( dmg_origin, damage_circle_radius, 500 );
        
        foreach ( player in players )
        {
            player.disablelaststand = 1;
        }
        
        self radiusdamage( dmg_origin, damage_circle_radius, 9999, 9999, self, "MOD_EXPLOSIVE", undefined, 0, 0, 0, 1 );
        
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                function_1fbc65c8a8fac631( player );
            }
            
            player.disablelaststand = 0;
        }
        
        /#
        #/
    }
    
    players = getplayersinradius( damage_origin, var_abef4f71bf4ecef6, 100 );
    agents = function_10926c30e8c04655( damage_origin, var_abef4f71bf4ecef6 );
    knockback_targets = arraycombine( players, agents );
    
    foreach ( target in knockback_targets )
    {
        direction_vector = target.origin - damage_origin;
        
        if ( direction_vector == ( 0, 0, 0 ) )
        {
            direction_vector += ( 0, 0, 0.01 );
        }
        
        knockback_multiplier = 10;
        vector_magnitude = var_abef4f71bf4ecef6 * 90 / length( direction_vector ) * knockback_multiplier;
        target knockback( direction_vector, vector_magnitude, 0 );
    }
}

// Namespace scorpio
// Params 1
// Checksum 0x51433dca, Offset: 0x69c1
// Size: 0x190
function function_1fbc65c8a8fac631( player )
{
    if ( !isdefined( player.screen_overlay ) )
    {
        player.screen_overlay = newclienthudelem( player );
        player.screen_overlay.x = 0;
        player.screen_overlay.y = 0;
        player.screen_overlay setshader( "black", 640, 480 );
        player.screen_overlay.alignx = "left";
        player.screen_overlay.aligny = "top";
        player.screen_overlay.sort = 1;
        player.screen_overlay.horzalign = "fullscreen";
        player.screen_overlay.vertalign = "fullscreen";
        player.screen_overlay.alpha = 0;
        player.screen_overlay.foreground = 1;
        player.screen_overlay.archived = 0;
        player.screen_overlay.scramblerdisabled = 1;
    }
    
    player.screen_overlay fadeovertime( 0.2 );
    player.screen_overlay.alpha = 1;
    level thread function_e8349f62cf0e651d( player );
}

// Namespace scorpio
// Params 1
// Checksum 0x16a39783, Offset: 0x6b59
// Size: 0xa1
function function_e8349f62cf0e651d( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    squad = teams::function_72b89edf6b47c40a( player );
    
    while ( squad.var_2c44544a01cc415e || player.sessionstate != "playing" && player.sessionstate != "spectator" )
    {
        waitframe();
    }
    
    player.screen_overlay fadeovertime( 0.3 );
    player.screen_overlay.alpha = 0;
}

// Namespace scorpio
// Params 0
// Checksum 0xf9af7818, Offset: 0x6c02
// Size: 0x1d6
function function_5c95468373a5468c()
{
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    
    while ( true )
    {
        stomp_type = level.scorpio_skel utility::waittill_any_return( "scorpio_stomp_a", "scorpio_stomp_b" );
        wait 5.65;
        
        if ( stomp_type == "scorpio_stomp_a" && level.scorpio_animnode.script_scenescriptbundle == "scene_sat_wc_scorpio_path01" )
        {
            var_d618bd532d7defb7 = ( 5655, -17131, 1040 );
        }
        
        if ( stomp_type == "scorpio_stomp_b" && level.scorpio_animnode.script_scenescriptbundle == "scene_sat_wc_scorpio_path01" )
        {
            var_d618bd532d7defb7 = ( -1734, -30278, 343 );
        }
        
        if ( stomp_type == "scorpio_stomp_a" && level.scorpio_animnode.script_scenescriptbundle == "scene_sat_wc_scorpio_path02" )
        {
            var_d618bd532d7defb7 = ( 45514, 19592, 444 );
        }
        
        if ( stomp_type == "scorpio_stomp_b" && level.scorpio_animnode.script_scenescriptbundle == "scene_sat_wc_scorpio_path02" )
        {
            var_d618bd532d7defb7 = ( 32311, 15134, 950 );
        }
        
        /#
            if ( getdvarint( @"hash_94cbb4c508c0230c", 0 ) )
            {
                print3d( var_d618bd532d7defb7, "<dev string:x6d>", undefined, undefined, 3, 1000 );
            }
        #/
        
        var_4b47655c33f51e24 = utility::spawn_tag_origin( var_d618bd532d7defb7 );
        var_4b47655c33f51e24 show();
        var_4b47655c33f51e24 forcenetfieldhighlod( 1 );
        waitframe();
        playfxontag( utility::getfx( "scorpio_pad_enabled" ), var_4b47655c33f51e24, "tag_origin" );
        var_4b47655c33f51e24 playsound( "evt_scorpio_stomp_indicator" );
        level.scorpio_skel utility::waittill_any( "scorpio_stomp", "scorpio_scene_stopped" );
        stopfxontag( utility::getfx( "scorpio_pad_enabled" ), var_4b47655c33f51e24, "tag_origin" );
        var_4b47655c33f51e24 delete();
    }
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0x81cb9f85, Offset: 0x6de0
    // Size: 0x5, Type: dev
    function function_6119cc8f0144dd5f()
    {
        
    }

#/

// Namespace scorpio
// Params 4
// Checksum 0x56878d78, Offset: 0x6ded
// Size: 0x5b, Type: bool
function scorpio_damaged( attacker, weapon, damagetype, damage )
{
    if ( !utility::flag( "scorpio_completed" ) )
    {
        level mp_agent_damage::function_2b26b84aa6ce249c( attacker.attacker, 1, 1, attacker.point, 0 );
    }
    
    return true;
}

// Namespace scorpio
// Params 1
// Checksum 0xa2e17ad8, Offset: 0x6e51
// Size: 0x44
function function_81effa23eda42791( vehicle_ref )
{
    leveldataforvehicle = vehicle_collision::get_data( vehicle_ref, 1 );
    leveldataforvehicle.handleeventcallback = &scorpio_veh_collision;
    leveldataforvehicle.class = "immovable";
}

// Namespace scorpio
// Params 0
// Checksum 0x75f55e7b, Offset: 0x6e9d
// Size: 0x295
function function_34f0f3b16a0b7c97()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self.velocity = ( 0, 0, 0 );
    aabb = self function_48cbebbf2007bfd1();
    midpoint = vectorlerp( aabb[ "min" ], aabb[ "max" ], 0.5 );
    radius = distance( midpoint, aabb[ "min" ] );
    
    while ( true )
    {
        if ( !isdefined( self ) || !isdefined( self.origin ) )
        {
            return;
        }
        
        players = getplayersinradius( self.origin, radius );
        
        foreach ( player in players )
        {
            aabb = self function_48cbebbf2007bfd1();
            scale = getdvarfloat( @"hash_df1d7e89e4403500", 0.9 );
            aabb_min_scaled = aabb[ "min" ] * scale;
            aabb_max_scaled = aabb[ "max" ] * scale;
            
            if ( math::function_47d0ed373b25c699( player.origin, aabb_min_scaled, aabb_max_scaled ) )
            {
                vector = anglestoright( self.angles ) * int( radius ) * -1;
                player.origin = player.origin + vector + ( 0, 0, 200 );
            }
            else if ( self.script_noteworthy == "j_hip_geo_high" )
            {
                hip_max = ( aabb[ "max" ][ 0 ] - 710, aabb[ "max" ][ 1 ] - 150, aabb[ "max" ][ 2 ] - 160 );
                hip_min = ( aabb[ "min" ][ 0 ] + 710, aabb[ "min" ][ 1 ] + 150, aabb[ "min" ][ 2 ] + 160 );
                
                if ( math::function_47d0ed373b25c699( player.origin, hip_min, hip_max ) )
                {
                    vector = anglestoright( self.angles ) * int( radius ) * -1;
                    player.origin = player.origin + vector + ( 0, 0, 200 );
                }
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace scorpio
// Params 5
// Checksum 0x43c8eaf1, Offset: 0x713a
// Size: 0x4d
function scorpio_veh_collision( vehicle1, vehicle2, position, normal, normalspeed )
{
    collisionresult = function_84efd23ce899e28d( vehicle1, vehicle2, "scorpio_test_veh", 1, 0 );
}

// Namespace scorpio
// Params 5
// Checksum 0x2e2b45c4, Offset: 0x718f
// Size: 0x32e
function function_84efd23ce899e28d( vehicle1, vehicle2, vehicleref, collisioncooldown, var_dbb40ce8f2176838 )
{
    if ( vehicle1 vehicle::get_ref() == vehicleref )
    {
        movingplatform = vehicle1;
        vehicle = vehicle2;
    }
    else
    {
        movingplatform = vehicle2;
        vehicle = vehicle1;
    }
    
    if ( vehicle_collision::is_in_ignore_list( vehicle, movingplatform ) )
    {
        return;
    }
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.health ) ) )
    {
        return;
    }
    
    movingplatformvelocity = undefined;
    vehiclevelocity = vehicle vehicle_getvelocity();
    
    if ( isdefined( movingplatform.velocity ) )
    {
        movingplatformvelocity = movingplatform.velocity;
    }
    else if ( isdefined( movingplatform getlinkedchildren() ) )
    {
        velocity = undefined;
        children = movingplatform getlinkedchildren();
        
        foreach ( child in children )
        {
            if ( isdefined( child.velocity ) )
            {
                movingplatformvelocity = child.velocity;
                break;
            }
        }
    }
    
    magdamagemodifier = 1;
    dirdamagemodifier = 1;
    dvarmodifier = 1;
    var_47925b7fffa4c390 = 1;
    var_3dda7b37a84f78fa = 20;
    var_512d245e0421aeac = 100;
    var_c65552494dd5caee = 99999;
    var_663ac03ca94e3df8 = length( vehiclevelocity );
    magdamagemodifier = math::remap( var_663ac03ca94e3df8, 0, 600, var_47925b7fffa4c390, var_3dda7b37a84f78fa );
    var_2be1e5087f607b31 = math::anglebetweenvectorsunit( vectornormalize( vehiclevelocity ), vectornormalize( movingplatformvelocity ) );
    dirdamagemodifier = math::remap( var_2be1e5087f607b31, 0, 180, var_512d245e0421aeac, var_c65552494dd5caee );
    health = vehicle.health;
    mindamage = health / 10;
    damage = mindamage * dirdamagemodifier * magdamagemodifier * dvarmodifier;
    isvehicledestroyed = damage >= health;
    
    if ( isvehicledestroyed )
    {
        vehicle.dontspawnhusk = 1;
    }
    
    vehicle dodamage( damage, movingplatform.origin, movingplatform, movingplatform, "MOD_CRUSH" );
    
    if ( vehicle vehicle_isphysveh() )
    {
        impulsestrength = var_dbb40ce8f2176838 ?? 250;
        vehicle vehphys_impulse( vehicle.origin - movingplatform.origin + ( 0, 0, 200 ), impulsestrength, 1 );
    }
    
    if ( vehicle.health < health )
    {
        level thread vehicle_collision::function_b456610deaad175( vehicle, movingplatform, collisioncooldown );
        vehicle vehicle::explode();
    }
    
    collisionresult = spawnstruct();
    collisionresult.movingplatform = movingplatform;
    collisionresult.vehicle = vehicle;
    collisionresult.isvehicledestroyed = isvehicledestroyed;
    return collisionresult;
}

// Namespace scorpio
// Params 2
// Checksum 0xcd400fd9, Offset: 0x74c6
// Size: 0x4f
function unresolved_collision_kill_player( player, penetration )
{
    if ( self.entrance_trigger.is_portal_exposed && player istouching( self.entrance_trigger ) )
    {
        return;
    }
    
    player kill();
    function_1fbc65c8a8fac631( player );
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0xb3b9f39c, Offset: 0x751d
    // Size: 0x5, Type: dev
    function function_c0768603890a6ea8()
    {
        
    }

#/

// Namespace scorpio
// Params 0
// Checksum 0xc6726843, Offset: 0x752a
// Size: 0x108
function function_2289c16ab4a4b898()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"scorpio_beam_start" );
        v_start = self gettagorigin( "tag_eye" );
        v_end = self gettagorigin( "tag_eye_lookat" );
        level.scorpio_skel.var_f9679ff0dcb279d1 = spawn( "script_model", v_end );
        level.scorpio_skel.var_f9679ff0dcb279d1.team = "neutral";
        level.scorpio_skel.var_f9679ff0dcb279d1 linkto( level.scorpio_skel, "tag_eye_lookat", ( 0, 0, 0 ), ( 0, 90, 0 ) );
        waitframe();
        level.scorpio_skel thread scorpio_fire_beam( v_start, v_end );
        level waittill( #"scorpio_beam_stop" );
        level.scorpio_skel.fx_laser delete();
    }
}

// Namespace scorpio
// Params 2
// Checksum 0x5f721cd9, Offset: 0x763a
// Size: 0x23c
function scorpio_fire_beam( v_start, v_end )
{
    level endon( #"scorpio_beam_stop" );
    level endon( #"game_ended" );
    self.fx_laser = playfxontagsbetweenclients( utility::getfx( "scorpio_laser" ), self, "tag_eye", self, "tag_eye_lookat" );
    
    if ( isdefined( self.fx_laser ) )
    {
        self.fx_laser forcenetfieldhighlod( 1 );
    }
    
    while ( true )
    {
        contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_vehicleclip", "physicscontents_vehicle" ] );
        ignorelist = [];
        results = physics_spherecast( v_start, self.var_f9679ff0dcb279d1.origin, 100, contents, ignorelist, "physicsquery_all" );
        
        foreach ( cast in results )
        {
            ent = cast[ "entity" ];
            
            if ( !ent )
            {
                continue;
            }
            
            if ( ent.team == "team_two_hundred" )
            {
                if ( 9999 >= ent.health )
                {
                    ent utility::ent_flag_set( "plasma_death_pap" );
                }
                
                ent dodamage( 9999, self.origin, self.var_f9679ff0dcb279d1, undefined, "MOD_ELEMENTAL_ELEC" );
            }
            
            if ( isplayer( ent ) )
            {
                ent dodamage( 50, self.origin, self.var_f9679ff0dcb279d1, undefined, "MOD_ELEMENTAL_ELEC" );
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                ent dodamage( 9999, self.origin, self.var_f9679ff0dcb279d1, undefined, "MOD_ELEMENTAL_ELEC" );
            }
        }
        
        /#
            sphere( self.var_f9679ff0dcb279d1.origin, 100, ( 1, 0, 0 ), undefined, 300 );
        #/
        
        wait 0.25;
    }
}

// Namespace scorpio
// Params 0
// Checksum 0xb3124968, Offset: 0x787e
// Size: 0x61
function function_232cdd9c622061e4()
{
    level endon( #"scorpio_scene_stopped" );
    level endon( #"scorpio_deleted" );
    wait_time = getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
    
    if ( wait_time > 5 )
    {
        wait wait_time - 4.5;
        utility::playsoundontag( "evt_scorpio_laser_charge", "tag_eye" );
        return;
    }
    
    return;
}

/#

    // Namespace scorpio
    // Params 0
    // Checksum 0xdc9a1314, Offset: 0x78e7
    // Size: 0x5, Type: dev
    function function_bc455021941d0ab2()
    {
        
    }

#/

// Namespace scorpio
// Params 1
// Checksum 0xee583546, Offset: 0x78f4
// Size: 0x71
function function_13d9f2ae0850110f( var_56174d118d349e38 )
{
    self notify( #"hash_ed0c6aa9cd572dae" );
    self endon( #"hash_ed0c6aa9cd572dae" );
    level endon( #"game_ended" );
    level endon( #"scorpio_deleted" );
    
    while ( true )
    {
        notetrack = level.scorpio_skel utility::waittill_any_in_array_return( level.var_56174d118d349e38 );
        thread function_3d939a6743e8fdd2( notetrack );
    }
}

// Namespace scorpio
// Params 1
// Checksum 0x54d609d0, Offset: 0x796d
// Size: 0x37
function function_3d939a6743e8fdd2( notetrack )
{
    level.scorpio_skel setscriptablepartstate( notetrack, "Play" );
    waitframe();
    level.scorpio_skel setscriptablepartstate( notetrack, "Stop" );
}

