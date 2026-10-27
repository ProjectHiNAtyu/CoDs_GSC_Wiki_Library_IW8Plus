// script_24ca45b70d66c3c3  (hash_24ca45b70d66c3c3.gscc) (size: 53439 Bytes / 0xd0bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61285151 (1630032209)
// size ...... 53439 (0xd0bf)
// includes .. 33  (offset: 0xc2ff)
// strings ... 191 (offset: 0xc407)
// dev strs .. 11  (offset: 0xd03b)
// exports ... 120 (offset: 0x87db)
// cseg ...... 0x12fa + 0x74e1 (0x87db)
// imports ... 314 (offset: 0x9a9b)
// animtree1 . 0   (offset: 0xd0bf)
// animtree2 . 0   (offset: 0xd0bf)
#using script_4e2becc40a3e7251;
#using script_5cb6af9395d116c0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\squad_notification;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\coop;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;

#namespace scorpio_interior;

// Namespace scorpio_interior
// Params 0, eflags: 0x5
// Checksum 0x70b18b8c, Offset: 0x1318
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3f28ce88bf59130", #"activity_common", &function_538033a540e63c70, undefined );
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x33d5f901, Offset: 0x1341
    // Size: 0x5, Type: dev
    function function_1dedde1750cdb87f()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 0, eflags: 0x4
