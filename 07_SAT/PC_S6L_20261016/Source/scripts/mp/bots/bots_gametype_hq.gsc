// scripts\mp\bots\bots_gametype_hq.gsc  (hash_0c1563dc424637ee.gscc) (size: 4105 Bytes / 0x1009 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5413727 (3577820967)
// size ...... 4105 (0x1009)
// includes .. 9   (offset: 0xf2d)
// strings ... 9   (offset: 0xf75)
// dev strs .. 3   (offset: 0xfe5)
// exports ... 13  (offset: 0x869)
// cseg ...... 0x120 + 0x749 (0x869)
// imports ... 41  (offset: 0xa71)
// animtree1 . 0   (offset: 0x1009)
// animtree2 . 0   (offset: 0x1009)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\gameobjects;

#namespace bots_gametype_hq;

// Namespace bots_gametype_hq
// Params 0
// Checksum 0x5c528146, Offset: 0x13e
// Size: 0x1a
function main()
{
    setup_callbacks();
    setup_bot_hq();
    
    /#
        thread bots_gametype_common::function_a6cacb00e9275066();
    #/
}

// Namespace bots_gametype_hq
// Params 0
// Checksum 0xe42a1e3a, Offset: 0x160
// Size: 0x48
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_hq_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_hq;
    autopilot::initialize( undefined, undefined, [ "bot_hq_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_hq
// Params 0
// Checksum 0x9ea2e115, Offset: 0x1b0
// Size: 0x1c4
function setup_bot_hq()
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
        current_radio = find_current_radio();
        
        if ( !isdefined( current_radio ) )
        {
            current_radio = utility::array_random( level.objectives );
        }
        
        bots_gametype_common::bot_cache_entrances_to_zones( [ current_radio ] );
        object_key = bots_gametype_common::function_df1624ff6e509697( current_radio );
        assert( !isdefined( level.bot_gametype_radios_precached[ object_key ] ) );
        level.bot_gametype_radios_precached[ object_key ] = 1;
        level.bot_gametype_precaching_done = 1;
        thread bot_cache_entrances_to_other_radios( current_radio );
    }
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0x899585ad, Offset: 0x37c
// Size: 0xbd
function bot_cache_entrances_to_other_radios( radio_done )
{
    for ( radios_left = arrayremove( level.objectives, radio_done ); radios_left.size > 0 ; radios_left = arrayremove( radios_left, radio_precaching ) )
    {
        radio_precaching = undefined;
        current_radio = find_current_radio();
        
        if ( isdefined( current_radio ) && arraycontains( radios_left, current_radio ) )
        {
            radio_precaching = current_radio;
        }
        else
        {
            radio_precaching = utility::array_random( radios_left );
        }
        
        bots_gametype_common::bot_cache_entrances_to_zones( [ radio_precaching ] );
        object_key = bots_gametype_common::function_df1624ff6e509697( radio_precaching );
        assert( !isdefined( level.bot_gametype_radios_precached[ object_key ] ) );
        level.bot_gametype_radios_precached[ object_key ] = 1;
    }
}

// Namespace bots_gametype_hq
// Params 0
// Checksum 0xa0391bd0, Offset: 0x441
// Size: 0x1d7
function bot_hq_think()
{
    self notify( #"bot_hq_think" );
    self endon( #"bot_hq_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    
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
        
        current_radio = find_current_radio();
        
        if ( !isdefined( current_radio ) || !current_radio.active )
        {
            bot_clear_hq_zone();
            self [[ self.personality_update_function ]]();
            continue;
        }
        
        object_key = bots_gametype_common::function_df1624ff6e509697( current_radio );
        
        if ( !isdefined( level.bot_gametype_radios_precached[ object_key ] ) )
        {
            bot_clear_hq_zone();
            self [[ self.personality_update_function ]]();
            continue;
        }
        
        hqowningteam = level.zone gameobjects::getownerteam();
        
        if ( self.team != hqowningteam )
        {
            if ( !bot_is_capturing_hq_zone( current_radio ) )
            {
                bot_capture_hq_zone( current_radio );
            }
            
            continue;
        }
        
        enemy_team = utility::get_enemy_team( self.team );
        enemies_inside_zone = level.zone.touchlist[ enemy_team ].size > 0;
        
        if ( enemies_inside_zone )
        {
            if ( !bot_is_capturing_hq_zone( current_radio ) )
            {
                bot_capture_hq_zone( current_radio );
            }
            
            continue;
        }
        
        if ( !bot_is_protecting_hq_zone( current_radio ) )
        {
            if ( bot_is_capturing_hq_zone( current_radio ) )
            {
                wait randomfloat( 2 );
                bot_clear_hq_zone();
                continue;
            }
            
            bot_protect_hq_zone( current_radio );
        }
    }
}

// Namespace bots_gametype_hq
// Params 0
// Checksum 0xe248bd21, Offset: 0x620
// Size: 0x84
function find_current_radio()
{
    foreach ( radio in level.objectives )
    {
        if ( radio == level.zone )
        {
            return radio;
        }
    }
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0x42e10bd8, Offset: 0x6ac
// Size: 0x24, Type: bool
function bot_is_capturing_hq_zone( zone )
{
    if ( !namespace_14346d439f44a158::is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0x6df4018c, Offset: 0x6d9
// Size: 0x24, Type: bool
function bot_is_protecting_hq_zone( zone )
{
    if ( !namespace_14346d439f44a158::is_protecting() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0x71f99e14, Offset: 0x706
// Size: 0x64
function bot_capture_hq_zone( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    namespace_14346d439f44a158::capture_zone( gameobjects_shared::get_origin( zone ), zone.tacpoints, zone, optional_params );
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0xd36f182e, Offset: 0x772
// Size: 0x79
function bot_protect_hq_zone( zone )
{
    self.current_zone = zone;
    zone_radius = length( zone.zone_bounds.half_size ) * 2;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    namespace_14346d439f44a158::protect_point( zone.center_tacpoint.groundpos, zone_radius, optional_params );
}

// Namespace bots_gametype_hq
// Params 0
// Checksum 0xe303938e, Offset: 0x7f3
// Size: 0x1c
function bot_clear_hq_zone()
{
    if ( namespace_14346d439f44a158::is_defending() )
    {
        namespace_14346d439f44a158::function_87e8deae08ce1a0();
    }
    
    self.current_zone = undefined;
}

// Namespace bots_gametype_hq
// Params 1
// Checksum 0xf104ea7d, Offset: 0x817
// Size: 0x51
function should_start_cautious_approach_hq( firstcheck )
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

