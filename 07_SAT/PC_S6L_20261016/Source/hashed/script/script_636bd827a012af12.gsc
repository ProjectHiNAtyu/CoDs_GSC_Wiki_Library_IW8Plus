// script_636bd827a012af12  (hash_636bd827a012af12.gscc) (size: 66337 Bytes / 0x10321 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbff4b7fc (3220486140)
// size ...... 66337 (0x10321)
// includes .. 57  (offset: 0xf525)
// strings ... 167 (offset: 0xf6ed)
// dev strs .. 33  (offset: 0x1017d)
// exports ... 152 (offset: 0xa779)
// cseg ...... 0x10ce + 0x96ab (0xa779)
// imports ... 434 (offset: 0xbf39)
// animtree1 . 0   (offset: 0x10321)
// animtree2 . 0   (offset: 0x10321)
#using script_2304453c69e996e2;
#using script_2498b7c75f1dee2d;
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\save;
#using scripts\common\scripted_widgets;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\waypoint;
#using scripts\common\waypoint_objective_handler;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\coop;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\activities\ob_activity_heli_takedown;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\countdown_timer;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_power_tier;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\telemetry_coop;

#namespace ob_story_mission_utils;

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xd6ed46ed, Offset: 0x10ec
// Size: 0xf4
function set_global_region_difficulty( difficulty_int = 1 )
{
    var_546e4eb5269dbafa = "difficulty_easy";
    
    switch ( difficulty_int )
    {
        default:
            var_546e4eb5269dbafa = "difficulty_easy";
            break;
        case 2:
            var_546e4eb5269dbafa = "difficulty_normal";
            break;
        case 3:
            var_546e4eb5269dbafa = "difficulty_hard";
            break;
        case 4:
            var_546e4eb5269dbafa = "difficulty_darkaether";
            break;
        case 5:
            var_546e4eb5269dbafa = "difficulty5";
            break;
        case 6:
            var_546e4eb5269dbafa = "difficulty6";
            break;
    }
    
    level.region_difficulty_manager.default_region.difficulty = var_546e4eb5269dbafa;
    level.region_difficulty_manager.default_region.difficultyint = difficulty_int;
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xb5ad2b95, Offset: 0x11e8
// Size: 0x46
function get_global_region_difficulty()
{
    if ( isdefined( level.region_difficulty_manager.default_region.difficulty ) )
    {
        return level.region_difficulty_manager.default_region.difficulty;
    }
    
    return "difficulty_undefined";
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xa9229676, Offset: 0x1237
// Size: 0x43
function function_695f0dcb1b47e6d9()
{
    if ( isdefined( level.region_difficulty_manager.default_region.difficultyint ) )
    {
        return level.region_difficulty_manager.default_region.difficultyint;
    }
    
    return 1;
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0x62520447, Offset: 0x1283
    // Size: 0x5, Type: dev
    function function_7e7dace10145207c()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x44dbeba1, Offset: 0x1290
// Size: 0xce
function get_activity_starts( activity_name )
{
    a_s_start = undefined;
    
    if ( isdefined( activity_name ) )
    {
        a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
        a_s_start = [];
        
        foreach ( spawn_point in a_spawn_points )
        {
            if ( spawn_point.script_noteworthy == activity_name )
            {
                a_s_start[ a_s_start.size ] = spawn_point;
            }
        }
        
        if ( a_s_start.size == 0 )
        {
            /#
                iprintln( "<dev string:x24>" );
            #/
            
            a_s_start = undefined;
        }
    }
    
    return a_s_start;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x52b2dc1e, Offset: 0x1367
// Size: 0x6d
function function_2686bb512b355040( activity_name, b_waitframe )
{
    a_s_start = get_activity_starts( activity_name );
    
    if ( !isarray( a_s_start ) )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        coop::teleport_player( level.players[ i ], a_s_start[ i ], b_waitframe );
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x13f5c4f5, Offset: 0x13dc
// Size: 0x7c
function function_b0bc4cf3be6ad752( s_trigger_ref, var_b60496d5b429ae0f, failattempts )
{
    a_ent_trig = getentarray( s_trigger_ref, "targetname" );
    a_noent_trig = getnoentvolumearray( s_trigger_ref, "targetname" );
    teleport_player_triggers = arraycombine( a_ent_trig, a_noent_trig );
    utility::array_thread( teleport_player_triggers, &function_2a735260e43c6b2d, failattempts );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level thread function_b4962a1d9327dacf( var_b60496d5b429ae0f, teleport_player_triggers );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x3dae651b, Offset: 0x1460
// Size: 0x247
function function_2a735260e43c6b2d( failattempts )
{
    self endon( #"death" );
    self endon( #"hash_24928a6c9cd6611f" );
    
    while ( true )
    {
        self waittill( #"trigger", triggerer );
        
        if ( ob::nightmare() )
        {
            if ( triggerer.classname == "script_vehicle" )
            {
                vehicle = triggerer;
                
                foreach ( occupant in vehicle.occupants )
                {
                    if ( !isplayer( occupant ) || !isalive( occupant ) )
                    {
                        continue;
                    }
                    
                    data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
                    thread vehicle_occupancy::exit( vehicle, vehicle_occupancy::get_occupant_seat( vehicle, occupant ), occupant, data, 1 );
                    occupant val::reset_all( "vehicle_occupant" );
                }
            }
            
            if ( triggerer.is_in_remote_robot == 1 )
            {
                return;
            }
            
            player = triggerer;
            
            if ( !player.is_teleporting )
            {
                if ( isdefined( level.var_6ac65a56e9e60396 ) )
                {
                    structs = get_activity_starts( level.var_6ac65a56e9e60396 );
                    
                    if ( structs.size )
                    {
                        player thread function_46a15fc0faec0c82( self, structs );
                    }
                }
            }
        }
        
        if ( !isplayer( triggerer ) )
        {
            continue;
        }
        
        player = triggerer;
        
        if ( !player.is_teleporting )
        {
            if ( failattempts.fails )
            {
                player.var_a2a2c3e5ca1c23b = ( player.var_a2a2c3e5ca1c23b ?? 0 ) + 1;
                
                if ( player.var_a2a2c3e5ca1c23b > failattempts.fails )
                {
                    player thread function_46a15fc0faec0c82( self, failattempts.structs );
                    player.var_a2a2c3e5ca1c23b = undefined;
                    waitframe();
                    continue;
                }
            }
            else
            {
                player.var_a2a2c3e5ca1c23b = undefined;
            }
            
            player thread function_46a15fc0faec0c82( self );
        }
        
        waitframe();
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x240c3c39, Offset: 0x16af
// Size: 0x20e
function function_46a15fc0faec0c82( trigger, overridestructs )
{
    player = self;
    player endon( #"death_or_disconnect" );
    a_s_teleport = overridestructs ?? utility::getstructarray( trigger.target, "targetname" );
    
    if ( !isdefined( a_s_teleport ) || a_s_teleport.size <= 0 )
    {
        /#
            iprintlnbold( "<dev string:x61>" );
        #/
        
        return;
    }
    
    player freezecontrols( 1 );
    waitframe();
    player notify( #"player_teleport_start" );
    a_s_teleport = sortbydistance( a_s_teleport, player.origin );
    s_teleport_to = undefined;
    
    for ( i = 0; i < a_s_teleport.size ; i++ )
    {
        players = getplayersinradius( a_s_teleport[ i ].origin, 32 );
        
        if ( players.size == 0 )
        {
            s_teleport_to = a_s_teleport[ i ];
            break;
        }
    }
    
    if ( !s_teleport_to )
    {
        s_teleport_to = a_s_teleport[ 0 ];
    }
    
    player telemetry_coop::function_48065623105118c3();
    player.is_teleporting = 1;
    player playsoundtoplayer( "evt_plr_out_of_bounds_respawn_fall", player );
    player notify( #"skydive_end" );
    player setvelocity( ( 0, 0, 0 ) );
    player function_fa215e46adf60c7d();
    player skydive_interrupt();
    player dontinterpolate();
    player function_5c764e554642cf04();
    player thread _teleport_player_death_failsafe();
    fade_time = 0.25;
    player hud_util::fade_out( fade_time, "white" );
    wait fade_time;
    
    /#
        iprintlnbold( "<dev string:xab>" );
    #/
    
    player setorigin( s_teleport_to.origin, 1 );
    player setplayerangles( s_teleport_to.angles, 1 );
    player playsoundtoplayer( "evt_plr_out_of_bounds_respawn", player );
    wait fade_time;
    player hud_util::fade_in( fade_time, "white" );
    player freezecontrols( 0 );
    player.is_teleporting = 0;
    player notify( #"player_teleport_end" );
    namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 3, undefined, player );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x40f9d107, Offset: 0x18c5
// Size: 0xa5
function function_b4962a1d9327dacf( var_b60496d5b429ae0f, teleport_player_triggers )
{
    level utility::flag_wait( var_b60496d5b429ae0f );
    
    foreach ( trig in teleport_player_triggers )
    {
        trig notify( #"hash_24928a6c9cd6611f" );
        
        if ( isent( trig ) )
        {
            trig delete();
        }
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x8c169ff9, Offset: 0x1972
// Size: 0x3e
function _teleport_player_death_failsafe()
{
    self endon( #"disconnect" );
    self endon( #"player_teleport_end" );
    self waittill( #"death" );
    hud_util::fade_in( 0, "white" );
    self.is_teleporting = 0;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x6946cd4c, Offset: 0x19b8
// Size: 0xe6
function set_player_frozen_vars( var_94d1ab5da995e573, str_id )
{
    if ( var_94d1ab5da995e573 )
    {
        if ( player::isinlaststand( self ) )
        {
            val::set( str_id, "fire", 0 );
        }
        
        val::set( str_id, "weapon", 0 );
        val::set( str_id, "allow_movement", 0 );
        val::set( str_id, "ignoreme", 1 );
        val::set( str_id, "freezecontrols", 1 );
        val::set( str_id, "killstreaks", 0 );
        val::set( str_id, "show_hud", 0 );
        val::set( str_id, "interactions", 0 );
        val::set( str_id, "usability", 0 );
        val::set( str_id, "allow_revive_teammate", 0 );
        val::set( str_id, "damage", 0 );
        val::set( str_id, "vehicle_use", 0 );
        return;
    }
    
    val::reset_all( str_id );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x4de6ed19, Offset: 0x1aa6
// Size: 0x111
function set_revive_spawns( spawnstructs )
{
    if ( !isdefined( level.on_player_spawned_starts ) )
    {
        level.on_player_spawned_starts = [];
    }
    
    if ( spawnstructs.size > 0 && isstruct( spawnstructs[ 0 ] ) && isdefined( spawnstructs[ 0 ].origin ) )
    {
        level.on_player_spawned_starts = spawnstructs;
        
        for ( iplayer = 0; iplayer < level.players.size && iplayer < level.on_player_spawned_starts.size ; iplayer++ )
        {
            player = level.players[ iplayer ];
            start = level.on_player_spawned_starts[ iplayer ];
            
            if ( !isplayer( player ) || !isdefined( start.origin ) )
            {
                continue;
            }
            
            player.var_30ee31fc6dba492a = start.origin;
            player.var_5acd906128ef37bd = start.angles;
        }
        
        return;
    }
    
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( level.var_a382d6287e313bba );
}

// Namespace ob_story_mission_utils
// Params 6
// Checksum 0x53c1f5ce, Offset: 0x1bbf
// Size: 0x14f
function function_9187113603e3519( player, animname, anime, reachtime = 0.5, reachnode = undefined, gunless = 0 )
{
    if ( !isdefined( reachnode ) )
    {
        reachnode = self;
    }
    
    if ( reachtime > 0 )
    {
        player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
        player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 0 );
        player.linktoent moveto( reachnode.origin, reachtime, 0.05, 0.05 );
        player.linktoent rotateto( reachnode.angles, reachtime, 0.05, 0.05 );
    }
    
    if ( gunless )
    {
        var_ed2a546b70aa8095 = takegun( player, reachtime );
        wait var_ed2a546b70aa8095;
    }
    
    create_player_rig( player, animname );
    anim_mp::anim_player_solo( player, player.var_9c077eda1131c35f, anime );
    
    if ( gunless )
    {
        player thread inventory_utility::takegunlessweapon();
    }
    
    remove_player_rig( player );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x6eddae37, Offset: 0x1d16
// Size: 0x4d
function takegun( player, reachtime )
{
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    return max( 0, reachtime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xbe673b25, Offset: 0x1d6c
// Size: 0xde
function create_player_rig( player, animname )
{
    player.animname = animname;
    var_9c077eda1131c35f = spawn( "script_arms", player.origin, 0, 0, player );
    player.var_9c077eda1131c35f = var_9c077eda1131c35f;
    var_9c077eda1131c35f.origin = player.origin;
    var_9c077eda1131c35f.angles = player.angles;
    var_9c077eda1131c35f.player = player;
    var_9c077eda1131c35f.animname = animname;
    var_9c077eda1131c35f useanimtree( level.scr_animtree[ animname ] );
    var_9c077eda1131c35f.updatedversion = 1;
    var_9c077eda1131c35f hide( 1 );
    var_9c077eda1131c35f showonlytoplayer( player );
    player playerlinktoabsolute( var_9c077eda1131c35f, "tag_player" );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x1ab87ebf, Offset: 0x1e52
// Size: 0x67
function remove_player_rig( player )
{
    player notify( #"remove_rig" );
    player unlink();
    player stopviewmodelanim();
    
    if ( player.var_9c077eda1131c35f )
    {
        if ( player.var_9c077eda1131c35f islinked() )
        {
            player.var_9c077eda1131c35f unlink();
        }
        
        player.var_9c077eda1131c35f delete();
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xf743a40b, Offset: 0x1ec1
// Size: 0xc9
function get_playing_players( var_6b5bb36852ce83aa = 0 )
{
    players = level.players;
    
    foreach ( player in players )
    {
        if ( player.sessionstate != "playing" )
        {
            players = arrayremove( players, player );
        }
        
        if ( var_6b5bb36852ce83aa && player player::isinlaststand() )
        {
            players = arrayremove( players, player );
        }
    }
    
    return players;
}

// Namespace ob_story_mission_utils
// Params 7
// Checksum 0x68ef626b, Offset: 0x1f93
// Size: 0xc7
function init_objective_interaction( var_31fca1348e82e1a2, scriptable_asset, interact_callback, scriptable_part, interact_angle = ( 0, 0, 0 ), visible_state = #"visible", hidden_state = #"hidden" )
{
    objective_interaction = spawnscriptable( scriptable_asset, var_31fca1348e82e1a2, interact_angle );
    interaction::register_scriptable_interact( objective_interaction, interact_callback );
    objective_interaction function_7653c765b6c7b815();
    objective_interaction.scriptable_part = scriptable_part;
    objective_interaction.visible_state = visible_state;
    objective_interaction.hidden_state = hidden_state;
    return objective_interaction;
}

// Namespace ob_story_mission_utils
// Params 4
// Checksum 0xed38005e, Offset: 0x2063
// Size: 0x14f
function function_c6e736cde48c3fe0( scriptable, squad_leader, objective_z_offset = 48, starts_mission = 0 )
{
    mission_objective_icon = starts_mission ? "sat_ob_objectivemarker_storymissionstart" : undefined;
    squad = squad_leader squad_utility::getsquadmembers( squad_leader.team );
    
    if ( !isdefined( scriptable.objective_id ) )
    {
        objective_id = function_b9cb179f9577f32a( scriptable.origin, objective_z_offset, squad, mission_objective_icon );
        scriptable.objective_id = objective_id;
    }
    else
    {
        objective_marker_show( scriptable.objective_id, squad );
    }
    
    scriptable setscriptablepartstate( scriptable.scriptable_part, scriptable.visible_state );
    
    foreach ( player in squad )
    {
        scriptable enablescriptableplayeruse( player );
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x684819cf, Offset: 0x21ba
// Size: 0xe3
function function_688cddd74c21cd39( scriptable, squad_leader )
{
    squad = squad_leader squad_utility::getsquadmembers( squad_leader.team );
    
    if ( isdefined( scriptable.objective_id ) )
    {
        objective_marker_clear( scriptable.objective_id, squad );
    }
    
    scriptable setscriptablepartstate( scriptable.scriptable_part, scriptable.visible_state );
    
    foreach ( player in squad )
    {
        scriptable disablescriptableplayeruse( player );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xa77de08c, Offset: 0x22a5
// Size: 0x20
function function_6314f03dfe2adbc5( var_94d1ab5da995e573 = 1 )
{
    level.var_1fe9ae2fed8cc836 = var_94d1ab5da995e573;
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0x3e8182f9, Offset: 0x22cd
    // Size: 0x5, Type: dev
    function function_d8ac17b321722058()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 14
// Checksum 0xe13d6d90, Offset: 0x22da
// Size: 0xf0
function function_56960723e6738b6c( ob_activity_name, str_objective_start, waypoint_bundle, done_notification, var_2ec40eb41a3473d8, var_1288e7582a6bdb5, use_nav_modifier = 1, var_37b53ff85831ed1c = 1, z_offset = 32, sync_status, trigger_required, cancel_on_death, hide_elevation, objective_offset )
{
    if ( !waypoint_bundle )
    {
        waypoint_bundle = { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" };
    }
    
    level thread waypoint_objective_handler::waypoint_objective_handler( &function_55b3307d41ec4624, str_objective_start, done_notification, var_2ec40eb41a3473d8, var_1288e7582a6bdb5, waypoint_bundle, var_37b53ff85831ed1c, use_nav_modifier, z_offset, sync_status, trigger_required, cancel_on_death, hide_elevation, objective_offset );
    waitframe();
    
    if ( isdefined( ob_activity_name ) )
    {
        thread objective_text_show( ob_activity_name );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x78143d25, Offset: 0x23d2
// Size: 0x1f3
function function_55b3307d41ec4624( waypoint_struct )
{
    if ( !waypoint_struct.origin )
    {
        if ( waypoint_struct.var_dc21504e32f2eda6.id )
        {
            objidpoolmanager::returnobjectiveid( waypoint_struct.var_dc21504e32f2eda6.id );
            waypoint_struct.var_dc21504e32f2eda6 = undefined;
        }
        
        if ( waypoint_struct.waypoint_marker.id )
        {
            objidpoolmanager::returnobjectiveid( waypoint_struct.waypoint_marker.id );
            waypoint_struct.waypoint_marker = undefined;
        }
        
        return;
    }
    
    if ( !waypoint_struct.var_dc21504e32f2eda6.id )
    {
        bundle = waypoint_struct.waypoint.data.waypoint_bundle;
        waypoint_struct.var_dc21504e32f2eda6 = { #state:"", #id:function_4b3016572e74f2c1( isstruct( bundle ) ? bundle.objective : bundle ) };
        objective_sethideelevation( waypoint_struct.var_dc21504e32f2eda6.id, waypoint_struct.waypoint.data.hide_elevation );
        
        if ( isstruct( bundle ) )
        {
            waypoint_struct.waypoint_marker = { #state:"", #id:function_4b3016572e74f2c1( bundle.waypoint ) };
            objective_sethideelevation( waypoint_struct.waypoint_marker.id, waypoint_struct.waypoint.data.hide_elevation );
        }
    }
    
    if ( waypoint_struct.var_dc21504e32f2eda6.id )
    {
        waypoint_struct thread function_554d82609324bcf0( self );
    }
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x8082e75d, Offset: 0x25cd
// Size: 0x7f
function private function_4b3016572e74f2c1( bundle )
{
    bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", bundle );
    var_1348ae8d95a313d0 = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( bundlexhash );
    
    if ( isdefined( var_1348ae8d95a313d0 ) && var_1348ae8d95a313d0 != -1 )
    {
        objective_removeallfrommask( var_1348ae8d95a313d0 );
        objective_addclienttomask( var_1348ae8d95a313d0, self );
        objective_showtoplayersinmask( var_1348ae8d95a313d0 );
        objective_setplayintro( var_1348ae8d95a313d0, 0 );
    }
    else
    {
        assertmsg( "<dev string:xd5>" + getxhashsourcename( bundlexhash ) );
    }
    
    return var_1348ae8d95a313d0;
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0xc
// Checksum 0x414b38de, Offset: 0x2655
// Size: 0x2ae
function private function_554d82609324bcf0( player )
{
    self notify( #"hash_ee78c2d16bd0408f" );
    self endon( #"hash_ee78c2d16bd0408f" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self endon( #"monitor_stop" );
    wait 0.25;
    origin = get_waypoint_objective_position( player );
    marker = self.waypoint_marker.id && !self.is_final_position ? self.waypoint_marker : self.var_dc21504e32f2eda6;
    objidpoolmanager::update_objective_position( marker.id, origin );
    self.var_f6419ccac6eff8e4 = undefined;
    
    if ( self.use_nav_modifier && !self.is_final_position )
    {
        waypointstructs = player waypoint::function_9d574fd4df1af10f();
        
        foreach ( waypointstruct in waypointstructs )
        {
            if ( waypointstruct.var_dc21504e32f2eda6.id == self.var_dc21504e32f2eda6.id )
            {
                continue;
            }
            
            var_c92885bb7c51279e = waypointstruct get_waypoint_objective_position( player );
            
            if ( !waypointstruct.var_f6419ccac6eff8e4 && distancesquared( origin, var_c92885bb7c51279e ) <= 1024 )
            {
                self.var_f6419ccac6eff8e4 = 1;
                break;
            }
        }
    }
    
    if ( self.var_f6419ccac6eff8e4 )
    {
        if ( self.waypoint_marker.id && !self.is_final_position )
        {
            self.var_dc21504e32f2eda6 function_98ed90d7a45c80ba( "empty" );
        }
        
        marker function_98ed90d7a45c80ba( "empty" );
        return;
    }
    
    if ( self.waypoint_marker.id )
    {
        var_455657c0122f69e4 = self.is_final_position ? self.waypoint_marker : self.var_dc21504e32f2eda6;
        var_455657c0122f69e4 function_98ed90d7a45c80ba( "empty" );
    }
    
    marker function_98ed90d7a45c80ba( !self.waypoint.data.var_37b53ff85831ed1c || self.is_final_position ? "current" : "active" );
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0xd1c3e87a, Offset: 0x290b
// Size: 0x36
function private function_98ed90d7a45c80ba( state )
{
    if ( self.state != state )
    {
        self.state = state;
        objective_state( self.id, state );
    }
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x969a78d9, Offset: 0x2949
// Size: 0xe8
function private get_waypoint_objective_position( player )
{
    origin = self.origin;
    var_4f7b74c5c9df434b = !self.is_final_position && !self.var_3e509260f3e3f2a4;
    
    if ( self.use_override )
    {
        var_797bca6393af3b4a = player waypoint_objective_handler::function_ce3c53ff7662012e( self.origin );
        
        if ( var_797bca6393af3b4a )
        {
            origin = var_797bca6393af3b4a.origin;
            var_4f7b74c5c9df434b &= !var_797bca6393af3b4a.var_f9e656b1894a327c;
        }
    }
    
    if ( var_4f7b74c5c9df434b )
    {
        return ( getgroundposition( origin, 6, 500, 0 ) + ( 0, 0, self.z_offset ) );
    }
    
    return origin + ( self.is_final_position ? self.waypoint.data.objective_offset : ( 0, 0, 0 ) );
}

// Namespace ob_story_mission_utils
// Params 6
// Checksum 0xfc926beb, Offset: 0x2a3a
// Size: 0x299
function function_49e5ca8428537e14( ob_activity_name, var_3ca8aff3d1e9fc14, notify_obj_complete, z_offset = 32, var_2e66ac816a078895 = 0, skipobjectivetext = 0 )
{
    assert( isdefined( ob_activity_name ), "<dev string:x106>" );
    assert( isdefined( var_3ca8aff3d1e9fc14 ), "<dev string:x14a>" );
    
    if ( isdefined( notify_obj_complete ) )
    {
        level endon( notify_obj_complete );
    }
    
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player_objective = spawnstruct();
    player_objective.obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_location", 0, 1 );
    waitframe();
    
    if ( !skipobjectivetext )
    {
        thread objective_text_show( ob_activity_name );
    }
    
    var_c7b1aae8162d8b58 = 0;
    player_objective.struct_array = objective_array_setup( var_3ca8aff3d1e9fc14 );
    player_objective.obj_id = function_b9cb179f9577f32a( player_objective.struct_array[ 0 ].origin );
    objidpoolmanager::objective_set_play_intro( player_objective.obj_id, !var_2e66ac816a078895 );
    objidpoolmanager::objective_set_play_outro( player_objective.obj_id, !var_2e66ac816a078895 );
    objidpoolmanager::objective_playermask_showtoall( player_objective.obj_id );
    function_2b8e3d3ae2a6414a( player_objective.obj_id, 1 );
    waitframe();
    
    while ( var_c7b1aae8162d8b58 < player_objective.struct_array.size )
    {
        objidpoolmanager::update_objective_position( player_objective.obj_id, player_objective.struct_array[ var_c7b1aae8162d8b58 ].origin + ( 0, 0, z_offset ) );
        
        foreach ( player in level.players )
        {
            thread function_9655c5ac2ca33fe( player_objective, player, var_c7b1aae8162d8b58 );
        }
        
        player_objective waittill( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
        
        if ( isdefined( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag ) )
        {
            level utility::flag_set( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag );
        }
        
        var_c7b1aae8162d8b58++;
    }
    
    objective_marker_clear( player_objective.obj_id );
    
    if ( isdefined( notify_obj_complete ) )
    {
        level notify( notify_obj_complete );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xc3614ee5, Offset: 0x2cdb
// Size: 0x81
function objective_array_setup( var_3ca8aff3d1e9fc14 )
{
    struct_array = [];
    s_obj_current = utility::getstruct( var_3ca8aff3d1e9fc14, "targetname" );
    
    while ( true )
    {
        struct_array[ struct_array.size ] = s_obj_current;
        
        if ( !isdefined( s_obj_current.target ) )
        {
            break;
        }
        
        s_obj_next = utility::getstruct( s_obj_current.target, "targetname" );
        
        if ( !isdefined( s_obj_next ) )
        {
            return;
        }
        
        s_obj_current = s_obj_next;
        waitframe();
    }
    
    return struct_array;
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0xa23f1d7b, Offset: 0x2d65
// Size: 0xf8
function function_9655c5ac2ca33fe( player_objective, player, var_c7b1aae8162d8b58 )
{
    player endon( #"death" );
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    player_objective endon( #"hash_2fa867d939a34fc6" );
    waitframe();
    
    if ( isdefined( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag_wait ) )
    {
        level utility::flag_wait( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag_wait );
    }
    else
    {
        var_7ae605d773736268 = squared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].radius );
        
        while ( distance2dsquared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].origin, player.origin ) > var_7ae605d773736268 )
        {
            waitframe();
        }
    }
    
    player_objective notify( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x6274fc83, Offset: 0x2e65
// Size: 0x64
function objective_text_show( var_930bd298a1235e7d, value, time_remaining )
{
    activity_instance = self;
    ob_contract_ui_widget::function_d3aa02fc5d62637d( var_930bd298a1235e7d, level.players );
    
    if ( isdefined( value ) )
    {
        ob_contract_ui_widget::function_855fd697c30b090c( value );
    }
    
    if ( isdefined( time_remaining ) )
    {
        ob_contract_ui_widget::function_e2652264f8a4b37c( time_remaining, level.players );
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xca2cc919, Offset: 0x2ed1
// Size: 0x105
function objective_marker_ping( objective_marker, players )
{
    waitframe();
    
    if ( !players || players.size <= 0 )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        origin = objective_getlocation( objective_marker, 0 );
        new_ping_index = player calloutmarkerping::function_5d7b7302e94b97c2( objective_marker, origin );
        
        if ( isdefined( new_ping_index ) )
        {
            player thread calloutmarkerping::function_3c501da3379eca0a( player, new_ping_index, undefined, [ "death_or_disconnect" ] );
        }
        
        if ( !isdefined( player.var_100965a2898fa20b ) )
        {
            player.var_100965a2898fa20b = [];
        }
        
        player.var_100965a2898fa20b[ objective_marker ] = new_ping_index;
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x627e461, Offset: 0x2fde
// Size: 0xca
function function_6c52650cb36dd9d3( objective_marker, players )
{
    if ( !isdefined( objective_marker ) )
    {
        return;
    }
    
    function_e7dea8423bedc2b6( objective_marker, players );
    
    if ( !players || players.size <= 0 )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player.var_100965a2898fa20b[ objective_marker ] ) )
        {
            player.var_100965a2898fa20b[ objective_marker ] = undefined;
        }
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x128e4a9b, Offset: 0x30b0
// Size: 0xe0
function function_e7dea8423bedc2b6( objective_marker, players )
{
    if ( !players || players.size <= 0 )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.var_100965a2898fa20b[ objective_marker ] ) || !player calloutmarkerping::isowner( player.var_100965a2898fa20b[ objective_marker ] ) )
        {
            continue;
        }
        
        player calloutmarkerping::function_7c0ee9d4b604e6d6( player.var_100965a2898fa20b[ objective_marker ] );
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x620e354a, Offset: 0x3198
// Size: 0x35
function function_315d79883d962ba7( value, max )
{
    activity_instance = self;
    ob_contract_ui_widget::setprogress( value, max, level.players );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xe71717cb, Offset: 0x31d5
// Size: 0x1e
function function_31f2c265b77aa2c1( difficulty )
{
    ob_contract_ui_widget::setdifficulty( difficulty, level.players );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x4ac56259, Offset: 0x31fb
// Size: 0x1e
function objective_timer_update( timeinseconds )
{
    ob_contract_ui_widget::function_e2652264f8a4b37c( timeinseconds, level.players );
}

// Namespace ob_story_mission_utils
// Params 6
// Checksum 0x2fda0c02, Offset: 0x3221
// Size: 0x92
function function_b3e9457491e7af72( var_930bd298a1235e7d, players, value, time_remaining, state = 2, difficulty = undefined )
{
    activity_instance = self;
    ob_contract_ui_widget::function_d3aa02fc5d62637d( var_930bd298a1235e7d, players, state );
    
    if ( isdefined( value ) )
    {
        ob_contract_ui_widget::function_fe5a48019d0d2e33( value, players );
    }
    
    if ( isdefined( time_remaining ) )
    {
        ob_contract_ui_widget::function_e2652264f8a4b37c( time_remaining, players );
    }
    
    if ( isdefined( difficulty ) )
    {
        ob_contract_ui_widget::setdifficulty( difficulty, players );
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x21d471ce, Offset: 0x32bb
// Size: 0x1f
function objective_text_clear()
{
    activity_instance = self;
    ob_contract_ui_widget::function_dac15947c2d451e9( level.players );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x94d8bf1d, Offset: 0x32e2
// Size: 0x22
function function_94bd9141862a4ba6( players )
{
    activity_instance = self;
    ob_contract_ui_widget::function_dac15947c2d451e9( players );
}

// Namespace ob_story_mission_utils
// Params 2, eflags: 0x4
// Checksum 0xbecb17d2, Offset: 0x330c
// Size: 0x244
function private function_95bc3e670c16c041( player, var_930bd298a1235e7d )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    player endon( #"disconnect" );
    player notifyonplayercommand( "toggle_map", "+focus" );
    player notifyonplayercommand( "toggle_map_kbm", "togglemap" );
    
    while ( true )
    {
        if ( player istacmapactive() )
        {
            player utility::waittill_any( "toggle_map", "toggle_map_kbm" );
        }
        
        result = player utility::waittill_any_in_array_or_timeout( [ "toggle_map", "toggle_map_kbm" ], 5 );
        
        if ( result == "timeout" && !player istacmapactive() )
        {
            ob_contract_ui_widget::function_dac15947c2d451e9( [ player ] );
            
            if ( isdefined( self.a_obj_id ) && self.a_obj_id.size > 0 )
            {
                foreach ( obj_id in self.a_obj_id )
                {
                    objective_marker_hide( obj_id, [ player ] );
                }
            }
            
            player utility::waittill_any( "toggle_map", "toggle_map_kbm" );
            ob_contract_ui_widget::function_d3aa02fc5d62637d( var_930bd298a1235e7d, [ player ] );
            
            if ( isdefined( self.a_obj_id ) && self.a_obj_id.size > 0 )
            {
                foreach ( obj_id in self.a_obj_id )
                {
                    objective_marker_show( obj_id, [ player ] );
                }
            }
        }
    }
    
    player notifyonplayercommandremove( "toggle_map", "+focus" );
    player notifyonplayercommandremove( "toggle_map_kbm", "togglemap" );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x7bf322ee, Offset: 0x3558
// Size: 0x9f
function function_b6384ff1268c6282()
{
    self notify( #"hash_c193e2fa73158792" );
    self endon( #"hash_c193e2fa73158792" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message );
        
        switch ( message )
        {
            case #"hash_8a66337b71ccec4c":
                self notify( #"tacmap_open" );
                break;
            case #"hash_899f65d5013659d0":
                self notify( #"tacmap_close" );
                break;
        }
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x2476fbb3, Offset: 0x35ff
// Size: 0x47
function function_b0fb462142682571( obj_entity, a_players, z_offset = 32 )
{
    obj_id = function_804834359f20ef5a( obj_entity, z_offset, a_players );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    return obj_id;
}

// Namespace ob_story_mission_utils
// Params 4
// Checksum 0x31b27e7c, Offset: 0x364f
// Size: 0x76
function function_c5f68c5406e92c4d( obj_origin, a_players, starts_story_mission = 0, z_offset = 32 )
{
    obj_marker_bundle_name = starts_story_mission ? "sat_ob_objectivemarker_storymissionstart" : "sat_ob_objectivemarker_location";
    obj_id = function_b9cb179f9577f32a( obj_origin, z_offset, a_players, obj_marker_bundle_name );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    return obj_id;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x2ecba370, Offset: 0x36ce
// Size: 0x27
function mission_objective_marker_show( obj_id, a_players )
{
    objective_marker_show( obj_id, a_players );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x2ecba371, Offset: 0x36fd
// Size: 0x28
function mission_objective_marker_hide( obj_id, a_players )
{
    objective_marker_hide( obj_id, a_players );
    function_2b8e3d3ae2a6414a( obj_id, 1 );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x697be5d7, Offset: 0x372d
// Size: 0x1f
function mission_objective_marker_clear( obj_id, a_players )
{
    objective_marker_clear( obj_id, a_players );
}

// Namespace ob_story_mission_utils
// Params 7
// Checksum 0x5f6cf902, Offset: 0x3754
// Size: 0x160
function function_b9cb179f9577f32a( obj_origin, z_offset = 0, a_players, obj_marker_bundle_name = "sat_ob_objectivemarker_storymissionmain", b_intro_outro = 1, var_82cbdb7aaa4626db = 0, hide_minimap = 1 )
{
    profilestart();
    
    if ( !isdefined( obj_origin ) )
    {
        /#
            iprintln( "<dev string:x19d>" );
        #/
        
        profilestop();
        return;
    }
    
    if ( isplayer( self ) )
    {
        self endon( #"death_or_disconnect" );
    }
    else
    {
        self endon( #"activity_ended", #"instance_destroyed" );
    }
    
    if ( !isdefined( self ) )
    {
        profilestop();
        return;
    }
    else if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( obj_marker_bundle_name );
    self.a_obj_id[ self.a_obj_id.size ] = obj_id;
    
    if ( b_intro_outro )
    {
        objidpoolmanager::objective_set_play_intro( obj_id, 1 );
        objidpoolmanager::objective_set_play_outro( obj_id, 1 );
    }
    else
    {
        objidpoolmanager::objective_set_play_intro( obj_id, 0 );
        objidpoolmanager::objective_set_play_outro( obj_id, 0 );
    }
    
    objidpoolmanager::update_objective_position( obj_id, obj_origin + ( 0, 0, z_offset ) );
    objidpoolmanager::objective_playermask_hidefromallplayers( obj_id );
    objective_marker_show( obj_id, a_players, var_82cbdb7aaa4626db );
    function_2b8e3d3ae2a6414a( obj_id, hide_minimap );
    profilestop();
    return obj_id;
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0xa01f242a, Offset: 0x38be
// Size: 0xcd
function function_804834359f20ef5a( obj_entity, z_offset = 80, a_players )
{
    profilestart();
    
    if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    if ( isdefined( self.var_9be376218db54aba ) )
    {
        obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( self.var_9be376218db54aba );
    }
    else
    {
        obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_location" );
    }
    
    self.a_obj_id[ self.a_obj_id.size ] = obj_id;
    objidpoolmanager::objective_set_play_intro( obj_id, 1 );
    objidpoolmanager::objective_set_play_outro( obj_id, 1 );
    objidpoolmanager::update_objective_onentity( obj_id, obj_entity );
    objidpoolmanager::update_objective_setzoffset( obj_id, z_offset );
    objective_marker_show( obj_id, a_players );
    function_2b8e3d3ae2a6414a( obj_id, 1 );
    profilestop();
    return obj_id;
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x214f8ec8, Offset: 0x3995
// Size: 0x181
function objective_marker_show( obj_id, a_players, var_82cbdb7aaa4626db )
{
    if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    if ( isdefined( obj_id ) )
    {
        if ( isarray( obj_id ) )
        {
            var_739b761382aa3203 = obj_id;
        }
        else
        {
            var_739b761382aa3203 = [ obj_id ];
        }
    }
    else
    {
        var_739b761382aa3203 = self.a_obj_id;
    }
    
    foreach ( obj_id in var_739b761382aa3203 )
    {
        assert( arraycontains( self.a_obj_id, obj_id ), "<dev string:x1e3>" );
        
        if ( !isdefined( a_players ) )
        {
            objidpoolmanager::objective_playermask_showtoall( obj_id );
        }
        else
        {
            foreach ( player in a_players )
            {
                objidpoolmanager::objective_playermask_addshowplayer( obj_id, player );
            }
        }
        
        function_2b8e3d3ae2a6414a( obj_id, 0 );
        
        if ( var_82cbdb7aaa4626db )
        {
            thread objective_marker_ping( obj_id, a_players );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x5d022943, Offset: 0x3b1e
// Size: 0x174
function objective_marker_hide( obj_id, a_players )
{
    if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    if ( isdefined( obj_id ) )
    {
        if ( isarray( obj_id ) )
        {
            var_b27e7e8baa89dbe = obj_id;
        }
        else
        {
            var_b27e7e8baa89dbe = [ obj_id ];
        }
    }
    else
    {
        var_b27e7e8baa89dbe = self.a_obj_id;
    }
    
    foreach ( obj_id in var_b27e7e8baa89dbe )
    {
        assert( arraycontains( self.a_obj_id, obj_id ), "<dev string:x1e3>" );
        
        if ( !isdefined( a_players ) )
        {
            objidpoolmanager::objective_playermask_hidefromall( obj_id );
        }
        else
        {
            foreach ( player in a_players )
            {
                objidpoolmanager::objective_playermask_hidefrom( obj_id, player );
            }
        }
        
        function_2b8e3d3ae2a6414a( obj_id, 1 );
        function_e7dea8423bedc2b6( obj_id, a_players );
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x6678cb8e, Offset: 0x3c9a
// Size: 0x119
function objective_marker_clear( obj_id, players )
{
    if ( isplayer( self ) )
    {
        self endon( #"death_or_disconnect" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    if ( isdefined( obj_id ) )
    {
        if ( isarray( obj_id ) )
        {
            var_6700fe567cc8f0ef = obj_id;
        }
        else
        {
            var_6700fe567cc8f0ef = [ obj_id ];
        }
    }
    else
    {
        var_6700fe567cc8f0ef = self.a_obj_id;
    }
    
    foreach ( obj_id in var_6700fe567cc8f0ef )
    {
        if ( arraycontains( self.a_obj_id, obj_id ) )
        {
            function_6c52650cb36dd9d3( obj_id, players );
            self.a_obj_id = arrayremove( self.a_obj_id, obj_id );
            namespace_d7fa4530141146a5::function_501e44ea1cb9219d( obj_id );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x120646ea, Offset: 0x3dbb
// Size: 0xd8
function objective_marker_clear_all()
{
    if ( !isdefined( level.objectiveidpool.active ) || level.objectiveidpool.active.size == 0 )
    {
        return;
    }
    
    foreach ( obj in level.objectiveidpool.active )
    {
        if ( objidpoolmanager::function_fb05d646a96ed99e( obj.objid ) )
        {
            continue;
        }
        
        objidpoolmanager::returnobjectiveid( obj.objid );
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x39575ac9, Offset: 0x3e9b
// Size: 0x76
function function_ab06e28322870f4( obj_origin, var_a0ba6d83e3c5a462, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    obj_circle = spawnquestcircle( "Quest_Ob", obj_origin[ 0 ], obj_origin[ 1 ], var_a0ba6d83e3c5a462, undefined );
    self.a_obj_circle[ self.a_obj_circle.size ] = obj_circle;
    function_ea26b2af32d9cfda( obj_circle, a_players );
    return obj_circle;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xd326810f, Offset: 0x3f1a
// Size: 0xc8
function function_ea26b2af32d9cfda( obj_circle, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x20b>" );
    
    if ( isdefined( a_players ) )
    {
        foreach ( player in a_players )
        {
            obj_circle showtoplayer( player );
        }
        
        return;
    }
    
    obj_circle show();
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xfc7264ab, Offset: 0x3fea
// Size: 0xc8
function function_2006c93a321c0277( obj_circle, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x20b>" );
    
    if ( isdefined( a_players ) )
    {
        foreach ( player in a_players )
        {
            obj_circle hidefromplayer( player );
        }
        
        return;
    }
    
    obj_circle hide();
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x76ff0b1b, Offset: 0x40ba
// Size: 0x6a
function function_352aa3aab98a0618( obj_circle )
{
    if ( !isdefined( obj_circle ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( !isdefined( self.a_obj_circle ) )
        {
            self.a_obj_circle = [];
        }
        
        assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x20b>" );
        self.a_obj_circle = arrayremove( self.a_obj_circle, obj_circle );
    }
    
    obj_circle delete();
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0x8a29361b, Offset: 0x412c
    // Size: 0x5, Type: dev
    function function_f64e4ff11c980e4e()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xa1496c82, Offset: 0x4139
// Size: 0x2da
function function_f20a9fe6c594f5b3( var_5310aea068a35a30 )
{
    if ( var_5310aea068a35a30 )
    {
        foreach ( player in level.players )
        {
            foreach ( player in level.players )
            {
                player val::set( "cinematic", "allow_jump", 0 );
                player val::set( "cinematic", "allow_movement", 0 );
                player val::set( "cinematic", "crouch", 0 );
                player val::set( "cinematic", "prone", 0 );
                player val::set( "cinematic", "melee", 0 );
                player val::set( "cinematic", "offhand_primary_weapons", 0 );
                player val::set( "cinematic", "offhand_secondary_weapons", 0 );
                player val::set( "cinematic", "weapon", 0 );
                player val::set( "cinematic", "damage", 0 );
                player val::set( "cinematic", "killstreaks", 0 );
                player val::set( "cinematic", "ignoreme", 1 );
                player val::set( "cinematic", "freezecontrols", 1 );
                player val::set( "cinematic", "ads", 0 );
                player val::set( "cinematic", "weapon_switch", 0 );
                player val::set( "cinematic", "action_slot_weapon", 0 );
                player val::set( "cinematic", "armor", 0 );
                player val::set( "cinematic", "supers", 0 );
                player val::set( "cinematic", "show_hud", 0 );
                player playerhide( 1 );
            }
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "cinematic" );
        player playershow( 1 );
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x67fe8221, Offset: 0x441b
// Size: 0x29
function function_30e437309fa64903()
{
    while ( true )
    {
        if ( utility::flag( "story_mission_party_check_complete" ) )
        {
            return;
        }
        
        /#
            iprintlnbold( "<dev string:x237>" );
        #/
        
        wait 3;
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0xe31df88c, Offset: 0x444c
// Size: 0x2ff
function function_b6605cd0fe35df2a( players, debug_print_msgs, activity_name )
{
    if ( coop::should_play_igcs() )
    {
        if ( !isarray( debug_print_msgs ) )
        {
            debug_print_msgs = [ debug_print_msgs ];
        }
        
        fade_time = 0.5;
        
        foreach ( player in players )
        {
            player thread hud_util::fade_out( fade_time, "black" );
            player val::set( "cinematic", "allow_movement", 0 );
            player val::set( "cinematic", "crouch", 0 );
            player val::set( "cinematic", "prone", 0 );
            player val::set( "cinematic", "melee", 0 );
            player val::set( "cinematic", "offhand_primary_weapons", 0 );
            player val::set( "cinematic", "offhand_secondary_weapons", 0 );
            player val::set( "cinematic", "weapon", 0 );
            player val::set( "cinematic", "damage", 0 );
            player val::set( "cinematic", "killstreaks", 0 );
            player val::set( "cinematic", "ignoreme", 1 );
            player val::set( "cinematic", "freezecontrols", 1 );
            player val::set( "cinematic", "ads", 0 );
            player val::set( "cinematic", "weapon_switch", 0 );
            player val::set( "cinematic", "action_slot_weapon", 0 );
            player val::set( "cinematic", "armor", 0 );
            player val::set( "cinematic", "supers", 0 );
        }
        
        wait fade_time;
        
        foreach ( debug_print_msg in debug_print_msgs )
        {
            iprintlnbold( debug_print_msg );
            wait 3.5;
        }
    }
    
    function_2686bb512b355040( activity_name );
    
    foreach ( player in players )
    {
        player val::reset_all( "cinematic" );
        player thread hud_util::fade_in( fade_time, "black" );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x900b09ff, Offset: 0x4753
// Size: 0x4e
function function_ecffad6077c8f9dc( var_ecffad6077c8f9dc = 1 )
{
    if ( var_ecffad6077c8f9dc )
    {
        val::set( "vm_animation", "ignoreme", 1 );
        val::set( "vm_animation", "damage", 0 );
        return;
    }
    
    val::reset_all( "vm_animation" );
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xff37b00f, Offset: 0x47a9
    // Size: 0x5, Type: dev
    function function_b12e83e970aa412b()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x79e700c6, Offset: 0x47b6
// Size: 0x268
function function_e6799e9a19df2365( targetname, var_e9564cd22ae43276 = %"hash_2b9705ca7545e18e", num_items = 4 )
{
    var_1a00a5a2ba836d4d = utility::getstructarray( targetname, "targetname" );
    
    foreach ( struct in var_1a00a5a2ba836d4d )
    {
        aligned_origin = ( int( struct.origin[ 0 ] ), int( struct.origin[ 1 ] ), int( struct.origin[ 2 ] ) );
        cache = common_cache::spawncache( %"hash_678525efe1c116c5", aligned_origin, struct.angles );
        
        /#
            if ( struct.origin != aligned_origin )
            {
                logstring( "<dev string:x25f>" + struct.origin + "<dev string:x351>" + aligned_origin );
            }
        #/
        
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "ob_sat_item_select_" ) )
        {
            var_33e1f9622e337b17 = hashcat( %"itemspawnentry:", struct.script_noteworthy );
            var_6a21abb6c002bb54 = %"itemspawnentry:ob_sat_item_ammo";
            common_cache::function_a09e7cf5bad99b64( cache, [ var_33e1f9622e337b17, var_6a21abb6c002bb54, var_6a21abb6c002bb54 ], 1 );
            continue;
        }
        
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "ob_sat_items_" ) )
        {
            current_item_list = hashcat( %"itemspawnlist:", struct.script_noteworthy ) ?? var_e9564cd22ae43276;
            current_num_items = struct.script_parameters ?? num_items;
            common_cache::function_a136b84fc5c0dfab( cache, current_item_list, current_num_items, 1 );
            continue;
        }
        
        current_item_list = var_e9564cd22ae43276;
        current_num_items = struct.script_parameters ?? num_items;
        common_cache::function_a136b84fc5c0dfab( cache, current_item_list, current_num_items, 1 );
    }
}

// Namespace ob_story_mission_utils
// Params 8
// Checksum 0x97e9e696, Offset: 0x4a26
// Size: 0x760
function item_spawn_weapon( struct_targetname, var_b60496d5b429ae0f, is_staged = 0, exclusive_owner = undefined, staggered_delay = 0, has_vfx = 0, n_max_weapon, var_f441b2b30952ec08 = 0 )
{
    if ( has_vfx )
    {
        level._effect[ "cradle_cracks_ground" ] = loadfxasset( "vfx_sat_wc_cradle_cracks_ground_med_a" );
    }
    
    if ( !isdefined( level.loot_drop_script_throttle ) )
    {
        level.loot_drop_script_throttle = throttle::throttle_initialize( "loot_drop_script", 1, level.framedurationseconds );
    }
    
    a_s_weapon = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( a_s_weapon.size == 0 )
    {
        return;
    }
    
    if ( isdefined( n_max_weapon ) )
    {
        n_max_weapon = minint( n_max_weapon, a_s_weapon.size );
        a_s_weapon = arrayrandomize( a_s_weapon );
    }
    else
    {
        n_max_weapon = a_s_weapon.size;
    }
    
    for ( i = 0; i < n_max_weapon ; i++ )
    {
        var_fe68cd50dcda7fdc = a_s_weapon[ i ];
        spawned_wpn = undefined;
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, var_fe68cd50dcda7fdc );
        
        if ( !isdefined( var_fe68cd50dcda7fdc.angles ) )
        {
            var_fe68cd50dcda7fdc.angles = ( 0, 0, 0 );
        }
        
        weapon_spawn_angles = var_fe68cd50dcda7fdc.angles - ( 0, 90, 0 );
        
        if ( is_staged )
        {
            wpn_spawn_options = common_item::function_bc5ff2958b71a708( var_fe68cd50dcda7fdc.origin, weapon_spawn_angles );
        }
        else
        {
            wpn_spawn_options = common_item::items_initspawnoptions_spawnfromposition( var_fe68cd50dcda7fdc.origin, weapon_spawn_angles );
        }
        
        wpn_spawn_options.var_90cdc5dbcd319e5d = 1;
        wpn_spawn_options.var_fd47e835523b473f = 1;
        wpn_spawn_options.var_8d4f327170228364 = 1;
        wpn_spawn_options.var_9161cf0784b6951d = 1;
        wpn_spawn_options.dropradiusscale = 0;
        wpn_spawn_options.var_23d3495c57d61bdf = 1;
        wpn_spawn_options.exclusiveowner = exclusive_owner;
        var_5b97ae4b727ee516 = strtok( var_fe68cd50dcda7fdc.script_noteworthy, "," );
        wpn_rarity = "base";
        
        if ( getdvarint( @"hash_b10ac56024891c37", 0 ) > 0 )
        {
            int_rarity = getdvarint( @"hash_b10ac56024891c37", 0 );
            a_str_rarity = [ "base", "green", "blue", "purple", "orange" ];
            int_rarity = clampint( int_rarity, 1, 5 );
            wpn_rarity = a_str_rarity[ int_rarity - 1 ];
        }
        else if ( isdefined( var_5b97ae4b727ee516[ 1 ] ) )
        {
            if ( isstartstr( var_5b97ae4b727ee516[ 1 ], "region_" ) && isdefined( function_695f0dcb1b47e6d9() ) )
            {
                var_546e4eb5269dbafa = function_695f0dcb1b47e6d9();
                
                switch ( var_5b97ae4b727ee516[ 1 ] )
                {
                    case #"hash_6536cab10ab5b441":
                        if ( utility::percent_chance( 75 ) )
                        {
                            int_rarity = var_546e4eb5269dbafa;
                        }
                        else if ( utility::percent_chance( 50 ) )
                        {
                            int_rarity = var_546e4eb5269dbafa + 1;
                        }
                        else
                        {
                            int_rarity = var_546e4eb5269dbafa - 1;
                        }
                        
                        break;
                    case #"hash_3bb983fc97af2bdc":
                        if ( utility::percent_chance( 75 ) )
                        {
                            int_rarity = var_546e4eb5269dbafa;
                        }
                        else
                        {
                            int_rarity = var_546e4eb5269dbafa - 1;
                        }
                        
                        int_rarity = randomintrange( var_546e4eb5269dbafa - 1, var_546e4eb5269dbafa + 1 );
                        break;
                    case #"hash_294284bc6ba746b6":
                        if ( utility::percent_chance( 75 ) )
                        {
                            int_rarity = var_546e4eb5269dbafa;
                        }
                        else
                        {
                            int_rarity = var_546e4eb5269dbafa + 1;
                        }
                        
                        break;
                    case #"hash_3394d11ccc22c5dc":
                        int_rarity = var_546e4eb5269dbafa - 1;
                        break;
                    case #"hash_cb16ee6efda2b4b6":
                        int_rarity = var_546e4eb5269dbafa + 1;
                        break;
                    case #"hash_3d93571cd20d96e8":
                    default:
                        int_rarity = var_546e4eb5269dbafa;
                        break;
                }
                
                a_str_rarity = [ "base", "green", "blue", "purple", "orange" ];
                int_rarity = clampint( int_rarity, 1, 5 );
                wpn_rarity = a_str_rarity[ int_rarity - 1 ];
            }
            else
            {
                wpn_rarity = var_5b97ae4b727ee516[ 1 ];
                
                if ( isdefined( var_5b97ae4b727ee516[ 2 ] ) && utility::cointoss() )
                {
                    wpn_rarity = var_5b97ae4b727ee516[ 2 ];
                }
            }
        }
        
        if ( isstartstr( var_5b97ae4b727ee516[ 0 ], "zm_" ) || isstartstr( var_5b97ae4b727ee516[ 0 ], "ob_" ) )
        {
            wpn_bundle = undefined;
            wpn_specific = var_5b97ae4b727ee516[ 0 ];
            
            if ( isdefined( wpn_rarity ) && wpn_rarity != "base" )
            {
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
                    wpn_list = "ob_sat_items_weapons_ar_sm_";
                    break;
                case #"hash_589e620d9c37ef93":
                case #"hash_fa0ed9f6bd4f4e9a":
                    wpn_list = "ob_sat_items_weapons_dm_sm_";
                    break;
                case #"hash_ba39cac9c099d4f1":
                case #"hash_fa27bdf6bd62aa3e":
                    wpn_list = "ob_sat_items_weapons_la_sm_";
                    break;
                case #"hash_2f2d546c2247838f":
                case #"hash_bb3bd3f7cd7a8a5c":
                case #"hash_fa27b9f6bd62a3f2":
                    wpn_list = "ob_sat_items_weapons_lm_sm_";
                    break;
                case #"hash_40a94c5d9e4e265b":
                case #"hash_fa24ddf6bd609e07":
                    wpn_list = "ob_sat_items_weapons_me_sm_";
                    break;
                case #"hash_719417cb1de832b6":
                case #"hash_fa4dbdf6bd80bf52":
                    wpn_list = "ob_sat_items_weapons_pi_sm_";
                    break;
                case #"hash_23209741b93850b5":
                case #"hash_fa50b4f6bd82efbe":
                    wpn_list = "ob_sat_items_weapons_sh_sm_";
                    break;
                case #"hash_900cb96c552c5e8e":
                case #"hash_fa50b9f6bd82f79d":
                    wpn_list = "ob_sat_items_weapons_sm_sm_";
                    break;
                case #"hash_6191aaef9f922f96":
                case #"hash_fa50b6f6bd82f2e4":
                    wpn_list = "ob_sat_items_weapons_sn_sm_";
                    break;
                default:
                    wpn_list = "ob_sat_items_weapons_story_";
                    break;
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
            
            thread item_cleanup( spawned_wpn, var_b60496d5b429ae0f, var_f441b2b30952ec08 );
        }
        
        if ( has_vfx )
        {
            playfx( utility::getfx( "cradle_cracks_ground" ), var_fe68cd50dcda7fdc.origin );
        }
        
        wait staggered_delay;
        waitframe();
    }
}

// Namespace ob_story_mission_utils
// Params 8
// Checksum 0xb3704025, Offset: 0x518e
// Size: 0x682
function item_spawn_equipment( struct_targetname, var_b60496d5b429ae0f, is_staged = 0, exclusive_owner = undefined, staggered_delay = 0, has_vfx = 0, n_max_equipment, var_f441b2b30952ec08 = 0 )
{
    if ( has_vfx )
    {
        level._effect[ "cradle_cracks_ground" ] = loadfxasset( "vfx_sat_wc_cradle_cracks_ground_med_a" );
    }
    
    if ( !isdefined( level.loot_drop_script_throttle ) )
    {
        level.loot_drop_script_throttle = throttle::throttle_initialize( "loot_drop_script", 1, level.framedurationseconds );
    }
    
    a_s_equipment = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( a_s_equipment.size == 0 )
    {
        return;
    }
    
    if ( isdefined( n_max_equipment ) )
    {
        n_max_equipment = minint( n_max_equipment, a_s_equipment.size );
        a_s_equipment = arrayrandomize( a_s_equipment );
    }
    else
    {
        n_max_equipment = a_s_equipment.size;
    }
    
    for ( struct_index = 0; struct_index < n_max_equipment ; struct_index++ )
    {
        s_equipment = a_s_equipment[ struct_index ];
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, s_equipment );
        var_20cb062e6c21e1ee = 1;
        
        if ( isdefined( s_equipment.script_count ) || isdefined( s_equipment.script_count_min ) || isdefined( s_equipment.script_count_max ) )
        {
            if ( isdefined( s_equipment.script_count_max ) )
            {
                equip_min = 0;
                
                if ( isdefined( s_equipment.script_count_min ) )
                {
                    equip_min = s_equipment.script_count_min;
                }
                
                var_20cb062e6c21e1ee = randomintrange( equip_min, s_equipment.script_count_max + 1 );
            }
            else if ( isdefined( s_equipment.script_count ) || isdefined( s_equipment.script_count_min ) )
            {
                var_20cb062e6c21e1ee = s_equipment.script_count;
            }
        }
        
        if ( var_20cb062e6c21e1ee == 0 )
        {
            waitframe();
            continue;
        }
        else if ( is_staged && var_20cb062e6c21e1ee == 1 )
        {
            if ( !isdefined( s_equipment.angles ) )
            {
                s_equipment.angles = ( 0, 0, 0 );
            }
            
            switch ( s_equipment.script_noteworthy )
            {
                case #"hash_edfcca2b8fe9abe0":
                    s_equipment.angles += ( -90, 0, 0 );
                    s_equipment.origin += anglestoup( s_equipment.angles ) * -5;
                    break;
                case #"hash_a40b479c6ab366":
                    s_equipment.origin += anglestoup( s_equipment.angles ) * -1;
                    break;
                case #"hash_e20a1cb721478068":
                    s_equipment.angles += ( 0, -180, 0 );
                    break;
                case #"hash_557ba94ba739c4c":
                case #"hash_3455fe1fe35951ab":
                case #"hash_419eab1e8a7645bb":
                case #"hash_45e32d5105d66e18":
                case #"hash_49112deb8c7b381e":
                case #"hash_4a8ef2d0cc3b55f6":
                case #"hash_4ed02928ce59f855":
                case #"hash_6a7008c7d35dbd31":
                case #"hash_724516071c9bb3b5":
                case #"hash_bf62c5c4f75e5dd7":
                case #"hash_c0e50f898fc13a44":
                case #"hash_db804599f154aaf2":
                case #"hash_fe6ab434e1c513ae":
                case #"hash_fee35589f858a150":
                    s_equipment.origin += anglestoup( s_equipment.angles ) * -5;
                    break;
                case #"hash_5b62411c9a2b7afa":
                default:
                    break;
            }
            
            equip_spawn_options = common_item::function_bc5ff2958b71a708( s_equipment.origin, s_equipment.angles );
        }
        else
        {
            equip_spawn_options = common_item::items_initspawnoptions_spawnfromposition( s_equipment.origin, s_equipment.angles );
        }
        
        equip_spawn_options.var_90cdc5dbcd319e5d = 1;
        equip_spawn_options.var_fd47e835523b473f = 1;
        equip_spawn_options.exclusiveowner = exclusive_owner;
        
        if ( var_20cb062e6c21e1ee > 1 )
        {
            if ( isdefined( s_equipment.radius ) )
            {
                equip_spawn_options.dropradiusscale = s_equipment.radius / 64;
            }
            else
            {
                equip_spawn_options.dropradiusscale = 1;
            }
        }
        else
        {
            equip_spawn_options.var_8d4f327170228364 = 1;
            equip_spawn_options.var_9161cf0784b6951d = 1;
            equip_spawn_options.dropradiusscale = 0;
            equip_spawn_options.var_23d3495c57d61bdf = 1;
        }
        
        equip_type = s_equipment.script_noteworthy;
        
        if ( isstartstr( equip_type, "zm_" ) || isstartstr( equip_type, "ob_" ) )
        {
            equip_bundle = undefined;
            equip_bundle = getscriptbundle( "itemspawnentry:" + equip_type );
            
            if ( isdefined( equip_bundle ) )
            {
                spawned_equip = common_item::function_61c2c0251e742ffd( equip_bundle, var_20cb062e6c21e1ee, equip_spawn_options );
            }
        }
        else
        {
            switch ( equip_type )
            {
                case #"hash_339227cb650975db":
                    equip_list = "ob_sat_items_lethals";
                    break;
                case #"hash_850999d7864fa3b4":
                    equip_list = "ob_sat_items_tacticals";
                    break;
                case #"hash_293629fa55ab7dd3":
                    equip_list = "ob_sat_items_zm_lethals";
                    break;
                case #"hash_4d1dbaaa0bfd6c7c":
                    equip_list = "ob_sat_items_zm_tacticals";
                    break;
                case #"hash_ed740cdc7ab43d5":
                    equip_list = "ob_sat_items_field_upgrades";
                    break;
                default:
                    equip_list = "ob_sat_items_equipment_sm";
                    break;
            }
            
            spawned_equip = common_item::function_38cde6a6acb68ea6( equip_list, 1, equip_spawn_options );
            
            if ( var_20cb062e6c21e1ee > 1 )
            {
                equip_bundle = undefined;
                equip_bundle = common_item::function_6b8ff3d5f2688336( spawned_equip[ 0 ] );
                
                if ( isdefined( equip_bundle ) )
                {
                    for ( var_d3fc17e3e0f6a67d = 0; var_d3fc17e3e0f6a67d < var_20cb062e6c21e1ee - 1 ; var_d3fc17e3e0f6a67d++ )
                    {
                        add_equip = common_item::function_61c2c0251e742ffd( equip_bundle, var_20cb062e6c21e1ee, equip_spawn_options );
                        spawned_equip[ spawned_equip.size ] = add_equip;
                    }
                }
            }
        }
        
        if ( isdefined( spawned_equip ) )
        {
            thread item_cleanup( spawned_equip, var_b60496d5b429ae0f, var_f441b2b30952ec08 );
        }
        
        if ( has_vfx )
        {
            playfx( utility::getfx( "cradle_cracks_ground" ), s_equipment.origin );
        }
        
        wait staggered_delay;
        waitframe();
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x4c7d1f1d, Offset: 0x5818
// Size: 0xfb
function item_cleanup( item, var_b60496d5b429ae0f, var_f441b2b30952ec08 = 0 )
{
    if ( var_f441b2b30952ec08 )
    {
        return;
    }
    
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( var_b60496d5b429ae0f );
    }
    
    if ( !isarray( item ) )
    {
        var_f0110ccab3f4a8a6 = [ item ];
    }
    else
    {
        var_f0110ccab3f4a8a6 = item;
    }
    
    foreach ( item in var_f0110ccab3f4a8a6 )
    {
        if ( isdefined( item ) )
        {
            item.cleanupdisabled = 0;
            item.var_fd47e835523b473f = 0;
            item thread common_item::items_scriptable_waitandcleanup( 90 );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xf5b00079, Offset: 0x591b
// Size: 0xdf
function function_fe3c20270b6e910a( var_b0ca7734f892c402 )
{
    elevator = getent( var_b0ca7734f892c402, #targetname );
    var_147999ba87340b1d = getscriptablearray( "elevator_ammo_restock_crate", #script_noteworthy );
    
    if ( !isdefined( elevator ) || !isdefined( var_147999ba87340b1d ) )
    {
        /#
            iprintlnbold( "<dev string:x364>" );
        #/
        
        return;
    }
    
    foreach ( ammo_crate in var_147999ba87340b1d )
    {
        if ( isdefined( ammo_crate ) )
        {
            ammo_crate enablelinkto();
            wait 1;
            ammo_crate linkto( elevator );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 7
// Checksum 0x6cad1f6a, Offset: 0x5a02
// Size: 0x2b8
function function_fa27c4afc0f886da( str_targetname = "lootSpawn", var_b60496d5b429ae0f, is_staged = 0, exclusive_owner = undefined, staggered_delay = 0, has_vfx = 0, var_f441b2b30952ec08 = 0 )
{
    a_s_items = utility::getstructarray( str_targetname, "targetname" );
    
    foreach ( var_c5fb7b9c0ca383b7 in a_s_items )
    {
        type = var_c5fb7b9c0ca383b7.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            waitframe();
            continue;
        }
        
        item_ref = undefined;
        
        switch ( type )
        {
            case #"hash_7b000c17064a1f80":
                item_ref = "equip_armorplate";
                break;
        }
        
        if ( !isdefined( item_ref ) )
        {
            waitframe();
            continue;
        }
        
        name = common_item_database::function_a4f0a21951180013( item_ref );
        throttle::throttle_wait_in_queue( level.loot_drop_script_throttle, var_c5fb7b9c0ca383b7 );
        
        if ( !isdefined( var_c5fb7b9c0ca383b7.angles ) )
        {
            var_c5fb7b9c0ca383b7.angles = ( 0, 0, 0 );
        }
        
        var_c5fb7b9c0ca383b7.angles -= ( 0, 90, 0 );
        
        if ( is_staged )
        {
            spawn_options = common_item::function_bc5ff2958b71a708( var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
        }
        else
        {
            spawn_options = common_item::items_initspawnoptions_spawnfromposition( var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
        }
        
        spawn_options.var_90cdc5dbcd319e5d = 1;
        spawn_options.var_fd47e835523b473f = 1;
        spawn_options.var_8d4f327170228364 = 1;
        spawn_options.var_9161cf0784b6951d = 1;
        spawn_options.dropradiusscale = 0;
        spawn_options.var_23d3495c57d61bdf = 1;
        spawn_options.exclusiveowner = exclusive_owner;
        spawned_item = common_item::function_61c2c0251e742ffd( name, 1, spawn_options );
        
        if ( isdefined( spawned_item ) )
        {
            thread item_cleanup( spawned_item, var_b60496d5b429ae0f, var_f441b2b30952ec08 );
        }
        
        if ( has_vfx )
        {
            playfx( utility::getfx( "cradle_cracks_ground" ), var_c5fb7b9c0ca383b7.origin );
        }
        
        wait staggered_delay;
        waitframe();
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xb91e0347, Offset: 0x5cc2
// Size: 0x7b
function function_97fcb77435f4ba9b( player, position )
{
    active_story_mission = story_contract_util::function_35a4b91d1599df3e( player );
    
    switch ( active_story_mission.key )
    {
        case #"sag_intro":
        case #"sag_mini_boss":
        case #"sag_stronghold":
            return "ob_sat_story_items_zone_def_tier_1";
        default:
            return ob_activity_utility::function_11635f111a5a5ae3( position );
    }
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xe743701a, Offset: 0x5d45
    // Size: 0x5, Type: dev
    function function_c1304ccc6920b0ec()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xdf8cba54, Offset: 0x5d52
// Size: 0x11
function function_5bc70e604efd304()
{
    supers_mp::givesuper( "super_survival_life_drain", undefined, 1 );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x3bbb0d9, Offset: 0x5d6b
// Size: 0x11
function function_49277deccb8e5215()
{
    supers_mp::givesuper( "super_frost_blast", undefined, 1 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xc9029d8d, Offset: 0x5d84
// Size: 0x3f
function function_288fdad79fa2a11( var_85a31aa28ae2fc7a = 1 )
{
    if ( var_85a31aa28ae2fc7a )
    {
        equipment_mp::giveequipment( "equip_super_grappling_hook_sm", "secondary" );
        return;
    }
    
    equipment_mp::giveequipment( "equip_super_grappling_hook", "secondary" );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x2ac211d3, Offset: 0x5dcb
// Size: 0x50
function function_a1cd17816bae5f6()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    mega_jump = "equip_super_mega_jump";
    equipment_mp::giveequipment( mega_jump, "secondary" );
    equipment_mp::setequipmentammo( mega_jump, 3 );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xaa2407ec, Offset: 0x5e23
// Size: 0x99
function refill_super_mega_jump()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_17468ca0327c5fd5" );
    mega_jump = "equip_super_mega_jump";
    
    while ( true )
    {
        if ( equipment_mp::hasequipment( mega_jump ) )
        {
            var_f6d1f05c41cc8aeb = equipment_mp::getequipmentammo( mega_jump );
            var_f0a78fa090433bda = equipment_mp::getequipmentmaxammo( mega_jump );
            
            if ( !isdefined( var_f6d1f05c41cc8aeb ) || var_f6d1f05c41cc8aeb < var_f0a78fa090433bda )
            {
                equipment_mp::incrementequipmentammo( mega_jump, var_f0a78fa090433bda );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x2d32a499, Offset: 0x5ec4
// Size: 0x11
function function_2383fc8bfc3074d2()
{
    supers_mp::givesuper( "super_war_machine", undefined, 1 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x3c136372, Offset: 0x5edd
// Size: 0x55
function function_a67ead85ff821fdf( amount )
{
    self.perkpackagedata.overridepointsneeded = amount;
    superinfo = supers_mp::getcurrentsuper( #"tactical" );
    superinfo.staticdata.pointsneeded = amount;
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x923e6137, Offset: 0x5f3a
// Size: 0x35
function player_loadout_save( save_field_name )
{
    self endon( #"death_or_disconnect" );
    var_4dafad3f0f3d987d = store_player_loadout( self );
    save::player_set_data( save_field_name, var_4dafad3f0f3d987d );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x50813fac, Offset: 0x5f77
// Size: 0x227
function store_player_loadout( player )
{
    player utility::ent_flag_waitopen_any( "restoring_loadout" );
    currentloadout = spawnstruct();
    currentloadout.rechargeEquipment = player.pers[ "rechargeEquipment" ];
    
    if ( isdefined( player.primaryweapons[ 0 ] ) )
    {
        currentloadout.primary = player common_instance_inventory::function_34f09daaeaad639e( player.primaryweapons[ 0 ] );
        currentloadout.primaryclip = player getweaponammoclip( player.primaryweapons[ 0 ] );
        currentloadout.primarystock = player getweaponammostock( player.primaryweapons[ 0 ] );
    }
    
    if ( isdefined( player.primaryweapons[ 1 ] ) )
    {
        currentloadout.secondary = player common_instance_inventory::function_34f09daaeaad639e( player.primaryweapons[ 1 ] );
        currentloadout.secondaryclip = player getweaponammoclip( player.primaryweapons[ 1 ] );
        currentloadout.secondarystock = player getweaponammostock( player.primaryweapons[ 1 ] );
    }
    
    if ( isdefined( player.currentprimaryweapon ) )
    {
        currentloadout.currentweapon = getweaponbasename( player.currentprimaryweapon );
    }
    
    if ( isdefined( player.meleeweapons[ 0 ] ) )
    {
        currentloadout.tertiary = player common_instance_inventory::function_34f09daaeaad639e( player.meleeweapons[ 0 ] );
    }
    
    currentloadout.primaryequipment = player equipment_mp::getcurrentequipment( "primary" );
    currentloadout.var_c547153026652d56 = player equipment_mp::getequipmentslotammo( "primary" );
    currentloadout.secondaryequipment = player equipment_mp::getcurrentequipment( "secondary" );
    currentloadout.var_6a168be0e4faa066 = player equipment_mp::getequipmentslotammo( "secondary" );
    
    if ( isdefined( player.super ) )
    {
        currentloadout.currentsuper = player.super.staticdata.ref;
    }
    
    return currentloadout;
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0xf546e8cc, Offset: 0x61a7
// Size: 0x6dc
function load_player_loadout( player, loadoutstruct, var_df3a53d8ae54579b = 1 )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( level.coop_reload )
    {
        streakdata = structcopy( player.streakdata, 1 );
        player killstreaks::clearkillstreaks();
        
        foreach ( streak in streakdata.streaks )
        {
            player killstreaks::awardkillstreak( streak.streakname, "other", undefined, undefined, undefined, 1 );
        }
    }
    
    if ( !isdefined( loadoutstruct ) )
    {
        assertmsg( "<dev string:x3c1>" );
    }
    
    player.pers[ "rechargeEquipment" ] = loadoutstruct.rechargeEquipment;
    player perkpackage::perkpackage_initpersdata();
    
    foreach ( weapon in player.primaryweapons )
    {
        player takeweapon( weapon );
    }
    
    player utility::ent_flag_set( "restoring_loadout" );
    player equipment_mp::takeequipment( "primary" );
    player equipment_mp::takeequipment( "secondary" );
    weaponprimary = undefined;
    var_f8995ffbf8047610 = undefined;
    
    if ( loadoutstruct.primary.lootid )
    {
        weaponprimary = player common_instance_inventory::function_ba123c1855fc926( loadoutstruct.primary );
        
        if ( isdefined( weaponprimary ) )
        {
            player inventory_utility::_giveweapon( weaponprimary, undefined, undefined, 1 );
            
            if ( isdefined( loadoutstruct.primary.rarity ) )
            {
                player utility::delaythread( 0.1, &item_weapon::function_40e1cbd0e1f47d1a, weaponprimary, loadoutstruct.primary.rarity );
            }
            
            clipammo = loadoutstruct.primaryclip;
            stockammo = loadoutstruct.primarystock;
            
            if ( var_df3a53d8ae54579b )
            {
                clipsize = weaponclipsize( weaponprimary );
                clipammo = clipsize;
                stockammo = int( max( stockammo, clipsize * 2 ) );
            }
            
            player setweaponammoclip( weaponprimary, clipammo );
            player setweaponammostock( weaponprimary, stockammo );
            weapon::fixupplayerweapons( player, weaponprimary );
        }
    }
    
    if ( loadoutstruct.secondary.lootid )
    {
        var_f8995ffbf8047610 = player common_instance_inventory::function_ba123c1855fc926( loadoutstruct.secondary );
        
        if ( isdefined( var_f8995ffbf8047610 ) )
        {
            player inventory_utility::_giveweapon( var_f8995ffbf8047610, undefined, undefined, 1 );
            
            if ( isdefined( loadoutstruct.secondary.rarity ) )
            {
                player utility::delaythread( 0.1, &item_weapon::function_40e1cbd0e1f47d1a, var_f8995ffbf8047610, loadoutstruct.secondary.rarity );
            }
            
            clipammo = loadoutstruct.secondaryclip;
            stockammo = loadoutstruct.secondarystock;
            
            if ( var_df3a53d8ae54579b )
            {
                clipsize = weaponclipsize( var_f8995ffbf8047610 );
                clipammo = clipsize;
                stockammo = int( max( stockammo, clipsize * 2 ) );
            }
            
            player setweaponammoclip( var_f8995ffbf8047610, clipammo );
            player setweaponammostock( var_f8995ffbf8047610, stockammo );
            weapon::fixupplayerweapons( player, var_f8995ffbf8047610 );
        }
    }
    
    if ( loadoutstruct.tertiary.lootid )
    {
        weapontertiary = player common_instance_inventory::function_ba123c1855fc926( loadoutstruct.tertiary );
        
        if ( isdefined( weapontertiary ) )
        {
            player inventory_utility::_giveweapon( weapontertiary, undefined, undefined, 1 );
            player weapon::function_b4c9549dee5d0fc5( weapontertiary );
            
            if ( isdefined( loadoutstruct.tertiary.rarity ) )
            {
                player utility::delaythread( 0.1, &item_weapon::function_40e1cbd0e1f47d1a, weapontertiary, loadoutstruct.tertiary.rarity );
            }
        }
    }
    
    if ( isdefined( loadoutstruct.primaryequipment ) )
    {
        var_c547153026652d56 = int( max( loadoutstruct.var_c547153026652d56, var_df3a53d8ae54579b ? 1 : 0 ) );
        player equipment_mp::giveequipment( loadoutstruct.primaryequipment, "primary" );
        player equipment_mp::setequipmentammo( loadoutstruct.primaryequipment, var_c547153026652d56 );
    }
    
    if ( isdefined( loadoutstruct.secondaryequipment ) )
    {
        var_6a168be0e4faa066 = int( max( loadoutstruct.var_6a168be0e4faa066, var_df3a53d8ae54579b ? 1 : 0 ) );
        player equipment_mp::giveequipment( loadoutstruct.secondaryequipment, "secondary" );
        player equipment_mp::setequipmentammo( loadoutstruct.secondaryequipment, var_6a168be0e4faa066 );
        player function_1de701092565167( loadoutstruct.secondaryequipment, var_6a168be0e4faa066 );
    }
    
    if ( isdefined( loadoutstruct.currentweapon ) )
    {
        if ( isdefined( weaponprimary ) && loadoutstruct.currentweapon == getweaponbasename( weaponprimary ) )
        {
            player inventory_utility::domonitoredweaponswitch( weaponprimary, 1 );
        }
        else if ( isdefined( var_f8995ffbf8047610 ) && loadoutstruct.currentweapon == getweaponbasename( var_f8995ffbf8047610 ) )
        {
            player inventory_utility::domonitoredweaponswitch( var_f8995ffbf8047610, 1 );
        }
    }
    
    if ( isdefined( loadoutstruct.currentsuper ) )
    {
        player perkpackage::perkpackage_giveoverridefieldupgrades( loadoutstruct.currentsuper );
        player supers_mp::givesuper( loadoutstruct.currentsuper, undefined, 1 );
    }
    else
    {
        player perkpackage::perkpackage_giveoverridefieldupgrades( "none" );
        player supers_mp::givesuper( "none", undefined, 1 );
    }
    
    wait 1;
    weaponpriority = [ weaponprimary, var_f8995ffbf8047610 ];
    var_cd7bb6f332ee144e = undefined;
    
    foreach ( weapon in weaponpriority )
    {
        if ( isdefined( loadoutstruct.currentweapon ) && weapon.basename == loadoutstruct.currentweapon || !isdefined( var_cd7bb6f332ee144e ) )
        {
            var_cd7bb6f332ee144e = weapon;
        }
    }
    
    if ( player utility::ent_flag_exist( "restoring_loadout" ) )
    {
        player utility::ent_flag_clear( "restoring_loadout" );
    }
    
    player thread function_97b6d033ac66e1bd( var_cd7bb6f332ee144e );
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x480dbded, Offset: 0x688b
// Size: 0x109
function private function_97b6d033ac66e1bd( var_cd7bb6f332ee144e )
{
    assert( isplayer( self ) );
    assert( isthreaded() );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( var_cd7bb6f332ee144e ) )
    {
        return;
    }
    
    while ( val::get( "freezecontrols" ) )
    {
        waitframe();
    }
    
    currentweapon = self.currentprimaryweapon;
    
    if ( !currentweapon || isnullweapon( currentweapon ) )
    {
        foreach ( ownedweapon in self.primaryweapons )
        {
            if ( ownedweapon && ownedweapon.basename == var_cd7bb6f332ee144e.basename )
            {
                self switchtoweaponimmediate( ownedweapon );
                break;
            }
        }
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x713e8f95, Offset: 0x699c
// Size: 0xc3
function function_6fd9c77130917eb1()
{
    assert( isplayer( self ) );
    self endon( #"death_or_disconnect" );
    wait 1;
    
    foreach ( weapon in self.primaryweapons )
    {
        clipsize = weaponclipsize( weapon );
        stockammo = utility::get_max_stock_ammo( weapon, 0 );
        self setweaponammoclip( weapon, clipsize );
        self setweaponammostock( weapon, stockammo );
    }
}

// Namespace ob_story_mission_utils
// Params 2, eflags: 0x4
// Checksum 0x18afeded, Offset: 0x6a67
// Size: 0x106
function private function_1de701092565167( equipmentref, equipmentammo )
{
    assert( isplayer( self ) );
    player = self;
    tableinfo = equipment_mp::getequipmenttableinfo( equipmentref );
    superinfo = player.tacticalsuper;
    
    if ( isdefined( tableinfo ) && isdefined( superinfo ) && level.var_b7e70fa484e134dc )
    {
        if ( tableinfo.bundle.issuper && tableinfo.bundle.superref == superinfo.staticdata.ref )
        {
            maxammo = player equipment_mp::getequipmentmaxammo( equipmentref );
            var_c72220043cd6bb2 = 0;
            
            if ( maxammo > 0 )
            {
                var_c72220043cd6bb2 = equipmentammo * superinfo.staticdata.pointsneeded / maxammo;
            }
            
            superinfo.basepoints = var_c72220043cd6bb2;
        }
    }
}

/#

    // Namespace ob_story_mission_utils
    // Params 1
    // Checksum 0xf6c6a974, Offset: 0x6b75
    // Size: 0xe1, Type: dev
    function function_c512e98688e4e357( player )
    {
        level endon( #"game_ended" );
        player notify( #"hash_d919500479ffb0a8" );
        player endon( #"hash_d919500479ffb0a8" );
        player endon( #"death_or_disconnect" );
        player notifyonplayercommand( "<dev string:x3db>", "<dev string:x3ee>" );
        player notifyonplayercommand( "<dev string:x3fa>", "<dev string:x40d>" );
        
        while ( getdvarint( @"hash_6430560bc1ca31b1", 0 ) )
        {
            result = player utility::waittill_any_return( "<dev string:x3db>", "<dev string:x3fa>" );
            
            if ( result == "<dev string:x3db>" )
            {
                iprintlnbold( "<dev string:x415>" );
                player.debugloadout = store_player_loadout( player );
            }
            else
            {
                iprintlnbold( "<dev string:x42b>" );
                load_player_loadout( player, player.debugloadout );
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xe1d0a58b, Offset: 0x6c5e
// Size: 0x8f
function init_loadout_table( classtable )
{
    loadouttable = isxhashasset( classtable ) ? classtable : "classtable:" + classtable;
    var_2f4e6505b731029a = class::function_868832c7872f848e( loadouttable );
    loadouts = [];
    
    for ( classindex = 0; classindex < var_2f4e6505b731029a ; classindex++ )
    {
        loadoutentry = spawnstruct();
        loadoutentry.loadout = create_player_loadout( classindex, loadouttable );
        loadouts[ loadouts.size ] = loadoutentry;
    }
    
    return loadouts;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x9aee92ab, Offset: 0x6cf6
// Size: 0x32
function create_player_loadout( classindex, table )
{
    var_596fc0475db17612 = class::table_getitem( table, classindex );
    return class::function_79947c7814a64d0e( var_596fc0475db17612 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xccf6cbde, Offset: 0x6d31
// Size: 0x29
function function_e78f206896829a34( ref )
{
    loadout = store_player_loadout( self );
    save::player_set_data( ref, loadout );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xb7048f99, Offset: 0x6d62
// Size: 0x30
function function_e2adc03861e49ea7( ref )
{
    restoredloadout = save::player_get_data( ref );
    
    if ( isdefined( restoredloadout ) )
    {
        load_player_loadout( self, restoredloadout );
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x11357f42, Offset: 0x6d9a
// Size: 0xe1
function validate_activity_name( activity_name )
{
    if ( !isdefined( level.activity_dictionary ) )
    {
        level.activity_dictionary = [];
        
        foreach ( index, activity in level.activity_array )
        {
            level.activity_dictionary[ tolower( activity[ "activity_name" ] ) ] = index;
        }
    }
    
    if ( !isdefined( level.activity_dictionary[ tolower( activity_name ) ] ) )
    {
        firstactivity = level.activity_array[ 0 ][ "activity_name" ];
        return firstactivity;
    }
    
    return activity_name;
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x47fab18a, Offset: 0x6e84
// Size: 0x185
function function_d4b28732504a2a08( fauxspawn, revivespawn )
{
    player = self;
    player endon( #"disconnect" );
    forcedloadout = level.coop_reload == 2;
    var_a8326d2bc4fd9c60 = isdefined( player save::player_get_data( "ob_sm_checkpoint_loadout" ) );
    
    if ( isdefined( level.loadout_classtable ) )
    {
        missiondata = utility::callsharedfunc( #"save", #"mission_get_data" );
        
        if ( isdefined( missiondata.activity_current ) )
        {
            activity_name = missiondata.activity_current;
        }
        else
        {
            activity_name = validate_activity_name( getdvar( @"start", level.activity_array[ 0 ][ "activity_name" ] ) );
        }
        
        forcedloadout = forcedloadout || level.var_9bef01ac1984cb4[ activity_name ];
        player function_c7a852929e36a3ee( level.loadout_classtable, level.activity_loadout[ activity_name ].index, level.activity_loadout[ activity_name ].rarity, undefined, level.activity_loadout[ activity_name ].var_f91170067a6d805c );
    }
    
    if ( !forcedloadout && var_a8326d2bc4fd9c60 )
    {
        player thread ob_gametype_story_mission::function_4cded001aa8458fb();
    }
    
    if ( level.coop_reload == 2 )
    {
        player utility::delaythread( level.framedurationseconds * 2, &ob_gametype_story_mission::player_loadout_save, "ob_sm_checkpoint_loadout" );
    }
}

// Namespace ob_story_mission_utils
// Params 8
// Checksum 0xebfde74b, Offset: 0x7011
// Size: 0x72
function function_3b9c5aa009cba304( classtablename, tableindex, n_weapon_rarity, var_cb97d9c847fb01e3 = "primary", var_f91170067a6d805c = 1, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced )
{
    thread function_ab4f5b5109e40545( classtablename, tableindex, n_weapon_rarity, var_cb97d9c847fb01e3, var_f91170067a6d805c, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced );
}

// Namespace ob_story_mission_utils
// Params 8, eflags: 0xc
// Checksum 0xced164b7, Offset: 0x708b
// Size: 0xb2
function private function_ab4f5b5109e40545( classtablename, tableindex, n_weapon_rarity, var_cb97d9c847fb01e3 = "primary", var_f91170067a6d805c = 1, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced )
{
    self notify( #"hash_b5cae59c3ff11bdd" );
    self endon( #"hash_b5cae59c3ff11bdd" );
    player = self;
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "squad_play_begin" );
    function_c7a852929e36a3ee( classtablename, tableindex, n_weapon_rarity, var_cb97d9c847fb01e3, var_f91170067a6d805c, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced );
}

// Namespace ob_story_mission_utils
// Params 8, eflags: 0x4
// Checksum 0x1255b948, Offset: 0x7145
// Size: 0x9e
function private function_c7a852929e36a3ee( classtablename, tableindex, n_weapon_rarity, var_cb97d9c847fb01e3 = "primary", var_f91170067a6d805c = 1, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced )
{
    player = self;
    loadouts = init_loadout_table( classtablename );
    function_eed8f50b586358d0( player, loadouts[ tableindex ].loadout, n_weapon_rarity, var_cb97d9c847fb01e3, var_f91170067a6d805c, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced );
}

// Namespace ob_story_mission_utils
// Params 5
// Checksum 0xb2aa79f6, Offset: 0x71eb
// Size: 0x7d
function function_96a2f57e9afcdff1( player, loadout, n_weapon_rarity, var_cb97d9c847fb01e3 = "primary", var_f91170067a6d805c = 1 )
{
    assert( isthreaded() );
    player = self;
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "squad_play_begin" );
    function_eed8f50b586358d0( player, loadout, n_weapon_rarity, var_cb97d9c847fb01e3, var_f91170067a6d805c );
}

// Namespace ob_story_mission_utils
// Params 8, eflags: 0x4
// Checksum 0xd19ee3c0, Offset: 0x7270
// Size: 0x8b6
function private function_eed8f50b586358d0( player, loadout, n_weapon_rarity, var_cb97d9c847fb01e3 = "primary", var_f91170067a6d805c = 1, var_49468aa1bd33a9a5, var_97ac80a32f14fa32, var_54a5bc149727fced )
{
    if ( player.primaryweaponobj )
    {
        player ammo_mod::function_e6267ae500506234( player.primaryweaponobj, 1 );
    }
    
    player.pers[ "gamemodeLoadout" ] = loadout;
    player.class = "gamemode";
    struct = player class::loadout_getclassstruct();
    struct = player class::loadout_updateclass( struct, "gamemode" );
    player class::preloadandqueueclassstruct( struct, 1, 1 );
    options = {};
    
    if ( ob::function_3cc23382db426150() )
    {
        options.keepoperator = 1;
    }
    
    level.var_ddd4489f3a9d5b8f = 1;
    player class::giveloadout( player.team, "gamemode", 0, 0, undefined, undefined, undefined, undefined, options );
    selfReviveCount = min( loadout[ "selfReviveCount" ] ?? 0, player laststand::function_a40d280a3420d81() );
    
    if ( !player laststand::hasselfrevivetoken() && selfReviveCount > 0 )
    {
        player laststand::function_39844c1e879cc048( selfReviveCount );
    }
    
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        player givestartammo( weapon );
        player givemaxammo( weapon );
    }
    
    if ( !isdefined( n_weapon_rarity ) )
    {
        n_weapon_rarity = 0;
    }
    
    if ( n_weapon_rarity != 0 )
    {
        player function_ec74a55c78cc831( n_weapon_rarity );
    }
    
    primaryweapons = self getweaponslist( "primary" );
    primaryrarity = loadout[ "loadoutPrimaryRarity" ] ?? "NONE";
    secondaryrarity = loadout[ "loadoutSecondaryRarity" ] ?? "NONE";
    
    foreach ( weapon in primaryweapons )
    {
        if ( weapon.classname == "fist" )
        {
            continue;
        }
        
        if ( issubstr( weapon.basename, "knife" ) )
        {
            continue;
        }
        
        var_b34024c18a4091f9 = player.primaryweaponobj && weapon == player.primaryweaponobj;
        var_5801cef44ff8ce11 = player.secondaryweaponobj && weapon == player.secondaryweaponobj;
        var_ffac8df1025fd743 = player.var_cc1262e66dbb1c79 && weapon == player.var_cc1262e66dbb1c79;
        
        if ( var_b34024c18a4091f9 && level.var_6ecea52a1c8dd49c[ primaryrarity ] > 0 )
        {
            player_set_weapon_rarity( weapon, level.var_6ecea52a1c8dd49c[ primaryrarity ] - 1 );
        }
        else if ( var_5801cef44ff8ce11 && level.var_6ecea52a1c8dd49c[ secondaryrarity ] > 0 )
        {
            player_set_weapon_rarity( weapon, level.var_6ecea52a1c8dd49c[ secondaryrarity ] - 1 );
        }
        
        if ( !var_b34024c18a4091f9 && !var_5801cef44ff8ce11 && !var_ffac8df1025fd743 )
        {
            player takeweapon( weapon );
        }
    }
    
    switch ( var_cb97d9c847fb01e3 )
    {
        case #"hash_511d3c24fcedcdb1":
            player thread inventory_utility::domonitoredweaponswitch( player.secondaryweaponobj );
            break;
        case #"hash_a7832978dd2b6523":
            player thread inventory_utility::domonitoredweaponswitch( player.var_cc1262e66dbb1c79 );
            break;
        default:
            player thread inventory_utility::domonitoredweaponswitch( player.primaryweaponobj );
            break;
    }
    
    if ( player.primaryweaponobj )
    {
        primaryammomod = loadout[ "loadoutPrimaryAmmoMod" ];
        
        if ( primaryammomod )
        {
            player ammo_mod::add_ammo_mod_to_weapon( player.primaryweaponobj, primaryammomod );
        }
    }
    
    if ( var_f91170067a6d805c )
    {
        fieldupgrade = loadout[ "loadoutFieldUpgrade1" ];
        
        if ( fieldupgrade && fieldupgrade != "none" )
        {
            player perkpackage::perkpackage_giveimmediate( fieldupgrade );
        }
    }
    
    if ( var_49468aa1bd33a9a5 )
    {
        if ( isnumber( loadout[ "loadoutPowerTier" ] ) )
        {
            player ob_power_tier::function_69df1bfb965b995d( 1 + loadout[ "loadoutPowerTier" ] );
            player ob_power_tier::function_75cc84297f5ba7ab();
        }
        else
        {
            assertmsg( "<dev string:x441>" + loadout[ "<dev string:x467>" ] );
        }
    }
    
    var_1db23e0735771ec5 = player.var_1db23e0735771ec5 ?? 0;
    var_38cdb896b8360654 = player.var_38cdb896b8360654 ?? 0;
    
    if ( var_97ac80a32f14fa32 )
    {
        skills = loadout[ "loadoutSkills" ] ?? [];
        
        foreach ( skill in skills )
        {
            if ( !isstring( skill.skillref ) || !isnumber( skill.skillupgrade ) || skill.skillupgrade <= 0 )
            {
                continue;
            }
            
            skillbundle = level.skillbundles[ getxhash( skill.skillref ) ][ skill.skillupgrade - 1 ];
            
            if ( skillbundle )
            {
                player utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, 1 );
                
                switch ( getxhash( skillbundle.skillcategory ) )
                {
                    case #"end_game":
                        var_1db23e0735771ec5 = ( skill.skilllevel ?? 0 ) + 1;
                        break;
                    case #"nightmare":
                        var_38cdb896b8360654 = ( skill.skilllevel ?? 0 ) + 1;
                        break;
                }
                
                continue;
            }
            
            assertmsg( "<dev string:x478>" + skill.skillref + "<dev string:x49a>" + skill.skillupgrade + "<dev string:x4a6>" );
        }
    }
    
    if ( var_54a5bc149727fced )
    {
        skilltracks = loadout[ "loadoutSkillTracks" ] ?? [];
        
        foreach ( var_bae191290246e653 in skilltracks )
        {
            var_a1d9a4fc1932ccec = "skilltrack:" + var_bae191290246e653.skilltrackref;
            
            /#
                var_1613b47d2178a8ae = undefined;
            #/
            
            foreach ( skilltrack in level.skilltracklist )
            {
                if ( var_a1d9a4fc1932ccec == skilltrack.ref )
                {
                    if ( player.activeskills )
                    {
                        player.skilltracks[ skilltrack.lootid ] = skilltrack;
                    }
                    else
                    {
                        player.loadoutSkillTracks[ skilltrack.lootid ] = skilltrack;
                    }
                    
                    /#
                        var_1613b47d2178a8ae = 1;
                    #/
                    
                    break;
                }
            }
            
            /#
                if ( !var_1613b47d2178a8ae )
                {
                    assertmsg( "<dev string:x4a8>" + var_bae191290246e653 );
                }
            #/
        }
        
        if ( self.powertier < 61 )
        {
            player.selectableskills = [];
            player utility::callsharedfunc( #"ob_skill_tracks", #"hash_9a28d6cd3de8589e", self.powertier );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x71a04728, Offset: 0x7b2e
// Size: 0xc3
function function_612f504f4ace9525()
{
    var_9557029912cceca1 = utility::spawn_tag_origin();
    random_rotation = ( 0, randomintrange( 0, 360 ), 0 );
    var_9557029912cceca1.origin += anglestoforward( var_9557029912cceca1.angles ) * randomfloatrange( 1, 4 );
    spawn_options = { #spawningentity:self, #dropradiusscale:1.1, #baseangles:var_9557029912cceca1.angles, #baseorigin:var_9557029912cceca1.origin, #spawnpositionindex:0 };
    
    if ( isdefined( var_9557029912cceca1 ) )
    {
        var_9557029912cceca1 delete();
    }
    
    return spawn_options;
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x545c556, Offset: 0x7bfa
// Size: 0x9
function function_e1e5cc9738265deb()
{
    function_f7835d70cbf459fc();
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xdf6bfb7f, Offset: 0x7c0b
// Size: 0x89
function function_f7835d70cbf459fc()
{
    spawn_options = function_612f504f4ace9525();
    
    for ( index = self.primaryinventory.size - 1; index >= 0 ; index-- )
    {
        if ( self.primaryinventory[ index ].basename != "sat_me_knife_mp" )
        {
            item_weapon::items_weapon_removeweapon( { #spawnoptions:spawn_options, #dontdrop:0, #weapon:self.primaryinventory[ index ] } );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x5a0145a4, Offset: 0x7c9c
// Size: 0xaa
function function_4657f38861c52871( primary_weapon_name, secondary_weapon_name )
{
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x4cf>" );
        #/
        
        return;
    }
    
    if ( isdefined( self.primaryweaponobj ) )
    {
        self takeweapon( self.primaryweaponobj );
    }
    
    if ( isdefined( level.defaultfist ) )
    {
        self takeweapon( level.defaultfist );
    }
    
    primary_weapon = weapon::buildweapon( primary_weapon_name );
    inventory_utility::_giveweapon( primary_weapon );
    
    if ( isdefined( secondary_weapon_name ) )
    {
        secondary_weapon = weapon::buildweapon( secondary_weapon_name );
        inventory_utility::_giveweapon( secondary_weapon );
    }
    
    inventory_utility::domonitoredweaponswitch( primary_weapon, 1 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xd098733a, Offset: 0x7d4e
// Size: 0x53
function function_56b8e693a8061a3d( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    wait 5;
    
    while ( true )
    {
        if ( getdvarint( @"hash_be9614909b273753", -1 ) >= 0 )
        {
            function_96b272e2782629af( player );
        }
        
        wait 1;
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x106d013e, Offset: 0x7da9
// Size: 0x108
function function_96b272e2782629af( player )
{
    perfloadouts = init_loadout_table( "mp_sat_ob_perf_class" );
    
    if ( !isdefined( perfloadouts[ getdvarint( @"hash_be9614909b273753", 0 ) ] ) )
    {
        assertmsg( "<dev string:x52b>" + "<dev string:x577>" );
    }
    else
    {
        player.pers[ "gamemodeLoadout" ] = perfloadouts[ getdvarint( @"hash_be9614909b273753", 0 ) ].loadout;
        player.class = "gamemode";
        struct = player class::loadout_getclassstruct();
        struct = player class::loadout_updateclass( struct, "gamemode" );
        player class::preloadandqueueclassstruct( struct, 1, 1 );
        player class::giveloadout( player.team, "gamemode", 0, 0 );
        self givestartammo( struct.loadoutprimaryobject );
        self givestartammo( struct.loadoutsecondaryobject );
    }
    
    setdvar( @"hash_be9614909b273753", -1 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xeebcf539, Offset: 0x7eb9
// Size: 0x63
function function_5a1d93f004f86c8b( var_7c0d29caa7b948c6 )
{
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"hash_b10ac56024891c37", 0 ) > 0 )
    {
        var_7c0d29caa7b948c6 = getdvarint( @"hash_b10ac56024891c37", 0 );
    }
    
    weapon = function_b6e2a31c8b9ffa86();
    var_7c0d29caa7b948c6 = clampint( var_7c0d29caa7b948c6, 1, 5 );
    item_weapon::function_40e1cbd0e1f47d1a( weapon, var_7c0d29caa7b948c6 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x9ae57758, Offset: 0x7f24
// Size: 0xc9
function function_ec74a55c78cc831( var_7c0d29caa7b948c6 )
{
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"hash_b10ac56024891c37", 0 ) > 0 )
    {
        var_7c0d29caa7b948c6 = getdvarint( @"hash_b10ac56024891c37", 0 );
    }
    
    var_7c0d29caa7b948c6 = clampint( var_7c0d29caa7b948c6, 1, 5 );
    currentweapons = self getweaponslistall();
    
    foreach ( weap in currentweapons )
    {
        item_weapon::function_40e1cbd0e1f47d1a( weap, var_7c0d29caa7b948c6 );
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x5a217b73, Offset: 0x7ff5
// Size: 0x34
function player_set_weapon_rarity( weapon, var_7c0d29caa7b948c6 )
{
    var_7c0d29caa7b948c6 = clampint( var_7c0d29caa7b948c6, 1, 5 );
    
    if ( isweapon( weapon ) )
    {
        item_weapon::function_40e1cbd0e1f47d1a( weapon, var_7c0d29caa7b948c6 );
    }
}

// Namespace ob_story_mission_utils
// Params 0, eflags: 0x4
// Checksum 0xaf45a350, Offset: 0x8031
// Size: 0x35
function private function_b6e2a31c8b9ffa86()
{
    self endon( #"death_or_disconnect" );
    currentweapon = self getcurrentweapon();
    
    while ( isnullweapon( currentweapon ) )
    {
        currentweapon = self getcurrentweapon();
        waitframe();
    }
    
    return currentweapon;
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xbb85c71d, Offset: 0x806f
    // Size: 0x5, Type: dev
    function function_6a2aeb8be89f91be()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 8
// Checksum 0x8eff2c83, Offset: 0x807c
// Size: 0x1b4
function function_53ca684fc4aa8af3( owner, spawnpoint, supplyitems, supplyammo = 1, supplyarmor = 1, airdrop = 0, var_35efbbc9c198b2f3 = 0, var_7718e1c4f0b159 )
{
    function_3ab5475619b9cb62();
    crate = undefined;
    
    if ( airdrop )
    {
        streakinfo = killstreak_utility::createstreakinfo( "airdrop", owner );
        scenenode = airdrop::dropcratefromscriptedheli( owner, owner.team, "wc_sm_supply_drop", spawnpoint, ( 0, randomint( 360 ), 0 ), spawnpoint, undefined, streakinfo, var_35efbbc9c198b2f3 );
        
        if ( scenenode.crates.size )
        {
            crate = scenenode.crates[ getfirstarraykey( scenenode.crates ) ];
            crate.var_88accb953478a622 hide();
            crate.var_b410f5d243619d25 hide();
        }
    }
    else
    {
        crate = airdrop::dropcrate( owner, owner.team, "wc_sm_supply_drop", spawnpoint, ( 0, randomint( 360 ), 0 ), spawnpoint, undefined, undefined, var_35efbbc9c198b2f3 );
    }
    
    if ( isdefined( crate ) )
    {
        crate.nochute = 0;
        crate.var_dbd8dfc4d8cbaf6c = 0;
        crate.nevertimeout = 1;
        crate.supplyitems = supplyitems;
        crate.supplyarmor = supplyarmor;
        crate.supplyammo = supplyammo;
        crate.var_7718e1c4f0b159 = var_7718e1c4f0b159;
    }
    
    return crate;
}

// Namespace ob_story_mission_utils
// Params 0, eflags: 0x4
// Checksum 0x2cebd49a, Offset: 0x8239
// Size: 0x12d
function private function_3ab5475619b9cb62()
{
    if ( utility::flag( "wc_sm_supply_drop_initialized" ) )
    {
        return;
    }
    
    leveldata = airdrop::getleveldata( "wc_sm_supply_drop" );
    leveldata.capturestring = &"mp/generic_loot_crate_capture";
    leveldata.basemodel = "streak_sat_vm_care_package_physics_ob_story_mission";
    leveldata.var_f49b9544396e05ea = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = "hud_icon_minimap_killstreak_carepackage";
    leveldata.minimapicon = "hud_icon_minimap_killstreak_carepackage";
    leveldata.usefov = 180;
    leveldata.friendlyuseonly = 1;
    leveldata.usepriority = -1;
    leveldata.ownerusetime = 1.25;
    leveldata.otherusetime = 1.25;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.capturecallback = &function_f403b2c70d558360;
    leveldata.isdropcrate = 1;
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "wc_sm_supply_drop", "streak_sat_vm_care_package_physics_ob_story_mission", undefined, &function_f403b2c70d558360 );
    utility::flag_set( "wc_sm_supply_drop_initialized" );
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x62fe1d2, Offset: 0x836e
// Size: 0x1a7
function private function_f403b2c70d558360( player )
{
    items = isarray( self.supplyitems ) ? self.supplyitems : [ self.supplyitems ];
    
    if ( isdefined( self.var_7718e1c4f0b159 ) )
    {
        dynamic_items = [[ self.var_7718e1c4f0b159 ]]( player );
        items = arraycombine( items, dynamic_items );
    }
    
    if ( self.supplyammo )
    {
        items[ items.size ] = %"itemspawnentry:ob_sat_item_ammo";
    }
    
    if ( self.supplyarmor )
    {
        items[ items.size ] = %"itemspawnentry:ob_sat_item_ammo";
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    
    foreach ( item in items )
    {
        itembundle = getscriptbundle( item );
        count = 1;
        
        if ( itembundle.var_d3af3f4e323ff7b0 && isdefined( itembundle.baseweapon ) )
        {
            count = weaponclipsize( itembundle.baseweapon );
        }
        
        common_item::function_61c2c0251e742ffd( itembundle, count, spawnoptions );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_59b4e0bb0811b551" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( self );
    }
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xe8d59565, Offset: 0x851d
    // Size: 0x5, Type: dev
    function function_6a3edca9aa3ae05b()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x76c20690, Offset: 0x852a
// Size: 0x156
function function_ac2a2440f56b2342( adjust_difficulty, var_cf085ffbb5a50735 = 0 )
{
    if ( !isalive( self ) || self.type != "zombie" )
    {
        return;
    }
    
    assert( isdefined( adjust_difficulty ) );
    
    switch ( adjust_difficulty )
    {
        case #"hash_f0e8c026bb8fb1fd":
            var_1d8712ee8243f426 = -2;
            break;
        case #"hash_9f3885591ed40969":
            var_1d8712ee8243f426 = -1;
            break;
        case #"hash_3d933bdf927d88f1":
            var_1d8712ee8243f426 = 2;
            break;
        case #"hash_18706e65c6bc0f65":
            var_1d8712ee8243f426 = 1;
            break;
        case #"hash_98861f591b81e8d1":
        default:
            var_1d8712ee8243f426 = 0;
            break;
    }
    
    if ( getdvarint( @"hash_2bf520a29416472b", 0 ) != 0 )
    {
        var_1d8712ee8243f426 = getdvarint( @"hash_2bf520a29416472b", 0 );
    }
    
    var_c817bb8b65abaf02 = function_695f0dcb1b47e6d9();
    new_difficulty_int = clampint( var_c817bb8b65abaf02 + var_1d8712ee8243f426, 1, 5 );
    
    if ( getdvarint( @"hash_53dc66fb0443db4e", 0 ) > 0 )
    {
        new_difficulty_int = clampint( getdvarint( @"hash_53dc66fb0443db4e", 0 ), 1, 5 );
    }
    
    new_difficulty = region_difficulty_manager::function_dc53171229eb2097( new_difficulty_int );
    zombie_set_difficulty( new_difficulty, var_cf085ffbb5a50735 );
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x4f29023f, Offset: 0x8688
// Size: 0x12b
function zombie_set_difficulty( new_difficulty, var_cf085ffbb5a50735 = 0 )
{
    if ( !isalive( self ) || self.type != "zombie" )
    {
        return;
    }
    
    /#
        assert( isdefined( new_difficulty ) );
        assert( arraycontains( region_difficulty_manager::function_ca02c3577d55b5f6(), new_difficulty ) );
    #/
    
    if ( self.og_difficulty == new_difficulty )
    {
        return;
    }
    
    if ( isdefined( self.difficulty ) )
    {
        self.og_difficulty = self.difficulty;
    }
    
    if ( !var_cf085ffbb5a50735 )
    {
        self.difficulty = new_difficulty;
        var_8d885b4aed0bef01 = region_difficulty_manager::function_d33b93a54f11258d( new_difficulty );
        
        if ( isdefined( self.var_d6894f01a36b4ff3.healthscriptbundle ) )
        {
            ai::set_ai_max_health( namespace_775af9b7afedb6d1::function_28795222258b3cca( self.var_d6894f01a36b4ff3.healthscriptbundle, var_8d885b4aed0bef01 ) );
            self.health = self.maxhealth;
        }
        
        utility::callsharedfunc( #"zombie", #"hash_e27e55920dabe660", var_8d885b4aed0bef01 );
        zombie_utils::set_zombie_round_difficulty( var_8d885b4aed0bef01 );
        return;
    }
    
    region_difficulty_manager::function_410b4f83b0a5b98( new_difficulty );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x96b83884, Offset: 0x87bb
// Size: 0x66
function function_9e2975b75559bdef()
{
    if ( !isalive( self ) || self.type != "zombie" )
    {
        return;
    }
    
    if ( isdefined( self.og_difficulty ) )
    {
        zombie_set_difficulty( self.og_difficulty );
        return;
    }
    
    if ( isdefined( get_global_region_difficulty() ) )
    {
        zombie_set_difficulty( get_global_region_difficulty() );
        return;
    }
    
    zombie_utils::set_zombie_round_difficulty( zombie_utils::get_zombie_round_difficulty() );
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xcd2deaa6, Offset: 0x8829
    // Size: 0x5, Type: dev
    function function_307260f80ff54a8()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 14
// Checksum 0x59ff04d1, Offset: 0x8836
// Size: 0x65e
function function_273dfd9583646854( spawn_loc_targetname, e_trigger, var_3f1a771117d6ebee = 0, take_off_flag, var_5a8098f4d94983ed = 20, var_5060286bf85d1deb = 40, var_769fc78c391f1a3 = 1, vtol_accel, vtol_decel, var_35ded5b75c27f888 = 0, var_1e4b31426513d89c = 0, var_d8ed17bac388a5ba = 256, var_ad524c95e59df290 = undefined, var_ac842ae178819fa2 = 0 )
{
    activity_instance = self;
    ob_activity_heli_takedown::function_fb53b392296c145c();
    set_vtol_speed( var_5a8098f4d94983ed, var_5060286bf85d1deb, vtol_accel, vtol_decel );
    var_f4a3774933a4ada = utility::getstruct( spawn_loc_targetname, "targetname" );
    
    if ( var_769fc78c391f1a3 )
    {
        activity_instance.start_location = undefined;
        activity_instance.var_2a47db6ce749f4a9 = undefined;
        activity_instance.start_location = var_f4a3774933a4ada;
        activity_instance ob_activity_heli_takedown::heli_takedown_heli_spawn( %"hash_3de08ee4ce53144f", 0 );
        activity_instance.var_2a47db6ce749f4a9.var_24954f14e27b448d = 0;
        
        if ( var_35ded5b75c27f888 )
        {
            objidpoolmanager::objective_playermask_hidefromall( activity_instance.var_2a47db6ce749f4a9.objidnum );
        }
        
        if ( var_3f1a771117d6ebee )
        {
            activity_instance.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f4a3774933a4ada.origin, 1, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ], 1, 5, 5, undefined, undefined, 1 );
        }
    }
    else
    {
        var_8896d707202f1d9d = spawnstruct();
        var_8896d707202f1d9d.start_location = var_f4a3774933a4ada;
        var_8896d707202f1d9d.start_location.origin = var_f4a3774933a4ada.origin + ( 0, 0, 10 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 = namespace_28acf6540b1bc740::heli_spawn_simple( var_8896d707202f1d9d.start_location, %"hash_3de08ee4ce53144f", var_3f1a771117d6ebee, 1 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 forcenetfieldhighlod( 1 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 vehicleshowonminimap( 0 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread ob_activity_heli_takedown::function_ff5870f68a2a6d1f( 1 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 setmaxpitchroll( 15, 15 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 setneargoalnotifydist( var_d8ed17bac388a5ba );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 setturningability( 0.02 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.b_escaping = 0;
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.hover_min_height = 0;
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.heightoffset = ( 0, 0, 0 );
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.damagestate = 0;
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.var_24954f14e27b448d = 0;
        var_8896d707202f1d9d.var_2a47db6ce749f4a9.pathgoaldistance = var_d8ed17bac388a5ba;
        
        if ( var_3f1a771117d6ebee )
        {
            var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f4a3774933a4ada.origin, 1, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ], 1, 5, 5, undefined, undefined, 1 );
        }
        
        if ( var_ac842ae178819fa2 )
        {
            var_8896d707202f1d9d.var_2a47db6ce749f4a9 vehicle_allowplayerstandon( 0 );
        }
    }
    
    if ( e_trigger )
    {
        e_trigger waittill( #"trigger" );
    }
    else if ( take_off_flag )
    {
        utility::flag_wait( take_off_flag );
    }
    
    if ( var_769fc78c391f1a3 )
    {
        activity_instance function_c9291118d6afd212( var_3f1a771117d6ebee );
        
        if ( isdefined( var_ad524c95e59df290 ) && isdefined( activity_instance.var_2a47db6ce749f4a9 ) )
        {
            activity_instance.var_2a47db6ce749f4a9 playrumblelooponentity( var_ad524c95e59df290 );
        }
        
        return;
    }
    
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 endon( #"death" );
    var_f0a264ca52a727a1 = utility::getstruct( var_8896d707202f1d9d.start_location.target, "targetname" );
    
    if ( var_3f1a771117d6ebee && isdefined( var_8896d707202f1d9d.var_2a47db6ce749f4a9 ) )
    {
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 vehicle_occupancy::function_474d87fe62493d22();
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 vehicle_occupancy::turn_engine_on();
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 playsoundonmovingent( "veh_vtol_ob_takeoff" );
    }
    
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 notify( #"takeoff" );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 setyawspeed( 100, 25, 25, 0.1 );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9.var_66985f8f48b0cef7 = 0;
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f0a264ca52a727a1, 0, undefined, 1, var_8896d707202f1d9d.var_2a47db6ce749f4a9.angles[ 1 ], 0, level.var_60312a4146f172ee, level.var_328258b5444888ed );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_all", 0 );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 setscriptablepartstate( "thrusters", "horizontal", 0 );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9.speed = level.var_4211d1e162e82fb2;
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 vehicle_setspeed( level.var_4211d1e162e82fb2, level.var_76d7e14e4d6491e9, level.var_6110fc2f90352874 );
    
    if ( isdefined( var_ad524c95e59df290 ) )
    {
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 playrumblelooponentity( var_ad524c95e59df290 );
    }
    
    if ( var_1e4b31426513d89c )
    {
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread function_c5455762aa9a92e6( var_f0a264ca52a727a1 );
    }
    else
    {
        var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::action_follow_path( var_f0a264ca52a727a1 );
    }
    
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 utility::waittill_any( "leaving", "follow_path_complete" );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "booster", 0 );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread vehicle::godon();
    waitframe();
    var_8896d707202f1d9d notify( #"heli_escaped" );
    var_8896d707202f1d9d.var_2a47db6ce749f4a9.b_escaping = 1;
    var_8896d707202f1d9d.var_2a47db6ce749f4a9 thread ob_activity_heli_takedown::function_ec2bfddde8f4bf8d();
}

// Namespace ob_story_mission_utils
// Params 5, eflags: 0x4
// Checksum 0xd5c36ed4, Offset: 0x8e9c
// Size: 0x2df
function private function_c5455762aa9a92e6( start_node, forceheight, var_bddf8c5a07aa920e, isdrone, toendnode )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"new_orders" );
    self endon( #"stop_all_action" );
    
    if ( !isdefined( start_node ) )
    {
        assertmsg( "<dev string:x58c>" );
        return;
    }
    
    self.next_target = start_node;
    path_end = 0;
    self setturningability( self.var_25ced6dafb5b15f0 );
    self setneargoalnotifydist( self.pathgoaldistance );
    
    while ( !path_end )
    {
        if ( isdefined( self.next_target ) )
        {
            speedoverride = var_bddf8c5a07aa920e;
            
            if ( isdefined( self.next_target.speed ) )
            {
                speedoverride = self.next_target.speed;
            }
            
            if ( isdefined( self.next_target.script_wait ) )
            {
                wait self.next_target.script_wait;
            }
            
            namespace_28acf6540b1bc740::function_7fb408948b1225e0( self.next_target, path_end, forceheight, 1, undefined, undefined, speedoverride, undefined, undefined, isdrone, 0 );
            
            if ( isdefined( self.next_target.script_flag_wait ) )
            {
                utility::flag_wait( self.next_target.script_flag_wait );
            }
        }
        
        if ( self.next_target.target )
        {
            if ( utility::issharedfuncdefined( #"hash_bd3211c9481a757d", #"hash_4e9284bb6b290f31" ) )
            {
                self.next_target = utility::callsharedfunc( #"hash_bd3211c9481a757d", #"hash_4e9284bb6b290f31", self, self.next_target.target );
            }
            else if ( isstruct( self.next_target ) )
            {
                self.next_target = utility::getstruct( self.next_target.target, "targetname" );
            }
            else if ( isent( self.next_target ) )
            {
                self.next_target = getent( self.next_target.target, #targetname );
            }
            else
            {
                self.next_target = getvehiclenode( self.next_target.target, #targetname );
            }
        }
        else
        {
            self.next_target = undefined;
        }
        
        if ( !isdefined( self.next_target ) || !toendnode && !isdefined( self.next_target.target ) )
        {
            path_end = 1;
        }
        
        waitframe();
    }
    
    self notify( #"follow_path_complete" );
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0xdbe6a55f, Offset: 0x9183
// Size: 0x4e
function private function_c9291118d6afd212( var_3f1a771117d6ebee = 0 )
{
    activity_instance = self;
    activity_instance.var_2a47db6ce749f4a9 endon( #"death" );
    
    if ( var_3f1a771117d6ebee )
    {
        activity_instance ob_activity_heli_takedown::function_95401236ea7e4f70();
    }
    
    activity_instance ob_activity_heli_takedown::function_e016f8e40b55e835();
}

// Namespace ob_story_mission_utils
// Params 4
// Checksum 0xfbe2e1d2, Offset: 0x91d9
// Size: 0xbf
function set_vtol_speed( var_5a8098f4d94983ed = 20, var_5060286bf85d1deb = 40, vtol_accel, vtol_decel )
{
    level.var_60312a4146f172ee = var_5a8098f4d94983ed;
    level.var_328258b5444888ed = var_5a8098f4d94983ed / 4;
    level.var_595350916585c0f8 = var_5a8098f4d94983ed / 4;
    level.var_4211d1e162e82fb2 = var_5060286bf85d1deb;
    level.var_76d7e14e4d6491e9 = var_5060286bf85d1deb / 8;
    level.var_6110fc2f90352874 = var_5060286bf85d1deb / 4;
    
    if ( isdefined( vtol_accel ) )
    {
        level.var_328258b5444888ed = vtol_accel;
        level.var_76d7e14e4d6491e9 = vtol_accel;
    }
    
    if ( isdefined( vtol_decel ) )
    {
        level.var_595350916585c0f8 = vtol_decel;
        level.var_6110fc2f90352874 = vtol_decel;
    }
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0x3545d8f1, Offset: 0x92a0
    // Size: 0x5, Type: dev
    function function_c53d15bafcd3d979()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 8
// Checksum 0xa6bb30d6, Offset: 0x92ad
// Size: 0x1cd
function function_516cfe2bb1eed11f( origin, abilityRef1, abilityRef2, slot, angles, parent, var_13833a5f12ac2abd, var_d409121c7cf489ee )
{
    if ( !isdefined( origin ) )
    {
        function_1421ee46061ec3a6( "origin" );
    }
    
    if ( !isdefined( abilityRef1 ) )
    {
        function_1421ee46061ec3a6( "abilityRef1" );
    }
    
    if ( !isdefined( abilityRef2 ) )
    {
        function_1421ee46061ec3a6( "abilityRef2" );
    }
    
    if ( !isdefined( slot ) )
    {
        function_1421ee46061ec3a6( "slot" );
    }
    
    ability_slot = #"default";
    
    if ( slot == "tactical" )
    {
        ability_slot = #"tactical";
    }
    
    activity_instance = self;
    
    if ( var_13833a5f12ac2abd )
    {
        foreach ( player in level.players )
        {
            player thread function_9cd30509999d8a27( var_13833a5f12ac2abd );
        }
    }
    
    if ( var_d409121c7cf489ee )
    {
        foreach ( player in level.players )
        {
            player thread function_9cd30509999d8a27( var_d409121c7cf489ee );
        }
    }
    
    return ob_item_select::function_95f9ecc2af4693f6( origin, abilityRef1, abilityRef2, ability_slot, angles, parent );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x684f74bb, Offset: 0x9483
// Size: 0xe6
function function_9cd30509999d8a27( options )
{
    player = self;
    level endon( #"game_ended" );
    
    if ( options.endon_string )
    {
        level endon( options.endon_string );
    }
    
    var_930bd298a1235e7d = player usinggamepad() ? options.var_a9496e34ebda5db : options.var_b53628100ef29954;
    
    while ( true )
    {
        player waittill( #"player_used_ability_case", ref );
        
        if ( ref == options.equipment_ref )
        {
            wait options.delay ?? 0;
            player utility::callsharedfunc( #"hint", #"add_simple", options.hint_ref_name, var_930bd298a1235e7d, options.hint_length ?? 5 );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xbc55ba10, Offset: 0x9571
// Size: 0x22
function function_1421ee46061ec3a6( var_5a1c0f3d18fe810f )
{
    /#
        iprintln( "<dev string:x5b1>" + var_5a1c0f3d18fe810f + "<dev string:x5b9>" );
    #/
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x4ce3f513, Offset: 0x959c
// Size: 0xef
function private function_5bca454cf2a2b2bb( params )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"boss_healthbar_removed" );
    
    if ( player.var_71c37977095602df )
    {
        boss_ent_or_struct = player.var_1bf81c9daec05b30;
        
        if ( isstruct( boss_ent_or_struct ) || isalive( boss_ent_or_struct ) )
        {
            player utility::ent_flag_set( "restoring_boss_healthbar" );
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
            wait 0.1;
            
            if ( player.var_27d2b2e566325b32 != "boss_healthbar_hide" )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_show( player.var_71c37977095602df, boss_ent_or_struct );
                player zombie_boss_healthbar::function_db02000f515bd5c6( boss_ent_or_struct.health );
                
                if ( player.var_27d2b2e566325b32 == "boss_healthbar_immune" )
                {
                    player zombie_boss_healthbar::zombie_boss_healthbar_immune();
                }
            }
            
            player utility::ent_flag_clear( "restoring_boss_healthbar" );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xf3fb4b4, Offset: 0x9693
// Size: 0xa3
function function_16e0adef86e5d052( var_bcbe92dff36a4ceb, var_82472a5ddedc03b8 )
{
    player = self;
    assert( !isdefined( player.var_71c37977095602df ) );
    assert( !callback::exists( #"player_spawned", &function_5bca454cf2a2b2bb ) );
    player.var_71c37977095602df = var_bcbe92dff36a4ceb;
    player.var_1bf81c9daec05b30 = var_82472a5ddedc03b8;
    player.var_27d2b2e566325b32 = "boss_healthbar_show";
    player callback::add( #"player_spawned", &function_5bca454cf2a2b2bb );
    player zombie_boss_healthbar::zombie_boss_healthbar_show( var_bcbe92dff36a4ceb, var_82472a5ddedc03b8 );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xb049c889, Offset: 0x973e
// Size: 0x3b
function function_6d307def1435e5d5()
{
    self endon( #"death_or_disconnect" );
    player = self;
    level utility::flag_wait( "scripted_widgets_initialized" );
    player thread scripted_widgets::add_streamer_hint( "boss_healthbar_streamer", "scripted_widget_boss_healthbar" );
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x80bb28af, Offset: 0x9781
// Size: 0x22
function function_2e1c3a1a4f92857d()
{
    player = self;
    player thread scripted_widgets::remove_streamer_hint( "boss_healthbar_streamer", "scripted_widget_boss_healthbar" );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x237f544e, Offset: 0x97ab
// Size: 0x7a, Type: bool
function function_6ec505041dcea08e( var_82472a5ddedc03b8 )
{
    player = self;
    
    if ( !var_82472a5ddedc03b8 )
    {
        return false;
    }
    
    if ( !player.var_1bf81c9daec05b30 )
    {
        return true;
    }
    
    previous_priority = player.var_1bf81c9daec05b30.ob_boss_healthbar_priority ?? 0;
    current_priority = var_82472a5ddedc03b8.ob_boss_healthbar_priority ?? 0;
    
    if ( current_priority > previous_priority )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x3c893099, Offset: 0x982e
// Size: 0x5d
function function_5a707116af438c92()
{
    player = self;
    player notify( #"boss_healthbar_removed" );
    player callback::remove( #"player_spawned", &function_5bca454cf2a2b2bb );
    player.var_27d2b2e566325b32 = undefined;
    player.var_1bf81c9daec05b30 = undefined;
    player.var_71c37977095602df = undefined;
    player zombie_boss_healthbar::zombie_boss_healthbar_hide();
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0x996ec1ce, Offset: 0x9893
// Size: 0x63
function player_boss_healthbar_show()
{
    player = self;
    assert( player.var_71c37977095602df );
    player.var_27d2b2e566325b32 = "boss_healthbar_show";
    
    if ( !player utility::ent_flag( "restoring_boss_healthbar" ) )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( player.var_71c37977095602df, player.var_1bf81c9daec05b30 );
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xfa6ad3c2, Offset: 0x98fe
// Size: 0x3a
function player_boss_healthbar_hide()
{
    player = self;
    player.var_27d2b2e566325b32 = "boss_healthbar_hide";
    
    if ( !player utility::ent_flag( "restoring_boss_healthbar" ) )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xae9a15df, Offset: 0x9940
// Size: 0x4d
function player_boss_healthbar_immune()
{
    player = self;
    assert( player.var_71c37977095602df );
    player.var_27d2b2e566325b32 = "boss_healthbar_immune";
    
    if ( !player utility::ent_flag( "restoring_boss_healthbar" ) )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_immune();
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x4eb441e3, Offset: 0x9995
// Size: 0x9d
function function_e231206f1628d4c6( var_5b8e8935d10a44bb, var_c80787b925cce664, maxhealthoverride )
{
    player = self;
    
    if ( !player.var_71c37977095602df )
    {
        return;
    }
    
    new_health = var_c80787b925cce664 ?? player.var_1bf81c9daec05b30.health;
    new_max_health = maxhealthoverride ?? player.var_1bf81c9daec05b30.maxhealth;
    player zombie_boss_healthbar::healthbar_set_health( new_health, new_max_health );
    
    if ( var_5b8e8935d10a44bb )
    {
        player zombie_boss_healthbar::function_db02000f515bd5c6( new_health );
    }
}

// Namespace ob_story_mission_utils
// Params 3
// Checksum 0x19e57137, Offset: 0x9a3a
// Size: 0x5c
function function_ecbb860d6714e9f3( index, do_transition = 0, var_ad30c944bbd232d7 = 1 )
{
    if ( !ob::nightmare() )
    {
        return;
    }
    
    if ( do_transition )
    {
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    }
}

// Namespace ob_story_mission_utils
// Params 5
// Checksum 0x6e4b93ac, Offset: 0x9a9e
// Size: 0xe9
function function_e1f7ae6f70c4b0c1( location, angles = ( 0, 0, 0 ), reward, activity_name, var_77003b8ff637fde8 )
{
    if ( isdefined( activity_name ) )
    {
        function_2686bb512b355040( activity_name );
    }
    
    thread function_6927a7f37a763921();
    common_item::function_61c2c0251e742ffd( %"hash_38127804fdc77167", undefined, common_item::function_bc5ff2958b71a708( location, angles ) );
    obj_id = function_b9cb179f9577f32a( location + ( 0, 0, 64 ) );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    reward_timer = 60;
    level thread chest_timer( "flag_nightmare_done", reward_timer );
    level utility::flag_wait_or_timeout( "flag_nightmare_done", reward_timer );
    
    /#
        if ( getdvarint( @"hash_e84ea0d344a80ce3", 0 ) )
        {
            level waittill( #"hash_1e9bc5e84aa89155" );
        }
    #/
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0xda302b2f, Offset: 0x9b8f
// Size: 0x14a
function function_c49b55e09c319e01( players, countdowntime )
{
    if ( countdowntime <= 0 )
    {
        return;
    }
    
    level notify( #"hash_dcd45e0ad6cba6be" );
    level endon( #"hash_dcd45e0ad6cba6be" );
    
    foreach ( player in players )
    {
        if ( !player scripted_widgets::is_active( "nightmare_chest_timer" ) )
        {
            player thread countdown_timer::create( "nightmare_chest_timer", "scripted_widget_countdown_banner", countdowntime, undefined, &"sat_wc/escape_in" );
        }
    }
    
    level utility::flag_wait_or_timeout( "flag_nightmare_done", countdowntime );
    
    foreach ( player in players )
    {
        player thread countdown_timer::close( "nightmare_chest_timer" );
    }
}

// Namespace ob_story_mission_utils
// Params 0, eflags: 0x4
// Checksum 0x9393d479, Offset: 0x9ce1
// Size: 0x108
function private function_6927a7f37a763921()
{
    activity_instance = self;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player val::set( "nm_end_ks_restore", "killstreaks", 0 );
        
        if ( player.var_80b4ca5db77982c1 )
        {
            var_d72cd7643b60619b = player common_item::function_c4c43ebb7aa636dc( "killstreak" );
            
            if ( !var_d72cd7643b60619b || !var_d72cd7643b60619b.count )
            {
                player utility::callsharedfunc( #"killstreak", #"awardkillstreak", player.var_80b4ca5db77982c1.ref, "other", undefined, undefined, undefined, 1 );
            }
        }
    }
}

// Namespace ob_story_mission_utils
// Params 2, eflags: 0x4
// Checksum 0x7f8523d9, Offset: 0x9df1
// Size: 0x56
function private chest_timer( flagendon, seconds = 60 )
{
    level.chest_time_remaining = seconds;
    
    while ( seconds > 0 && !level utility::flag( flagendon ) )
    {
        seconds -= 1;
        level.chest_time_remaining = seconds;
        wait 1;
    }
}

/#

    // Namespace ob_story_mission_utils
    // Params 0
    // Checksum 0xc38c33b8, Offset: 0x9e4f
    // Size: 0x5, Type: dev
    function function_31c7566912ea8e9f()
    {
        
    }

#/

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xb16f711f, Offset: 0x9e5c
// Size: 0x86
function function_5e3119d7ac0da406( var_7fbb1b6fdc3285a1 )
{
    foreach ( player in level.players )
    {
        player thread function_c62d1fe8cfa27b0e( var_7fbb1b6fdc3285a1 );
    }
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x629eedba, Offset: 0x9eea
// Size: 0x21
function private function_c62d1fe8cfa27b0e( var_7fbb1b6fdc3285a1 )
{
    player = self;
    player giveachievement( var_7fbb1b6fdc3285a1 );
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0x3a57a9f1, Offset: 0x9f13
// Size: 0x30
function function_f21cd61a6b760846( params )
{
    player = self;
    
    if ( isplayer( player ) )
    {
        player function_c62d1fe8cfa27b0e( "sat_wc_dontdieonme" );
    }
}

// Namespace ob_story_mission_utils
// Params 4
// Checksum 0xb0d76ac6, Offset: 0x9f4b
// Size: 0x103
function function_e89ed2a08ce38bbf( puzzle_name, puzzle_asset, radius = 512, height = 512 )
{
    assert( !isdefined( self.stream_volume ) || self.stream_volume.puzzle_name == puzzle_name && self.stream_volume.puzzle_asset == puzzle_asset, "<dev string:x609>" );
    
    if ( self.stream_volume )
    {
        return;
    }
    
    level utility::flag_wait( "scripted_widgets_initialized" );
    self.stream_volume = spawn( "noent_volume_trigger_radius", self.origin, 0, radius, height );
    self.stream_volume.puzzle_name = puzzle_name;
    self.stream_volume.puzzle_asset = puzzle_asset;
    self.stream_volume thread function_af045c990841e3c1();
    thread function_98876f12ae4bbad();
}

// Namespace ob_story_mission_utils
// Params 0
// Checksum 0xf8ac48da, Offset: 0xa056
// Size: 0xe9
function remove_connection_puzzle_streaming_volume()
{
    if ( self.stream_volume )
    {
        self.stream_volume notify( "remove_connection_puzzle_streaming_volume_" + self.stream_volume.puzzle_name );
        
        foreach ( player in level.players )
        {
            player scripted_widgets::remove_streamer_hint( self.stream_volume.puzzle_name, self.stream_volume.puzzle_asset );
        }
        
        self.stream_volume delete();
        self.stream_volume = undefined;
    }
}

// Namespace ob_story_mission_utils
// Params 0, eflags: 0x4
// Checksum 0xe481d806, Offset: 0xa147
// Size: 0xac
function private function_af045c990841e3c1()
{
    self endon( #"death" );
    self endon( "remove_connection_puzzle_streaming_volume_" + self.puzzle_name );
    self.var_50a88292323ed49 = [];
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && !isautopilot( ent ) && !self.var_50a88292323ed49[ ent getentitynumber() ] )
        {
            self.var_50a88292323ed49[ ent getentitynumber() ] = ent;
            ent scripted_widgets::add_streamer_hint( self.puzzle_name, self.puzzle_asset );
            ent thread watch_for_puzzle_streaming_volume_exit( self );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 1, eflags: 0x4
// Checksum 0x738d3640, Offset: 0xa1fb
// Size: 0x9b
function private watch_for_puzzle_streaming_volume_exit( volume )
{
    self notify( "watch_for_puzzle_streaming_volume_exit_" + volume.puzzle_name );
    self endon( #"death_or_disconnect" );
    self endon( "watch_for_puzzle_streaming_volume_exit_" + volume.puzzle_name );
    volume endon( "remove_connection_puzzle_streaming_volume_" + volume.puzzle_name );
    
    while ( isdefined( volume ) )
    {
        if ( !self istouching( volume ) )
        {
            volume.var_50a88292323ed49[ self getentitynumber() ] = undefined;
            scripted_widgets::remove_streamer_hint( volume.puzzle_name, volume.puzzle_asset );
            return;
        }
        
        wait 1;
    }
}

// Namespace ob_story_mission_utils
// Params 0, eflags: 0xc
// Checksum 0x28ea3984, Offset: 0xa29e
// Size: 0x4a
function private function_98876f12ae4bbad()
{
    self notify( #"hash_9f407d48622b55c1" );
    self endon( #"hash_9f407d48622b55c1" );
    self endon( "remove_connection_puzzle_streaming_volume_" + self.stream_volume.puzzle_name );
    self waittill( #"death" );
    thread remove_connection_puzzle_streaming_volume();
}

// Namespace ob_story_mission_utils
// Params 2
// Checksum 0x2475737e, Offset: 0xa2f0
// Size: 0x3dd
function function_9d7c461c00f2f588( var_8c5067d0870248c8, var_cc8f9a53a9ec507f = 0 )
{
    self notify( #"hash_9d391fa2f829d621" );
    self endon( #"hash_9d391fa2f829d621" );
    assert( isplayer( self ) );
    assert( isdefined( var_8c5067d0870248c8 ) );
    player = self;
    player endon( #"disconnect" );
    
    while ( !isdefined( player.activeskills ) )
    {
        waitframe();
    }
    
    player utility::callsharedfunc( #"ob_skill_tracks", #"reset" );
    player.var_8c5067d0870248c8 = var_8c5067d0870248c8;
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( isdefined( squad ) )
    {
        squad.var_8c5067d0870248c8 = var_8c5067d0870248c8;
    }
    
    if ( var_8c5067d0870248c8 > 0 )
    {
        var_ce441c5dd91822a = level.var_bb86f77304f193c4.var_b048aaa76b661eb8[ var_8c5067d0870248c8 - 1 ];
    }
    
    var_63f5d251ce5e4cc7 = level.var_bb86f77304f193c4.var_b048aaa76b661eb8[ var_8c5067d0870248c8 ];
    var_223e3017a8acb28d = var_63f5d251ce5e4cc7.var_9863884f2d02bf19;
    
    if ( var_223e3017a8acb28d )
    {
        skillbundle = level.skillbundles[ #"health_upgrade" ][ var_223e3017a8acb28d - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_9863884f2d02bf19 != var_63f5d251ce5e4cc7.var_9863884f2d02bf19;
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_3a7fb967d38eca8 = var_63f5d251ce5e4cc7.var_60de73fc67dffea8;
    
    if ( var_3a7fb967d38eca8 )
    {
        skillbundle = level.skillbundles[ #"armor_upgrade" ][ var_3a7fb967d38eca8 - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_60de73fc67dffea8 != var_63f5d251ce5e4cc7.var_60de73fc67dffea8;
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_4e511b604e8b02c8 = var_63f5d251ce5e4cc7.var_e85dfdcd7b1359c8;
    
    if ( var_4e511b604e8b02c8 )
    {
        skillbundle = level.skillbundles[ #"move_speed_upgrade" ][ var_4e511b604e8b02c8 - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_e85dfdcd7b1359c8 != var_63f5d251ce5e4cc7.var_e85dfdcd7b1359c8;
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_51a31e11c3f6b95a = var_63f5d251ce5e4cc7.var_4d17635b3a5e4eae;
    
    if ( var_51a31e11c3f6b95a )
    {
        skillbundle = level.skillbundles[ #"damage_upgrade" ][ var_51a31e11c3f6b95a - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_4d17635b3a5e4eae != var_63f5d251ce5e4cc7.var_4d17635b3a5e4eae;
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_7f056493a27459cb = var_63f5d251ce5e4cc7.var_ce3ce9809563cd53;
    
    if ( var_7f056493a27459cb )
    {
        skillbundle = level.skillbundles[ #"equipment_hound" ][ var_7f056493a27459cb - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f );
        }
    }
}

// Namespace ob_story_mission_utils
// Params 1
// Checksum 0xab8acec5, Offset: 0xa6d5
// Size: 0xa4
function function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 )
{
    var_8c5067d0870248c8 = var_64bb57aa2d6e8b35.var_8c5067d0870248c8 ?? 0;
    var_8c5067d0870248c8++;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player function_9d7c461c00f2f588( var_8c5067d0870248c8 );
    }
}