// Checksum 0x71968192, Offset: 0x134e
// Size: 0x2
function private function_538033a540e63c70()
{
    
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xe058a71b, Offset: 0x1358
// Size: 0xe7
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "OB_SCORPIO_INTERIOR", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_SCORPIO_INTERIOR", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_SCORPIO_INTERIOR", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "OB_SCORPIO_INTERIOR", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_SCORPIO_INTERIOR" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "OB_SCORPIO_INTERIOR" );
    level._effect[ "energy_ball_plasma" ] = loadfxasset( "vfx_sat_sco_robot_int_pad_pulse_1" );
    scriptable::scriptable_addnotifycallback( "scorpio_interior_weakpoint_destroyed", &weakpoint_destroyed_callback );
    scriptable::scriptable_adddamagedcallback( &weakpoint_damage_callback );
    scriptable::scriptable_adddamagedcallback( &core_damage_callback );
    level callback::add( #"player_connect", &healthbar_on_player_connect );
    level callback::add( #"player_spawned", &on_player_spawned );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x7e15f14a, Offset: 0x1447
// Size: 0x276
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.scorpio_participants = [];
    activity_instance thread setup_interior_interacts();
    activity_instance thread function_db2faa3c20d823c6();
    activity_instance thread setup_healthbar();
    init_plates( "ob_scorpio_interior_plate", activity_instance );
    entrance_trigger = getent( "scorpio_interior_entrance_trigger", #targetname );
    entrance_trigger.activity_instance = activity_instance;
    activity_instance thread function_494d63c89dcae966();
    activity_instance thread function_27b017187254ce74( 1 );
    core = getentitylessscriptablearray( "scorpio_interior_core", #script_noteworthy )[ 0 ];
    core.max_health = getdvarint( @"hash_8481e540c5ff606a", 40000 );
    core.var_ab8007f32d8a3abe = core.max_health;
    core.max_damage_taken = core.max_health * 0.02;
    core.var_1d03cd3f2037ebbb = core.max_health * 0.5;
    core.phase = 1;
    core.activity_instance = activity_instance;
    core setscriptablepartstate( "health", "damageable" );
    shield = getentitylessscriptablearray( "scorpio_interior_core_shield", #script_noteworthy )[ 0 ];
    shield setscriptablepartstate( "health", "damageable" );
    activity_instance thread function_63748e5900836444( shield );
    trigger::makeenterexittrigger( entrance_trigger, &function_713cc4802f7d18ec );
    level thread function_a0fe30748a0e428a();
    level thread function_7ca4e7b4f1356575();
    
    if ( level.scorpio_path_chosen == "path_01" )
    {
        time_limit = getdvarfloat( @"hash_734dbe303df80cc5", 577 );
    }
    else if ( level.scorpio_path_chosen == "path_02" )
    {
        time_limit = getdvarfloat( @"hash_734dbe303df80cc5", 513 );
    }
    
    activity_definition_utils::updatetimer( time_limit, activity_instance );
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ "OB_SCORPIO_INTERIOR" ];
    
    if ( isdefined( activity_info.region.difficulty ) )
    {
        activity_instance.var_546e4eb5269dbafa = activity_info.region.difficulty;
        activity_instance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0 );
    }
    
    level thread function_9187e77917fd1bb0();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xf2d5df26, Offset: 0x16c5
// Size: 0x37a
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.scorpio_interior_failed )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_ba90189bd75b136c", 0 ) == 1 )
        {
            thread function_2bc277f044e466f0( 1, activity_instance.playerparticipants );
            
            foreach ( player in level.players )
            {
                function_558553ee01c73219( player );
            }
            
            level.scorpio_skel.health_struct = undefined;
            activity_instance_common::endactivity( activity_instance, 1 );
            return;
        }
    #/
    
    utility::flag_clear( "scorpio_completed" );
    utility::flag_clear( "scorpio_headlaunch_ready" );
    utility::flag_clear( "scorpio_headlaunch_complete" );
    core = getentitylessscriptablearray( "scorpio_interior_core", #script_noteworthy )[ 0 ];
    plate_01 = getentitylessscriptablearray( "ob_scorpio_interior_plate_01", #targetname )[ 0 ];
    plate_02 = getentitylessscriptablearray( "ob_scorpio_interior_plate_02", #targetname )[ 0 ];
    plate_03 = getentitylessscriptablearray( "ob_scorpio_interior_plate_03", #targetname )[ 0 ];
    core_shield = getentitylessscriptablearray( "scorpio_interior_core_shield", #script_noteworthy )[ 0 ];
    
    /#
        debug_draw( plate_01, "<dev string:x24>" );
        debug_draw( plate_02, "<dev string:x2d>" );
        debug_draw( plate_03, "<dev string:x36>" );
    #/
    
    nightmare_struct = utility::getstruct( "scorpio_interior_cradle_nightmare_center", "targetname" );
    var_8223ee6726fc55c0 = getdvarfloat( @"hash_13c24b2a0fa58c75", 8 );
    activity_instance thread function_8328c423f0a253e3( plate_01, "plate_01_complete", "scorpio_interior_bottom_defenders_01", "plate_01", "plate_01_cradle_vfx", var_8223ee6726fc55c0 );
    activity_instance thread function_c57852382dfb190f( nightmare_struct.origin, 1750 );
    activity_instance utility::waittill_all_in_array( [ "plate_01_complete" ] );
    activity_instance thread core_vulnerable( core, core_shield, 1 );
    activity_instance waittill( #"damage_threshold_hit" );
    activity_instance.var_dc364191fb7909d1 = 1;
    overlord::playevent( "scorpio_phase_2", activity_instance.playerparticipants );
    activity_instance thread function_6800cc05941b805d( nightmare_struct.origin, 1750 );
    var_d9c1c26b166237f7 = getdvarfloat( @"hash_e698eb3f1fcfbc32", 6 );
    activity_instance thread function_8328c423f0a253e3( plate_02, "plate_02_complete", "scorpio_interior_bottom_defenders_02", "plate_02", "plate_02_cradle_vfx", var_d9c1c26b166237f7 );
    activity_instance thread function_8328c423f0a253e3( plate_03, "plate_03_complete", "scorpio_interior_bottom_defenders_03", "plate_03", "plate_03_cradle_vfx", var_d9c1c26b166237f7 );
    activity_instance utility::waittill_all_in_array( [ "plate_02_complete", "plate_03_complete" ] );
    activity_instance thread core_vulnerable( core, core_shield, 2 );
    activity_instance waittill( #"damage_threshold_hit" );
    
    /#
        iprintlnbold( "<dev string:x3f>" );
    #/
    
    thread function_2bc277f044e466f0( 1, activity_instance.playerparticipants );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xc98f8634, Offset: 0x1a47
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance activity_ai_encounters::function_cb88eba0bb17a5e4();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x5fc46e25, Offset: 0x1a7e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xe3b95358, Offset: 0x1aa2
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x95152397, Offset: 0x1aba
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x959778b0, Offset: 0x1b10
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xb9acc257, Offset: 0x1b50
// Size: 0x97
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        player setclientomnvar( "ui_hide_minimap", 0 );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x8d195af1, Offset: 0x1bef
// Size: 0x119
function function_494d63c89dcae966()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.scorpio_skel utility::waittill_any_in_array( [ "scorpio_reached_end", "scorpio_interior_timeout" ] );
    activity_instance.scorpio_interior_failed = 1;
    thread function_2bc277f044e466f0( 0, activity_instance.playerparticipants );
    
    if ( activity_instance_common::getactivitystate( activity_instance ) == "Idle" )
    {
        activity_instance_common::function_46135a69bddfec2c( activity_instance );
    }
    
    foreach ( player in level.players )
    {
        function_558553ee01c73219( player );
    }
    
    if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x308d2de4, Offset: 0x1d10
// Size: 0x10d
function function_5f0e1c7e92bea551( time_limit )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    missiontime = gettime() + time_limit * 1000;
    
    while ( gettime() < missiontime )
    {
        waitframe();
    }
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player dodamage( player.health - 1, player.origin, level.scorpio_skel.exit_interact );
    }
    
    level.scorpio_skel notify( #"scorpio_interior_timeout" );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x37b11de9, Offset: 0x1e25
// Size: 0x172
function function_27b017187254ce74( var_4ea02cac14472611 )
{
    utility::flag_wait( "scriptables_ready" );
    crate_structs = utility::getstructarray( "scorpio_interior_ammo_crate", "targetname" );
    
    foreach ( struct in crate_structs )
    {
        scriptables = getentitylessscriptablearray( undefined, undefined, struct.origin, 300 );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable.classname == "scriptable_guild_ammo_restock_model_no_icon" && scriptable getscriptableparthasstate( "military_ammo_restock", "useable_on_icon" ) )
            {
                if ( var_4ea02cac14472611 )
                {
                    scriptable setscriptablepartstate( "military_ammo_restock", "useable_on_icon" );
                    continue;
                }
                
                scriptable setscriptablepartstate( "military_ammo_restock", "useable_on" );
            }
        }
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x1e99ab08, Offset: 0x1f9f
// Size: 0x72
function jump_pad_setup()
{
    var_6bf3019314bad940 = utility::getstruct( "scorpio_interior_jump_pad_01" );
    var_6bf3049314badfd9 = utility::getstruct( "scorpio_interior_jump_pad_02" );
    jump_pads = getentitylessscriptablearray( "scorpio_interio_jump_pad", #script_noteworthy );
    level thread jump_pad_watcher( var_6bf3019314bad940, 100, 950 );
    level thread jump_pad_watcher( var_6bf3049314badfd9, 420, 655 );
}

// Namespace scorpio_interior
// Params 3
// Checksum 0x890d7972, Offset: 0x2019
// Size: 0x81
function jump_pad_watcher( var_ee26cf46e899a5c6, forward_velocity, upward_velocity )
{
    level endon( #"game_ended" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    
    if ( !var_ee26cf46e899a5c6 )
    {
        return;
    }
    
    while ( true )
    {
        players_in_radius = getplayersinradius( var_ee26cf46e899a5c6.origin, 64 );
        
        if ( isdefined( players_in_radius ) )
        {
            jump_pad_knockback( players_in_radius, var_ee26cf46e899a5c6, forward_velocity, upward_velocity );
        }
        
        waitframe();
    }
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xcfd6d49c, Offset: 0x20a2
// Size: 0x138
function jump_pad_knockback( players, var_ee26cf46e899a5c6, forward_velocity = 100, upward_velocity = 1000 )
{
    foreach ( player in players )
    {
        if ( isplayer( player ) && !events::function_853f2fa3d548d7ec( player ) )
        {
            up = anglestoup( player.angles );
            forward = anglestoforward( var_ee26cf46e899a5c6.angles );
            player setorigin( player.origin + ( 0, 0, 20 ) );
            player setvelocity( forward * forward_velocity + up * upward_velocity );
            player playsoundonmovingent( "evt_scorpio_jumppad_launch" );
            player playlocalsound( "evt_scorpio_jumppad_launch_plr" );
        }
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xacc1eef7, Offset: 0x21e2
// Size: 0x53a
function scorpio_interior_cleanup()
{
    if ( level.scorpio_skel.health_struct )
    {
        level.scorpio_skel.health_struct = undefined;
    }
    
    pylon_lights = getentarray( "red_pylon_lights", #script_noteworthy );
    
    foreach ( pylon_light in pylon_lights )
    {
        pylon_light setlightintensity( 700 );
    }
    
    foreach ( player in level.scorpio_participants )
    {
        player playersetgroundreferenceent( undefined );
    }
    
    level.scorpio_participants = undefined;
    
    if ( isdefined( level.scorpio_skel.immersion_ent ) )
    {
        level.scorpio_skel.immersion_ent delete();
    }
    
    core = getentitylessscriptablearray( "scorpio_interior_core", #script_noteworthy )[ 0 ];
    
    if ( isdefined( core ) )
    {
        core setscriptablepartstate( "base", "pristine" );
    }
    
    core_trigger = getent( "scorpio_interior_portal_head_entrance", #targetname );
    
    if ( isdefined( core_trigger ) )
    {
        core_trigger notify( #"hash_73537c07898a047a" );
    }
    
    if ( isdefined( level.scorpio_skel.entrance_interact ) )
    {
        level.scorpio_skel.entrance_interact delete();
    }
    
    if ( isdefined( level.scorpio_skel.exit_interact ) )
    {
        level.scorpio_skel.exit_interact delete();
    }
    
    plates = getentitylessscriptablearray( "ob_scorpio_interior_plate", #script_noteworthy );
    
    foreach ( plate in plates )
    {
        plate setscriptablepartstate( "charge", "inactive" );
        plate setscriptablepartstate( "active", "off" );
        plate.trigger notify( #"hash_73537c07898a047a" );
        
        foreach ( weakpoint in plate.weakpoints )
        {
            weakpoint setscriptablepartstate( "model", "inactive" );
            weakpoint setscriptablepartstate( "health", "inactive" );
        }
        
        if ( plate.var_4011c55b1271a240 )
        {
            foreach ( spark in plate.var_4011c55b1271a240 )
            {
                spark delete();
            }
        }
    }
    
    level thread function_27b017187254ce74( 0 );
    
    if ( level.var_8917de2e90988249 )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( level.var_8917de2e90988249.a_obj_id[ 0 ] );
    }
    
    if ( level.scorpio_headlaunch_obj_id )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ] );
    }
    
    if ( level.var_cea3d20fc4af331f )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( level.var_cea3d20fc4af331f.a_obj_id[ 0 ] );
    }
    
    if ( level.scorpio_obj_id )
    {
        objidpoolmanager::objective_playermask_hidefromallplayers( level.scorpio_obj_id.a_obj_id[ 0 ] );
    }
    
    shatter_scriptables = getentitylessscriptablearray( "scorpio_interior_plate_vfx", #targetname );
    
    foreach ( scriptable in shatter_scriptables )
    {
        scriptable setscriptablepartstate( "vfx", "off" );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x68412a9b, Offset: 0x2724
// Size: 0x85
function function_db2faa3c20d823c6()
{
    activity_instance = self;
    
    if ( !isdefined( level.scorpio_skel.immersion_ent ) )
    {
        immersion_center = utility::getstruct( "scorpio_interior_immersion_center", "targetname" );
        immersion_ent = spawn( "script_model", immersion_center.origin );
        level.scorpio_skel.immersion_ent = immersion_ent;
    }
    
    level thread function_a448e807f05ebd96();
    level thread function_4be57114385d897();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x8df86470, Offset: 0x27b1
// Size: 0x10a
function function_4be57114385d897()
{
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    immersion_center = utility::getstruct( "scorpio_interior_immersion_center", "targetname" );
    
    if ( !isdefined( immersion_center ) )
    {
        return;
    }
    
    while ( true )
    {
        level.scorpio_skel waittill( #"scorpio_foot_down" );
        earthquake( 0.25, 1, immersion_center.origin, 2000 );
        
        foreach ( player in level.scorpio_participants )
        {
            player playsoundtoplayer( "evt_scorpio_int_fs_impact_2d", player );
        }
        
        wait 2;
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x43196185, Offset: 0x28c3
// Size: 0x24b
function function_a448e807f05ebd96()
{
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    level endon( #"scorpio_deleted" );
    base_duration = 5;
    base_yaw = 0.85;
    base_pitch = 0.85;
    base_roll = 2.5;
    
    while ( isdefined( level.scorpio_skel.immersion_ent ) )
    {
        duration = randomfloatrange( base_duration - 1, base_duration + 1 );
        yaw = randomfloatrange( base_yaw - 0.5, base_yaw + 0.5 );
        pitch = randomfloatrange( base_pitch - 0.5, base_pitch + 0.5 );
        roll = randomfloatrange( base_roll - 1, base_roll + 1 );
        
        if ( level.scorpio_skel.immersion_ent )
        {
            level.scorpio_skel.immersion_ent rotateto( ( yaw, pitch, roll ), duration, 0.05, 0.05 );
        }
        
        wait duration;
        duration = randomfloatrange( base_duration - 1, base_duration + 1 );
        
        if ( level.scorpio_skel.immersion_ent )
        {
            level.scorpio_skel.immersion_ent rotateto( ( 0, 0, 0 ), duration, 0.05, 0.05 );
        }
        
        wait duration;
        duration = randomfloatrange( base_duration - 1, base_duration + 1 );
        yaw = randomfloatrange( base_yaw * -1 - 0.5, base_yaw + 0.5 );
        pitch = randomfloatrange( base_pitch * -1 - 0.5, base_pitch + 0.5 );
        roll = randomfloatrange( base_roll * -1 - 1, base_roll + 1 );
        
        if ( level.scorpio_skel.immersion_ent )
        {
            level.scorpio_skel.immersion_ent rotateto( ( yaw, pitch, roll ), duration, 0.05, 0.05 );
        }
        
        wait duration;
    }
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0xd4e9a381, Offset: 0x2b16
    // Size: 0x5, Type: dev
    function function_aa8939c6038eb429()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 11
// Checksum 0x37f584df, Offset: 0x2b23
// Size: 0x3e0
function core_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_ob_scorpio_interior_core" )
    {
        return;
    }
    
    core = instance;
    state = core getscriptablepartstate( "base" );
    
    if ( state == "destroyed" )
    {
        return;
    }
    
    if ( level.scorpio_skel.health_struct.immune )
    {
        return;
    }
    
    damage = min( idamage, core.max_damage_taken );
    core.var_ab8007f32d8a3abe -= damage;
    result = 0;
    
    switch ( core.phase )
    {
        case 1:
            core.var_ab8007f32d8a3abe = max( core.var_ab8007f32d8a3abe, core.var_1d03cd3f2037ebbb );
            result = function_128911d56e972cee( core.var_ab8007f32d8a3abe, core.var_1d03cd3f2037ebbb );
            break;
        case 2:
            core.var_ab8007f32d8a3abe = max( core.var_ab8007f32d8a3abe, 0 );
            result = function_128911d56e972cee( core.var_ab8007f32d8a3abe, 0 );
            break;
        default:
            break;
    }
    
    level.scorpio_skel.health_struct.health = core.var_ab8007f32d8a3abe;
    update_healthbar();
    health_percentage = core.var_ab8007f32d8a3abe / core.max_health * 100;
    var_4168e1b0a662402e = clamp( health_percentage, 0, 100 );
    var_4168e1b0a662402e = int( var_4168e1b0a662402e );
    eattacker damagefeedback::updatehitmarker( "standard", var_4168e1b0a662402e == 0, 0, 1 );
    eattacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
    
    if ( result )
    {
        /#
            iprintlnbold( "<dev string:x50>" );
        #/
        
        switch ( core.phase )
        {
            case 1:
                core_shield = getentitylessscriptablearray( "scorpio_interior_core_shield", #script_noteworthy )[ 0 ];
                
                if ( core_shield )
                {
                    core_shield setscriptablepartstate( "model", "visible" );
                    core_shield setscriptablepartstate( "health", "damageable" );
                }
                
                level.scorpio_skel.health_struct.immune = 1;
                update_healthbar();
                break;
            case 2:
                core setscriptablepartstate( "health", "inactive" );
                core setscriptablepartstate( "base", "destroyed" );
                
                foreach ( player in level.players )
                {
                    function_558553ee01c73219( player );
                }
                
                level.scorpio_skel.health_struct = undefined;
                break;
            default:
                break;
        }
        
        core.activity_instance notify( #"damage_threshold_hit" );
    }
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x57155c59, Offset: 0x2f0b
// Size: 0x20, Type: bool
function function_128911d56e972cee( var_ab8007f32d8a3abe, var_d648d1dbc51f0b0f )
{
    if ( var_ab8007f32d8a3abe <= var_d648d1dbc51f0b0f )
    {
        return true;
    }
    
    return false;
}

// Namespace scorpio_interior
// Params 3
// Checksum 0xc4005b04, Offset: 0x2f34
// Size: 0x8a
function core_vulnerable( core, shield, phase )
{
    core setscriptablepartstate( "health", "damageable" );
    
    if ( shield )
    {
        shield setscriptablepartstate( "model", "hidden" );
        shield setscriptablepartstate( "health", "inactive" );
    }
    
    level.scorpio_skel.health_struct.immune = 0;
    update_healthbar();
    core.phase = phase;
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x1f118e09, Offset: 0x2fc6
// Size: 0x115
function function_63748e5900836444( shield )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        shield_state = shield getscriptablepartstate( "model" );
        
        if ( shield_state == "visible" )
        {
            players = getplayersinradius( shield.origin, 260 );
            
            foreach ( player in players )
            {
                v_direction = vectornormalize( player.origin - shield.origin );
                player knockback( v_direction, 150, 1 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x32ca08cb, Offset: 0x30e3
// Size: 0x87
function setup_healthbar()
{
    level endon( #"scorpio_deleted" );
    activity_instance = self;
    health_struct = spawnstruct();
    health_struct.maxhealth = getdvarint( @"hash_8481e540c5ff606a", 40000 );
    health_struct.health = health_struct.maxhealth;
    health_struct.immune = 1;
    level.scorpio_skel.health_struct = health_struct;
    update_healthbar();
}

// Namespace scorpio_interior
// Params 0, eflags: 0x4
// Checksum 0x686c9f75, Offset: 0x3172
// Size: 0x21
function private function_b2a8b897e2cc0f2b()
{
    if ( !self.var_20b2af94667695c9 )
    {
        thread function_20b2af94667695c9();
        self.var_20b2af94667695c9 = 1;
    }
}

// Namespace scorpio_interior
// Params 0, eflags: 0x4
// Checksum 0xe0548f0c, Offset: 0x319b
// Size: 0x24
function private function_fdf83b6eecbebed3()
{
    if ( self.var_20b2af94667695c9 )
    {
        self notify( #"hash_383b3ef37079d78" );
        self.var_20b2af94667695c9 = 0;
    }
}

// Namespace scorpio_interior
// Params 0, eflags: 0xc
// Checksum 0xd50fbb56, Offset: 0x31c7
// Size: 0x5d
function private function_20b2af94667695c9()
{
    self notify( #"hash_7f6d6d2249892fea" );
    self endon( #"hash_7f6d6d2249892fea" );
    self endon( #"disconnect" );
    self endon( #"hash_383b3ef37079d78" );
    
    while ( true )
    {
        self waittill( #"boss_healthbar_removed" );
        
        if ( !isdefined( self.var_71c37977095602df ) )
        {
            thread function_a3efcbd47b8ad257( self );
        }
    }
}

// Namespace scorpio_interior
// Params 1, eflags: 0x4
// Checksum 0x13ec1249, Offset: 0x322c
// Size: 0x32
function private function_558553ee01c73219( player )
{
    if ( player.var_71c37977095602df == "ob_boss_scorpio" )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    player function_fdf83b6eecbebed3();
}

// Namespace scorpio_interior
// Params 1, eflags: 0x4
// Checksum 0x8b8bbe72, Offset: 0x3266
// Size: 0x180
function private function_a3efcbd47b8ad257( player )
{
    if ( !level.scorpio_skel.health_struct )
    {
        return;
    }
    
    player function_b2a8b897e2cc0f2b();
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_scorpio", level.scorpio_skel.health_struct );
        }
        else if ( player.var_71c37977095602df == "ob_boss_scorpio" )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        else if ( player ob_story_mission_utils::function_6ec505041dcea08e( level.scorpio_skel.health_struct ) )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_scorpio", level.scorpio_skel.health_struct );
        }
    }
    else if ( player ob_story_mission_utils::function_6ec505041dcea08e( level.scorpio_skel.health_struct ) )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_scorpio", level.scorpio_skel.health_struct );
    }
    
    if ( player.var_71c37977095602df == "ob_boss_scorpio" )
    {
        if ( level.scorpio_skel.health_struct.immune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        else
        {
            player thread ob_story_mission_utils::player_boss_healthbar_show();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xa8571875, Offset: 0x33ee
// Size: 0x7b
function update_healthbar()
{
    foreach ( player in level.players )
    {
        thread function_a3efcbd47b8ad257( player );
    }
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x1610ebe5, Offset: 0x3471
// Size: 0x3c
function healthbar_on_player_connect( params )
{
    self endon( #"death_or_disconnect" );
    player = self;
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    function_a3efcbd47b8ad257( player );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xc799cdfc, Offset: 0x34b5
// Size: 0x1e
function on_player_spawned( params )
{
    function_5dc70d31d3e21631( params );
    healthbar_on_player_spawned( params );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xf6f0046, Offset: 0x34db
// Size: 0x22
function healthbar_on_player_spawned( params )
{
    player = self;
    function_a3efcbd47b8ad257( player );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x1592d2c9, Offset: 0x3505
// Size: 0x72
function function_5dc70d31d3e21631( params )
{
    if ( !params.revivespawn )
    {
        return;
    }
    
    player = self;
    
    if ( isdefined( level.scorpio_participants ) )
    {
        playerparticipating = arraycontains( level.scorpio_participants, player );
        
        if ( playerparticipating )
        {
            player.is_in_head = undefined;
            function_9fbddfbbf295038d( player );
        }
    }
    
    player function_80711b016dda727e( 0 );
}

// Namespace scorpio_interior
// Params 0, eflags: 0x4
// Checksum 0xe723ff1f, Offset: 0x357f
// Size: 0x7a
function private function_4eb8ea61d6f4a1b4()
{
    if ( isdefined( level.scorpio_skel ) )
    {
        origin = level.scorpio_skel gettagorigin( "tag_portal" );
        angles = level.scorpio_skel.angles;
    }
    else
    {
        origin = level.var_6b79638bcf01eb70;
        angles = level.var_30d5ba4b6db4ded;
    }
    
    return { #angles:angles, #origin:origin };
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0xb41f1b40, Offset: 0x3602
    // Size: 0x5, Type: dev
    function function_da3aa9bbb93a5dda()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 6
// Checksum 0x9643adb5, Offset: 0x360f
// Size: 0x76
function function_8328c423f0a253e3( plate, complete_notify, defender_structs, encounter_tag, var_da31a658ccca3196, weakpoint_time )
{
    activity_instance = self;
    activity_instance function_d3b7a69bd206f771( plate, var_da31a658ccca3196 );
    activity_instance thread spawn_juggerbot( plate, complete_notify, undefined, weakpoint_time );
    activity_instance thread function_16e25cf5a8130a2b( "ai_encounter:sat_ob_scorpio_interior_defenders", defender_structs, 500, encounter_tag );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xa5da990b, Offset: 0x368d
// Size: 0x138
function function_d3b7a69bd206f771( plate, var_da31a658ccca3196 )
{
    activity_instance = self;
    scriptables = [];
    initial_shatter = spawnscriptable( "sat_ob_scorpio_cradle_shatter", plate.origin + ( 0, 0, 50 ), plate.angles );
    initial_shatter setscriptablepartstate( "vfx", "vfx_cancer_cradle_shatter_05" );
    wait 1;
    scriptables = getentitylessscriptablearray( var_da31a658ccca3196, #script_noteworthy );
    delay = 0.75;
    
    foreach ( scriptable in scriptables )
    {
        scriptable setscriptablepartstate( "vfx", "vfx_cancer_cradle_shatter_05" );
        wait delay;
        delay -= 0.15;
        delay = max( 0.25, delay );
    }
    
    activity_instance thread cleanup_cradle_shatter( initial_shatter, scriptables );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x7b846c9b, Offset: 0x37cd
// Size: 0x9c
function cleanup_cradle_shatter( initial_shatter, scriptables )
{
    wait 3;
    initial_shatter freescriptable();
    
    foreach ( scriptable in scriptables )
    {
        scriptable setscriptablepartstate( "vfx", "off" );
    }
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x36dcf2d8, Offset: 0x3871
// Size: 0x25e
function init_plates( script_noteworthy, activity_instance )
{
    plates = getentitylessscriptablearray( script_noteworthy, #script_noteworthy );
    
    foreach ( plate in plates )
    {
        plate.trigger = getent( plate.targetname + "_trigger", #targetname );
        trigger::makeenterexittrigger( plate.trigger, &plate_on_player_enter, &plate_on_player_exit, undefined, undefined );
        goal_volume = getnoentvolumearray( plate.targetname + "_goal", #script_noteworthy )[ 0 ];
        plate.goal_volume = goal_volume;
        linked_structs = utility::getstructarray( plate.target, "targetname" );
        plate.linked_structs = linked_structs;
        plate thread function_5e4ee03db5c689be();
        weakpoints = getentitylessscriptablearray( plate.targetname + "_weakpoint", #script_noteworthy );
        
        foreach ( weakpoint in weakpoints )
        {
            weakpoint.plate = plate;
        }
        
        plate.weakpoints = weakpoints;
        plate.trigger.containsplayer = 0;
        plate.trigger.var_b8018d01fccc3ef4 = 0;
        plate.activity_instance = activity_instance;
        plate.should_spawn = 0;
        plate.should_shutdown = 0;
        activity_instance thread function_e823decaef9241ff( plate, 3000 );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x5146b17d, Offset: 0x3ad7
// Size: 0xfa
function function_5e4ee03db5c689be()
{
    plate = self;
    
    foreach ( struct in plate.linked_structs )
    {
        for ( current_struct = struct; isdefined( current_struct.target ) ; current_struct = var_e67d2b409143afde[ 0 ] )
        {
            var_e67d2b409143afde = utility::getstructarray( current_struct.target, "targetname" );
            
            if ( isdefined( var_e67d2b409143afde ) )
            {
                if ( var_e67d2b409143afde.size > 1 )
                {
                    var_e67d2b409143afde = arrayrandomize( var_e67d2b409143afde );
                    current_struct.script_noteworthy = var_e67d2b409143afde[ 0 ].script_noteworthy;
                    current_struct = var_e67d2b409143afde[ 0 ];
                    continue;
                }
            }
        }
    }
}

// Namespace scorpio_interior
// Params 5
// Checksum 0xbb95fa43, Offset: 0x3bd9
// Size: 0xd6
function activate_plate( plate, complete_notify, plate_capture_time = 5, max_weakpoints, weakpoint_time = 15 )
{
    activity_instance = self;
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    plate setscriptablepartstate( "active", "on" );
    plate thread function_b490aa9e11d1e16f( plate_capture_time );
    plate waittill( #"plate_charged" );
    plate setscriptablepartstate( "active", "off" );
    plate setscriptablepartstate( "charge", "charged" );
    plate function_45436d2719d9cf4d( complete_notify, plate_capture_time, max_weakpoints, weakpoint_time );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x6b0c844f, Offset: 0x3cb7
// Size: 0xcc
function function_b490aa9e11d1e16f( capture_max_time )
{
    self notify( #"hash_dc894bbd9c6e0f06" );
    self endon( #"hash_dc894bbd9c6e0f06" );
    plate = self;
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    capture_progress = 0;
    
    while ( capture_progress < capture_max_time )
    {
        capture_rate = function_cd502004e04887bb( plate.trigger.var_b8018d01fccc3ef4, plate );
        capture_progress += capture_rate;
        capture_progress = max( capture_progress, 0 );
        
        /#
        #/
        
        if ( capture_progress >= capture_max_time )
        {
            break;
        }
        
        wait 1;
    }
    
    plate notify( #"plate_charged" );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xf1ee6593, Offset: 0x3d8b
// Size: 0xc1
function function_a250790f8666248b( plate )
{
    result = 0;
    
    foreach ( ent in plate.trigger.triggerenterents )
    {
        if ( isplayer( ent ) && ent player::isreallyalive() && !ent.inlaststand )
        {
            result = 1;
            break;
        }
    }
    
    return result;
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xe3b494ae, Offset: 0x3e55
// Size: 0xb9
function function_cd502004e04887bb( num_players_in_trigger, plate )
{
    result = function_a250790f8666248b( plate );
    
    if ( result )
    {
        num_players_in_trigger = int( min( num_players_in_trigger, 1 ) );
        
        switch ( num_players_in_trigger )
        {
            case 1:
                capture_rate = 1;
                plate setscriptablepartstate( "charge", "charging" );
                break;
            default:
                capture_rate = -0.5;
                plate setscriptablepartstate( "charge", "inactive" );
                break;
        }
    }
    else
    {
        capture_rate = -0.5;
        plate setscriptablepartstate( "charge", "inactive" );
    }
    
    return capture_rate;
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xf70f61de, Offset: 0x3f17
// Size: 0x46
function plate_on_player_enter( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        trigger.var_b8018d01fccc3ef4 += 1;
        trigger.containsplayer = 1;
    }
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x41725bc6, Offset: 0x3f65
// Size: 0x74
function plate_on_player_exit( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        assert( trigger.var_b8018d01fccc3ef4 > 0, "<dev string:x6b>" );
        trigger.var_b8018d01fccc3ef4 = maxint( trigger.var_b8018d01fccc3ef4 - 1, 0 );
        
        if ( trigger.var_b8018d01fccc3ef4 == 0 )
        {
            trigger.containsplayer = 0;
        }
    }
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xd0083d64, Offset: 0x3fe1
// Size: 0xbe
function function_45436d2719d9cf4d( complete_notify, plate_capture_time, max_weakpoints, weakpoint_time )
{
    plate = self;
    var_41307f4ffadbf90b = plate.linked_structs;
    var_41307f4ffadbf90b = arrayrandomize( var_41307f4ffadbf90b );
    
    if ( isdefined( max_weakpoints ) )
    {
        var_c2393e3b33e99c0 = int( min( max_weakpoints, var_41307f4ffadbf90b.size ) );
    }
    else
    {
        var_c2393e3b33e99c0 = var_41307f4ffadbf90b.size;
    }
    
    for ( i = 0; i < var_c2393e3b33e99c0 ; i++ )
    {
        plate thread function_53a6f43f8bcadc31( var_41307f4ffadbf90b[ i ], weakpoint_time );
    }
    
    plate thread function_2abab3fd4517f100( var_c2393e3b33e99c0 );
    plate thread function_7d4551078fe6557d( complete_notify );
    plate thread function_e4e824d68123cdf0( complete_notify, plate_capture_time, max_weakpoints, weakpoint_time );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x86134243, Offset: 0x40a7
// Size: 0x274
function function_53a6f43f8bcadc31( start_struct, weakpoint_time )
{
    plate = self;
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    spark = utility::spawn_model( "tag_origin", start_struct.origin, ( 0, 0, 0 ) );
    
    if ( !isdefined( plate.var_4011c55b1271a240 ) )
    {
        plate.var_4011c55b1271a240 = [];
    }
    
    plate.var_4011c55b1271a240[ plate.var_4011c55b1271a240.size ] = spark;
    waitframe();
    playfxontag( level._effect[ "energy_ball_plasma" ], spark, "tag_origin" );
    
    for ( current_target = start_struct; isdefined( current_target.target ) ; current_target = next_target )
    {
        next_targets = utility::getstructarray( current_target.target, "targetname" );
        
        if ( next_targets.size > 1 )
        {
            foreach ( target in next_targets )
            {
                if ( current_target.script_noteworthy == target.script_noteworthy )
                {
                    next_target = target;
                }
            }
        }
        else
        {
            next_target = next_targets[ 0 ];
        }
        
        if ( !isdefined( next_target ) )
        {
            next_target = getentitylessscriptablearray( current_target.target, #targetname )[ 0 ];
            
            if ( !isdefined( next_target ) )
            {
                assertmsg( "<dev string:xba>" );
            }
        }
        
        distance = distancesquared( current_target.origin, next_target.origin );
        move_speed = mapfloat( 0, 360000, 0.25, 0.85, distance );
        spark moveto( next_target.origin, move_speed );
        wait move_speed;
    }
    
    wait 0.1;
    plate.var_4011c55b1271a240 = arrayremove( plate.var_4011c55b1271a240, spark );
    spark delete();
    activate_weakpoint( current_target, plate, weakpoint_time );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xa9ceb74d, Offset: 0x4323
// Size: 0xb0
function function_7d4551078fe6557d( complete_notify )
{
    self notify( #"hash_2497be88cf6c382f" );
    self endon( #"hash_2497be88cf6c382f" );
    plate = self;
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    plate endon( #"weakpoint_failed" );
    plate waittill( #"hash_1e64bd0a10512d86" );
    plate.activity_instance notify( complete_notify );
    plate.activity_instance thread function_f4a2165e67098089( plate.origin, 100, plate.targetname );
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xeeb2944c, Offset: 0x43db
// Size: 0x13d
function function_e4e824d68123cdf0( complete_notify, plate_capture_time, max_weakpoints, weakpoint_time )
{
    self notify( #"hash_467bd980b44d270d" );
    self endon( #"hash_467bd980b44d270d" );
    plate = self;
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    plate endon( #"hash_1e64bd0a10512d86" );
    plate waittill( #"weakpoint_failed" );
    
    foreach ( weakpoint in plate.weakpoints )
    {
        weakpoint setscriptablepartstate( "model", "inactive" );
        weakpoint setscriptablepartstate( "health", "inactive" );
    }
    
    plate.should_spawn = 1;
    activate_plate( plate, complete_notify, plate_capture_time, max_weakpoints, weakpoint_time );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xaa4cfdb2, Offset: 0x4520
// Size: 0x81
function function_2abab3fd4517f100( var_c2393e3b33e99c0 )
{
    plate = self;
    plate endon( #"weakpoint_failed" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    
    for ( num_destroyed = 0; num_destroyed < var_c2393e3b33e99c0 ; num_destroyed++ )
    {
        plate waittill( #"weakpoint_destroyed" );
    }
    
    plate notify( #"hash_1e64bd0a10512d86" );
}

// Namespace scorpio_interior
// Params 3
// Checksum 0x7696ec03, Offset: 0x45a9
// Size: 0x10d
function activate_weakpoint( weakpoint, plate, time )
{
    plate endon( #"weakpoint_failed" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    
    /#
        debug_draw( weakpoint, "<dev string:x101>", 10, ( 0, 1, 0 ), time );
    #/
    
    weakpoint.var_ab8007f32d8a3abe = 100;
    weakpoint.destroyed = 0;
    weakpoint setscriptablepartstate( "model", "active" );
    weakpoint setscriptablepartstate( "health", "damageable" );
    wait time;
    
    if ( weakpoint getscriptablepartstate( "health" ) == "damageable" || weakpoint getscriptablepartstate( "health" ) == "damaged" )
    {
        plate notify( #"weakpoint_failed" );
        weakpoint setscriptablepartstate( "model", "inactive" );
        weakpoint setscriptablepartstate( "health", "inactive" );
    }
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xd15bf566, Offset: 0x46be
// Size: 0x6f
function weakpoint_destroyed_callback( scriptable, notif, params, var_64ffacba090c91be )
{
    if ( scriptable.type != "sat_ob_scorpio_interior_weakpoint" )
    {
        return;
    }
    
    if ( !scriptable.destroyed )
    {
        scriptable.destroyed = 1;
        scriptable.plate notify( #"weakpoint_destroyed" );
    }
}

// Namespace scorpio_interior
// Params 11
// Checksum 0x4974119d, Offset: 0x4735
// Size: 0x12f
function weakpoint_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_ob_scorpio_interior_weakpoint" )
    {
        return;
    }
    
    weakpoint = instance;
    state = weakpoint getscriptablepartstate( "health" );
    
    if ( state == "destroyed" )
    {
        return;
    }
    
    if ( weakpoint.destroyed )
    {
        return;
    }
    
    weakpoint.var_ab8007f32d8a3abe -= idamage;
    eattacker damagefeedback::updatehitmarker( "standard", weakpoint.var_ab8007f32d8a3abe <= 0, 0, 1 );
    eattacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
    
    if ( weakpoint.var_ab8007f32d8a3abe <= 0 )
    {
        weakpoint setscriptablepartstate( "health", "destroyed" );
    }
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x1d101db9, Offset: 0x486c
    // Size: 0x5, Type: dev
    function function_5aca1b69c9fe65e()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 2
// Checksum 0x6ef83ccc, Offset: 0x4879
// Size: 0x50
function function_713cc4802f7d18ec( ent, trigger )
{
    if ( isplayer( ent ) && arraycontains( level.scorpio_participants, ent ) )
    {
        activity_instance_common::function_46135a69bddfec2c( trigger.activity_instance );
        trigger notify( #"hash_73537c07898a047a" );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x678be821, Offset: 0x48d1
// Size: 0x149
function setup_interior_interacts()
{
    activity_instance = self;
    entrance_point = level.scorpio_skel gettagorigin( "tag_portal" );
    exit_struct = utility::getstruct( "test_scorpio_interior_exit", "targetname" );
    entrance_interact = interaction::register_interact( entrance_point, 64, &on_interior_interact );
    entrance_interact interaction::set_interact_hint_callback( &entrance_hint_callback );
    entrance_interact.script_noteworthy = "entrance";
    entrance_interact.var_a1e68c33991c906f = exit_struct;
    entrance_interact.activity_instance = activity_instance;
    level.scorpio_skel.entrance_interact = entrance_interact;
    setup_interact_settings( entrance_interact, 80, 160, 160 );
    exit_interact = interaction::register_interact( exit_struct.origin, 64, &on_interior_interact, &"sat_ob_activities/scorpio_interior_exit" );
    exit_interact.script_noteworthy = exit_struct.script_noteworthy;
    exit_interact.var_a1e68c33991c906f = entrance_point;
    exit_interact.activity_instance = activity_instance;
    setup_interact_settings( exit_interact, 80, 200, 200 );
    level.scorpio_skel.exit_interact = exit_interact;
    level thread function_79b1020c825084c1();
}

// Namespace scorpio_interior
// Params 4
// Checksum 0x3f512a1c, Offset: 0x4a22
// Size: 0x8b
function setup_interact_settings( interact, var_3b36db39e36618bb = 64, var_d278ce2df1e58bf9 = 120, hint_display_range = 128 )
{
    interact setusableenabled( 1 );
    interact setusepriority( 0 );
    interact sethintdisplayrange( hint_display_range );
    interact setusefov( var_d278ce2df1e58bf9 );
    interact sethintdisplayfov( var_d278ce2df1e58bf9 );
    interact setcursorhint( "HINT_BUTTON" );
    interact setuseholdduration( "duration_short" );
    interact setuserange( var_3b36db39e36618bb );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xee2cf8a1, Offset: 0x4ab5
// Size: 0x72
function on_interior_interact( player )
{
    interact = self;
    
    switch ( interact.script_noteworthy )
    {
        case #"hash_5be0e07fd816af73":
            function_f9500965257e57b( player );
            break;
        case #"hash_cf84b0041cf92be5":
            function_9fbddfbbf295038d( player );
            break;
    }
    
    teleport_player( player, interact.script_noteworthy, interact );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xd58422f0, Offset: 0x4b2f
// Size: 0x5b
function function_79b1020c825084c1()
{
    while ( isdefined( level.scorpio_skel.entrance_interact ) )
    {
        entrance_origin = level.scorpio_skel gettagorigin( "tag_portal" );
        level.scorpio_skel.entrance_interact.origin = entrance_origin;
        waitframe();
    }
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x4c0113f0, Offset: 0x4b92
// Size: 0x8d
function entrance_hint_callback( interact, player )
{
    if ( level.scorpio_participants && level.scorpio_participants.size >= 12 )
    {
        return { #var_26bbd300351fde34:0, #string:&"sat_ob_activities/scorpio_interior_locked", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"sat_ob_activities/scorpio_interior_enter", #type:"HINT_BUTTON" };
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x55788ea9, Offset: 0x4c27
// Size: 0x99
function function_f9500965257e57b( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( level.scorpio_interior_activity ) )
    {
        activity_participation::function_bc67362dace4370c( level.scorpio_interior_activity, player );
    }
    
    if ( isdefined( level.scorpio_participants ) && !arraycontains( level.scorpio_participants, player ) )
    {
        level.scorpio_participants = arraycombineunique( level.scorpio_participants, [ player ] );
    }
    
    player function_80711b016dda727e( 1 );
    player.var_333c3fe63fb6f429 = &function_4eb8ea61d6f4a1b4;
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x79792a11, Offset: 0x4cc8
// Size: 0xb4
function function_9fbddfbbf295038d( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_hide_minimap", 0 );
    
    if ( isdefined( player.is_in_head ) )
    {
        return;
    }
    
    if ( isdefined( level.scorpio_participants ) && arraycontains( level.scorpio_participants, player ) )
    {
        level.scorpio_participants = arrayremove( level.scorpio_participants, player );
    }
    
    if ( isdefined( level.scorpio_interior_activity ) )
    {
        activity_participation::function_61aa2b2879f2c0a2( level.scorpio_interior_activity, player, 1 );
    }
    
    if ( isalive( player ) )
    {
        player function_80711b016dda727e( 0 );
    }
    
    player.var_333c3fe63fb6f429 = undefined;
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xb76f9379, Offset: 0x4d84
// Size: 0x45
function function_80711b016dda727e( value )
{
    if ( value )
    {
        self.game_extrainfo |= 268435456;
        return;
    }
    
    self.game_extrainfo &= ~268435456;
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x4e81dd9d, Offset: 0x4dd1
// Size: 0x7e
function function_cb8c3987330df7ba( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        ent.is_in_head = 1;
        
        if ( !isdefined( ent.s_exfil ) )
        {
            ent.s_exfil = {};
            ent.s_exfil.origin = trigger.origin;
        }
        
        teleport_player( ent, "head", undefined, "scorpio_interior_head_teleport_exit" );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x72d517dd, Offset: 0x4e57
// Size: 0x15d
function function_9187e77917fd1bb0()
{
    level endon( #"game_ended" );
    level.scorpio_skel endon( #"scorpio_headlaunch_complete" );
    level.scorpio_skel endon( #"scorpio_interior_fail" );
    destination_struct = utility::getstruct( "test_scorpio_interior_exit", "targetname" );
    destination_struct = utility::getstruct( destination_struct.target, "targetname" );
    destination_origin = destination_struct.origin;
    
    while ( true )
    {
        var_b4d7f7d1581a2d7e = getplayersinradius( level.scorpio_skel.origin, 2048, 1700 );
        var_9020cac9def4d93e = getplayersinradius( level.scorpio_skel gettagorigin( "tag_portal" ), 2048, 1700, 0 );
        players = arraycombine( var_b4d7f7d1581a2d7e, var_9020cac9def4d93e );
        
        foreach ( player in players )
        {
            player streamhint::playerstreamhintlocation( destination_origin );
        }
        
        wait 0.3;
    }
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xafcb280c, Offset: 0x4fbc
// Size: 0x92d
function teleport_player( player, direction, interact, destination_target_name )
{
    player endon( #"disconnect" );
    player notify( #"skydive_end" );
    player cancelmantle();
    player dropoffascender();
    player cancelgrapple();
    player skydive_interrupt();
    player function_64f1800c957cf63c();
    player coop::set_player_frozen_vars( 1, "scorpio_interior_teleport" );
    waitframe();
    player dontinterpolate();
    player function_a4a572d8d09b0f46();
    player setvelocity( ( 0, 0, 0 ) );
    player setstance( "stand", 1, 1 );
    player cleardamageindicators();
    player utility::callsharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0" );
    
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
    
    player.screen_overlay fadeovertime( 0.5 );
    player.screen_overlay.alpha = 1;
    wait 0.7;
    
    switch ( direction )
    {
        case #"hash_5be0e07fd816af73":
            destination_struct = utility::getstruct( interact.var_a1e68c33991c906f.target, "targetname" );
            destination_origin = destination_struct function_5ab742fe8ba45b97();
            destination_angles = destination_struct.angles;
            break;
        case #"hash_cf84b0041cf92be5":
            var_457dec5d1f96dac7 = level.scorpio_skel gettagorigin( "tag_portal" );
            exit_forward = anglestoforward( level.scorpio_skel.angles );
            destination_origin = var_457dec5d1f96dac7 + exit_forward * -700;
            destination_angles = level.scorpio_skel.angles * -1;
            break;
        case #"hash_c5eb1d6c938c1863":
            player coop::function_eb6e09941acb48e9();
            var_457dec5d1f96dac7 = level.scorpio_skel gettagorigin( "tag_portal" );
            exit_point_rand = utility::getrandompointincircle( var_457dec5d1f96dac7 + ( 0, 0, 700 ), 64 );
            exit_forward = anglestoforward( level.scorpio_skel.angles );
            destination_origin = exit_point_rand + exit_forward * -700;
            destination_angles = level.scorpio_skel.angles;
            break;
        case #"hash_b107b5547c755d23":
            destination_struct = utility::getstruct( destination_target_name, "targetname" );
            destination_origin = destination_struct.origin;
            destination_angles = destination_struct.angles;
            break;
    }
    
    if ( player.revivingteammate )
    {
        player.var_3ded14e19d81ef7e = 1;
        waitframe();
    }
    
    if ( player.sessionstate != "spectator" )
    {
        player setorigin( destination_origin + ( 0, 0, 5 ) );
    }
    
    if ( isdefined( destination_angles ) )
    {
        player setplayerangles( destination_angles );
    }
    
    switch ( direction )
    {
        case #"hash_5be0e07fd816af73":
            player playersetgroundreferenceent( level.scorpio_skel.immersion_ent );
            player thread function_b8aaffd90604a998();
            overlord::playevent( "scorpio_enter", [ player ] );
            
            if ( level.var_e1565e5d789e4f77 )
            {
                player thread squad_notification::create( "scorpio_headlaunch_prep_countdown", "scripted_widget_squad_notification_mp_sat_ob_low", level.var_e1565e5d789e4f77, undefined, &"sat_ob_activities/scorpio_headlaunch_prep" );
            }
            
            player setclientomnvar( "ui_hide_minimap", 1 );
            break;
        case #"hash_cf84b0041cf92be5":
            player playersetgroundreferenceent( undefined );
            player val::set( "scorpio_interior_teleport", "allow_movement", 1 );
            player val::set( "scorpio_interior_teleport", "freezecontrols", 0 );
            up = anglestoup( player.angles );
            forward = anglestoforward( level.scorpio_skel.angles );
            player setvelocity( forward * randomfloatrange( -800, -750 ) + up * randomfloatrange( 600, 650 ) );
            player thread function_4ccfe5db46592cce( 1 );
            player thread function_171d33b6ba75f2fc();
            player thread squad_notification::close( "scorpio_headlaunch_prep_countdown" );
            player setclientomnvar( "ui_hide_minimap", 0 );
            break;
        case #"hash_c5eb1d6c938c1863":
            player playersetgroundreferenceent( undefined );
            player val::set( "scorpio_interior_teleport", "allow_movement", 1 );
            player val::set( "scorpio_interior_teleport", "freezecontrols", 0 );
            up = anglestoup( player.angles );
            forward = anglestoforward( level.scorpio_skel.angles );
            player setvelocity( forward * randomfloatrange( -1000, -950 ) + up * randomfloatrange( 400, 450 ) );
            player function_4ccfe5db46592cce( 2 );
            overlord::playevent( "scorpio_activity_fail", [ player ] );
            player setclientomnvar( "ui_hide_minimap", 0 );
            break;
        case #"hash_b107b5547c755d23":
            break;
    }
    
    switch ( direction )
    {
        case #"hash_5be0e07fd816af73":
            if ( level.var_8917de2e90988249 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( level.var_8917de2e90988249.a_obj_id[ 0 ], player );
                thread ob_story_mission_utils::objective_marker_ping( level.var_8917de2e90988249.a_obj_id[ 0 ], [ player ] );
            }
            
            objidpoolmanager::objective_playermask_hidefrom( level.scorpio_obj_id.a_obj_id[ 0 ], player );
            break;
        case #"hash_cf84b0041cf92be5":
            if ( level.var_8917de2e90988249 )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_8917de2e90988249.a_obj_id[ 0 ], player );
            }
            
            if ( level.scorpio_headlaunch_obj_id )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ], player );
            }
            
            if ( level.var_cea3d20fc4af331f )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_cea3d20fc4af331f.a_obj_id[ 0 ], player );
            }
            
            if ( level.scorpio_obj_id )
            {
                objidpoolmanager::objective_playermask_addshowplayer( level.scorpio_obj_id.a_obj_id[ 0 ], player );
            }
            
            break;
        case #"hash_c5eb1d6c938c1863":
            if ( level.var_8917de2e90988249 )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_8917de2e90988249.a_obj_id[ 0 ], player );
            }
            
            if ( level.var_cea3d20fc4af331f )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_cea3d20fc4af331f.a_obj_id[ 0 ], player );
            }
            
            break;
        case #"hash_b107b5547c755d23":
            if ( level.var_8917de2e90988249 )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_8917de2e90988249.a_obj_id[ 0 ], player );
            }
            
            if ( level.var_cea3d20fc4af331f )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.var_cea3d20fc4af331f.a_obj_id[ 0 ], player );
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ], player );
            break;
    }
    
    wait 1;
    
    switch ( direction )
    {
        case #"hash_5be0e07fd816af73":
            wait 3;
            break;
        case #"hash_cf84b0041cf92be5":
            break;
        case #"hash_b107b5547c755d23":
            break;
    }
    
    player.screen_overlay fadeovertime( 0.5 );
    player.screen_overlay.alpha = 0;
    wait 0.5;
    
    if ( isdefined( player.screen_overlay ) )
    {
        player.screen_overlay destroy();
    }
    
    player coop::set_player_frozen_vars( 0, "scorpio_interior_teleport" );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x3fcddd0f, Offset: 0x58f1
// Size: 0xca
function function_5ab742fe8ba45b97()
{
    if ( !isdefined( self.var_b7d8e725ca94bfe7 ) || self.var_b7d8e725ca94bfe7.size == 32 )
    {
        self.var_b7d8e725ca94bfe7 = [];
    }
    
    do
    {
        random_index = randomint( 32 );
        var_2cc7e8755c05277a = arraycontains( self.var_b7d8e725ca94bfe7, random_index );
    }
    while ( var_2cc7e8755c05277a );
    
    self.var_b7d8e725ca94bfe7[ self.var_b7d8e725ca94bfe7.size ] = random_index;
    row = mod( random_index, 8 );
    column = floor( random_index / 8 );
    x_displacement = row * 32;
    y_displacement = column * 32 - 48;
    return self.origin + ( x_displacement * -1, y_displacement, 0 );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xf927ee94, Offset: 0x59c4
// Size: 0x42
function function_b8aaffd90604a998()
{
    self endon( #"death_or_disconnect" );
    prev = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
    wait 3;
    self.attackeraccuracy = prev;
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xdf4e1ad, Offset: 0x5a0e
// Size: 0x3e
function function_4ccfe5db46592cce( time )
{
    self skydive_beginfreefall();
    wait time;
    
    if ( !self.ismutantinjection && !self.isjuggernaut )
    {
        self skydive_setdeploymentstatus( 1 );
    }
    
    self skydive_deployparachute();
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x89ab51d7, Offset: 0x5a54
    // Size: 0x5, Type: dev
    function function_d18922029b43b1d9()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 5
// Checksum 0x13364023, Offset: 0x5a61
// Size: 0xb1
function function_16e25cf5a8130a2b( var_a4c086caa1cbfd68, struct_targetname, radius = 500, encounter_tag, var_310c26e7749060f2 )
{
    if ( isdefined( struct_targetname ) )
    {
        defenders_struct = utility::getstruct( struct_targetname, "targetname" );
        origin = defenders_struct.origin;
    }
    else
    {
        origin = var_310c26e7749060f2;
    }
    
    requestid = activity_ai_encounters::function_eb8506829193f5eb( var_a4c086caa1cbfd68, origin, radius, 1, 0, 1, 0 );
    
    if ( isdefined( encounter_tag ) )
    {
        function_1a9d724a960fa19d( requestid, encounter_tag, 1 );
    }
    
    ai_spawn_director::add_spawned_callback( requestid, &defender_on_spawn );
    return requestid;
}

// Namespace scorpio_interior
// Params 4
// Checksum 0x5d6d9e35, Offset: 0x5b1b
// Size: 0x6e
function defender_on_spawn( requestid, userdata, agent, data )
{
    if ( getdvarint( @"hash_24890fbfc9921ecf", 0 ) )
    {
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    }
    else
    {
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    }
    
    agent.var_6fb8224240879ded = 1;
    agent thread on_spawn_ignore_all();
}

// Namespace scorpio_interior
// Params 4
// Checksum 0xc9f9cb58, Offset: 0x5b91
// Size: 0xc8
function spawn_juggerbot( plate, complete_notify, radius = 10, weakpoint_time )
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_interior_mini_bosses", plate.origin, radius, 1, 0, 1, 0 );
    function_1a9d724a960fa19d( requestid, "juggerbot", 1 );
    function_64ac8c4e752f4dca( requestid, 0 );
    userdata = spawnstruct();
    userdata.plate = plate;
    userdata.complete_notify = complete_notify;
    userdata.weakpoint_time = weakpoint_time;
    userdata.activity_instance = self;
    ai_spawn_director::add_spawned_callback( requestid, &juggerbot_on_spawn, userdata );
}

// Namespace scorpio_interior
// Params 4
// Checksum 0x76204030, Offset: 0x5c61
// Size: 0xe6
function juggerbot_on_spawn( requestid, userdata, agent, data )
{
    if ( getdvarint( @"hash_24890fbfc9921ecf", 0 ) )
    {
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    }
    else
    {
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    }
    
    agent.goalradius = 0;
    agent.var_6fb8224240879ded = 1;
    agent setgoalpos( agent.origin, 0 );
    agent.var_ee914ad666562200 = 1;
    agent.var_e94a0381e288005e = #"activity_scorpio_interior";
    agent thread juggerbot_watch_for_death( userdata.activity_instance, userdata.plate, userdata.complete_notify, userdata.weakpoint_time );
    agent thread on_spawn_ignore_all();
}

// Namespace scorpio_interior
// Params 4
// Checksum 0x2b3a94da, Offset: 0x5d4f
// Size: 0xc0
function juggerbot_watch_for_death( activity_instance, plate, complete_notify, weakpoint_time )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self waittill( #"death" );
    
    /#
        capture_time_override = getdvarint( @"hash_2b0a5fd8739106f3", 0 ) > 0 ? getdvarint( @"hash_2b0a5fd8739106f3", 0 ) : undefined;
        var_714614659284a59 = getdvarint( @"hash_c8828047fca3c2bf", 0 ) > 0 ? getdvarint( @"hash_c8828047fca3c2bf", 0 ) : undefined;
    #/
    
    activity_instance thread activate_plate( plate, complete_notify, capture_time_override, var_714614659284a59, weakpoint_time );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x5b89650c, Offset: 0x5e17
// Size: 0x6e
function function_c57852382dfb190f( var_310c26e7749060f2, var_b7e6d2d89bfacd6 = 3000 )
{
    activity_instance = self;
    requestid = activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_interior_cradle_flood_fill_slow", var_310c26e7749060f2, var_b7e6d2d89bfacd6, 1, 0, 1, 0 );
    ai_spawn_director::add_spawned_callback( requestid, &function_109193043646d91f, var_310c26e7749060f2 );
    ai_spawn_director::function_53289c032f506bb1( requestid, &function_e55f83ff5fb3d46c, activity_instance );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x9b8165, Offset: 0x5e8d
// Size: 0x5f
function function_6800cc05941b805d( var_310c26e7749060f2, var_b7e6d2d89bfacd6 = 3000 )
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_interior_cradle_flood_fill", var_310c26e7749060f2, var_b7e6d2d89bfacd6, 1, 0, 1, 0 );
    ai_spawn_director::add_spawned_callback( requestid, &function_109193043646d91f, var_310c26e7749060f2 );
    ai_spawn_director::function_53289c032f506bb1( requestid, &function_cea8c313da9834c4 );
}

// Namespace scorpio_interior
// Params 4
// Checksum 0x42b4ea9c, Offset: 0x5ef4
// Size: 0x96
function function_109193043646d91f( requestid, var_310c26e7749060f2, agent, data )
{
    agent forcethreatupdate();
    agent function_fa32376aaa88a7a2( var_310c26e7749060f2, 1750 );
    
    if ( getdvarint( @"hash_24890fbfc9921ecf", 0 ) )
    {
        agent ob_story_mission_utils::zombie_set_difficulty( "difficulty5" );
    }
    else
    {
        agent ob_story_mission_utils::zombie_set_difficulty( "difficulty_darkaether" );
    }
    
    agent.var_6fb8224240879ded = 1;
    agent val::set( "scorpio_interior", "allow_unreachable_attack", 0 );
    agent thread on_spawn_ignore_all();
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xaaff527b, Offset: 0x5f92
// Size: 0x27, Type: bool
function function_e55f83ff5fb3d46c( requestid, activity_instance )
{
    if ( activity_instance.var_dc364191fb7909d1 )
    {
        return true;
    }
    
    return false;
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x3c829d41, Offset: 0x5fc2
// Size: 0x16, Type: bool
function function_cea8c313da9834c4( requestid, userdata )
{
    return false;
}

// Namespace scorpio_interior
// Params 3
// Checksum 0x46148e7c, Offset: 0x5fe1
// Size: 0x6a
function function_f4a2165e67098089( var_310c26e7749060f2, var_b7e6d2d89bfacd6 = 100, encounter_tag )
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_interior_mini_bosses", var_310c26e7749060f2, var_b7e6d2d89bfacd6, 1, 0, 1, 0 );
    
    if ( isdefined( encounter_tag ) )
    {
        function_1a9d724a960fa19d( requestid, encounter_tag, 1 );
    }
    
    ai_spawn_director::add_spawned_callback( requestid, &function_109193043646d91f, var_310c26e7749060f2 );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0x8608ea71, Offset: 0x6053
// Size: 0xa7
function function_e823decaef9241ff( plate, radius = 3000 )
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_scorpio_plate_flood_fill", plate.origin, radius, 1, 0, 1, 0 );
    ai_spawn_director::function_c99d360d62c49a9c( requestid, &function_9a25c5792baf887b, plate );
    ai_spawn_director::function_53289c032f506bb1( requestid, &function_7c699759ecc04b8c, plate );
    
    if ( isdefined( plate.targetname ) )
    {
        function_1a9d724a960fa19d( requestid, plate.targetname, 1 );
    }
    
    ai_spawn_director::add_spawned_callback( requestid, &defender_on_spawn, plate.goal_volume );
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xf9777217, Offset: 0x6102
// Size: 0x33
function function_9a25c5792baf887b( requestid, plate )
{
    if ( plate.should_spawn )
    {
        plate.should_spawn = 0;
        return 1;
    }
}

// Namespace scorpio_interior
// Params 2
// Checksum 0xddd286a1, Offset: 0x613d
// Size: 0x26
function function_7c699759ecc04b8c( requestid, plate )
{
    if ( plate.should_shutdown )
    {
        return 1;
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xade96ce8, Offset: 0x616b
// Size: 0x9
function function_67d2590205e336ce()
{
    activity_ai_encounters::function_ef590f5a067bcaf5();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xefb18cc5, Offset: 0x617c
// Size: 0x4b
function on_spawn_ignore_all()
{
    agent = self;
    agent endon( #"death" );
    agent val::set( "scorpio_interior_agent", "ignoreall", 1 );
    wait 1.5;
    agent val::set( "scorpio_interior_agent", "ignoreall", 0 );
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x423861ca, Offset: 0x61cf
    // Size: 0x5, Type: dev
    function function_54b1ff48400175ac()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 2
// Checksum 0x108cc511, Offset: 0x61dc
// Size: 0x19d
function function_2bc277f044e466f0( var_9273225410ea7efc, player_participants )
{
    if ( var_9273225410ea7efc )
    {
        level.scorpio_participants = player_participants;
        utility::flag_set( "scorpio_completed" );
        level thread setup_head_escape();
        level thread function_1c0b9c628c1901c7();
        thread function_67d2590205e336ce();
        
        foreach ( player in level.scorpio_participants )
        {
            player hud_message::showsplash( #"hash_30831df648ddc685" );
        }
        
        return;
    }
    
    level.scorpio_skel notify( #"scorpio_interior_fail" );
    overlord::playevent( "scorpio_activity_fail", level.scorpio_participants );
    hud_util::showsplashtoall( #"sat_ob_scorpio_interior_failure" );
    level thread scorpio_exterior::function_3f2c28196579d5d0();
    
    foreach ( player in player_participants )
    {
        level thread teleport_player( player, "exit" );
    }
    
    wait 2;
    level.scorpio_skel notify( #"hash_18cd2e6280f3513f" );
    scorpio_interior_cleanup();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x75f33f5, Offset: 0x6381
// Size: 0x17c
function function_1c0b9c628c1901c7()
{
    spawn_loc = utility::getstruct( "scorpio_interior_head_loot_spawn", "targetname" );
    
    if ( !spawn_loc )
    {
        spawn_loc = utility::getstruct( "scorpio_interior_head_teleport_exit", "targetname" );
        spawn_loc.origin += ( 100, 0, 0 );
    }
    
    spawnoptions = { #critical:1, #var_18608bd8660b3a19:0, #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #dropradiusscale:1, #var_8d4f327170228364:0, #var_23d3495c57d61bdf:0, #baseangles:spawn_loc.angles, #baseorigin:spawn_loc.origin, #spawnpositionindex:0 };
    exotic_loot = common_item::function_61c2c0251e742ffd( %"hash_44b1a671abff99a8", undefined, spawnoptions );
    wait 0.5;
    legendary_loot = common_item::function_61c2c0251e742ffd( %"hash_2d9fa775d787f4aa", undefined, spawnoptions );
    wait 1;
    level.var_8917de2e90988249 = spawnstruct();
    level.var_8917de2e90988249 ob_story_mission_utils::function_b9cb179f9577f32a( exotic_loot.origin, 16, level.scorpio_participants, "sat_ob_objectivemarker_storymissionmain", 1, 1, 1 );
    wait 1;
    utility::flag_set( "scorpio_exotic_loot_spawned" );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x7b919694, Offset: 0x6505
// Size: 0xbb
function function_4cc83cf20b24eb9f()
{
    core = getentitylessscriptablearray( "scorpio_interior_core", #script_noteworthy )[ 0 ];
    spawnoptions = { #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #core:core, #dropradiusscale:1.2, #baseangles:core.angles, #baseorigin:core.origin - ( 0, 0, 500 ), #spawnpositionindex:0 };
    common_item::function_577fe3f000fcb275( 0.2, 50, %"hash_6140def539ff3c3c", spawnoptions );
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0xf69f806a, Offset: 0x65c8
    // Size: 0x5, Type: dev
    function function_8113a980bd5b4fa3()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 0
// Checksum 0x4574c55a, Offset: 0x65d5
// Size: 0x284
function setup_head_escape()
{
    core = getentitylessscriptablearray( "scorpio_interior_core", #script_noteworthy )[ 0 ];
    core setscriptablepartstate( "health", "inactive" );
    core setscriptablepartstate( "base", "destroyed" );
    pylon_lights = getentarray( "red_pylon_lights", #script_noteworthy );
    
    foreach ( pylon_light in pylon_lights )
    {
        pylon_light setlightintensity( 0 );
    }
    
    shield = getentitylessscriptablearray( "scorpio_interior_core_shield", #script_noteworthy )[ 0 ];
    shield setscriptablepartstate( "model", "hidden" );
    shield setscriptablepartstate( "health", "inactive" );
    core_trigger = getent( "scorpio_interior_portal_head_entrance", #targetname );
    wait 1;
    overlord::playevent( "scorpio_core_destroyed", level.scorpio_participants );
    utility::flag_wait( "scorpio_exotic_loot_spawned" );
    core thread function_593d91288abab644( core_trigger );
    launch_struct = utility::getstruct( "scorpio_interior_head_launch_interact", "targetname" );
    level.scorpio_headlaunch_obj_id = launch_struct;
    level.scorpio_headlaunch_obj_id ob_story_mission_utils::function_b9cb179f9577f32a( level.scorpio_headlaunch_obj_id.origin, 4, level.scorpio_participants, "sat_ob_objectivemarker_exfil", 0, 0, 1 );
    level.scorpio_headlaunch_obj_id objidpoolmanager::function_373aaf492aabde6f( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ], 252, 230, 19 );
    level.scorpio_headlaunch_obj_id ob_story_mission_utils::mission_objective_marker_hide( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ] );
    level thread scorpio_headlaunch_prep_countdown();
    wait 30;
    level.scorpio_skel utility::playsoundontag( "dx_wc_scor_lext_tacb_headunitpreparingfor", "J_Head" );
    overlord::playevent( "scorpio_headlaunch_ready", level.scorpio_participants );
    launch_interact = interaction::register_interact( launch_struct.origin, 64, &on_launch_interact, &"sat_ob_activities/scorpio_interior_launch" );
    setup_interact_settings( launch_interact );
    level thread function_21396773a548e0ce( launch_interact );
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x732d9f2a, Offset: 0x6861
// Size: 0xa6
function function_593d91288abab644( core_trigger )
{
    wait int( 15 );
    self setscriptablepartstate( "base", "portal" );
    trigger::makeenterexittrigger( core_trigger, &function_cb8c3987330df7ba );
    level.var_cea3d20fc4af331f = spawnstruct();
    level.var_cea3d20fc4af331f ob_story_mission_utils::function_b9cb179f9577f32a( self.origin - ( 0, 0, 550 ), 0, level.scorpio_participants, "sat_ob_objectivemarker_exfil", 0, 0, 1 );
    level.var_cea3d20fc4af331f objidpoolmanager::function_373aaf492aabde6f( level.var_cea3d20fc4af331f.a_obj_id[ 0 ], 252, 230, 19 );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xb4685ad6, Offset: 0x690f
// Size: 0x174
function scorpio_headlaunch_prep_countdown()
{
    level endon( #"scorpio_scene_stopped" );
    level endon( #"scorpio_deleted" );
    level endon( #"game_ended" );
    level.var_e1565e5d789e4f77 = 30;
    
    foreach ( player in level.scorpio_participants )
    {
        player thread squad_notification::create( "scorpio_headlaunch_prep_countdown", "scripted_widget_squad_notification_mp_sat_ob_low", level.var_e1565e5d789e4f77, undefined, &"sat_ob_activities/scorpio_headlaunch_prep" );
    }
    
    while ( level.var_e1565e5d789e4f77 > 0 )
    {
        level.var_e1565e5d789e4f77 -= 1;
        wait 1;
    }
    
    level.var_e1565e5d789e4f77 = undefined;
    wait 1;
    
    foreach ( player in level.scorpio_participants )
    {
        player thread squad_notification::close( "scorpio_headlaunch_prep_countdown" );
    }
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x1fc0fda, Offset: 0x6a8b
// Size: 0x35
function function_21396773a548e0ce( launch_interact )
{
    level.scorpio_skel endon( #"head_launch_started" );
    wait 40;
    launch_interact delete();
    level thread function_5168eeb5fa95a515();
}

// Namespace scorpio_interior
// Params 1
// Checksum 0xcf73df1d, Offset: 0x6ac8
// Size: 0x39
function on_launch_interact( player )
{
    level.scorpio_skel notify( #"head_launch_started" );
    level thread function_5168eeb5fa95a515();
    self playsound( "evt_scorpio_head_button_press" );
    self delete();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x377d3ff, Offset: 0x6b09
// Size: 0x3c6
function function_5168eeb5fa95a515()
{
    level endon( #"scorpio_scene_stopped" );
    level endon( #"scorpio_deleted" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.scorpio_skel.entrance_interact ) )
    {
        level.scorpio_skel.entrance_interact delete();
    }
    
    level thread scorpio_exterior::function_3f2c28196579d5d0();
    level thread scorpio_exterior::function_50d2d399689da874();
    
    foreach ( player in level.players )
    {
        function_558553ee01c73219( player );
    }
    
    level.scorpio_skel utility::playsoundontag( "dx_wc_scor_lext_tacb_headunitlaunchingin", "J_Head" );
    overlord::playevent( "scorpio_headlaunch_start", level.scorpio_participants );
    wait 2;
    
    while ( utility::flag( "scorpio_in_attack_anim" ) )
    {
        waitframe();
    }
    
    level thread function_10efd27bd842e57b();
    level thread function_44ae31c2ab6f30c5();
    
    for ( i = 0; i < 10 ; i++ )
    {
        overlord::playevent( "scorpio_headlaunch_" + string( 10 - i ), level.scorpio_participants );
        
        /#
            iprintlnbold( "<dev string:x10c>" + 10 - i );
        #/
        
        wait 1;
    }
    
    core_trigger = getent( "scorpio_interior_portal_head_entrance", #targetname );
    
    if ( isdefined( core_trigger ) )
    {
        core_trigger notify( #"hash_73537c07898a047a" );
    }
    
    wait 2.3;
    
    foreach ( player in level.scorpio_participants )
    {
        if ( player.is_in_head )
        {
            if ( level.scorpio_headlaunch_obj_id )
            {
                objidpoolmanager::objective_playermask_hidefrom( level.scorpio_headlaunch_obj_id.a_obj_id[ 0 ], player );
            }
            
            player setclientomnvar( o"ui_ob_exfil_video_type", 1 );
            player playersetgroundreferenceent( undefined );
            player thread function_8ebba56ebd93a22d();
            continue;
        }
        
        function_9fbddfbbf295038d( player );
        level thread teleport_player( player, "exit_forced" );
    }
    
    level.scorpio_skel notify( #"scorpio_headlaunch_complete" );
    level.scorpio_skel notify( #"head_launch_started" );
    
    if ( !utility::flag( "scorpio_headlaunch_ready" ) )
    {
        level thread scorpio::function_876f13f543032ce2();
    }
    
    utility::flag_set( "scorpio_headlaunch_complete" );
    wait 2;
    
    foreach ( player in level.scorpio_participants )
    {
        if ( player.b_completed_exfil )
        {
            continue;
        }
        
        if ( player.is_in_head && !player.var_f8582488fe61ed8b )
        {
            player.b_completed_exfil = 1;
            level thread namespace_3a2a361a08f89b78::function_7945ba0143ab037d( player, #"hash_a796402786903f6" );
            continue;
        }
        
        if ( !player.is_in_head )
        {
            function_9fbddfbbf295038d( player );
            level thread teleport_player( player, "exit_forced" );
        }
    }
    
    scorpio_interior_cleanup();
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x6419c381, Offset: 0x6ed7
// Size: 0xb8
function function_10efd27bd842e57b()
{
    countdown_aliases = [ "dx_wc_scor_lext_tacb_ten", "dx_wc_scor_lext_tacb_nine", "dx_wc_scor_lext_tacb_eight", "dx_wc_scor_lext_tacb_seven", "dx_wc_scor_lext_tacb_six", "dx_wc_scor_lext_tacb_five", "dx_wc_scor_lext_tacb_four", "dx_wc_scor_lext_tacb_three", "dx_wc_scor_lext_tacb_two", "dx_wc_scor_lext_tacb_one" ];
    level.scorpio_skel utility::playsoundontag( "evt_scorpio_head_pre_launch_ext", "J_Neck" );
    
    for ( i = 0; i < countdown_aliases.size ; i++ )
    {
        level.scorpio_skel utility::playsoundontag( countdown_aliases[ i ], "J_Head" );
        wait 1;
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xc346bb0d, Offset: 0x6f97
// Size: 0x9b
function function_44ae31c2ab6f30c5()
{
    foreach ( player in level.scorpio_participants )
    {
        player clearsoundsubmix( "sat_mp_activity_scorpio_pre_launch_mute", 0.5 );
        player playlocalsound( "evt_scorpio_head_pre_launch_int" );
    }
    
    utility::flag_set( "flag_head_launch_started" );
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x40960105, Offset: 0x703a
// Size: 0x4c
function function_171d33b6ba75f2fc()
{
    if ( utility::flag( "flag_head_launch_started" ) )
    {
        alias_length = lookupsoundlength( "evt_scorpio_head_pre_launch_int" );
        self setsoundsubmix( "sat_mp_activity_scorpio_pre_launch_mute", 0.5 );
        wait alias_length / 1000;
        self clearsoundsubmix( "sat_mp_activity_scorpio_pre_launch_mute", 0.5 );
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xc1a01acb, Offset: 0x708e
// Size: 0x5ff
function function_8ebba56ebd93a22d()
{
    self endon( #"disconnect" );
    self.var_f8582488fe61ed8b = 1;
    self.b_completed_exfil = 1;
    
    if ( !isdefined( self.screen_overlay ) )
    {
        self.screen_overlay = newclienthudelem( self );
        self.screen_overlay.x = 0;
        self.screen_overlay.y = 0;
        self.screen_overlay setshader( "black", 640, 480 );
        self.screen_overlay.alignx = "left";
        self.screen_overlay.aligny = "top";
        self.screen_overlay.sort = 1;
        self.screen_overlay.horzalign = "fullscreen";
        self.screen_overlay.vertalign = "fullscreen";
        self.screen_overlay.alpha = 0;
        self.screen_overlay.foreground = 1;
        self.screen_overlay.archived = 0;
        self.screen_overlay.scramblerdisabled = 1;
    }
    
    self dontinterpolate();
    self unlink();
    self hidelegsandshadow();
    self playerhide();
    val::set( "scorpio_headlaunch_cam", "freezecontrols", 1 );
    val::set( "scorpio_headlaunch_cam", "show_hud", 0 );
    val::set( "scorpio_headlaunch_cam", "interactions", 0 );
    val::set( "scorpio_headlaunch_cam", "allow_revive_teammate", 0 );
    val::set( "scorpio_headlaunch_cam", "damage", 0 );
    val::set( "scorpio_headlaunch_cam", "vehicle_use", 0 );
    val::set( "scorpio_headlaunch_cam", "crouch", 0 );
    val::set( "scorpio_headlaunch_cam", "gesture", 0 );
    val::set( "scorpio_headlaunch_cam", "allow_jump", 0 );
    val::set( "scorpio_headlaunch_cam", "killstreaks", 0 );
    val::set( "scorpio_headlaunch_cam", "melee", 0 );
    val::set( "scorpio_headlaunch_cam", "offhand_weapons", 0 );
    val::set( "scorpio_headlaunch_cam", "prone", 0 );
    val::set( "scorpio_headlaunch_cam", "sprint", 0 );
    val::set( "scorpio_headlaunch_cam", "supers", 0 );
    val::set( "scorpio_headlaunch_cam", "usability", 0 );
    val::set( "scorpio_headlaunch_cam", "weapon", 0 );
    val::set( "scorpio_headlaunch_cam", "allow_movement", 0 );
    val::set( "scorpio_headlaunch_cam", "fire", 0 );
    val::set( "scorpio_headlaunch_cam", "weapon_switch", 0 );
    val::set( "scorpio_headlaunch_cam", "ignoreme", 1 );
    self setsoundsubmix( "sat_mp_activity_scorpio_pre_launch_mute", 0.5 );
    self.screen_overlay fadeovertime( 0.7 );
    self.screen_overlay.alpha = 1;
    level utility::flag_wait( "play_head_launch_xcam" );
    
    if ( !utility::flag( "scorpio_headlaunch_ready" ) )
    {
        self playxcam( "sat_wc_cin_scorpio_head_launch_xcam", 0, level.scorpio_head.origin, level.scorpio_head.angles - ( 0, 90, 0 ) );
        xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_head_launch_xcam" );
    }
    else
    {
        switch ( level.var_c1808a4a618b4b31 )
        {
            case #"hash_df8d474a666c3a5b":
                self playxcam( "sat_wc_cin_scorpio_path01_a_head_launch_end_xcam", 0, level.scorpio_animnode.origin, level.scorpio_animnode.angles );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path01_a_head_launch_end_xcam" );
                break;
            case #"hash_df8d484a666c3bee":
                self playxcam( "sat_wc_cin_scorpio_path01_b_head_launch_end_xcam", 0, ( -1390.93, -29410.9, 4628.5 ), ( 0, 0, 0 ) );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path01_b_head_launch_end_xcam" );
                break;
            case #"hash_df8d494a666c3d81":
                self playxcam( "sat_wc_cin_scorpio_path01_c_head_launch_end_xcam", 0, ( 9409.88, -42439.6, 5890.95 ), ( 0, 0, 0 ) );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path01_c_head_launch_end_xcam" );
                break;
            case #"hash_e8e19c4a6bd0f26a":
                self playxcam( "sat_wc_cin_scorpio_path02_a_head_launch_end_xcam", 0, level.scorpio_animnode.origin, level.scorpio_animnode.angles );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path02_a_head_launch_end_xcam" );
                break;
            case #"hash_e8e19b4a6bd0f0d7":
                self playxcam( "sat_wc_cin_scorpio_path02_b_head_launch_end_xcam", 0, ( 31823, 16593.3, 5329.44 ), ( 0, 0, 0 ) );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path02_b_head_launch_end_xcam" );
                break;
            case #"hash_e8e19a4a6bd0ef44":
                self playxcam( "sat_wc_cin_scorpio_path02_c_head_launch_end_xcam", 0, ( 16760, 17241.7, 4531.61 ), ( 0, 0, 0 ) );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_path02_c_head_launch_end_xcam" );
                break;
            default:
                self playxcam( "sat_wc_cin_scorpio_head_launch_xcam", 0, level.scorpio_head.origin, level.scorpio_head.angles );
                xcam_playtime = getxcamlength( "sat_wc_cin_scorpio_head_launch_xcam" );
                break;
        }
    }
    
    self.screen_overlay fadeovertime( 1.5 );
    self.screen_overlay.alpha = 0;
    wait 1.7;
    
    if ( isdefined( self.screen_overlay ) )
    {
        self.screen_overlay destroy();
    }
    
    if ( xcam_playtime > 0 && xcam_playtime )
    {
        wait xcam_playtime - 4.3;
    }
    else
    {
        wait 6.5;
    }
    
    thread namespace_3a2a361a08f89b78::function_7945ba0143ab037d( self, #"hash_a796402786903f6" );
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x7572886c, Offset: 0x7695
    // Size: 0x5, Type: dev
    function function_33f683982ef26701()
    {
        
    }

#/

// Namespace scorpio_interior
// Params 4
// Checksum 0x6e12a67d, Offset: 0x76a2
// Size: 0x4e0
function item_spawn_weapon( struct_targetname, var_b60496d5b429ae0f, is_staged = 0, exclusive_owner = undefined )
{
    if ( !isdefined( level.loot_drop_script_throttle ) )
    {
        level.loot_drop_script_throttle = throttle::throttle_initialize( "loot_drop_script", 1, level.framedurationseconds );
    }
    
    a_s_weapon = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( a_s_weapon.size == 0 )
    {
        return;
    }
    
    foreach ( var_fe68cd50dcda7fdc in a_s_weapon )
    {
        spawned_wpn = undefined;
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, var_fe68cd50dcda7fdc );
        
        if ( is_staged )
        {
            wpn_spawn_options = common_item::function_bc5ff2958b71a708( var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles );
        }
        else
        {
            wpn_spawn_options = common_item::items_initspawnoptions_spawnfromposition( var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles );
        }
        
        wpn_spawn_options.var_90cdc5dbcd319e5d = 1;
        wpn_spawn_options.var_fd47e835523b473f = 1;
        wpn_spawn_options.var_8d4f327170228364 = 1;
        wpn_spawn_options.dropradiusscale = 0;
        wpn_spawn_options.var_23d3495c57d61bdf = 1;
        wpn_spawn_options.exclusiveowner = exclusive_owner;
        var_5b97ae4b727ee516 = strtok( var_fe68cd50dcda7fdc.script_noteworthy, "," );
        
        if ( isstartstr( var_5b97ae4b727ee516[ 0 ], "zm_" ) || isstartstr( var_5b97ae4b727ee516[ 0 ], "ob_" ) )
        {
            wpn_bundle = undefined;
            wpn_specific = var_5b97ae4b727ee516[ 0 ];
            
            if ( isdefined( var_5b97ae4b727ee516[ 1 ] ) )
            {
                wpn_rarity = var_5b97ae4b727ee516[ 1 ];
                
                if ( isdefined( var_5b97ae4b727ee516[ 2 ] ) && utility::cointoss() )
                {
                    wpn_rarity = var_5b97ae4b727ee516[ 2 ];
                }
                
                wpn_specific = var_5b97ae4b727ee516[ 0 ] + "_" + wpn_rarity;
            }
            
            wpn_bundle = getscriptbundle( "itemspawnentry:" + wpn_specific );
            
            if ( isdefined( wpn_bundle ) )
            {
                spawned_wpn = item_weapon::function_b960bc85ea91de14( wpn_bundle, wpn_spawn_options );
            }
        }
        else
        {
            switch ( var_5b97ae4b727ee516[ 0 ] )
            {
                case #"hash_98dcd2e7e7e3c632":
                case #"hash_fa18d2f6bd57925a":
                    wpn_list = "ob_sat_items_weapons_ar_";
                    break;
                case #"hash_589e620d9c37ef93":
                case #"hash_fa0ed9f6bd4f4e9a":
                    wpn_list = "ob_sat_items_weapons_dm_";
                    break;
                case #"hash_ba39cac9c099d4f1":
                case #"hash_fa27bdf6bd62aa3e":
                    wpn_list = "ob_sat_items_weapons_la_";
                    break;
                case #"hash_2f2d546c2247838f":
                case #"hash_bb3bd3f7cd7a8a5c":
                case #"hash_fa27b9f6bd62a3f2":
                    wpn_list = "ob_sat_items_weapons_lm_";
                    break;
                case #"hash_40a94c5d9e4e265b":
                case #"hash_fa24ddf6bd609e07":
                    wpn_list = "ob_sat_items_weapons_me_";
                    break;
                case #"hash_719417cb1de832b6":
                case #"hash_fa4dbdf6bd80bf52":
                    wpn_list = "ob_sat_items_weapons_pi_";
                    break;
                case #"hash_23209741b93850b5":
                case #"hash_fa50b4f6bd82efbe":
                    wpn_list = "ob_sat_items_weapons_sh_";
                    break;
                case #"hash_900cb96c552c5e8e":
                case #"hash_fa50b9f6bd82f79d":
                    wpn_list = "ob_sat_items_weapons_sm_";
                    break;
                case #"hash_6191aaef9f922f96":
                case #"hash_fa50b6f6bd82f2e4":
                    wpn_list = "ob_sat_items_weapons_sn_";
                    break;
                default:
                    wpn_list = "ob_sat_items_weapons_";
                    break;
            }
            
            wpn_rarity = "base";
            
            if ( isdefined( var_5b97ae4b727ee516[ 1 ] ) )
            {
                wpn_rarity = var_5b97ae4b727ee516[ 1 ];
                
                if ( isdefined( var_5b97ae4b727ee516[ 2 ] ) && utility::cointoss() )
                {
                    wpn_rarity = var_5b97ae4b727ee516[ 2 ];
                }
            }
            
            spawned_wpn = common_item::function_38cde6a6acb68ea6( wpn_list + wpn_rarity, 1, wpn_spawn_options );
        }
        
        if ( isdefined( spawned_wpn ) )
        {
            ammo_count = undefined;
            
            if ( isdefined( var_fe68cd50dcda7fdc.script_ammo_clip ) )
            {
                ammo_count = var_fe68cd50dcda7fdc.script_ammo_clip;
            }
            else if ( isdefined( var_fe68cd50dcda7fdc.script_ammo_extra ) )
            {
                ammo_count = var_fe68cd50dcda7fdc.script_ammo_extra;
            }
            
            if ( isdefined( ammo_count ) )
            {
                if ( isarray( spawned_wpn ) )
                {
                    foreach ( wpn in spawned_wpn )
                    {
                        wpn.weaponstockammo = ammo_count;
                    }
                }
                else
                {
                    spawned_wpn.weaponstockammo = ammo_count;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xbe155133, Offset: 0x7b8a
// Size: 0xf1
function function_a0fe30748a0e428a()
{
    self notify( #"hash_6ede9ae4d3217f77" );
    self endon( #"hash_6ede9ae4d3217f77" );
    
    while ( true )
    {
        while ( !getdvarint( @"hash_50005837457e510e", 0 ) )
        {
            waitframe();
        }
        
        if ( isdefined( level.scorpio_skel.entrance_interact ) )
        {
            foreach ( player in level.players )
            {
                level thread teleport_player( player, "entrance", level.scorpio_skel.entrance_interact );
            }
        }
        
        setdvar( @"hash_50005837457e510e", 0 );
        waitframe();
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xed682e82, Offset: 0x7c83
// Size: 0xe4
function function_7ca4e7b4f1356575()
{
    self notify( #"hash_946eb0bde4ebe7f" );
    self endon( #"hash_946eb0bde4ebe7f" );
    
    while ( true )
    {
        while ( !getdvarint( @"hash_2c00fccac61f2089", 0 ) )
        {
            waitframe();
        }
        
        if ( isdefined( level.scorpio_skel.entrance_interact ) )
        {
            foreach ( player in level.players )
            {
                level thread teleport_player( player, "head", undefined, "scorpio_interior_head_teleport_exit" );
            }
        }
        
        setdvar( @"hash_2c00fccac61f2089", 0 );
        waitframe();
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x82bcbe8c, Offset: 0x7d6f
// Size: 0x4ea
function function_33d510965b079837()
{
    level.var_8c664d386518fb1d = [];
    
    if ( !utility::flag( "scorpio_headlaunch_ready" ) )
    {
        cam_struct = spawnstruct();
        cam_struct.origin = level.scorpio_skel.origin + ( -7282.63, 826.666, 3647.53 );
        cam_struct.angles = ( 0, -13, 0 );
        cam_struct.events = [ [ "rotate", ( -66.255, -35.255, 0 ), 4.6, 3.2 ] ];
        cam_struct.cam = utility::spawn_tag_origin( cam_struct.origin, cam_struct.angles );
        level.var_8c664d386518fb1d[ level.var_8c664d386518fb1d.size ] = cam_struct;
    }
    else
    {
        cam_struct = spawnstruct();
        cam_struct.origin = level.scorpio_skel.origin + ( -7282.63, 826.666, 3647.53 );
        cam_struct.angles = ( 10, -13, 0 );
        cam_struct.events = [ [ "rotate", ( -92.255, -55.255, 0 ), 2.3, 1.8 ] ];
        cam_struct.cam = utility::spawn_tag_origin( cam_struct.origin, cam_struct.angles );
        level.var_8c664d386518fb1d[ level.var_8c664d386518fb1d.size ] = cam_struct;
    }
    
    cam_struct = spawnstruct();
    cam_struct.origin = level.scorpio_skel.origin + ( -5954.82, -1814.68, 3553.53 );
    cam_struct.angles = ( -5, -5, 0 );
    cam_struct.events = [ [ "move", ( -8508.8, -6176.34, 3553.53 ), 2.5, 1, 1, 1 ], [ "rotate", ( 0, 20, 0 ), 2, 1.8 ] ];
    cam_struct.cam = utility::spawn_tag_origin( cam_struct.origin, cam_struct.angles );
    level.var_8c664d386518fb1d[ level.var_8c664d386518fb1d.size ] = cam_struct;
    
    if ( !utility::flag( "scorpio_headlaunch_ready" ) )
    {
        cam_struct = spawnstruct();
        cam_struct.origin = level.scorpio_skel.origin + ( -1229, -2165, 5100 );
        cam_struct.angles = ( 0, 66, 0 );
        cam_struct.events = [ [ "move", ( -2401.53, -4042.71, 10859.5 ), 5.5, 1.8, 0, 4 ], [ "rotate", ( 66, 66, 0 ), 3.5, 2 ] ];
        cam_struct.cam = utility::spawn_tag_origin( cam_struct.origin, cam_struct.angles );
        level.var_8c664d386518fb1d[ level.var_8c664d386518fb1d.size ] = cam_struct;
        return;
    }
    
    cam_struct = spawnstruct();
    cam_struct.origin = level.scorpio_skel.origin + ( -3206, -2185, 5100 );
    cam_struct.angles = ( 41, 26, 0 );
    cam_struct.events = [ [ "move", ( -5418.87, -4058.71, 10825.1 ), 4.3, 1.6, 0, 2 ], [ "rotate", ( 60, 26, 0 ), 3.5, 1.5 ] ];
    cam_struct.cam = utility::spawn_tag_origin( cam_struct.origin, cam_struct.angles );
    level.var_8c664d386518fb1d[ level.var_8c664d386518fb1d.size ] = cam_struct;
}

// Namespace scorpio_interior
// Params 0
// Checksum 0xab685439, Offset: 0x8261
// Size: 0x11
function function_1ffde025f55c515c()
{
    return utility::array_random( level.var_8c664d386518fb1d );
}

/#

    // Namespace scorpio_interior
    // Params 0
    // Checksum 0x42b45a6, Offset: 0x827b
    // Size: 0x191, Type: dev
    function function_3b0ebed7f303112a()
    {
        while ( true )
        {
            sphere( level.scorpio_skel.origin + ( -7282.63, 826.666, 3647.53 ), 30, ( 1, 0, 0 ), 0, 30 );
            sphere( level.scorpio_skel.origin + ( -5954.82, -1814.68, 3553.53 ), 30, ( 0, 1, 0 ), 0, 30 );
            sphere( level.scorpio_skel.origin + ( -1229, -2165, 5100 ), 30, ( 0, 0, 1 ), 0, 30 );
            utility::draw_angles( ( 0, -13, 0 ), level.scorpio_skel.origin + ( -7282.63, 826.666, 3647.53 ), ( 1, 0, 0 ), 20, 30 );
            utility::draw_angles( ( -5, -5, 0 ), level.scorpio_skel.origin + ( -5954.82, -1814.68, 3553.53 ), ( 0, 1, 0 ), 20, 30 );
            utility::draw_angles( ( 0, 66, 0 ), level.scorpio_skel.origin + ( -1229, -2165, 5100 ), ( 0, 0, 1 ), 20, 30 );
            waitframe();
        }
    }

#/

// Namespace scorpio_interior
// Params 0
// Checksum 0x1cc84071, Offset: 0x8414
// Size: 0x98
function function_ab4fd057c22bd33d()
{
    if ( level.var_8c664d386518fb1d )
    {
        foreach ( cam in level.var_8c664d386518fb1d )
        {
            cam.cam delete();
        }
        
        level.var_8c664d386518fb1d = undefined;
    }
}

// Namespace scorpio_interior
// Params 0
// Checksum 0x14679b92, Offset: 0x84b4
// Size: 0x9d
function function_95dcb81c7eb06e38()
{
    var_b0ecd5597030bd21 = 1;
    
    foreach ( event in self.events )
    {
        thread function_d2a32da27b90f3cc( event );
        
        if ( var_b0ecd5597030bd21 < event[ 2 ] )
        {
            var_b0ecd5597030bd21 = event[ 2 ];
        }
    }
    
    wait var_b0ecd5597030bd21;
}

// Namespace scorpio_interior
// Params 1
// Checksum 0x229c9a0b, Offset: 0x8559
// Size: 0xe3
function function_d2a32da27b90f3cc( event )
{
    if ( event[ 3 ] )
    {
        wait event[ 3 ];
    }
    
    if ( !event[ 4 ] )
    {
        event[ 4 ] = 0;
    }
    
    if ( !event[ 5 ] )
    {
        event[ 5 ] = 0;
    }
    
    switch ( event[ 0 ] )
    {
        case #"hash_49c181c60054bd6a":
            self.cam rotateto( event[ 1 ], event[ 2 ], event[ 4 ], event[ 5 ] );
            break;
        case #"hash_ecb83a34dd571174":
            self.cam moveto( level.scorpio_skel.origin + event[ 1 ], event[ 2 ], event[ 4 ], event[ 5 ] );
            break;
        case #"hash_92bcabbf88850fb2":
            self.cam unlink();
        default:
            break;
    }
    
    wait event[ 2 ];
}

/#

    // Namespace scorpio_interior
    // Params 5, eflags: 0x4
    // Checksum 0x73975f5e, Offset: 0x8644
    // Size: 0x59, Type: dev
    function private debug_draw( entity, string, radius, color, duration )
    {
        me = level.players[ 0 ];
        me thread debug_draw_inner( entity, string, radius, color, duration );
    }

    // Namespace scorpio_interior
    // Params 5, eflags: 0x4
    // Checksum 0xd313238b, Offset: 0x86a5
    // Size: 0x136, Type: dev
    function private debug_draw_inner( entity, string, radius, color, duration )
    {
        if ( !isdefined( radius ) )
        {
            radius = 64;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        self endon( #"disconnect" );
        level endon( #"game_ended" );
        entity endon( #"death" );
        end_time = duration ? gettime() + duration * 1000 : undefined;
        
        while ( true )
        {
            waitframe();
            
            if ( !( getdvarint( @"hash_18d4e8510a206a0d", 0 ) > 0 ) )
            {
                continue;
            }
            
            if ( !entity )
            {
                break;
            }
            
            if ( end_time && gettime() >= end_time )
            {
                break;
            }
            
            sphere( entity.origin, radius, color );
            formatted_string = string;
            
            if ( end_time )
            {
                remain = int( ( end_time - gettime() ) / 100 ) / 10;
                formatted_string += "<dev string:x11d>" + remain + "<dev string:x120>";
            }
            
            print3d( entity.origin, formatted_string, color );
        }
    }

#/
