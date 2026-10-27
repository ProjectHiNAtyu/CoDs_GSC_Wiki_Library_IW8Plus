// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util.gsc  (hash_0cea808c219d9690.gscc) (size: 53481 Bytes / 0xd0e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3596e7d6 (899082198)
// size ...... 53481 (0xd0e9)
// includes .. 41  (offset: 0xc1ad)
// strings ... 231 (offset: 0xc2f5)
// dev strs .. 8   (offset: 0xd081)
// exports ... 139 (offset: 0x8455)
// cseg ...... 0x14cc + 0x6f89 (0x8455)
// imports ... 305 (offset: 0x9a0d)
// animtree1 . 0   (offset: 0xd0e9)
// animtree2 . 0   (offset: 0xd0e9)
#using script_3016732d4c7eef02;
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\hints;
#using scripts\common\hud_util;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\math;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\puzzles\keypad_puzzle;
#using scripts\common\scene;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\ground_drone_unit_mp;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\coop;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\supers;
#using scripts\mp\vehicles\damage;

#namespace ob_virgo_util;

// Namespace ob_virgo_util
// Params 2
// Checksum 0x7f997fb9, Offset: 0x14ea
// Size: 0x52
function virgo_teleport_players( activity_name, bink_name )
{
    if ( isdefined( bink_name ) )
    {
        structs = ob_story_mission_utils::get_activity_starts( activity_name );
        level thread coop::play_cinematic( bink_name, { #structs:structs } );
        return;
    }
    
    level thread ob_story_mission_utils::function_2686bb512b355040( activity_name );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xa37be1f4, Offset: 0x1544
// Size: 0x79
function function_9f82575f71dc8cf7( wait_time, do_fade = 1 )
{
    player = self;
    player endon( #"death" );
    
    if ( do_fade )
    {
        player lerpfovbypreset( "hellstorm_missile_zoom_out" );
        player hud_util::fade_out( wait_time, "white" );
        wait wait_time;
        player lerpfovbypreset( "default" );
        wait wait_time;
        player hud_util::fade_in( wait_time, "white" );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xe8305889, Offset: 0x15c5
// Size: 0x8e
function fade_squad( time )
{
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0, "white" );
    }
    
    wait time;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xb48dc962, Offset: 0x165b
// Size: 0x15
function setup_ui_widget( s_activity_name )
{
    ob_story_mission_utils::objective_text_show( s_activity_name );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xa6e13c9, Offset: 0x1678
// Size: 0x15
function function_3fbaca3bceae7dfb( s_loc_objective )
{
    ob_story_mission_utils::objective_text_show( s_loc_objective );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xb5f7ea8f, Offset: 0x1695
// Size: 0xa2
function function_9b6adf1cce23cc19( ent, flag )
{
    ent.complete_flag = flag;
    captime = ent.captime ?? 40;
    radius = ent.radius ?? 196;
    capture_zone = ob_capture_zone::function_40df18d63bc4331a( ent.targetname, self, undefined, captime, undefined, undefined, undefined, 1, 1, ent );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_COMPLETE", &zoneonuse );
    thread ob_capture_zone::function_7d67c057ae88b5a0( capture_zone, radius, 1 );
    return capture_zone;
}

// Namespace ob_virgo_util
// Params 1, eflags: 0x4
// Checksum 0xd98d22c0, Offset: 0x1740
// Size: 0x35
function private zoneonuse( capture_zone )
{
    level notify( #"hash_c843da3ea08b0512" );
    level notify( #"zone_captured" );
    level utility::flag_set( self.complete_flag );
}

/#

    // Namespace ob_virgo_util
    // Params 2
    // Checksum 0x356f04a8, Offset: 0x177d
    // Size: 0xca, Type: dev
    function function_d1cab9a6f04295c7( zone, point )
    {
        zone endon( #"death" );
        zone.trigger endon( #"death" );
        captime = point.captime ?? 40;
        
        while ( true )
        {
            if ( isdefined( zone.curprogress ) )
            {
                print3d( zone.trigger.origin + ( 0, 0, 64 ), "<dev string:x24>" + zone.curprogress / 1000 + "<dev string:x25>" + captime, ( 1, 0, 0 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_virgo_util
// Params 0
// Checksum 0xc4aaf4d6, Offset: 0x184f
// Size: 0x16c
function function_62429e1b1c34454c()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.icondefending = "waypoint_defending";
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1 );
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0x3080e348, Offset: 0x19c3
// Size: 0xdd
function function_70674852bcdd6cd3( var_dc6a4b4b351da087, flag_name, var_c65d7af13cce3674 = &"sat_ob_story_missions/virgo_interact_generic", var_490060d47d9e122a, have_objective, offset = ( 0, 0, 0 ) )
{
    if ( isstring( var_dc6a4b4b351da087 ) )
    {
        struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    }
    else
    {
        struct = var_dc6a4b4b351da087;
    }
    
    interact = interaction::register_interact( struct.origin + offset, 64, &zone_interact, var_c65d7af13cce3674 );
    interact.flag_interact = flag_name;
    interact setcursorhint( "HINT_BUTTON" );
    
    if ( isdefined( var_490060d47d9e122a ) )
    {
        interact.var_490060d47d9e122a = var_490060d47d9e122a;
    }
    
    return struct;
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0x819aa8be, Offset: 0x1aa9
// Size: 0xe8
function function_c344e89174400419( var_dc6a4b4b351da087, flag_name, flag_scene_done, var_c65d7af13cce3674 = &"sat_ob_story_missions/virgo_interact_generic", scene_struct, shot_name )
{
    if ( isstring( var_dc6a4b4b351da087 ) )
    {
        struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    }
    else
    {
        struct = var_dc6a4b4b351da087;
    }
    
    interact = interaction::register_interact( struct.origin + ( 0, 0, -16 ), 64, &scene_interact, var_c65d7af13cce3674 );
    interact.flag_interact = flag_name;
    interact.scene_struct = scene_struct;
    interact.var_f40cc8b1fe735ee3 = shot_name;
    interact.flag_scene_done = flag_scene_done;
    interact setcursorhint( "HINT_BUTTON" );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xe0104b88, Offset: 0x1b99
// Size: 0xdf
function robot_hack( var_7eb1220c474ee48e, var_c65d7af13cce3674 = &"sat_ob_story_missions/virgo_interact_generic" )
{
    var_490060d47d9e122a = "virgo_hack_1";
    spot = spawnstruct();
    spot.origin = var_7eb1220c474ee48e.origin + 16 * anglestoforward( var_7eb1220c474ee48e.angles ) + ( 0, 0, 40 );
    level utility::flag_wait( "flag_start_garden_countdown" );
    interact = interaction::register_interact( spot.origin, 64, &robot_interact, var_c65d7af13cce3674 );
    interact.var_7eb1220c474ee48e = var_7eb1220c474ee48e;
    thread function_f2ebeef954fe90e6( spot, "flag_start_garden_combat", var_7eb1220c474ee48e );
    level utility::flag_wait( "flag_japan_fight_combat_start" );
    interact makeunusable();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x4663a15a, Offset: 0x1c80
// Size: 0x3c
function robot_interact( player )
{
    self makeunusable();
    self.var_7eb1220c474ee48e.hacked = 1;
    self.var_7eb1220c474ee48e notify( #"robot_shutdown" );
}

// Namespace ob_virgo_util
// Params 5
// Checksum 0x767ef3ee, Offset: 0x1cc4
// Size: 0xa1
function function_9c84195f092c0e2b( var_dc6a4b4b351da087, flag_name, var_c65d7af13cce3674 = &"sat_ob_story_missions/virgo_interact_generic", var_490060d47d9e122a, text )
{
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    interact = interaction::register_interact( struct.origin, 64, &function_75188a7ccce84205, var_c65d7af13cce3674 );
    interact.var_490060d47d9e122a = var_490060d47d9e122a;
    level.puzzle_flag = flag_name;
    thread function_144604a50795e58f( var_dc6a4b4b351da087, flag_name, undefined );
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0x5381528b, Offset: 0x1d6d
// Size: 0x12a
function virgo_keypad( var_dc6a4b4b351da087, flag_name, var_c65d7af13cce3674, keypad_name, flag_success, number )
{
    namespace_4ac7bd741c9c2707::function_c4ebca8f7435b099();
    
    if ( isstring( var_dc6a4b4b351da087 ) )
    {
        struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    }
    else
    {
        struct = var_dc6a4b4b351da087;
    }
    
    interact = interaction::register_interact( struct.origin, 64, &function_ae818561664ab925, var_c65d7af13cce3674, undefined, undefined, undefined, "HINT_BUTTON" );
    interact.flag_interact = flag_name;
    interact.flag_success = flag_success;
    interact.var_c65d7af13cce3674 = var_c65d7af13cce3674;
    
    if ( isdefined( keypad_name ) )
    {
        [ interact.keypad ] = getentarray( "script_model_puzzle_keypad", #classname );
        interact.keypad.keypad_name = keypad_name;
        interact.code_number = number;
        interact.keypad thread function_37df50447da40a8e( flag_success );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xc804a728, Offset: 0x1e9f
// Size: 0x1b2
function function_ae818561664ab925( player )
{
    self makeunusable();
    level utility::flag_set( self.flag_interact );
    self.keypad.var_4ac7bd741c9c2707.seed = self.code_number;
    self.keypad.var_4ac7bd741c9c2707.chances = 0;
    self.keypad.var_4ac7bd741c9c2707.var_5806943da988e08c = 0;
    finished = "";
    
    if ( isautopilot( player ) )
    {
        level utility::flag_set( self.flag_success );
        return;
    }
    
    if ( isdefined( self.keypad ) )
    {
        self.keypad.var_4ac7bd741c9c2707.param = self.keypad.keypad_name;
        player namespace_4ac7bd741c9c2707::function_8e9c784db97ea8fa( self.keypad );
        
        if ( player namespace_4ac7bd741c9c2707::is_active() )
        {
            finished = self.keypad utility::waittill_any_return( "keypad_puzzle_success", "keypad_puzzle_fail", "keypad_puzzle_closed" );
        }
        
        if ( level utility::flag( self.flag_success ) )
        {
            player namespace_4ac7bd741c9c2707::function_f94db7815fb20875();
            return;
        }
        
        if ( finished == "keypad_puzzle_success" )
        {
            player namespace_4ac7bd741c9c2707::function_f94db7815fb20875();
            level utility::flag_set( self.flag_success );
            return;
        }
        
        player namespace_4ac7bd741c9c2707::function_f94db7815fb20875();
        
        if ( level utility::flag( self.flag_success ) )
        {
            return;
        }
        
        self makeusable();
        interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_unlock" );
        self setcursorhint( "HINT_BUTTON" );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xe8d18d5c, Offset: 0x2059
// Size: 0x42
function function_37df50447da40a8e( flag_success )
{
    self notify( #"hash_580611685a69e6be" );
    self endon( #"hash_580611685a69e6be" );
    self waittill( #"keypad_puzzle_success" );
    level utility::flag_set( flag_success );
    waitframe();
    self makeunusable();
}

// Namespace ob_virgo_util
// Params 0, eflags: 0x4
// Checksum 0xc84187c8, Offset: 0x20a3
// Size: 0xc4
function private function_2e122204a2a9f941()
{
    level notify( #"hash_a6742864fb90f4ac" );
    level endon( #"hash_a6742864fb90f4ac" );
    level endon( #"death" );
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted", data );
        
        foreach ( player in data.players )
        {
            player notify( #"ConnectionPuzzleCompleted" );
        }
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x3aac00bc, Offset: 0x216f
// Size: 0x52c
function zone_interact( player )
{
    if ( !val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    self makeunusable();
    level.pullforward_initiator = player;
    
    if ( isdefined( self.var_490060d47d9e122a ) )
    {
        player thread start_interact_scene( "struct_puzzle_scene" );
        level utility::flag_set( "flag_virgo_puzzle_interact_used" );
        
        if ( player connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            consoles = getscriptablearray( "puzzle_console", "targetname" );
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
            }
            
            foreach ( spectator in level.players )
            {
                if ( spectator != player )
                {
                    spectator thread connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a, 1 );
                }
            }
            
            finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
            player function_d68eec31414afe2e( "struct_puzzle_scene" );
            
            if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
            {
                consoles = getscriptablearray( "puzzle_console", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
                }
                
                foreach ( member in level.players )
                {
                    if ( member == player )
                    {
                        player connection_puzzle::close();
                        continue;
                    }
                    
                    member connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
                }
                
                level utility::flag_set( self.flag_interact );
            }
            else
            {
                consoles = getscriptablearray( "puzzle_console", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
                }
                
                foreach ( member in level.players )
                {
                    if ( member == player )
                    {
                        player connection_puzzle::close();
                        continue;
                    }
                    
                    member connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
                }
                
                waitframe();
                self makeusable();
                interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_hack" );
                self setcursorhint( "HINT_BUTTON" );
            }
        }
        else
        {
            waitframe();
            
            if ( isplayer( player ) )
            {
                player function_d68eec31414afe2e( "struct_puzzle_scene" );
            }
            
            self makeusable();
            interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_hack" );
        }
        
        return;
    }
    
    if ( isdefined( self.keypad ) )
    {
        player namespace_4ac7bd741c9c2707::function_8e9c784db97ea8fa( self.keypad );
        finished = self.keypad utility::waittill_any_return( "keypad_puzzle_success", "keypad_puzzle_fail", "keypad_puzzle_closed", "death_or_disconnect" );
        
        if ( finished == "keypad_puzzle_success" )
        {
            level utility::flag_set( self.flag_interact );
        }
        else
        {
            waitframe();
            self makeusable();
            interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_unlock" );
        }
        
        return;
    }
    
    level utility::flag_set( self.flag_interact );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x958ee68, Offset: 0x26a3
// Size: 0x12
function function_75188a7ccce84205( player )
{
    self makeunusable();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x1b3c9a58, Offset: 0x26bd
// Size: 0x72
function start_interact_scene( scene_targetname )
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    player = self;
    scene_struct = utility::getstruct( scene_targetname );
    
    if ( !isdefined( scene_struct ) )
    {
        return;
    }
    
    scene_struct scene::play( player, "enter" );
    
    if ( isalive( player ) )
    {
        scene_struct thread scene::play( player, "idle" );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xfee35944, Offset: 0x2737
// Size: 0x4b
function function_d68eec31414afe2e( scene_targetname )
{
    player = self;
    scene_struct = utility::getstruct( scene_targetname );
    
    if ( !isdefined( scene_struct ) )
    {
        return;
    }
    
    scene_struct scene::stop();
    scene_struct scene::play( player, "exit" );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x7e9cd24d, Offset: 0x278a
// Size: 0x66
function scene_interact( player )
{
    self makeunusable();
    level utility::flag_set( self.flag_interact );
    scene_struct = self.scene_struct;
    scene_struct thread function_4bd4a542456c5ca1( player );
    scene_struct scene::play( player, self.var_f40cc8b1fe735ee3 );
    level utility::flag_set( self.flag_scene_done );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x3e96f7e9, Offset: 0x27f8
// Size: 0x51
function function_4bd4a542456c5ca1( player )
{
    level endon( #"hash_aa7ddf691ee943" );
    computer = scene::get_entity( "Computer" );
    
    while ( true )
    {
        computer waittill( #"hash_b11c76a38ca9f71" );
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x5518e129, Offset: 0x2851
// Size: 0x13
function correct_callback()
{
    level utility::flag_set( level.puzzle_flag );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x5e55d467, Offset: 0x286c
// Size: 0x2
function incorrect_callback()
{
    
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xfa3213cf, Offset: 0x2876
// Size: 0x2
function close_callback()
{
    
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x3b61d21f, Offset: 0x2880
// Size: 0x4e
function function_1415e67b35bab88e( triggername, flag_name )
{
    etrigger = getent( triggername, "targetname" );
    etrigger waittill( #"trigger", eother );
    level utility::flag_set( flag_name );
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xce405beb, Offset: 0x28d6
// Size: 0xc3
function function_144604a50795e58f( var_dc6a4b4b351da087, flag_name, offset = ( 0, 0, 16 ) )
{
    if ( isstring( var_dc6a4b4b351da087 ) )
    {
        struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    }
    else
    {
        struct = var_dc6a4b4b351da087;
    }
    
    if ( !isdefined( self.var_8029d4363972e15 ) )
    {
        self.var_8029d4363972e15 = [];
    }
    
    var_7755c399b0e4de3c = self.var_8029d4363972e15.size;
    self.var_8029d4363972e15[ var_7755c399b0e4de3c ] = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin + offset );
    level function_19e36a7a5aaa759c( flag_name );
    ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15[ var_7755c399b0e4de3c ] );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xd2a58678, Offset: 0x29a1
// Size: 0x22
function function_19e36a7a5aaa759c( flag_name )
{
    level endon( #"hash_2ca212cd3fce0055" );
    level utility::flag_wait( flag_name );
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xc4dd3a2e, Offset: 0x29cb
// Size: 0x87
function function_f2ebeef954fe90e6( struct, flag_name, var_7eb1220c474ee48e )
{
    if ( !isdefined( self.var_8029d4363972e15 ) )
    {
        self.var_8029d4363972e15 = [];
    }
    
    var_7755c399b0e4de3c = self.var_8029d4363972e15.size;
    self.var_8029d4363972e15[ var_7755c399b0e4de3c ] = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 8 );
    var_7eb1220c474ee48e robot_wait( flag_name );
    ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15[ var_7755c399b0e4de3c ] );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x81c5ee5d, Offset: 0x2a5a
// Size: 0x22
function robot_wait( flag_name )
{
    self endon( #"robot_shutdown" );
    level utility::flag_wait( flag_name );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xd31fcb60, Offset: 0x2a84
// Size: 0x73
function function_39e414cb1157c478( ent, flag_name )
{
    if ( !isdefined( self.var_8029d4363972e15 ) )
    {
        self.var_8029d4363972e15 = [];
    }
    
    var_7755c399b0e4de3c = self.var_8029d4363972e15.size;
    self.var_8029d4363972e15[ var_7755c399b0e4de3c ] = ob_story_mission_utils::function_804834359f20ef5a( ent );
    level utility::flag_wait( flag_name );
    ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15[ var_7755c399b0e4de3c ] );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xec2a8096, Offset: 0x2aff
// Size: 0x64
function function_eed67ae4eff902e7( var_dc6a4b4b351da087, flag_name )
{
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    self.breadcrumb_obj = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 8 );
    level utility::flag_wait( flag_name );
    ob_story_mission_utils::objective_marker_clear( self.breadcrumb_obj );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x1e60c2a2, Offset: 0x2b6b
// Size: 0x5c
function function_ff8dc9bcbccc8557( flag_encounter, encounter_name )
{
    utility::flag_wait( flag_encounter );
    
    /#
        iprintlnbold( "<dev string:x2a>" );
    #/
    
    encounter_targetname = encounter_name;
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( request_id, 1 );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x3714941f, Offset: 0x2bcf
// Size: 0x63
function function_d93f34b367f44d1d( flag_encounter, encounter_name )
{
    if ( isdefined( flag_encounter ) )
    {
        level utility::flag_wait( flag_encounter );
    }
    
    /#
        iprintlnbold( "<dev string:x2a>" );
    #/
    
    encounter_targetname = encounter_name;
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( request_id, 1 );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xdf30ee48, Offset: 0x2c3a
// Size: 0xd7
function function_46e2bf5e03bae81e( struct, flag_name )
{
    var_44bb5e2d2f5251d7 = spawnstruct();
    var_44bb5e2d2f5251d7.origin = struct.origin;
    var_44bb5e2d2f5251d7.angles = struct.angles;
    var_44bb5e2d2f5251d7.health = 4000;
    var_44bb5e2d2f5251d7.maxhealth = 4000;
    var_44bb5e2d2f5251d7.weaponinfo = "sat_quadtank_turret";
    var_44bb5e2d2f5251d7.modelbaseground = "veh_sat_mil_drone_quadtank_blockout";
    turret = ob_soldier_util::ob_sentry_turret_spawn( var_44bb5e2d2f5251d7 );
    
    if ( isdefined( flag_name ) )
    {
        turret thread function_594e39c36cfec0f9( flag_name );
    }
    
    offset = ( 0, 0, 128 );
    thread function_144604a50795e58f( var_44bb5e2d2f5251d7, flag_name, offset );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x106c4ecc, Offset: 0x2d19
// Size: 0x23
function function_594e39c36cfec0f9( flag_name )
{
    self waittill( #"death" );
    level utility::flag_set( flag_name );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xa2606080, Offset: 0x2d44
// Size: 0x3e
function function_4691a6627babd3a( var_571de51250f2e341, var_9043d4f329045aed )
{
    ent = spawn( "script_model", var_9043d4f329045aed );
    ent setmodel( var_571de51250f2e341 );
    ent setcandamage( 0 );
    return ent;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x1a1cf8e3, Offset: 0x2d8b
// Size: 0x8e
function jet_flight_path( s_start_path )
{
    self.origin = s_start_path.origin;
    self.angles = s_start_path.angles;
    n_random_speed = randomintrange( 2, 3 );
    s_end_path_struct = utility::getstruct( s_start_path.target, "targetname" );
    self moveto( s_end_path_struct.origin, n_random_speed );
    self waittill( #"movedone" );
    self delete();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x4925163b, Offset: 0x2e21
// Size: 0x8e
function drone_flight_path( s_start_path )
{
    self.origin = s_start_path.origin;
    self.angles = s_start_path.angles;
    n_random_speed = randomintrange( 14, 15 );
    s_end_path_struct = utility::getstruct( s_start_path.target, "targetname" );
    self moveto( s_end_path_struct.origin, n_random_speed );
    self waittill( #"movedone" );
    self delete();
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x9efa99e8, Offset: 0x2eb7
// Size: 0xe5
function spawn_dawgs( var_5a2d888ab5e604d8, usage_mode )
{
    a_ai_dawgs = [];
    var_263285fff9e45a22 = utility::getstructarray( var_5a2d888ab5e604d8 );
    
    foreach ( struct in var_263285fff9e45a22 )
    {
        dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", struct.origin, struct.angles, "team_hundred_ninety" );
        a_ai_dawgs = arraycombineunique( a_ai_dawgs, [ dawg ] );
        dawg thread function_a2a93a5c24206854();
    }
    
    return a_ai_dawgs;
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xe5d97536, Offset: 0x2fa5
// Size: 0x5c
function function_a2a93a5c24206854()
{
    self endon( #"death" );
    waitframe();
    owner = utility::spawn_tag_origin( self.origin, self.angles );
    owner.team = self.team;
    self.spawned_tag_origin = owner;
    dawg::dawgpostinit( owner );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x81a9e692, Offset: 0x3009
// Size: 0xd3
function function_6d6d770fb4abded1( str_soldier_name )
{
    a_ai_soldier = [];
    var_711b0ea9c47a7f59 = utility::getstructarray( str_soldier_name );
    
    foreach ( struct in var_711b0ea9c47a7f59 )
    {
        var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_short", struct.origin, struct.angles, "team_hundred_ninety" );
        a_ai_soldier = arraycombineunique( a_ai_soldier, [ var_d937a8ac809622d5 ] );
    }
    
    return a_ai_soldier;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x552d5430, Offset: 0x30e5
// Size: 0xd3
function function_c73c9e2be27951cf( var_9958d11062737a54 )
{
    a_ai_juggernaut = [];
    var_6800f375518e1ff7 = utility::getstructarray( var_9958d11062737a54 );
    
    foreach ( struct in var_6800f375518e1ff7 )
    {
        ai_juggernaut = mp_agent::spawnnewagentaitype( "sat_ob_enemy_hvt_jugg_minigun", struct.origin, struct.angles, "team_hundred_ninety" );
        a_ai_juggernaut = arraycombineunique( a_ai_juggernaut, [ ai_juggernaut ] );
    }
    
    return a_ai_juggernaut;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x7e9f11a9, Offset: 0x31c1
// Size: 0xd3
function spawn_snipers( var_b669615e45e2d6c1 )
{
    a_ai_snipers = [];
    var_2d1a421e8ab186fb = utility::getstructarray( var_b669615e45e2d6c1 );
    
    foreach ( struct in var_2d1a421e8ab186fb )
    {
        var_4bfb5ab41950eff6 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_specialist_sniper", struct.origin, struct.angles, "team_hundred_ninety" );
        a_ai_snipers = arraycombineunique( a_ai_snipers, [ var_4bfb5ab41950eff6 ] );
    }
    
    return a_ai_snipers;
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xa5ccb6f7, Offset: 0x329d
// Size: 0x10e
function spawn_rushers( var_2baf63342644c847, goal, flag_name = "flag_virgo_harper_boss_3" )
{
    var_447b2312f33dfc9 = utility::getstructarray( var_2baf63342644c847 );
    
    foreach ( struct in var_447b2312f33dfc9 )
    {
        playfx( level._effect[ "enemy_vanish" ], struct.origin );
        var_7a0c319cd6b6599b = mp_agent::spawnnewagentaitype( "sat_ob_enemy_specialist_rusher", struct.origin, struct.angles, "team_hundred_ninety" );
        var_7a0c319cd6b6599b setgoalpos( goal, 128 );
        
        if ( isdefined( flag_name ) )
        {
            var_7a0c319cd6b6599b thread rusher_cleanup( flag_name );
        }
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xa45bc397, Offset: 0x33b3
// Size: 0x50
function rusher_cleanup( flag_name )
{
    self endon( #"death" );
    level utility::flag_wait( flag_name );
    wait randomfloatrange( 0, 0.25 );
    playfx( level._effect[ "enemy_vanish" ], self.origin );
    self kill();
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x7b0d3319, Offset: 0x340b
// Size: 0xb5
function spawn_juggerbots( var_e3f9bd1dd3e18f7f, count )
{
    var_54d41dbf5903a277 = [];
    var_adae4bc24d47644a = utility::getstructarray( var_e3f9bd1dd3e18f7f );
    
    for ( i = 0; i < count ; i++ )
    {
        playfx( level._effect[ "enemy_vanish" ], var_adae4bc24d47644a[ i ].origin );
        jugg = mp_agent::spawnnewagentaitype( "sat_juggerbot", var_adae4bc24d47644a[ i ].origin, var_adae4bc24d47644a[ i ].angles, "team_hundred_ninety" );
        var_54d41dbf5903a277 = arraycombineunique( var_54d41dbf5903a277, [ jugg ] );
    }
    
    return var_54d41dbf5903a277;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xa98383fd, Offset: 0x34c9
// Size: 0x47
function function_2987bea0e44c9a52( struct )
{
    minion = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_short", struct.origin, struct.angles, "team_hundred_ninety" );
    minion invisiblenotsolid();
    return minion;
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xf05aae7c, Offset: 0x3519
// Size: 0xb5
function init_hide_and_show_models()
{
    sm_destroyed_ambulance_echo = getent( "sm_destroyed_ambulance_echo", "targetname" );
    
    if ( isdefined( sm_destroyed_ambulance_echo ) )
    {
        sm_destroyed_ambulance_echo hide();
    }
    
    a_memory_jump_models = getentarray( "memory_jump_models", "script_noteworthy" );
    
    foreach ( var_d003efdbfd294720 in a_memory_jump_models )
    {
        if ( isdefined( var_d003efdbfd294720 ) )
        {
            var_d003efdbfd294720 hide();
        }
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xb0c91241, Offset: 0x35d6
// Size: 0x2
function init_vehicles()
{
    
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xf18e85c2, Offset: 0x35e0
// Size: 0x17f
function function_e68ea7f6b97ccd83( stop_flag )
{
    utility::flag_wait( "toma_strike_initialized" );
    var_28ed962522598df3 = toma_strike::function_2828cb52fc7c81ef();
    toma_strike::init_toma_strike_params( var_28ed962522598df3 );
    level.toma_weapon_name = "toma_proj_sat_ob_virgo";
    level.var_d2057eb693bfdb83 = "ks_toma_strike_cluster_sat_ob_virgo";
    num_shots = 5;
    
    if ( level utility::flag( stop_flag ) )
    {
        return;
    }
    
    if ( level utility::flag( "flag_stun_harper" ) )
    {
        return;
    }
    
    struct = utility::getstruct( "struct_fake_agent", "targetname" );
    
    if ( !isdefined( level.wizard ) )
    {
        level.wizard = function_2987bea0e44c9a52( struct );
    }
    
    owner = level.wizard;
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "evt_plr_incoming_cradle_attack_01", player.origin + ( 0, 0, 600 ) );
        level thread utility::play_sound_in_space( "maaws_reticle_locked", player.origin );
        level thread scriptedtomastrike( owner, player, num_shots, 64, 256 );
    }
}

// Namespace ob_virgo_util
// Params 5
// Checksum 0x9f703191, Offset: 0x3767
// Size: 0x19f
function scriptedtomastrike( owner, player, var_5b98b9c4e91a8ec0 = 1, var_e04b8226e0fedca3 = 0, var_b5342819efc54845 = 64 )
{
    owner endon( #"death" );
    streakname = "toma_strike";
    striketype = 1;
    streakinfo = killstreak_utility::createstreakinfo( streakname, owner );
    var_147ece74855f6277 = ( 0, 0, 0 );
    ownerforward = ( 0, 0, 0 );
    ownerright = ( 0, 0, 0 );
    origin = player.origin;
    
    if ( var_e04b8226e0fedca3 )
    {
        origin = player.origin + ( randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), randomfloatrange( -1 * var_e04b8226e0fedca3, var_e04b8226e0fedca3 ), 0 );
    }
    
    level thread function_ba77161cc021d53e( origin + ( 0, 0, 8 ), ( 0, 0, 0 ), 4 );
    killstreak_utility::killstreak_dangernotifyplayersinrange( owner, owner.team, 1024, streakname, origin );
    
    for ( j = 0; j < var_5b98b9c4e91a8ec0 ; j++ )
    {
        var_4d99e8552caf305a = owner toma_strike::findunobstructedfiringinfo( origin, var_b5342819efc54845, var_147ece74855f6277, ownerforward, ownerright );
        owner thread toma_strike::tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
        wait randomfloatrange( 0.25, 0.5 );
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x32bd5c9a, Offset: 0x390e
// Size: 0x91
function function_ba77161cc021d53e( origin, angles, duration )
{
    if ( level utility::flag( "flag_virgo_harper_boss_3" ) )
    {
        return;
    }
    
    tag = level utility::function_1808878d1c511ce8( origin, angles );
    waitframe();
    playfxontag( level._effect[ "harper_killstreak" ], tag, "tag_origin" );
    level utility::flag_wait_or_timeout( "flag_virgo_harper_boss_3", duration );
    stopfxontag( level._effect[ "harper_killstreak" ], tag, "tag_origin" );
    tag delete();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x1e1a2c73, Offset: 0x39a7
// Size: 0x122
function dropsupplies( var_cc8021337dce0be5 = 2 )
{
    wait 4;
    
    while ( var_cc8021337dce0be5 > 0 )
    {
        foreach ( player in level.players )
        {
            while ( isalive( player ) && player killstreak_utility::is_using_killstreak( 1 ) )
            {
                wait 1;
            }
            
            if ( isalive( player ) )
            {
                var_cc8021337dce0be5--;
                spawnpoint = player.origin + anglestoforward( player.angles ) * 512 + ( 0, 0, 500 );
                crate = airdrop::dropkillstreakcrate( player, "allies", "airdrop", spawnpoint, ( 0, randomint( 360 ), 0 ), spawnpoint );
                break;
            }
        }
        
        wait 20;
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xcda7e026, Offset: 0x3ad1
// Size: 0x202
function supply_drop_1( var_dc6a4b4b351da087, var_46f1327fcd04fb1e )
{
    if ( isdefined( var_46f1327fcd04fb1e ) )
    {
        level utility::flag_wait( var_46f1327fcd04fb1e );
    }
    
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    player = level.players[ 0 ];
    spawn_point = struct.origin + ( 0, 0, 1000 );
    spawn_items = [ %"hash_35298bd2d2aff71f", %"hash_530e8de563ad2546", %"hash_2ddcc6f3a52fa283" ];
    
    switch ( level.players.size )
    {
        case 1:
            break;
        case 2:
            break;
        case 3:
            spawn_items[ spawn_items.size ] = %"hash_35298bd2d2aff71f";
            spawn_items[ spawn_items.size ] = %"hash_530e8de563ad2546";
            break;
        case 4:
            spawn_items[ spawn_items.size ] = %"hash_35298bd2d2aff71f";
            spawn_items[ spawn_items.size ] = %"hash_530e8de563ad2546";
            spawn_items[ spawn_items.size ] = %"hash_2ddcc6f3a52fa283";
            spawn_items[ spawn_items.size ] = %"hash_2ddcc6f3a52fa283";
            break;
        default:
            break;
    }
    
    crate = ob_story_mission_utils::function_53ca684fc4aa8af3( player, spawn_point, spawn_items, 1, 0, 1 );
    crate hudoutlineenable( "outline_depth_purple" );
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "mp_arms_new_objective", player.origin );
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xb10e22bb, Offset: 0x3cdb
// Size: 0x204
function supply_drop_2( var_dc6a4b4b351da087, var_46f1327fcd04fb1e )
{
    if ( isdefined( var_46f1327fcd04fb1e ) )
    {
        level utility::flag_wait( var_46f1327fcd04fb1e );
    }
    
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    player = level.players[ 0 ];
    spawn_point = struct.origin + ( 0, 0, 1000 );
    spawn_items = [ %"hash_35298bd2d2aff71f", %"hash_1f9d4339f18de3bd" ];
    
    switch ( level.players.size )
    {
        case 1:
            break;
        case 2:
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            break;
        case 3:
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            break;
        case 4:
            spawn_items[ spawn_items.size ] = %"hash_35298bd2d2aff71f";
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            spawn_items[ spawn_items.size ] = %"hash_1f9d4339f18de3bd";
            break;
        default:
            break;
    }
    
    crate = ob_story_mission_utils::function_53ca684fc4aa8af3( player, spawn_point, spawn_items, 1, 0, 1 );
    crate hudoutlineenable( "outline_depth_purple" );
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "mp_arms_new_objective", player.origin );
    }
}

/#

    // Namespace ob_virgo_util
    // Params 0
    // Checksum 0xd6d869a2, Offset: 0x3ee7
    // Size: 0x5, Type: dev
    function function_a99d13af2370eddb()
    {
        
    }

#/

// Namespace ob_virgo_util
// Params 2
// Checksum 0xd20fe211, Offset: 0x3ef4
// Size: 0x21
function item_spawn_weapon( struct_targetname, var_b60496d5b429ae0f )
{
    thread ob_story_mission_utils::item_spawn_weapon( struct_targetname, var_b60496d5b429ae0f, 1 );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xd20fe211, Offset: 0x3f1d
// Size: 0x21
function item_spawn_equipment( struct_targetname, var_b60496d5b429ae0f )
{
    thread ob_story_mission_utils::item_spawn_equipment( struct_targetname, var_b60496d5b429ae0f, 1 );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x87460c16, Offset: 0x3f46
// Size: 0x6a
function function_3101add945789597( origin )
{
    itembundle = getscriptbundle( "itemspawnentry:" + level._ammopouch_info.ammopouchitem );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin );
    spawnoptions.spawningent = self;
    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x1d598d4d, Offset: 0x3fb8
// Size: 0xf
function function_3af329f7a69f7b06()
{
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "trig_fail_falls" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x187bfdce, Offset: 0x3fcf
// Size: 0x2c
function function_e38df884ac672c35()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        function_4050ce12d85a804e( player );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x7a58acd, Offset: 0x4003
// Size: 0xb8
function function_4050ce12d85a804e( player )
{
    level endon( #"hash_f72ef04e6918916a" );
    
    /#
        iprintlnbold( "<dev string:x44>" );
    #/
    
    wait_time = 0.25;
    player hud_util::fade_out( wait_time, "white" );
    player freezecontrols( 1 );
    wait wait_time;
    s_teleport_ref = utility::getstruct( self.target, "targetname" );
    player dontinterpolate();
    player setorigin( s_teleport_ref.origin, 1 );
    player setplayerangles( s_teleport_ref.angles, 1 );
    wait wait_time;
    player freezecontrols( 0 );
    player hud_util::fade_in( wait_time, "white" );
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x3ea7c847, Offset: 0x40c3
// Size: 0xd6
function function_4408fb951c105cb4( trigger_targetname, var_4cc0d6c492112ce5, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended" );
    var_5cba3aa7cba1a93c = getentarray( trigger_targetname, #targetname );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        var_5cba3aa7cba1a93c = getnoentvolumearray( trigger_targetname, #targetname );
        
        if ( !isdefined( var_5cba3aa7cba1a93c[ 0 ] ) )
        {
            /#
                iprintlnbold( "<dev string:x68>" + trigger_targetname );
            #/
            
            return;
        }
    }
    
    var_f8178163be04ed2 = spawnstruct();
    var_f8178163be04ed2.var_66983e9b7f1e4f98 = var_66983e9b7f1e4f98;
    thread utility::array_thread( var_5cba3aa7cba1a93c, &_trigger_wait_proc, var_f8178163be04ed2 );
    var_f8178163be04ed2 waittill( #"player_trigger", player );
    
    if ( isdefined( var_4cc0d6c492112ce5 ) )
    {
        level utility::flag_set( var_4cc0d6c492112ce5 );
    }
    
    return player;
}

// Namespace ob_virgo_util
// Params 1, eflags: 0x4
// Checksum 0xdf94eefc, Offset: 0x41a2
// Size: 0x71
function private _trigger_wait_proc( var_f8178163be04ed2 )
{
    while ( true )
    {
        self waittill( #"trigger", data );
        
        if ( var_f8178163be04ed2.var_66983e9b7f1e4f98 )
        {
            if ( isplayer( data ) && !isbot( data ) )
            {
                break;
            }
        }
        else if ( isplayer( data ) )
        {
            break;
        }
        
        waitframe();
    }
    
    var_f8178163be04ed2 notify( #"player_trigger", data );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xa507b2cf, Offset: 0x421b
// Size: 0x2c
function function_ac8a27a537d8ac9c( params )
{
    level endon( #"game_ended" );
    self skydive_setbasejumpingstatus( 0 );
    self skydive_setdeploymentstatus( 0 );
    self skydive_autodeployoff();
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x1d5e99d, Offset: 0x424f
// Size: 0x46
function function_a966881c39aa6bad( point, type )
{
    special = mp_agent::spawnnewagentaitype( type, point.origin, point.angles, "team_hundred_ninety" );
    return special;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xbeb770e0, Offset: 0x429e
// Size: 0x4e
function function_7ee93ae119e3f312( var_490060d47d9e122a )
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    connection_puzzle::init_from_layout( asset, var_490060d47d9e122a, var_490060d47d9e122a, 0, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    level.connection_puzzle_asset = asset;
    level thread function_2e122204a2a9f941();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x32625267, Offset: 0x42f4
// Size: 0x1c0
function function_d7b66ae5a4715213( var_e9a2f811a2ae6be8 )
{
    vspeed = 100;
    node = utility::getstruct( var_e9a2f811a2ae6be8, "targetname" );
    spawnnode = spawnstruct();
    spawnnode.origin = node.origin;
    spawnnode.angles = node.angles;
    spawnnode.vehicletype = "veh_hover_warship_ob_phys";
    spawnnode.modelname = "veh_sat_mil_air_vtol_buzzard_ob";
    spawnnode.targetname = "japan_vtol";
    faildata = spawnstruct();
    vtol = vehicle_tracking::spawn_vehicle( spawnnode, faildata );
    vtol.var_d543261e69382d13 = 0;
    vtol.vehiclename = "veh_hover_warship_ob_phys";
    vtol.maxhealth = 1000;
    vtol.health = vtol.maxhealth;
    vtol.team = "team_hundred_ninety";
    vtol setvehicleteam( "team_hundred_ninety" );
    vehicle_tracking::register_instance( vtol, undefined, vtol.team );
    vtol vehicle_damage::set_can_damage( 1 );
    vtol.var_300686ebe3a78e39 = 1;
    vtol damage::set_death_callback( "veh_hover_warship_ob_phys", &function_b68424a3a74c409d );
    vtol function_d2b8ee2e1275daaf( 1 );
    vtol.exitnode = node;
    
    if ( vtol.var_d543261e69382d13 )
    {
        vtol addcomponent( "p2p" );
    }
    
    vtol vehicle_setspeed( vspeed / 2, vspeed / 4, vspeed / 4 );
    vtol setvehgoalpos( node.origin, 1 );
    return vtol;
}

// Namespace ob_virgo_util
// Params 1, eflags: 0x4
// Checksum 0xe1301d11, Offset: 0x44bd
// Size: 0x17, Type: bool
function private function_b68424a3a74c409d( data )
{
    thread handle_death_damage( data );
    return true;
}

// Namespace ob_virgo_util
// Params 1, eflags: 0x4
// Checksum 0xc59db976, Offset: 0x44dd
// Size: 0x29
function private handle_death_damage( data )
{
    vtol_crash( 150, data.objweapon );
    thread vtol_explode( data );
}

// Namespace ob_virgo_util
// Params 2, eflags: 0x4
// Checksum 0x2297fb07, Offset: 0x450e
// Size: 0xa5
function private vtol_crash( speed, weaponkilledby )
{
    self endon( #"explode" );
    self clearlookatent();
    self notify( #"crashing" );
    self setscriptablepartstate( #"hash_d5d1a8239e113123", #"on", 0 );
    self vehicle_setspeed( speed, 30, 60 );
    
    if ( !self.var_d543261e69382d13 )
    {
        self setmaxpitchroll( 10, 50 );
        self setneargoalnotifydist( 100 );
    }
    
    glassdamagestate = #"hash_8e017c8fa9c4eba5";
    self setscriptablepartstate( #"glass", glassdamagestate, 0 );
    vtol_explode();
}

// Namespace ob_virgo_util
// Params 1, eflags: 0x4
// Checksum 0x6b5bf0ea, Offset: 0x45bb
// Size: 0x9f
function private vtol_explode( data )
{
    self notify( #"explode" );
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_mp" );
    }
    
    self setscriptablepartstate( #"explode", #"on", 0 );
    self setscriptablepartstate( #"hash_30998a3c3fc2989c", #"on", 0 );
    wait 0.35;
    callback::callback( #"hash_5f04bed91965f0ec", data );
    delete_vtol();
}

// Namespace ob_virgo_util
// Params 0, eflags: 0x4
// Checksum 0xe2053d93, Offset: 0x4662
// Size: 0xb1
function private delete_vtol()
{
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        
        if ( isdefined( self.turret.firetarget ) )
        {
            self.turret.firetarget delete();
        }
    }
    
    if ( isdefined( self.var_795c9a23417e649c ) )
    {
        self.var_795c9a23417e649c setentityowner( undefined );
        self.var_795c9a23417e649c delete();
    }
    
    if ( isdefined( self.var_bf973a4d1cadadc9 ) )
    {
        self.var_bf973a4d1cadadc9 setentityowner( undefined );
        self.var_bf973a4d1cadadc9 delete();
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x74e8757e, Offset: 0x471b
// Size: 0xef
function function_56cb0e32a61e4863( super, var_ca908a6a83b8fb50 = "story_mission_party_check_complete", play_sound = 0 )
{
    if ( isdefined( var_ca908a6a83b8fb50 ) )
    {
        level utility::flag_wait( var_ca908a6a83b8fb50 );
    }
    
    level utility::flag_wait( "story_mission_party_check_complete" );
    
    foreach ( player in level.players )
    {
        player equipment_mp::giveequipment( "equip_super_teleport", "secondary" );
        
        if ( play_sound )
        {
            level thread utility::play_sound_in_space( "mp_arms_new_objective", player.origin );
        }
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xe7b60eb8, Offset: 0x4812
// Size: 0x88
function function_3f71b984669ccaa7()
{
    level utility::flag_wait( "story_mission_party_check_complete" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x14a0ec8b, Offset: 0x48a2
// Size: 0xcf
function ai_retreat( var_1d700db5b7348742 )
{
    self endon( #"death" );
    vol = getnoentvolumearray( var_1d700db5b7348742, #targetname )[ 0 ];
    
    if ( !isdefined( vol ) )
    {
        return;
    }
    
    wait randomfloatrange( 0.2, 0.5 );
    
    if ( utility::cointoss() )
    {
        val::set( "retreat", "ignoreall", 1 );
    }
    
    if ( utility::cointoss() )
    {
        self.sprint = 1;
        utility::demeanor_override( "sprint" );
    }
    
    self setgoalvolumeauto( vol );
    
    if ( val::get( "ignoreall" ) )
    {
        utility::waittill_notify_or_timeout( "goal", 5 );
        val::reset_all( "retreat" );
    }
    
    if ( isdefined( self.sprint ) )
    {
        utility::clear_demeanor_override();
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xd61f8721, Offset: 0x4979
// Size: 0x85
function function_6db88e9571f4e393()
{
    enemies = getaiarray( "team_hundred_ninety" );
    
    foreach ( guy in enemies )
    {
        guy kill();
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x6bf7340b, Offset: 0x4a06
// Size: 0x191
function function_259506da220dcdb2( startstruct, n_speed, var_3471cfda50727386 )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self freezecontrols( 1 );
    self disableweapons();
    current_pos = startstruct;
    hud_util::fade_out( 0.1, "white" );
    
    if ( !isdefined( var_3471cfda50727386 ) )
    {
        e_linkent = utility::function_1808878d1c511ce8( startstruct.origin );
        level.player playerlinkto( e_linkent, "tag_origin", 1, 45, 45, 30, 30 );
    }
    else
    {
        e_linkent = utility::function_1808878d1c511ce8( startstruct.origin );
        level.player playerlinkto( e_linkent, "tag_origin", 1 );
    }
    
    wait 0.1;
    hud_util::fade_in( 0.1, "white" );
    
    while ( isdefined( current_pos.target ) )
    {
        var_f370b69d0d8846ba = utility::getstruct( current_pos.target, "targetname" );
        
        if ( !isdefined( var_f370b69d0d8846ba ) )
        {
            break;
        }
        
        traveltime = distance( current_pos.origin, var_f370b69d0d8846ba.origin ) / n_speed;
        e_linkent moveto( var_f370b69d0d8846ba.origin, traveltime, 0 );
        wait traveltime;
        current_pos = var_f370b69d0d8846ba;
    }
    
    self freezecontrols( 0 );
    self enableweapons();
    self unlink();
    
    if ( isdefined( level.playersjumped ) )
    {
        level.playersjumped++;
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x1e14bf31, Offset: 0x4b9f
// Size: 0x20c
function virgo_effects()
{
    if ( !isdefined( level._effect ) )
    {
        level._effect = [];
    }
    
    level._effect[ "enemy_death_cleanup" ] = loadfxasset( "vfx_sat_wc_ai_cradle_soldier_death_01" );
    level._effect[ "harper_killstreak" ] = loadfxasset( "vfx_sat_wc_vgo_boss_attack_target_01" );
    level._effect[ "enemy_vanish" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    level._effect[ "harper_slam" ] = loadfxasset( "vfx_sat_wc_vgo_boss_hand_aoe_ring_01" );
    level._effect[ "harper_missile_trail" ] = loadfxasset( "vfx_sat_wc_vgo_crr_boss_attack_mouth_projectile_trail" );
    level._effect[ "blinking_red" ] = loadfxasset( "vfx_sat_drone_blinking_light_red" );
    level._effect[ "harper_impact" ] = loadfxasset( "vfx_sat_wc_vgo_crr_boss_dmg_impact_01" );
    level._effect[ "harper_bubble_impact" ] = loadfxasset( "vfx_sat_wc_vgo_crr_boss_dmg_impact_02" );
    level._effect[ "harper_fatal_impact" ] = loadfxasset( "vfx_sat_wc_vgo_crr_boss_dmg_impact_03" );
    level._effect[ "echo_burst" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_burst_01" );
    level._effect[ "body_fx_head" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_head_01" );
    level._effect[ "body_fx_torso" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_torso_01" );
    level._effect[ "body_fx_arms" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_arm_01" );
    level._effect[ "body_fx_leg" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_leg_01" );
    level._effect[ "body_fx_foot" ] = loadfxasset( "vfx_sat_wc_vgo_echo_chr_foot_01" );
    level._effect[ "frogger_bike_trail" ] = loadfxasset( "vfx_sat_wc_vgo_pkr_cradle_bike_trail_1" );
    level._effect[ "frogger_bike_spawn" ] = loadfxasset( "vfx_sat_wc_vgo_pkr_cradle_bike_spawn_1" );
    level._effect[ "frogger_veh_trail" ] = loadfxasset( "vfx_sat_wc_vgo_pkr_cradle_car_trail_1" );
    level._effect[ "frogger_veh_spawn" ] = loadfxasset( "vfx_sat_wc_vgo_pkr_cradle_car_spawn_1" );
    level._effect[ "cradle_bamf" ] = loadfxasset( "vfx_sat_wc_vgo_cradle_warp_portal_char_bamf" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x495412c9, Offset: 0x4db3
// Size: 0x1c5
function function_29164af2d4d89658()
{
    waitframe();
    ent_names = [];
    ent_names[ ent_names.size ] = "Civ1";
    ent_names[ ent_names.size ] = "Civ2";
    ent_names[ ent_names.size ] = "Civ3";
    ent_names[ ent_names.size ] = "Civ4";
    ent_names[ ent_names.size ] = "Civ5";
    ent_names[ ent_names.size ] = "Civ6";
    ent_names[ ent_names.size ] = "Crashsite_Civ1";
    ent_names[ ent_names.size ] = "Crashsite_Civ2";
    ent_names[ ent_names.size ] = "Crashsite_Civ3";
    ent_names[ ent_names.size ] = "echo_harper";
    ent_names[ ent_names.size ] = "echo_president";
    ent_names[ ent_names.size ] = "echo_samuels";
    ent_names[ ent_names.size ] = "echo_soldier";
    ent_names[ ent_names.size ] = "Figure1_Harper";
    ent_names[ ent_names.size ] = "Figure2_Samuels";
    ent_names[ ent_names.size ] = "Figure3_President";
    ent_names[ ent_names.size ] = "Figure4_Escort";
    ent_names[ ent_names.size ] = "Player";
    ent_names[ ent_names.size ] = "fiftyfifty";
    ent_names[ ent_names.size ] = "lamarck";
    ent_names[ ent_names.size ] = "soldier01";
    ent_names[ ent_names.size ] = "soldier03";
    ent_names[ ent_names.size ] = "civ01";
    ent_names[ ent_names.size ] = "civ02";
    ent_names[ ent_names.size ] = "civ";
    ent_names[ ent_names.size ] = "cop";
    ent_names[ ent_names.size ] = "medic";
    
    foreach ( name in ent_names )
    {
        ent = scene::get_entity( name );
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        ent thread function_357b1006de18716b();
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xac7cf003, Offset: 0x4f80
// Size: 0x11a
function function_357b1006de18716b()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"body_fx_end" );
    
    /#
        iprintln( "<dev string:x8b>" );
    #/
    
    self waittill( #"echo_start" );
    playfxontag( level._effect[ "body_fx_head" ], self, "j_head" );
    playfxontag( level._effect[ "body_fx_torso" ], self, "j_spinelower" );
    waitframe();
    playfxontag( level._effect[ "body_fx_arms" ], self, "j_elbow_ri" );
    playfxontag( level._effect[ "body_fx_arms" ], self, "j_elbow_le" );
    waitframe();
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_ri" );
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_le" );
    waitframe();
    playfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_ri" );
    playfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_le" );
    thread function_b5f25c1a6f9a7b0f();
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xcd5df3d8, Offset: 0x50a2
// Size: 0x106
function function_b5f25c1a6f9a7b0f()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"body_fx_end" );
    self waittill( #"echo_stop" );
    stopfxontag( level._effect[ "body_fx_head" ], self, "j_head" );
    stopfxontag( level._effect[ "body_fx_torso" ], self, "j_spinelower" );
    waitframe();
    stopfxontag( level._effect[ "body_fx_arms" ], self, "j_elbow_ri" );
    stopfxontag( level._effect[ "body_fx_arms" ], self, "j_elbow_le" );
    waitframe();
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_ri" );
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_le" );
    waitframe();
    stopfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_ri" );
    stopfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_le" );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xa2094b3, Offset: 0x51b0
// Size: 0x178
function function_88d17055dbbf5a84( wakeup_flag, delay = 0 )
{
    self endon( #"death" );
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_elbow_ri" );
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_elbow_le" );
    waitframe();
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_ri" );
    playfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_le" );
    waitframe();
    playfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_ri" );
    playfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_le" );
    level utility::flag_wait( wakeup_flag );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_elbow_ri" );
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_elbow_le" );
    waitframe();
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_ri" );
    stopfxontag( level._effect[ "body_fx_leg" ], self, "j_knee_le" );
    waitframe();
    stopfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_ri" );
    stopfxontag( level._effect[ "body_fx_foot" ], self, "j_ankle_le" );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x819ed560, Offset: 0x5330
// Size: 0x108
function function_5d37d49bdad4eadd( var_6f179ea8bc574e4b, harper_point )
{
    self notify( #"hash_dff0fd999c383f1d" );
    self endon( #"hash_dff0fd999c383f1d" );
    
    if ( !isdefined( var_6f179ea8bc574e4b ) )
    {
        var_6f179ea8bc574e4b = [ { #origin:( 38500, 28400, -70 ) }, { #origin:( 39500, 30700, -70 ) }, { #origin:( 39000, 32500, -70 ) }, { #origin:( 39500, 30700, -70 ) } ];
    }
    
    if ( !isdefined( harper_point ) )
    {
        harper_point = ( 37500, 31250, -70 );
    }
    
    radius = clamp( distance( var_6f179ea8bc574e4b[ 0 ].origin, harper_point ), 512, 4096 );
    circle = function_52654c12f38e0189( var_6f179ea8bc574e4b[ 0 ].origin, radius );
    circle thread function_41b171fd1a9d480a( var_6f179ea8bc574e4b, harper_point );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xd1befa70, Offset: 0x5440
// Size: 0x1ce
function function_41b171fd1a9d480a( struct_array, contain_point )
{
    curr_point = 0;
    var_4a3a6d08bb28242d = 1200;
    var_4a3a6d08bb28242d = 4096;
    max_radius = 8096;
    
    while ( !level utility::flag( "flag_virgo_harper_boss_3" ) )
    {
        dist = distance( struct_array[ curr_point % struct_array.size ].origin, struct_array[ ( curr_point + 1 ) % struct_array.size ].origin );
        time = dist / 120;
        iter = int( time / 2 );
        move_frac = 1 / iter;
        
        for ( i = 1; i <= iter ; i++ )
        {
            moveto = vectorlerp( struct_array[ curr_point % struct_array.size ].origin, struct_array[ ( curr_point + 1 ) % struct_array.size ].origin, move_frac * i );
            
            if ( isvector( contain_point ) )
            {
                radius = clamp( distance( moveto, contain_point ), 512, 4096 );
            }
            else
            {
                radius = var_4a3a6d08bb28242d;
            }
            
            self brcirclemoveto( moveto[ 0 ], moveto[ 1 ], radius, 2 );
            level thread update_minimap_circle( self, self.origin, moveto, var_4a3a6d08bb28242d, radius, 2 );
            
            if ( isdefined( self.mapcircle ) )
            {
                game_utility::questcircle_move( moveto );
                game_utility::function_d46d8731ed9d281( radius );
            }
            
            wait 2;
        }
        
        curr_point++;
    }
    
    level notify( #"hash_4c3ae759ed22e567" );
    
    if ( isdefined( level.var_f7af54e3a4e17c28.mapcircle ) )
    {
        level.var_f7af54e3a4e17c28 game_utility::questcircle_delete();
    }
    
    level.var_f7af54e3a4e17c28 delete();
    level.var_f7af54e3a4e17c28 = undefined;
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x7ded52a9, Offset: 0x5616
// Size: 0xd4
function function_8a4b5830e567ba87( current_struct )
{
    harper_point = utility::getstruct( "harper_point", "targetname" );
    radius = 6000;
    circle_move_time = 10;
    var_556c8b233a9cc422 = radius;
    circle = function_52654c12f38e0189( current_struct.origin, radius );
    wait circle_move_time;
    circle thread function_762c6014a6a892c8( current_struct, harper_point, radius, circle_move_time, var_556c8b233a9cc422 );
    level utility::flag_wait( "flag_virgo_harper_boss_3" );
    level notify( #"hash_4c3ae759ed22e567" );
    
    if ( isdefined( level.var_f7af54e3a4e17c28.mapcircle ) )
    {
        level.var_f7af54e3a4e17c28 game_utility::questcircle_delete();
    }
    
    level.var_f7af54e3a4e17c28 delete();
    level.var_f7af54e3a4e17c28 = undefined;
}

// Namespace ob_virgo_util
// Params 5
// Checksum 0x84576128, Offset: 0x56f2
// Size: 0xec
function function_762c6014a6a892c8( current_struct, harper_point, radius, circle_move_time, var_556c8b233a9cc422 )
{
    level endon( #"hash_4c3ae759ed22e567" );
    circle = self;
    
    while ( !level utility::flag( "flag_virgo_harper_boss_3" ) )
    {
        next_struct = utility::getstruct( current_struct.target, "targetname" );
        radius = distance( next_struct.origin, harper_point.origin );
        circle brcirclemoveto( next_struct.origin[ 0 ], next_struct.origin[ 1 ], radius, circle_move_time );
        level thread update_minimap_circle( circle, current_struct.origin, next_struct.origin, var_556c8b233a9cc422, radius, circle_move_time );
        wait circle_move_time;
        var_556c8b233a9cc422 = radius;
        current_struct = next_struct;
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xb13f3c0c, Offset: 0x57e6
// Size: 0x149
function f( circle, includepoint )
{
    wait 1;
    
    while ( !isplayer( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    player = level.players[ 0 ];
    
    for ( iter = 0; !level utility::flag( "flag_virgo_harper_boss_3" ) ; iter++ )
    {
        moveto = player.origin + ( randomfloatrange( 100, 512 ), randomfloatrange( 100, 512 ), 0 );
        
        if ( isdefined( includepoint ) )
        {
            radius = distance( moveto, includepoint );
        }
        else
        {
            radius = 1024 / ( iter % 2 + 1 ) * ( level.players.size + 1 ) / 2;
        }
        
        circle brcirclemoveto( moveto[ 0 ], moveto[ 1 ], radius, 2 );
        
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_move( moveto );
            circle game_utility::function_d46d8731ed9d281( radius );
        }
        
        out = "Radius: " + radius;
        wait 2;
    }
    
    level notify( #"hash_4c3ae759ed22e567" );
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
    level.var_f7af54e3a4e17c28 = undefined;
}

// Namespace ob_virgo_util
// Params 4
// Checksum 0x66f62d60, Offset: 0x5937
// Size: 0xfe
function drone_circle_event( struct, radius = 2048, final_radius = 8, var_cf306bbdec90ce = 15 )
{
    level thread virgo_vo::br_circle_callout( undefined, "event_la_freeway_br_circle_1" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce / 2, "event_la_freeway_br_circle_2" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce, "event_la_freeway_br_circle_3" );
    circle = function_52654c12f38e0189( struct.origin, radius );
    circle brcirclemoveto( struct.origin[ 0 ], struct.origin[ 1 ], final_radius, var_cf306bbdec90ce );
    thread update_minimap_circle( circle, struct.origin, undefined, radius, final_radius, var_cf306bbdec90ce );
    wait var_cf306bbdec90ce;
    level utility::flag_set( "flag_drone_circle_closed" );
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
}

// Namespace ob_virgo_util
// Params 4
// Checksum 0x685245e1, Offset: 0x5a3d
// Size: 0x2dc
function function_ff8219359b61ca66( struct, radius = 2048, final_radius, var_cf306bbdec90ce = 15 )
{
    level thread virgo_vo::br_circle_callout( undefined, "event_la_freeway_br_circle_1" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce / 2, "event_la_freeway_br_circle_2" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce, "event_la_freeway_br_circle_3" );
    br_circle_position_01 = utility::getstruct( "br_circle_position_01", "targetname" );
    circle = function_52654c12f38e0189( br_circle_position_01.origin, 1500 );
    level utility::flag_wait( "flag_collapse_circle_01" );
    var_49849b1723fc777e = 1;
    var_8098e5fa64ce762c = 1500;
    circle brcirclemoveto( br_circle_position_01.origin[ 0 ], br_circle_position_01.origin[ 1 ], var_8098e5fa64ce762c, var_49849b1723fc777e );
    level thread update_minimap_circle( circle, br_circle_position_01.origin, br_circle_position_01.origin, radius, var_8098e5fa64ce762c, var_49849b1723fc777e );
    wait var_49849b1723fc777e;
    level utility::flag_wait( "flag_collapse_circle_02" );
    var_de9130f562309ca = 1;
    var_bab919f24c479d30 = 800;
    br_circle_position_02 = utility::getstruct( "br_circle_position_02", "targetname" );
    circle brcirclemoveto( br_circle_position_02.origin[ 0 ], br_circle_position_02.origin[ 1 ], var_bab919f24c479d30, var_de9130f562309ca );
    level thread update_minimap_circle( circle, br_circle_position_01.origin, br_circle_position_02.origin, var_8098e5fa64ce762c, var_bab919f24c479d30, var_de9130f562309ca );
    wait var_de9130f562309ca;
    level utility::flag_wait( "flag_collapse_circle_03" );
    var_a81e83a6da41844f = 15;
    var_24788fb83b3a2ac5 = 500;
    br_circle_position_03 = utility::getstruct( "br_circle_position_03", "targetname" );
    circle brcirclemoveto( br_circle_position_03.origin[ 0 ], br_circle_position_03.origin[ 1 ], var_24788fb83b3a2ac5, var_a81e83a6da41844f );
    level thread update_minimap_circle( circle, br_circle_position_02.origin, br_circle_position_03.origin, var_bab919f24c479d30, var_24788fb83b3a2ac5, var_a81e83a6da41844f );
    wait var_a81e83a6da41844f;
    var_3a52f4176b804144 = 15;
    var_39cde171a80fe45a = 0;
    br_circle_position_03 = utility::getstruct( "main_drone_interact", "targetname" );
    circle brcirclemoveto( br_circle_position_03.origin[ 0 ], br_circle_position_03.origin[ 1 ], var_39cde171a80fe45a, var_3a52f4176b804144 );
    level thread update_minimap_circle( circle, br_circle_position_03.origin, br_circle_position_03.origin, var_24788fb83b3a2ac5, 1, var_3a52f4176b804144 );
    wait var_3a52f4176b804144;
    level notify( #"hash_4c3ae759ed22e567" );
    level utility::flag_set( "flag_drone_circle_closed" );
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0x7d769013, Offset: 0x5d21
// Size: 0x120
function function_374a43deed4cfbf4( start_point, time, hold_time = 0, stop_flag, close_radius = 1024, delay )
{
    var_9a7b20e173174021 = 4096;
    var_af20df805aa22681 = 50;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    circle = function_52654c12f38e0189( start_point, var_9a7b20e173174021, var_af20df805aa22681 );
    circle brcirclemoveto( start_point[ 0 ], start_point[ 1 ], close_radius, time );
    level thread update_minimap_circle( circle, start_point, undefined, var_9a7b20e173174021, close_radius, time );
    struct = spawnstruct();
    struct.origin = start_point;
    thread function_144604a50795e58f( struct, stop_flag, ( 0, 0, 96 ) );
    level utility::flag_wait_any_timeout( time + hold_time, stop_flag, "flag_stun_harper" );
    level notify( #"hash_2ca212cd3fce0055" );
    level notify( #"hash_4c3ae759ed22e567" );
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0xb40653e5, Offset: 0x5e49
// Size: 0x183
function circle_event( struct, radius = 4096, final_radius = 400, var_cf306bbdec90ce = 20, hold_time = 30, var_817aca4f72906644 )
{
    level utility::flag_clear( "flag_circle_event_done" );
    thread function_144604a50795e58f( struct, "flag_circle_event_done", ( 0, 0, 96 ) );
    level thread virgo_vo::br_circle_callout( undefined, "event_carrier_br_circle_1" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce / 2, "event_carrier_br_circle_2" );
    level thread virgo_vo::br_circle_callout( var_cf306bbdec90ce, "event_carrier_br_circle_3" );
    circle = function_52654c12f38e0189( struct.origin, radius );
    circle brcirclemoveto( struct.origin[ 0 ], struct.origin[ 1 ], final_radius, var_cf306bbdec90ce );
    thread update_minimap_circle( circle, struct.origin, undefined, radius, final_radius, var_cf306bbdec90ce );
    wait var_cf306bbdec90ce;
    level utility::flag_wait_or_timeout( var_817aca4f72906644, hold_time );
    level notify( #"hash_4c3ae759ed22e567" );
    circle brcirclemoveto( struct.origin[ 0 ], struct.origin[ 1 ], 4096, 3 );
    level utility::flag_set( "flag_circle_event_done" );
    wait 3;
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xe6e60856, Offset: 0x5fd4
// Size: 0x11a
function function_52654c12f38e0189( v_origin, radius = 1024, var_af20df805aa22681 = 9 )
{
    level.var_f7af54e3a4e17c28 = spawnbrcircle( v_origin[ 0 ], v_origin[ 1 ], radius );
    level.var_f7af54e3a4e17c28 show();
    level.var_f7af54e3a4e17c28 game_utility::questcircle_create( "testCircle_cyan", v_origin, radius );
    level.var_f7af54e3a4e17c28 game_utility::questcircle_showtoall();
    level.ob_circle_damage_tick = var_af20df805aa22681;
    level.var_f7af54e3a4e17c28 thread circle_damage_tick();
    
    foreach ( player in level.players )
    {
        player thread function_bdea713c2a20721e();
    }
    
    return level.var_f7af54e3a4e17c28;
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x6cf2ecf5, Offset: 0x60f7
// Size: 0x3e
function function_bdea713c2a20721e()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"hash_5454b33220509c33" );
    thread hints::hint_add_simple( "virgo_hint_brcircle", &"sat_ob_story_missions/virgo_hint_harper_ring", 4 );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x55acb850, Offset: 0x613d
// Size: 0x52
function function_653179aadae80f96()
{
    if ( isdefined( level.var_f7af54e3a4e17c28 ) )
    {
        level notify( #"hash_4c3ae759ed22e567" );
        level.var_f7af54e3a4e17c28 hide( 1 );
        
        if ( isdefined( level.var_f7af54e3a4e17c28.mapcircle ) )
        {
            level.var_f7af54e3a4e17c28 game_utility::questcircle_hidefromall();
        }
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x11caf269, Offset: 0x6197
// Size: 0x54
function function_dc862777278cd3()
{
    if ( isdefined( level.var_f7af54e3a4e17c28 ) )
    {
        level.var_f7af54e3a4e17c28 show();
        level.var_f7af54e3a4e17c28 thread circle_damage_tick();
        
        if ( isdefined( level.var_f7af54e3a4e17c28.mapcircle ) )
        {
            level.var_f7af54e3a4e17c28 game_utility::questcircle_showtoall();
        }
    }
}

// Namespace ob_virgo_util
// Params 6
// Checksum 0x8f44fc35, Offset: 0x61f3
// Size: 0x12c
function update_minimap_circle( circle, start_pos, end_pos, var_9a7b20e173174021, var_86491b20c248f26, duration )
{
    assert( isdefined( circle.mapcircle ), "<dev string:x97>" );
    assert( var_86491b20c248f26 > 0, "<dev string:xe4>" );
    assert( var_9a7b20e173174021 > 0, "<dev string:xe4>" );
    circle.mapcircle endon( #"death" );
    circle endon( #"death" );
    start_time = gettime();
    end_time = gettime() + duration * 1000;
    
    while ( gettime() < end_time )
    {
        frac = math::lerp_fraction( start_time, end_time, gettime() );
        radius = math::lerp( var_9a7b20e173174021, var_86491b20c248f26, frac );
        
        if ( isdefined( start_pos ) && isdefined( end_pos ) )
        {
            pos = vectorlerp( start_pos, end_pos, frac );
            circle game_utility::questcircle_move( pos );
        }
        
        circle game_utility::function_d46d8731ed9d281( radius );
        wait 0.05;
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x65dd1033, Offset: 0x6327
// Size: 0x2c7
function circle_damage_tick()
{
    level endon( #"game_ended" );
    level endon( #"hash_4c3ae759ed22e567" );
    var_16fa12dd34d85976 = br_circle::function_60fec44444cbd5d2();
    
    while ( true )
    {
        if ( isdefined( level.var_f7af54e3a4e17c28 ) )
        {
            damagetick = level.ob_circle_damage_tick;
            
            if ( isdefined( level.circledamagemultiplier ) )
            {
                damagetick = int( damagetick * level.circledamagemultiplier );
            }
            
            if ( damagetick > 0 )
            {
                dangercircleorigin = level.var_f7af54e3a4e17c28.origin;
                dangercircleradius = level.var_f7af54e3a4e17c28.origin[ 2 ];
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    var_d3d5e207911ff294 = 0;
                    
                    if ( distance2dsquared( dangercircleorigin, player.origin ) > dangercircleradius * dangercircleradius )
                    {
                        if ( isalive( player ) )
                        {
                            var_d3d5e207911ff294 = 1;
                            player notify( #"hash_5454b33220509c33" );
                            
                            if ( !isdefined( player.var_2f8b6417bc00b4a0 ) )
                            {
                                player.var_2f8b6417bc00b4a0 = gettime();
                            }
                            
                            modifieddamagetick = player br_circle::function_eaac348121cbeb8c( var_16fa12dd34d85976, damagetick );
                            
                            if ( gasmask::hasgasmask( player ) )
                            {
                                if ( gasmask::function_e949a578c3db30d( player ) )
                                {
                                    if ( !player.gasmaskequipped )
                                    {
                                        player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                                else if ( player.gasmaskhealth <= 0 )
                                {
                                    player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    player br_pickups::function_5375ae93bfe708df();
                                    player br_pickups::function_219547e563ff9527();
                                }
                                else
                                {
                                    if ( isdefined( level.var_548004405d16dcf8 ) )
                                    {
                                        player [[ level.var_548004405d16dcf8 ]]( "aether_gas" );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                            }
                            else
                            {
                                player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                            }
                        }
                        else
                        {
                            player.var_2f8b6417bc00b4a0 = undefined;
                        }
                        
                        continue;
                    }
                    
                    player.var_2f8b6417bc00b4a0 = undefined;
                    
                    if ( gasmask::hasgasmask( player ) )
                    {
                        if ( gasmask::function_e949a578c3db30d( player ) )
                        {
                            continue;
                        }
                        
                        if ( player.gasmaskhealth <= 0 )
                        {
                            player playsoundtoplayer( "br_gas_mask_break_plr", player );
                            player br_pickups::function_5375ae93bfe708df();
                            continue;
                        }
                        
                        player br_pickups::gasmaskoff( "br_circle" );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xc3cc9dc6, Offset: 0x65f6
// Size: 0x3e
function function_ce81cd0a94fb3d8f( bink_name, flag_name, duration )
{
    coop::play_cinematic( bink_name, { #timeout:duration, #flag:flag_name } );
}

// Namespace ob_virgo_util
// Params 4
// Checksum 0xcd01307f, Offset: 0x663c
// Size: 0x164
function function_6c6cd04099ff6cfd( agent, struct, travel_time = 2, delay_time = 1 )
{
    agent endon( #"death" );
    wait delay_time;
    var_58d4f3750009cbbd = 1;
    start = agent.origin;
    end = struct.origin;
    tag = utility::function_1808878d1c511ce8( start, agent.angles );
    agent invisiblenotsolid();
    playfx( level._effect[ "enemy_vanish" ], start );
    playfxontag( level._effect[ "harper_missile_trail" ], tag, "tag_origin" );
    waitframe();
    agent forceteleport( end, agent.angles );
    tag moveto( start + ( 0, 0, 96 ), var_58d4f3750009cbbd, 0.5, 0.5 );
    wait var_58d4f3750009cbbd;
    tag moveto( end, travel_time, 0.5, 0.5 );
    wait travel_time;
    stopfxontag( level._effect[ "harper_missile_trail" ], tag, "tag_origin" );
    tag delete();
    playfx( level._effect[ "enemy_vanish" ], end );
    agent visiblesolid();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x2ebbb7f8, Offset: 0x67a8
// Size: 0xbb
function spawn_gdu( var_c15ee5e7aff347e6 )
{
    bundle = killstreak::function_85b2d8e857ab4898( "ground_drone_unit" );
    streakinfo = spawnstruct();
    streakinfo.owner = self;
    streakinfo.streakname = "ground_drone_unit";
    streakinfo.team = self.team;
    streakinfo.var_fc297c214692ba76 = 1;
    streakinfo.var_2cf65238266c20bc = 30;
    streakinfo.var_b60175dee49da226 = 30;
    streakinfo.bundle = bundle;
    ground_drone_unit_mp::function_bf849300daf6e7da( self, self.team, var_c15ee5e7aff347e6.origin, streakinfo, undefined );
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xc5100667, Offset: 0x686b
// Size: 0x24
function function_5012a6974dd80c0d( gdu )
{
    gdu.owner.spawnedgdus = 1;
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x2cb9913, Offset: 0x6897
// Size: 0x13d
function function_8099635f87b4d57c( flag_name = "flag_stop_bobbing", scalar = 1 )
{
    self endon( #"hash_fbdbfc8941ec04b0" );
    self endon( #"death" );
    ent_model = self;
    rotationangles = ( 5, 5, 5 );
    rotationangles *= scalar;
    zmove = 25 * scalar;
    ent_model.ogorigin = ent_model.origin;
    ent_model.var_4cb8ecc59af64ddc = ent_model.angles;
    
    while ( !level utility::flag( flag_name ) )
    {
        ent_model rotateby( rotationangles, 3, 1.5, 1.5 );
        ent_model movez( -1 * zmove, 3, 1.5, 1.5 );
        wait 2 + randomfloat( 1 );
        ent_model rotateby( rotationangles * -1, 3, 1.5, 1.5 );
        ent_model movez( zmove, 3, 1.5, 1.5 );
        wait 2 + randomfloat( 1 );
    }
}

// Namespace ob_virgo_util
// Params 5
// Checksum 0xf7562a8b, Offset: 0x69dc
// Size: 0xc7
function virgo_drones( var_1f727fc6db558e07, offset = ( 0, 0, 0 ), delay, type = "turret", var_b60496d5b429ae0f )
{
    if ( !isdefined( level.ob_drone_throttle ) )
    {
        virgo_drone_init();
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    spawn_points = utility::getstructarray( var_1f727fc6db558e07, "targetname" );
    count = spawn_points.size;
    self.dronescount = spawn_points.size;
    
    for ( index = 0; index < count ; index++ )
    {
        thread function_1a31b67da78a2af0( type, offset, spawn_points[ index ], var_b60496d5b429ae0f );
    }
}

// Namespace ob_virgo_util
// Params 10
// Checksum 0x75862d3f, Offset: 0x6aab
// Size: 0x17c
function setup_drone_values( movedistance = 64, var_6f8e1815c814e080 = 96, var_6f6b0e15c7ee82ca = 64, engagedmovetime = 1, alertmovetime = 1, dashmovetime = 1, var_c48a311adb63f5da = 0.5, var_7a09c045385eacee = 0.5, stationarytime = 2, var_4f9479db21cbaf60 = 2 )
{
    dronedata = spawnstruct();
    dronedata.movedistance = movedistance;
    dronedata.var_6f8e1815c814e080 = var_6f8e1815c814e080;
    dronedata.var_6f6b0e15c7ee82ca = var_6f6b0e15c7ee82ca;
    dronedata.engagedmovetime = engagedmovetime;
    dronedata.alertmovetime = alertmovetime;
    dronedata.dashmovetime = dashmovetime;
    dronedata.var_c48a311adb63f5da = var_c48a311adb63f5da;
    dronedata.var_7a09c045385eacee = var_7a09c045385eacee;
    dronedata.stationarytime = stationarytime;
    dronedata.var_4f9479db21cbaf60 = var_4f9479db21cbaf60;
    dronedata.memory = { #bad_pos:[], #vis_stack:[] };
    return dronedata;
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x9089737f, Offset: 0x6c30
// Size: 0x30
function virgo_drone_init()
{
    level.ob_drone_throttle = throttle::throttle_initialize( "ob_drone_move", 1, level.framedurationseconds ?? 0.1 );
    ob_flying_drone::setup_helper_drones();
}

// Namespace ob_virgo_util
// Params 5
// Checksum 0x2d1ea0a2, Offset: 0x6c68
// Size: 0x18d
function function_7c91f56fa8065a89( type, offset, struct, dronedata, var_b60496d5b429ae0f )
{
    spawn_path_array = [ struct.origin + offset ];
    drone = ob_flying_drone::spawn_helper_drone( type, level.players[ 0 ], spawn_path_array );
    drone.movedistance = dronedata.movedistance;
    drone.var_6f8e1815c814e080 = dronedata.var_6f8e1815c814e080;
    drone.var_6f6b0e15c7ee82ca = dronedata.var_6f6b0e15c7ee82ca;
    drone.engagedmovetime = dronedata.engagedmovetime;
    drone.alertmovetime = dronedata.alertmovetime;
    drone.dashmovetime = dronedata.dashmovetime;
    drone.var_c48a311adb63f5da = dronedata.var_c48a311adb63f5da;
    drone.var_7a09c045385eacee = dronedata.var_7a09c045385eacee;
    drone.stationarytime = dronedata.stationarytime;
    drone.var_4f9479db21cbaf60 = dronedata.var_4f9479db21cbaf60;
    drone.memory = dronedata.memory;
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        drone thread function_de15b1fe5f750ea2( var_b60496d5b429ae0f );
    }
    
    drone thread ob_flying_drone::function_dbc3536438aea5e0();
    drone thread ob_flying_drone::drone_movebehavior();
}

// Namespace ob_virgo_util
// Params 4
// Checksum 0x8820b2f8, Offset: 0x6dfd
// Size: 0x1b2
function function_1a31b67da78a2af0( type, offset, struct, var_b60496d5b429ae0f )
{
    spawn_path_array = [ struct.origin + offset ];
    dronedata = setup_drone_values();
    droneoptions = spawnstruct();
    droneoptions.activationdelay = 0.3;
    droneoptions.movedistance = dronedata.movedistance;
    droneoptions.var_6f8e1815c814e080 = dronedata.var_6f8e1815c814e080;
    droneoptions.var_6f6b0e15c7ee82ca = dronedata.var_6f6b0e15c7ee82ca;
    droneoptions.engagedmovetime = dronedata.engagedmovetime;
    droneoptions.alertmovetime = dronedata.alertmovetime;
    droneoptions.dashmovetime = dronedata.dashmovetime;
    droneoptions.var_c48a311adb63f5da = dronedata.var_c48a311adb63f5da;
    droneoptions.var_7a09c045385eacee = dronedata.var_7a09c045385eacee;
    droneoptions.stationarytime = dronedata.stationarytime;
    droneoptions.var_4f9479db21cbaf60 = dronedata.var_4f9479db21cbaf60;
    droneoptions.memory = dronedata.memory;
    droneoptions.hackable = 1;
    drone = ob_flying_drone::spawn_helper_drone( type, level.players[ 0 ], spawn_path_array, undefined, droneoptions );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        drone thread function_de15b1fe5f750ea2( var_b60496d5b429ae0f );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x39f3604c, Offset: 0x6fb7
// Size: 0x5e
function function_de15b1fe5f750ea2( var_b60496d5b429ae0f )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"hash_84941674cca5e76d" );
    drone endon( #"drone_cleaned_up" );
    drone endon( #"death" );
    level utility::flag_wait( var_b60496d5b429ae0f );
    drone delete();
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0xbe681348, Offset: 0x701d
// Size: 0x8b
function function_4bc6557dc8ff5dac( struct )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"hash_84941674cca5e76d" );
    drone endon( #"drone_cleaned_up" );
    drone endon( #"death" );
    
    while ( isdefined( struct.target ) )
    {
        struct = utility::getstruct( struct.target, "targetname" );
        drone drone_move_to( struct.origin );
    }
}

// Namespace ob_virgo_util
// Params 2, eflags: 0x4
// Checksum 0x76c602b, Offset: 0x70b0
// Size: 0x1b2
function private drone_move_to( var_b1dd718a8fbb3c1c, fly_speed = 10 )
{
    drone = self;
    drone rotateto( vectortoangles( ( var_b1dd718a8fbb3c1c[ 0 ], var_b1dd718a8fbb3c1c[ 1 ], drone.origin[ 2 ] ) - drone.origin ), 0.5 );
    wait 0.5;
    v_diff = vectornormalize( var_b1dd718a8fbb3c1c - drone.origin );
    f_forward_dot = vectordot( v_diff, anglestoforward( drone.angles ) );
    f_right_dot = vectordot( v_diff, anglestoright( drone.angles ) );
    cross = vectorcross( v_diff, ( 0, 0, 1 ) );
    move_time = distance( drone.origin, var_b1dd718a8fbb3c1c ) / fly_speed;
    accel_time = move_time * drone.var_c48a311adb63f5da / 100;
    var_af19742ed09a0a72 = move_time * drone.var_7a09c045385eacee / 100;
    yawangle = vectortoangles( var_b1dd718a8fbb3c1c - drone.origin )[ 1 ];
    drone moveto( var_b1dd718a8fbb3c1c, move_time, accel_time, var_af19742ed09a0a72 );
    
    if ( length( cross ) <= 0.1 )
    {
        yawangle = drone.angles[ 1 ];
        drone rotateto( ( 0, yawangle, 0 ), accel_time );
    }
    else
    {
        drone rotateby( ( 30 * f_forward_dot, 0, 30 * f_right_dot ), accel_time );
    }
    
    wait move_time;
    drone rotateto( ( 0, yawangle, 0 ), var_af19742ed09a0a72 );
    wait var_af19742ed09a0a72;
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x81ea1ce2, Offset: 0x726a
// Size: 0x57
function function_fdd5b4c27ba17b79( scale = "light", duration = 0.5, players = level.players )
{
    namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( scale, duration, undefined, players, undefined, undefined, 1 );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xd370c3f1, Offset: 0x72c9
// Size: 0x63
function function_4ec71c3da6905745()
{
    self notify( #"hash_b89e13453dbe2060" );
    self endon( #"hash_b89e13453dbe2060" );
    scene_struct = utility::getstruct( "struct_scene_ambient_drone", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct thread scene::play();
        level thread virgo_audio::drone_ambience();
        level utility::flag_wait( "flag_void_1_bink_done" );
        scene_struct scene::stop();
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x11b2ec0d, Offset: 0x7334
// Size: 0xb1
function function_d05a0e33c28b8063( origin )
{
    self notify( #"hash_6971f9aac71d7192" );
    self endon( #"hash_6971f9aac71d7192" );
    level endon( #"hash_86df7ddbf33d3ea4" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player predictstreamposuntilcleared( origin );
        }
        
        waitframe();
    }
}

// Namespace ob_virgo_util
// Params 7
// Checksum 0x31edd96d, Offset: 0x73ed
// Size: 0x43b
function echo_fragment_transition( activity_instance, startsname, structname, flaginteract, flagcomplete, var_f4137d46cfd7ab62 = 1, regroupradius )
{
    interactstruct = activity_instance function_70674852bcdd6cd3( structname, flaginteract, &"sat_ob_story_missions/virgo_interact_echo", undefined, undefined, ( 0, 0, -16 ) );
    
    if ( !isdefined( interactstruct.origin ) )
    {
        return;
    }
    
    level thread function_d05a0e33c28b8063( ob_story_mission_utils::get_activity_starts( startsname )[ 0 ].origin );
    level utility::flag_wait( flaginteract );
    level thread function_fdd5b4c27ba17b79( "light" );
    coop::function_164d95b45992525( { #triggerradius:regroupradius, #var_30215d8ee868ab1b:5, #noregroup:var_f4137d46cfd7ab62, #var_9172157ef0919145:0, #var_ba7c3b8fa9d3823:level.pullforward_initiator } );
    groundorigin = getgroundposition( interactstruct.origin, 0 );
    structangles = interactstruct.angles;
    playerorigin = groundorigin + anglestoforward( structangles ) * 100;
    playerangles = structangles + ( 0, 180, 0 );
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
        player coop::set_player_frozen_vars( 1, "echo_fragment", 0 );
        
        if ( player.sessionstate == "playing" )
        {
            player setorigin( playerorigin );
            player setplayerangles( playerangles );
        }
        
        pbgpostfxbundlestart( player, %"sat_ob_cradle_portal_in" );
        player lerpfovbypreset( "hellstorm_missile_zoom_out" );
    }
    
    wait 0.3;
    
    foreach ( player in level.players )
    {
        player lerpfovbypreset( "hellstorm_missile_zoom_in" );
    }
    
    wait 0.25;
    structs = ob_story_mission_utils::get_activity_starts( startsname );
    level coop::play_cinematic( "sat_virgo_cradle_wormhole_transition", { #timeout:1, #teleportdelay:1, #fadeendshader:"white", #fadestartshader:"none", #fadestartnone:1, #countdown:0, #skip:0, #flag:flagcomplete, #structs:structs } );
    
    foreach ( player in level.players )
    {
        player lerpfovbypreset( "default_200ms" );
        pbgpostfxbundlestart( player, %"sat_ob_cradle_portal_out" );
    }
    
    wait 0.25;
    
    foreach ( player in level.players )
    {
        player coop::set_player_frozen_vars( 0, "echo_fragment" );
    }
    
    level notify( #"hash_86df7ddbf33d3ea4" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x34cb2f2b, Offset: 0x7830
// Size: 0x57
function function_a3d301fb23f69fa2()
{
    struct = utility::getstruct( "struct_crashsite_ability_case", "targetname" );
    
    if ( isdefined( struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_war_machine", "super_active_camo", #"default", struct.angles, undefined, 1 );
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x76d1300c, Offset: 0x788f
// Size: 0x57
function function_9f5a4a38ccd4c7a3()
{
    struct = utility::getstruct( "struct_garden_ability_case", "targetname" );
    
    if ( isdefined( struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_teleport", "super_portal_summon", #"tactical", struct.angles, undefined, 1 );
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xcf3f7fcd, Offset: 0x78ee
// Size: 0x31
function function_2463b23bc69b1a0a( enemies, killcount, flag )
{
    waittill_dead_or_dying( enemies, killcount );
    utility::flag_set( flag );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xa3e7b6f7, Offset: 0x7927
// Size: 0xba
function function_ac9de8895f3e4a23( guys, vol )
{
    guys = utility::array_removedead_or_dying( guys );
    goalvolume = getent( vol, "targetname" );
    
    foreach ( guy in guys )
    {
        if ( isalive( guy ) )
        {
            guy thread function_c04c50d8c93df4d3( goalvolume, 1.2, 2.7 );
        }
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0xc6169581, Offset: 0x79e9
// Size: 0x62
function function_c04c50d8c93df4d3( goalvolume, delay_min, delay_max )
{
    if ( isdefined( delay_min ) && isdefined( delay_max ) )
    {
        self endon( #"death" );
        wait randomfloatrange( delay_min, delay_max );
    }
    
    if ( isalive( self ) )
    {
        self.forcegoal = 0;
        self.fixednode = 0;
        self setgoalvolumeauto( goalvolume );
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0xa2b6ffad, Offset: 0x7a53
// Size: 0x11a
function waittill_dead_or_dying( guys, num )
{
    newarray = [];
    
    foreach ( member in guys )
    {
        if ( isalive( member ) && !member.ignoreforfixednodesafecheck )
        {
            newarray[ newarray.size ] = member;
        }
    }
    
    guys = newarray;
    ent = spawnstruct();
    ent.count = guys.size;
    
    if ( num < ent.count )
    {
        ent.count = num;
    }
    
    utility::array_thread( guys, &waittill_dead_or_dying_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"waittill_dead_guy_dead_or_dying" );
    }
}

// Namespace ob_virgo_util
// Params 1
// Checksum 0x235839e, Offset: 0x7b75
// Size: 0x3b
function waittill_dead_or_dying_thread( ent )
{
    utility::waittill_any( "death", "long_death", "death_engaged" );
    ent.count--;
    ent notify( #"waittill_dead_guy_dead_or_dying" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x4c88609b, Offset: 0x7bb8
// Size: 0x1b
function carrier_exploders()
{
    assert( isthreaded() );
    level utility::exploder( "fx_carrier_intro" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x553143b5, Offset: 0x7bdb
// Size: 0x2c
function function_5585684359fbcac0()
{
    self waittill( #"play_cradle_bamf" );
    playfx( level._effect[ "cradle_bamf" ], self.origin );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xd7bf4b49, Offset: 0x7c0f
// Size: 0x8c
function function_dbc4595e2e99750()
{
    a_trig_multiple_fire = getentarray( "trig_multiple_fire", "targetname" );
    
    foreach ( fire_trig in a_trig_multiple_fire )
    {
        fire_trig thread monitor_player_fire_damage();
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0xaa9b6d5, Offset: 0x7ca3
// Size: 0x73
function monitor_player_fire_damage()
{
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            ent dodamage( 12, ent.origin, ent, ent, "MOD_FIRE" );
            ent playrumbleonentity( "damage_heavy" );
            playsoundatpos( ent.origin, #"hash_e154b3219b4ef628" );
            wait 0.5;
        }
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x8f0d5436, Offset: 0x7d1e
// Size: 0x8f
function revive_squad()
{
    foreach ( player in level.players )
    {
        if ( player.inlaststand )
        {
            player laststand::function_75e6bc3d39e1f2bb( player, "last_stand_revived" );
        }
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x133e2b48, Offset: 0x7db5
// Size: 0x6a
function function_f8c90a6db244c560( scene_struct, var_101bc5e990568fd3 )
{
    waitframe();
    ent = scene_struct scene::get_entity( var_101bc5e990568fd3 );
    ent.team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", ent.team, [ ent ] );
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x849508f1, Offset: 0x7e27
// Size: 0x9b
function function_5014ebb9978c03b2( var_1bb1f29fb2e8e4cb, var_9f254670dddc6ae5, hint_string )
{
    foreach ( player in level.players )
    {
        player thread ability_hint( var_1bb1f29fb2e8e4cb, var_9f254670dddc6ae5, hint_string );
    }
}

// Namespace ob_virgo_util
// Params 3
// Checksum 0x3dc57793, Offset: 0x7eca
// Size: 0x110
function ability_hint( var_1bb1f29fb2e8e4cb, var_9f254670dddc6ae5, hint_string )
{
    player = self;
    self endon( #"death" );
    self endon( #"disconnect" );
    given_hint = 0;
    
    while ( !level utility::flag( var_1bb1f29fb2e8e4cb ) && !given_hint )
    {
        weapons = player getweaponslistall();
        
        foreach ( item in weapons )
        {
            if ( issubstr( item.basename, var_9f254670dddc6ae5 ) )
            {
                player thread function_f057eb8eb57396ba( "virgo_hint_" + var_9f254670dddc6ae5, hint_string );
                given_hint = 1;
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x9706bd9e, Offset: 0x7fe2
// Size: 0x39
function function_f057eb8eb57396ba( hint_ref, hint_string )
{
    self notify( #"hash_423f107297a98765" );
    self endon( #"hash_423f107297a98765" );
    thread hints::hint_add_simple( hint_ref, hint_string, 4 );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x6918126c, Offset: 0x8023
// Size: 0x7e
function function_cc6d564ea2eb6880()
{
    wait 4;
    
    foreach ( player in level.players )
    {
        player thread function_b2bc9839552385c9();
    }
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x1cc9b350, Offset: 0x80a9
// Size: 0x6b
function function_b2bc9839552385c9()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    has_annihilator = 0;
    
    while ( !supers_mp::issuperready() )
    {
        waitframe();
    }
    
    if ( utility::is_player_gamepad_enabled() )
    {
        thread function_f057eb8eb57396ba( "virgo_hint_annihilator", &"sat_ob_story_missions/virgo_annihilator_hint_gamepad" );
        return;
    }
    
    thread function_f057eb8eb57396ba( "virgo_hint_annihilator", &"sat_ob_story_missions/virgo_annihilator_hint" );
}

// Namespace ob_virgo_util
// Params 2
// Checksum 0x32a6eb03, Offset: 0x811c
// Size: 0x2dc
function function_b9f55012c46396c2( struct, radius = 1024 )
{
    function_fdd5b4c27ba17b79( "heavy" );
    wait 1;
    struct zombie_boss_healthbar::function_f50a10314e72caa1();
    struct zombie_boss_healthbar::init_zombie_boss_healthbar();
    circle = function_52654c12f38e0189( struct.origin, radius );
    playfx( level._effect[ "enemy_death_cleanup" ], struct.origin );
    level.dark_mason = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_soldier", struct.origin, struct.angles, "team_hundred_ninety" );
    level.dark_mason setmodel( "body_c_sat_usa_pl_black_horde_sp" );
    
    if ( isdefined( level.dark_mason.headmodel ) )
    {
        level.dark_mason detach( level.dark_mason.headmodel );
    }
    
    level.dark_mason attach( "head_c_sat_usa_pl_black_base_cradle" );
    level.dark_mason.headmodel = "head_c_sat_usa_pl_black_base_cradle";
    level.dark_mason.maxhealth = 15000;
    level.dark_mason.health = 15000;
    level.health_struct = spawnstruct();
    level.health_struct.health = level.dark_mason.health;
    level.health_struct.maxhealth = level.dark_mason.maxhealth;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_harper", level.health_struct );
    }
    
    level.dark_mason function_61f50ce8f428bf0d();
    
    if ( isdefined( circle.mapcircle ) )
    {
        circle game_utility::questcircle_delete();
    }
    
    circle delete();
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    function_fdd5b4c27ba17b79( "heavy" );
}

// Namespace ob_virgo_util
// Params 0
// Checksum 0x976c1fc2, Offset: 0x8400
// Size: 0x55
function function_61f50ce8f428bf0d()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        level callback::callback( "on_boss_progress_updated", { #maxhealth:self.maxhealth, #health:self.health } );
    }
}

