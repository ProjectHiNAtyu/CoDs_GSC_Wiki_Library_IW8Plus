// scripts\mp\bots\bots_gametype_koth.gsc  (hash_110e8cce19077cc3.gscc) (size: 4754 Bytes / 0x1292 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf7efa69 (3212769897)
// size ...... 4754 (0x1292)
// includes .. 11  (offset: 0x1192)
// strings ... 11  (offset: 0x11ea)
// dev strs .. 3   (offset: 0x126e)
// exports ... 12  (offset: 0xa5e)
// cseg ...... 0x13b + 0x923 (0xa5e)
// imports ... 47  (offset: 0xc3e)
// animtree1 . 0   (offset: 0x1292)
// animtree2 . 0   (offset: 0x1292)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\gameobjects;

#namespace bots_gametype_koth;

// Namespace bots_gametype_koth
// Params 0
// Checksum 0x6d9d4bd3, Offset: 0x159
// Size: 0x25
function main()
{
    level.var_ae4d3fde002fedb4 = 1;
    setup_callbacks();
    setup_bot_koth();
    
    /#
        thread bots_gametype_common::function_a6cacb00e9275066();
    #/
}

// Namespace bots_gametype_koth
// Params 0
// Checksum 0xa34e05d3, Offset: 0x186
// Size: 0x48
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_koth_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_koth;
    autopilot::initialize( undefined, undefined, [ "bot_koth_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_koth
// Params 0
// Checksum 0x91ae67a6, Offset: 0x1d6
// Size: 0x1d2
function setup_bot_koth()
{
    bots_util::bot_waittill_bots_enabled();
    var_b149307f9ac27374 = 0;
    
    foreach ( objective in level.objectives )
    {
        objective thread bots_gametype_common::monitor_zone_control();
        var_b124be14c732e96d = 0;
        
        if ( !gameobjects_shared::is_activated( objective ) )
        {
            gameobjects_common::activate_trigger( objective );
            var_b124be14c732e96d = 1;
        }
        
        objective.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( objective, 1 );
        
        if ( var_b124be14c732e96d )
        {
            gameobjects_common::deactivate_trigger( objective );
        }
        
        /#
            if ( objective.tacpoints.size < 5 )
            {
                wait 5;
                assertmsg( "<dev string:x24>" + objective.objectivekey + "<dev string:x2a>" + objective.origin + "<dev string:x38>" );
                
                if ( objective.tacpoints.size < 3 )
                {
                    var_b149307f9ac27374 = 1;
                }
            }
        #/
    }
    
    level.var_acfff33730ed3d7f = 1;
    
    if ( !var_b149307f9ac27374 )
    {
        level.bot_hp_allow_predictive_capping = 1;
        initial_zone = level.zone;
        
        if ( !isdefined( initial_zone ) )
        {
            initial_zone = utility::array_random( level.objectives );
        }
        
        bots_gametype_common::bot_cache_entrances_to_zones( [ initial_zone ] );
        object_key = bots_gametype_common::function_df1624ff6e509697( initial_zone );
        assert( !isdefined( level.bot_gametype_zones_precached[ object_key ] ) );
        level.bot_gametype_zones_precached[ object_key ] = 1;
        level.bot_gametype_precaching_done = 1;
        thread bot_cache_entrances_to_other_zones( initial_zone );
    }
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0xfc4b2162, Offset: 0x3b0
// Size: 0xc0
function bot_cache_entrances_to_other_zones( zone_done )
{
    for ( zones_left = arrayremove( level.objectives, zone_done ); zones_left.size > 0 ; zones_left = arrayremove( zones_left, zone_precaching ) )
    {
        zone_precaching = undefined;
        current_zone = level.zone;
        
        if ( isdefined( current_zone ) && arraycontains( zones_left, current_zone ) )
        {
            zone_precaching = current_zone;
        }
        else
        {
            zone_precaching = utility::array_random( zones_left );
        }
        
        bots_gametype_common::bot_cache_entrances_to_zones( [ zone_precaching ] );
        object_key = bots_gametype_common::function_df1624ff6e509697( zone_precaching );
        assert( !isdefined( level.bot_gametype_zones_precached[ object_key ] ) );
        level.bot_gametype_zones_precached[ object_key ] = 1;
    }
}

// Namespace bots_gametype_koth
// Params 0
// Checksum 0x467cbd57, Offset: 0x478
// Size: 0x36f
function bot_koth_think()
{
    self notify( #"bot_koth_think" );
    self endon( #"bot_koth_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    var_1eac739b8217e187 = undefined;
    last_recorded_zone = level.zone;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 0.05;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !( isdefined( level.zone ) && isdefined( level.bot_gametype_zones_precached[ bots_gametype_common::function_df1624ff6e509697( level.zone ) ] ) ) )
        {
            if ( namespace_14346d439f44a158::is_defending() )
            {
                namespace_14346d439f44a158::function_87e8deae08ce1a0();
            }
            
            self.current_zone = undefined;
            self [[ self.personality_update_function ]]();
            continue;
        }
        
        if ( last_recorded_zone != level.zone )
        {
            var_1eac739b8217e187 = undefined;
            last_recorded_zone = level.zone;
        }
        
        current_zone_active = level.zone.visibleteam != "none" && !level.zoneislocked && gameobjects_shared::is_activated( level.zone ) && isdefined( level.zoneendtime );
        var_ed3c97e4685ab7c6 = !isdefined( var_1eac739b8217e187 ) && !level.zonerandomlocationorder && level.bot_hp_allow_predictive_capping;
        
        if ( current_zone_active && var_ed3c97e4685ab7c6 )
        {
            var_626ff3d9b40e8b7 = level.zoneendtime - gettime();
            
            if ( var_626ff3d9b40e8b7 > 0 && var_626ff3d9b40e8b7 < 10000 )
            {
                var_a40305705a2889b = level.zone gameobjects::getownerteam() == self.team;
                
                if ( !var_a40305705a2889b )
                {
                    var_c2048e2d1d145927 = level.zone.zone_bounds.radius * 6;
                    
                    if ( var_626ff3d9b40e8b7 < 5000 )
                    {
                        var_c2048e2d1d145927 = level.zone.zone_bounds.radius * 3;
                    }
                    
                    var_81ed423ee535e8ca = distance( level.zone.zone_bounds.center, self.origin );
                    
                    if ( var_81ed423ee535e8ca > var_c2048e2d1d145927 )
                    {
                        var_1eac739b8217e187 = bot_should_cap_next_zone();
                    }
                }
                else
                {
                    team_limit = bots_util_mp::bot_get_max_players_on_team( self.team );
                    var_1d28d49c95c779c9 = ceil( team_limit / 2 );
                    
                    if ( var_626ff3d9b40e8b7 < 5000 )
                    {
                        var_1d28d49c95c779c9 = ceil( team_limit / 3 );
                    }
                    
                    var_6a2e7f7cf49e4a17 = bot_get_num_teammates_capturing_zone( level.zone );
                    
                    if ( var_6a2e7f7cf49e4a17 + 1 > var_1d28d49c95c779c9 )
                    {
                        var_1eac739b8217e187 = bot_should_cap_next_zone();
                    }
                }
            }
        }
        
        var_b176fae21df10829 = level.zone;
        
        if ( var_1eac739b8217e187 )
        {
            next_zone_index = ( level.prevzoneindex + 1 ) % level.objectives.size;
            
            if ( next_zone_index == 0 )
            {
                next_zone_index = 1;
            }
            
            var_b176fae21df10829 = level.objectives[ string( next_zone_index ) ];
        }
        
        if ( !bot_is_capturing_zone( var_b176fae21df10829 ) )
        {
            bot_capture_koth_zone( var_b176fae21df10829 );
        }
    }
}

// Namespace bots_gametype_koth
// Params 0
// Checksum 0x6836f011, Offset: 0x7ef
// Size: 0x74
function bot_should_cap_next_zone()
{
    if ( level.zonerandomlocationorder )
    {
        return 0;
    }
    
    strategy_level = self botgetdifficultysetting( "strategyLevel" );
    var_8dcb03dd6b262b9e = 0;
    
    if ( strategy_level == 1 )
    {
        var_8dcb03dd6b262b9e = 0.1;
    }
    else if ( strategy_level == 2 )
    {
        var_8dcb03dd6b262b9e = 0.5;
    }
    else if ( strategy_level == 3 )
    {
        var_8dcb03dd6b262b9e = 0.8;
    }
    
    return randomfloat( 1 ) < var_8dcb03dd6b262b9e;
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0x3b3f616, Offset: 0x86b
// Size: 0x15
function bot_get_num_teammates_capturing_zone( zone )
{
    return bot_get_teammates_capturing_zone( zone ).size;
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0x3f865a75, Offset: 0x889
// Size: 0xe1
function bot_get_teammates_capturing_zone( zone )
{
    teammates_capturing_zone = [];
    
    foreach ( other_player in level.participants )
    {
        if ( other_player != self && game_utility_common::isteamparticipant( other_player ) && isalliedsentient( self, other_player ) )
        {
            if ( other_player istouching( level.zone.trigger ) )
            {
                if ( !isai( other_player ) || other_player bot_is_capturing_zone( zone ) )
                {
                    teammates_capturing_zone[ teammates_capturing_zone.size ] = other_player;
                }
            }
        }
    }
    
    return teammates_capturing_zone;
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0x5abb08f4, Offset: 0x973
// Size: 0x24, Type: bool
function bot_is_capturing_zone( zone )
{
    if ( !namespace_14346d439f44a158::is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0x873c6343, Offset: 0x9a0
// Size: 0x64
function bot_capture_koth_zone( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    namespace_14346d439f44a158::capture_zone( gameobjects_shared::get_origin( zone ), zone.tacpoints, zone, optional_params );
}

// Namespace bots_gametype_koth
// Params 1
// Checksum 0xb660f194, Offset: 0xa0c
// Size: 0x51
function should_start_cautious_approach_koth( firstcheck )
{
    if ( firstcheck )
    {
        team = level.zone gameobjects::getownerteam();
        
        if ( team == "neutral" || team == self.team )
        {
            return 0;
        }
    }
    
    return bots_strategy::should_start_cautious_approach_default( firstcheck );
}

