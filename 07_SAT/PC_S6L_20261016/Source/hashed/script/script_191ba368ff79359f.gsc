// script_191ba368ff79359f  (hash_191ba368ff79359f.gscc) (size: 15993 Bytes / 0x3e79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1103216e (285417838)
// size ...... 15993 (0x3e79)
// includes .. 16  (offset: 0x3bbd)
// strings ... 36  (offset: 0x3c3d)
// dev strs .. 4   (offset: 0x3e49)
// exports ... 34  (offset: 0x2621)
// cseg ...... 0x368 + 0x22b9 (0x2621)
// imports ... 135 (offset: 0x2b71)
// animtree1 . 0   (offset: 0x3e79)
// animtree2 . 0   (offset: 0x3e79)
#using script_5cb6af9395d116c0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;

#namespace scorpio_unlock;

// Namespace scorpio_unlock
// Params 0
// Checksum 0xacda747b, Offset: 0x386
// Size: 0x89
function activity_type_init()
{
    setdvarifuninitialized( @"hash_b19ee4b25ab72a86", 10 );
    activity_common::function_944074f3079c1d4e( "REV_OB_SCORPIO_UNLOCK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SCORPIO_UNLOCK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_SCORPIO_UNLOCK", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_SCORPIO_UNLOCK", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_SCORPIO_UNLOCK" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_SCORPIO_UNLOCK" );
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xccee3d49, Offset: 0x417
// Size: 0x484
function activity_setup()
{
    if ( isdefined( level.var_5611c21c9d9c23fb ) )
    {
        [[ level.var_5611c21c9d9c23fb ]]();
    }
    
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.scorpio_unlock_activity = activity_instance;
    activity_instance.scorpio_unlock_zombies = [];
    portal_angles = ( 0, 0, 0 );
    portal_origin_offset = ( 0, 0, 48 );
    
    if ( activity_instance.varianttag == "scorpio_unlock_path_01" )
    {
        level.scorpio_path_chosen = "path_01";
        portal_angles = ( 2, 0, -2.5 );
    }
    else
    {
        level.scorpio_path_chosen = "path_02";
        portal_origin_offset = ( 0, 0, 38 );
        portal_angles = ( -4, 0, -6 );
    }
    
    hud_util::showsplashtoall( #"hash_7cc904385696f218" );
    var_ea54c0ab42a167ca = activity_instance activity_instance_common::function_94763020f8207b8b();
    activity_instance.portal = utility::spawn_tag_origin( var_ea54c0ab42a167ca - portal_origin_offset, portal_angles );
    activity_instance.portal forcenetfieldhighlod( 1 );
    waitframe();
    activity_instance.portal show();
    playfxontag( utility::getfx( "scorpio_summon_portal" ), activity_instance.portal, "tag_origin" );
    activity_instance.hand_model = spawn( "script_model", var_ea54c0ab42a167ca - ( 135, 0, 694 ) );
    activity_instance.hand_model.angles = ( 3.8411, 330.489, -165.489 );
    activity_instance.hand_model setmodel( "j_wrist_unlock_geo_high" );
    
    if ( activity_instance.varianttag == "scorpio_unlock_path_01" )
    {
        activity_instance.var_6bd599c60e9b36b7 = [ utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( 168, 190, -40 ) ), utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( -278, 95, -45 ) ), utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( 85, -200, -40 ) ) ];
    }
    else
    {
        activity_instance.var_6bd599c60e9b36b7 = [ utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( 168, 190, -40 ) ), utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( -278, 95, -55 ) ), utility::spawn_tag_origin( var_ea54c0ab42a167ca + ( 85, -200, -40 ) ) ];
    }
    
    foreach ( point in activity_instance.var_6bd599c60e9b36b7 )
    {
        point show();
    }
    
    activity_instance.portal.portal_intensity = 1;
    activity_instance function_582979b4868e41a9();
    activity_instance.hand_model moveto( self.hand_model.origin + ( 0, 0, 212 ), 8, 0.5, 0.5 );
    activity_instance thread function_b7ce0244d11308ec( 8 );
    activity_instance.nav_obstacles = [ createnavobstaclebybounds( var_ea54c0ab42a167ca + ( 170, 200, 0 ), ( 45, 45, 120 ), ( 0, 0, 0 ) ), createnavobstaclebybounds( var_ea54c0ab42a167ca + ( -255, 90, 0 ), ( 70, 50, 120 ), ( 0, 0, 0 ) ), createnavobstaclebybounds( var_ea54c0ab42a167ca + ( 100, -180, 0 ), ( 50, 80, 120 ), ( 0, 0, 0 ) ) ];
    activity_instance.unlock_progress = 0;
    activity_instance.should_spawn_ai = 1;
    activity_instance setup_scorpio_unlock_icon();
    
    if ( !isdefined( level.var_4b1635ad61099327 ) )
    {
        level callback::add( #"on_ai_killed", &on_ai_killed_unlock, activity_instance );
        level.var_4b1635ad61099327 = 1;
    }
    
    activity_instance setup_scorpio_unlock_interact();
    
    /#
        activity_instance thread function_caa45d1f2340ea3e();
    #/
    
    activity_instance thread activity_timeout();
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xad7c60c6, Offset: 0x8a3
// Size: 0x100
function activity_timeout()
{
    activity_instance = self;
    activity_instance endon( #"scorpio_unlock_started" );
    
    if ( level.ob_overtime_settings )
    {
        ob_overtime_time = level.ob_overtime_settings.overtime_time;
    }
    
    ob_overtime_time_ms = getdvarint( @"scr_ob_overtime_time", ob_overtime_time ?? 0 ) * 1000;
    
    while ( true )
    {
        match_duration_ms = int( level.timelimit ) * 1000;
        level.var_aa651267740d4cb1 = level.starttime + match_duration_ms - ob_overtime_time_ms;
        remainingtimems = int( max( 0, level.var_aa651267740d4cb1 - gettime() ) );
        time_limit = getdvarint( @"hash_b19ee4b25ab72a86" ) * 60 * 1000;
        
        if ( remainingtimems <= time_limit )
        {
            thread unlock_activity_ended( activity_instance );
            activity_instance_common::function_9aeeabe50fc9cc3e( activity_instance );
            return;
        }
        
        wait 1;
    }
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x5a673437, Offset: 0x9ab
// Size: 0x358
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance notify( #"scorpio_unlock_started" );
    time_limit = getdvarfloat( @"hash_4f38d2d033840801", 300 );
    activity_instance.var_78770bf2c55fe93d = activity_instance activity_instance_common::function_94763020f8207b8b();
    activity_definition_utils::updatetimer( time_limit, activity_instance );
    activity_instance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 100 );
    activity_instance thread function_5f0e1c7e92bea551( time_limit );
    activity_instance thread function_e416295b21688913();
    activity_instance thread function_5fa518f681866f66();
    activity_instance thread function_f489eb7216ae9932();
    activity_instance.obj_circle = ob_story_mission_utils::function_ab06e28322870f4( activity_instance.var_78770bf2c55fe93d, 1000, level.players );
    activity_instance.a_obj_circle = [];
    activity_instance.a_obj_circle[ activity_instance.a_obj_circle.size ] = activity_instance.obj_circle;
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_summon_flood_fill", activity_instance.var_78770bf2c55fe93d, 650, 1, 1, 1, 0 );
    ai_spawn_director::function_c99d360d62c49a9c( requestid, &function_c13ecab4cd053555, self );
    ai_spawn_director::function_53289c032f506bb1( requestid, &function_f7a157c435e76b90, self );
    ai_spawn_director::add_spawned_callback( requestid, &function_4cbcfabafb93a321, activity_instance );
    activity_instance.requestid = requestid;
    activity_instance thread function_bd1a9a56942a572();
    
    /#
        activity_instance thread function_e90bb665baff4a2d();
    #/
    
    activity_outcome = activity_instance utility::waittill_any_return( "scorpio_unlock_complete", "scorpio_unlock_timeout" );
    level thread unlock_activity_ended( activity_instance );
    
    if ( activity_outcome == "scorpio_unlock_timeout" )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        foreach ( player in activity_instance.playerparticipants )
        {
            player hud_message::showsplash( #"hash_4c8da73c8cf89ab9" );
        }
        
        activity_instance_common::endactivity( activity_instance, 0 );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x40>" );
    #/
    
    if ( level.scorpio_path_chosen == "path_01" )
    {
        laser_endpoint = ( 13500.6, -1978.49, 23000.2 );
    }
    else if ( level.scorpio_path_chosen == "path_02" )
    {
        laser_endpoint = ( 58993.4, 25661.6, 23770.9 );
    }
    
    fx_laser = function_767584b2d3ddf986( utility::getfx( "scorpio_summon_laser" ), activity_instance.var_78770bf2c55fe93d - ( 0, 0, 30 ), ( 0, 0, 0 ), laser_endpoint );
    playsoundatpos( activity_instance.var_78770bf2c55fe93d, "evt_scorpio_summon_laser_beam" );
    
    if ( isdefined( fx_laser ) )
    {
        fx_laser forcenetfieldhighlod( 1 );
    }
    
    wait 4.5;
    level thread scorpio::function_2737405cf9fb2a23();
    level thread scorpio::function_41c0ac831f272407();
    wait 1;
    fx_laser delete();
    hud_util::showsplashtoall( #"hash_464997ab159cab86" );
    setomnvar( o"ui_world_event_timer", int( gettime() + 21650 ) );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace scorpio_unlock
// Params 1
// Checksum 0x17cc5706, Offset: 0xd0b
// Size: 0x1f0
function unlock_activity_ended( activity_instance )
{
    level callback::remove( #"on_ai_killed", &on_ai_killed_unlock, activity_instance );
    activity_instance cleanup_vfx();
    activity_instance.hand_model moveto( activity_instance.hand_model.origin - ( 0, 0, 445 ), 8, 2, 1.2 );
    activity_instance thread function_b7ce0244d11308ec( 8 );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( level.scorpio_unlock_obj_id ) )
    {
        level objidpoolmanager::returnobjectiveid( level.scorpio_unlock_obj_id );
    }
    
    if ( activity_instance.obj_circle )
    {
        activity_instance ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
    }
    
    if ( isdefined( activity_instance.requestid ) )
    {
        ai_spawn_director::cancel_spawn_request( activity_instance.requestid, 0, 0 );
    }
    
    activity_instance.should_shutdown_ai = 1;
    activity_instance activity_ai_encounters::function_cb88eba0bb17a5e4();
    wait 1;
    activity_instance cleanup_models();
    
    foreach ( obj in activity_instance.nav_obstacles )
    {
        destroynavobstacle( obj );
    }
    
    foreach ( point in activity_instance.var_6bd599c60e9b36b7 )
    {
        point delete();
    }
}

/#

    // Namespace scorpio_unlock
    // Params 0
    // Checksum 0xac1ffde4, Offset: 0xf03
    // Size: 0x6d, Type: dev
    function function_e90bb665baff4a2d()
    {
        level endon( #"game_ended" );
        activity_instance = self;
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        activity_instance endon( #"scorpio_unlock_complete" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_2c79bf8106ddb5da", 0 ) )
            {
                self.unlock_progress = 100;
                break;
            }
            
            waitframe();
        }
    }

    // Namespace scorpio_unlock
    // Params 0
    // Checksum 0x4748410a, Offset: 0xf78
    // Size: 0x8d, Type: dev
    function function_caa45d1f2340ea3e()
    {
        level endon( #"game_ended" );
        activity_instance = self;
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        activity_instance endon( #"scorpio_unlock_complete" );
        var_ea54c0ab42a167ca = activity_instance activity_instance_common::function_94763020f8207b8b();
        
        while ( true )
        {
            if ( getdvarint( @"hash_c5e11249d8a43d1c", 0 ) )
            {
                sphere( var_ea54c0ab42a167ca, 800, ( 1, 0, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace scorpio_unlock
// Params 1
// Checksum 0x9f53a15a, Offset: 0x100d
// Size: 0x70
function function_5f0e1c7e92bea551( time_limit )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"scorpio_unlock_complete" );
    missiontime = gettime() + time_limit * 1000;
    
    while ( gettime() < missiontime )
    {
        waitframe();
    }
    
    activity_instance notify( #"scorpio_unlock_timeout" );
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xde9a3893, Offset: 0x1085
// Size: 0x135
function setup_scorpio_unlock_icon()
{
    activity_instance = self;
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( level.scorpio_unlock_obj_id ) )
    {
        level objidpoolmanager::returnobjectiveid( level.scorpio_unlock_obj_id );
    }
    
    bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", "sat_ob_objectivemarker_scorpio" );
    level.scorpio_unlock_obj_id = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( bundlexhash );
    objidpoolmanager::update_objective_position( level.scorpio_unlock_obj_id, activity_instance.portal.origin + ( 0, 0, 500 ) );
    objidpoolmanager::objective_set_play_intro( level.scorpio_unlock_obj_id, 0 );
    objidpoolmanager::objective_set_play_outro( level.scorpio_unlock_obj_id, 0 );
    function_2b8e3d3ae2a6414a( level.scorpio_unlock_obj_id, 0 );
    objective_state( level.scorpio_unlock_obj_id, "active" );
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_we_scorpio_unlock" );
    function_3f1a6a0ae5901866( level.scorpio_unlock_obj_id, hovercardid );
    function_771fb62e0d43ad8( level.scorpio_unlock_obj_id, &"sat_ob_activities/scorpio_unlock" );
    objective_setlabel( level.scorpio_unlock_obj_id, &"sat_ob_activities/scorpio_unlock" );
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xd2101eea, Offset: 0x11c2
// Size: 0x9c
function setup_scorpio_unlock_interact()
{
    activity_instance = self;
    var_cbf2696af3924e4b = activity_instance activity_instance_common::function_94763020f8207b8b();
    activity_start_interact = interaction::register_interact( var_cbf2696af3924e4b, 64, &scorpio_unlock_on_interact );
    activity_start_interact interaction::set_interact_hint_callback( &scorpio_unlock_interact_hint );
    activity_start_interact makeusable();
    activity_start_interact setusableenabled( 1 );
    activity_start_interact setusepriority( 0 );
    activity_start_interact sethintdisplayrange( 130 );
    activity_start_interact setusefov( 140 );
    activity_start_interact sethintdisplayfov( 140 );
    activity_start_interact setcursorhint( "HINT_BUTTON" );
    activity_start_interact setuseholdduration( "duration_short" );
    activity_start_interact setuserange( 128 );
}

// Namespace scorpio_unlock
// Params 1
// Checksum 0x2da24eb, Offset: 0x1266
// Size: 0x22
function scorpio_unlock_on_interact( player )
{
    activity_instance_common::function_46135a69bddfec2c( level.scorpio_unlock_activity );
    self delete();
}

// Namespace scorpio_unlock
// Params 2
// Checksum 0x69698a70, Offset: 0x1290
// Size: 0x40
function scorpio_unlock_interact_hint( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"sat_ob_activities/scorpio_unlock_interact", #type:"HINT_BUTTON" };
}

// Namespace scorpio_unlock
// Params 0, eflags: 0x4
// Checksum 0xd8491454, Offset: 0x12d9
// Size: 0x2d7
function private function_582979b4868e41a9()
{
    portal = self.portal;
    
    switch ( portal.portal_intensity )
    {
        case 0:
            portal delete();
            break;
        case 1:
            break;
        case 2:
            foreach ( player in self.playerparticipants )
            {
                earthquake( 0.375, 1, player.origin, 100 );
                player playrumbleonentity( "heavy_2s" );
            }
            
            break;
        case 3:
            foreach ( player in self.playerparticipants )
            {
                earthquake( 0.375, 1, player.origin, 100 );
                player playrumbleonentity( "heavy_2s" );
            }
            
            break;
        case 4:
            foreach ( player in self.playerparticipants )
            {
                earthquake( 0.575, 1.5, player.origin, 100 );
                player playrumbleonentity( "heavy_2s" );
            }
            
            break;
        case 5:
            foreach ( player in self.playerparticipants )
            {
                earthquake( 0.775, 2, player.origin, 100 );
                player playrumbleonentity( "heavy_2s" );
            }
            
            break;
        default:
            break;
    }
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xe2d486b1, Offset: 0x15b8
// Size: 0x41b
function function_e416295b21688913()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"scorpio_unlock_timeout" );
    
    while ( true )
    {
        if ( self.unlock_progress == 0 && !isdefined( self.portal_started ) )
        {
            self.portal_started = 1;
            self.portal.portal_intensity = 2;
            function_582979b4868e41a9();
            self.hand_model moveto( self.hand_model.origin + ( 0, 0, 20 ), 8, 2, 1.2 );
            thread function_b7ce0244d11308ec( 8 );
        }
        else if ( self.unlock_progress >= 35 && !isdefined( self.first_threshold_reached ) )
        {
            self.first_threshold_reached = 1;
            self.portal.portal_intensity = 3;
            function_582979b4868e41a9();
            self.hand_model moveto( self.hand_model.origin + ( 0, 0, 50 ), 8, 2, 1.2 );
            thread function_b7ce0244d11308ec( 8 );
        }
        else if ( self.unlock_progress >= 70 && !isdefined( self.second_threshold_reached ) )
        {
            self.second_threshold_reached = 1;
            self.portal.portal_intensity = 4;
            function_582979b4868e41a9();
            self.hand_model moveto( self.hand_model.origin + ( 0, 0, 75 ), 8, 2, 1.2 );
            thread function_b7ce0244d11308ec( 8 );
        }
        else if ( self.unlock_progress == 100 && !isdefined( self.var_f6ba959ee15b5936 ) )
        {
            foreach ( agent in self.scorpio_unlock_zombies )
            {
                agent kill();
            }
            
            self.var_f6ba959ee15b5936 = 1;
            self.portal.portal_intensity = 5;
            function_582979b4868e41a9();
            self.hand_model moveto( self.hand_model.origin + ( 0, 0, 100 ), 8, 2, 1.2 );
            thread function_b7ce0244d11308ec( 8 );
            self.portal utility::delaycall( 0.5, &playsound, "evt_scorpio_laser_charge" );
            wait 2;
            scorpio_unlock_vo = [ "scorpio_arrival_laser_karm", "scorpio_arrival_laser_mars" ];
            overlord::playevent( utility::array_random( scorpio_unlock_vo ), self.playerparticipants );
            wait 4;
            
            foreach ( player in self.playerparticipants )
            {
                earthquake( 0.68, 4, player.origin, 800 );
                player playrumbleonentity( "heavy_2s" );
            }
            
            self notify( #"scorpio_unlock_complete" );
            wait 2;
            self.hand_model moveto( self.hand_model.origin - ( 0, 0, 445 ), 8, 2, 1.2 );
            thread function_b7ce0244d11308ec( 8 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0xd2bbd996, Offset: 0x19db
// Size: 0xfc
function function_5fa518f681866f66()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"scorpio_unlock_timeout" );
    
    while ( true )
    {
        if ( activity_instance.unlock_progress >= 25 && !activity_instance.var_fe372bdcfd986495 )
        {
            activity_instance thread function_84c02e62eb2e78f6( 1 );
            activity_instance.var_fe372bdcfd986495 = 1;
        }
        else if ( activity_instance.unlock_progress >= 50 && !activity_instance.var_d4381fa1abcaf44f )
        {
            activity_instance thread function_84c02e62eb2e78f6( 2 );
            activity_instance.var_d4381fa1abcaf44f = 1;
        }
        else if ( activity_instance.unlock_progress >= 75 && !activity_instance.var_c95063e9aefa2728 )
        {
            activity_instance thread function_84c02e62eb2e78f6( 3 );
            activity_instance.var_c95063e9aefa2728 = 1;
        }
        
        waitframe();
    }
}

// Namespace scorpio_unlock
// Params 1
// Checksum 0xe3f2c6fc, Offset: 0x1adf
// Size: 0x149
function function_b7ce0244d11308ec( time )
{
    activity_instance = self;
    var_ea54c0ab42a167ca = activity_instance activity_instance_common::function_94763020f8207b8b();
    
    foreach ( point in activity_instance.var_6bd599c60e9b36b7 )
    {
        playfxontag( utility::getfx( "scorpio_summon_dust" ), point, "tag_origin" );
        playsoundatpos( point.origin, "evt_scorpio_summon_hand_metal" );
    }
    
    wait time;
    
    foreach ( point in activity_instance.var_6bd599c60e9b36b7 )
    {
        stopfxontag( utility::getfx( "scorpio_summon_dust" ), point, "tag_origin" );
    }
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x230741a3, Offset: 0x1c30
// Size: 0x5e
function cleanup_models()
{
    activity_instance = self;
    
    if ( activity_instance.portal )
    {
        activity_instance.portal.portal_intensity = 0;
        activity_instance function_582979b4868e41a9();
    }
    
    wait 8;
    
    if ( activity_instance.hand_model )
    {
        activity_instance.hand_model delete();
    }
}

/#

    // Namespace scorpio_unlock
    // Params 0
    // Checksum 0xd631c290, Offset: 0x1c96
    // Size: 0x5, Type: dev
    function function_93ca77d755cefe77()
    {
        
    }

#/

// Namespace scorpio_unlock
// Params 1
// Checksum 0x25c45c76, Offset: 0x1ca3
// Size: 0x75
function function_84c02e62eb2e78f6( count = 1 )
{
    activity_instance = self;
    
    for ( i = 0; i < count ; i++ )
    {
        requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_summon_specials", activity_instance.var_78770bf2c55fe93d, 650, 1, 1, 1, 2 );
        ai_spawn_director::add_spawned_callback( requestid, &function_4cbcfabafb93a321, activity_instance );
    }
}

// Namespace scorpio_unlock
// Params 2
// Checksum 0x6d19fd37, Offset: 0x1d20
// Size: 0x33
function function_c13ecab4cd053555( requestid, activity_instance )
{
    if ( activity_instance.should_spawn_ai )
    {
        activity_instance.should_spawn_ai = 0;
        return 1;
    }
}

// Namespace scorpio_unlock
// Params 2
// Checksum 0x11552927, Offset: 0x1d5b
// Size: 0x26
function function_f7a157c435e76b90( requestid, activity_instance )
{
    if ( activity_instance.should_shutdown_ai )
    {
        return 1;
    }
}

// Namespace scorpio_unlock
// Params 4
// Checksum 0x3505c6f7, Offset: 0x1d89
// Size: 0x132
function function_4cbcfabafb93a321( requestid, activity_instance, agent, data )
{
    if ( isdefined( activity_instance.var_78770bf2c55fe93d ) )
    {
        if ( getdvarint( @"hash_24890fbfc9921ecf", 0 ) )
        {
            agent ob_story_mission_utils::zombie_set_difficulty( "difficulty5" );
        }
        else
        {
            agent ob_story_mission_utils::zombie_set_difficulty( "difficulty_darkaether" );
        }
        
        agent.is_scorpio_unlock_ai = 1;
        agent setgoalpos( activity_instance.var_78770bf2c55fe93d, 650 );
        activity_instance.scorpio_unlock_zombies[ activity_instance.scorpio_unlock_zombies.size ] = agent;
        agent function_fa32376aaa88a7a2( agent.origin, 2500 );
        agent._blackboard.var_b213ded5043dfa2b = agent.origin;
        agent._blackboard.var_8d11b98561e1eb81 = 100;
        agent._blackboard.var_8d34ab856208146f = 400;
        agent._blackboard.var_6a8c50efac75caa1 = 2500;
        agent.var_6fb8224240879ded = 1;
    }
}

// Namespace scorpio_unlock
// Params 0, eflags: 0x4
// Checksum 0x56e5eaa1, Offset: 0x1ec3
// Size: 0xf8
function private function_bd1a9a56942a572()
{
    activity_instance = self;
    maxrangesq = 9000000;
    
    while ( true )
    {
        activity_instance.scorpio_unlock_zombies = utility::array_removedead_or_dying( activity_instance.scorpio_unlock_zombies );
        
        foreach ( agent in activity_instance.scorpio_unlock_zombies )
        {
            if ( isalive( agent ) && distancesquared( agent.origin, activity_instance.var_78770bf2c55fe93d ) > maxrangesq )
            {
                agent.var_a13bed1ac47e1b2c = 1;
                agent kill();
            }
        }
        
        wait 0.25;
    }
}

// Namespace scorpio_unlock
// Params 2, eflags: 0x4
// Checksum 0x65dd0b0b, Offset: 0x1fc3
// Size: 0x121
function private on_ai_killed_unlock( params, activityinstance )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( activityinstance ) && isdefined( activityinstance.valid_zombies ) )
    {
        if ( arraycontains( activityinstance.valid_zombies, self ) )
        {
            if ( activityinstance.unlock_progress < 100 )
            {
                increase = 1;
                
                /#
                    increase *= getdvarint( @"hash_9236f1e231afcc7b", 1 );
                #/
                
                activityinstance.unlock_progress = clamp( activityinstance.unlock_progress + increase, 0, 100 );
                beam_start_pos = self gettagorigin( "j_head" );
                beam_end_pos = activityinstance activity_instance_common::function_94763020f8207b8b();
                function_29a54a1adee4df6b( beam_start_pos, beam_end_pos + ( 0, 0, -30 ) );
                waitframe();
                activity_definition_utils::updateprogress( activityinstance.unlock_progress, activityinstance, 100 );
                
                /#
                    iprintlnbold( "<dev string:x5e>" + activityinstance.unlock_progress + "<dev string:x72>" );
                #/
            }
        }
    }
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x971337a6, Offset: 0x20ec
// Size: 0xd9
function get_zombies_in_radius()
{
    var_d3bf5c32e7a64eb1 = getaispeciesarray( "all", "zombie" );
    culled_zombies = sortbydistancecullbyradius( var_d3bf5c32e7a64eb1, activity_instance_common::function_94763020f8207b8b(), 1000 );
    valid_zombies = [];
    
    foreach ( zombie in culled_zombies )
    {
        if ( zombie.is_scorpio_unlock_ai )
        {
            valid_zombies[ valid_zombies.size ] = zombie;
            
            if ( !isdefined( zombie.activityinstance ) )
            {
                zombie.activityinstance = self;
            }
        }
    }
    
    return valid_zombies;
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x44033087, Offset: 0x21ce
// Size: 0x1d5
function function_f489eb7216ae9932()
{
    self endon( #"scorpio_unlock_complete" );
    self endon( #"scorpio_unlock_timeout" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( isdefined( self.valid_zombies ) )
        {
            self.past_zombies = self.valid_zombies;
        }
        else
        {
            self.past_zombies = [];
        }
        
        self.valid_zombies = get_zombies_in_radius();
        var_48815cf4b249aec6 = arrayremove( self.valid_zombies, self.past_zombies );
        var_537c2272f3ebcf9f = arrayremove( self.past_zombies, self.valid_zombies );
        
        if ( var_48815cf4b249aec6.size > 0 )
        {
            waitframe();
            
            foreach ( zombie in var_48815cf4b249aec6 )
            {
                if ( zombie.is_scorpio_unlock_ai )
                {
                    zombie setscriptablepartstate( "smoke", "on", 0 );
                }
            }
        }
        
        foreach ( zombie in var_537c2272f3ebcf9f )
        {
            if ( isalive( zombie ) )
            {
                if ( zombie.is_scorpio_unlock_ai )
                {
                    zombie setscriptablepartstate( "smoke", "off", 0 );
                }
            }
        }
        
        wait 0.15;
    }
}

// Namespace scorpio_unlock
// Params 2, eflags: 0x4
// Checksum 0x9f5ea9b, Offset: 0x23ab
// Size: 0xb4
function private function_29a54a1adee4df6b( beam_start_pos, beam_end_pos )
{
    vfx_point = utility::spawn_model( "tag_origin", beam_start_pos, ( 0, 0, 0 ) );
    playfxontag( level._effect[ "vfx_sat_sco_robot_ext_pad_pulse_1" ], vfx_point, "tag_origin" );
    distance = distancesquared( beam_start_pos, beam_end_pos );
    move_speed = mapfloat( 0, 360000, 0.35, 0.65, distance );
    waitframe();
    vfx_point moveto( beam_end_pos, move_speed );
    wait move_speed;
    playsoundatpos( vfx_point.origin, "evt_scorpio_cradle_trail_impact" );
    vfx_point delete();
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x76d4c4e5, Offset: 0x2467
// Size: 0xaa
function cleanup_vfx()
{
    foreach ( zombie in self.valid_zombies )
    {
        if ( isalive( zombie ) && zombie.is_scorpio_unlock_ai && zombie getscriptablehaspart( "smoke" ) )
        {
            zombie setscriptablepartstate( "smoke", "off" );
        }
    }
}

/#

    // Namespace scorpio_unlock
    // Params 0
    // Checksum 0xf60b5b27, Offset: 0x2519
    // Size: 0x5, Type: dev
    function function_9002c5d78539d855()
    {
        
    }

#/

// Namespace scorpio_unlock
// Params 1
// Checksum 0x50cf82dd, Offset: 0x2526
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace scorpio_unlock
// Params 0
// Checksum 0x85e78c13, Offset: 0x2554
// Size: 0x62
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( level.scorpio_unlock_obj_id ) )
    {
        level objidpoolmanager::returnobjectiveid( level.scorpio_unlock_obj_id );
    }
    
    if ( activity_instance.obj_circle )
    {
        activity_instance ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
    }
}

// Namespace scorpio_unlock
// Params 1
// Checksum 0xf1145a74, Offset: 0x25be
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace scorpio_unlock
// Params 1
// Checksum 0x2d4bb350, Offset: 0x25fe
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

