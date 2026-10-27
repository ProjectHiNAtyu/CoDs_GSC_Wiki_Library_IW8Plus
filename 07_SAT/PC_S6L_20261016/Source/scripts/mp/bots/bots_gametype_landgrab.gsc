// scripts\mp\bots\bots_gametype_landgrab.gsc  (hash_3827b33d02119b22.gscc) (size: 3292 Bytes / 0xcdc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1047f172 (273150322)
// size ...... 3292 (0xcdc)
// includes .. 7   (offset: 0xc20)
// strings ... 8   (offset: 0xc58)
// dev strs .. 3   (offset: 0xcb8)
// exports ... 10  (offset: 0x724)
// cseg ...... 0x100 + 0x624 (0x724)
// imports ... 30  (offset: 0x8b4)
// animtree1 . 0   (offset: 0xcdc)
// animtree2 . 0   (offset: 0xcdc)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;

#namespace bots_gametype_landgrab;

// Namespace bots_gametype_landgrab
// Params 0
// Checksum 0xa1cd218e, Offset: 0x11e
// Size: 0x1a
function main()
{
    setup_callbacks();
    setup_bot_landgrab();
    
    /#
        thread bots_gametype_common::function_a6cacb00e9275066();
    #/
}

// Namespace bots_gametype_landgrab
// Params 0
// Checksum 0xcb851ef2, Offset: 0x140
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_landgrab_think;
    autopilot::initialize( undefined, undefined, [ "bot_landgrab_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_landgrab
// Params 0
// Checksum 0x93d24b9a, Offset: 0x17b
// Size: 0x2d2
function setup_bot_landgrab()
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
        while ( level.zones.size == 0 )
        {
            waitframe();
        }
        
        other_zones = level.objectives;
        
        foreach ( zone in level.zones )
        {
            bots_gametype_common::bot_cache_entrances_to_zones( [ zone ], 1 );
            object_key = bots_gametype_common::function_df1624ff6e509697( zone );
            assert( !isdefined( level.bot_gametype_zones_precached[ object_key ] ) );
            level.bot_gametype_zones_precached[ object_key ] = 1;
            other_zones = arrayremove( other_zones, zone );
        }
        
        level.bot_gametype_precaching_done = 1;
        
        foreach ( zone in other_zones )
        {
            bots_gametype_common::bot_cache_entrances_to_zones( [ zone ], 1 );
            object_key = bots_gametype_common::function_df1624ff6e509697( zone );
            assert( !isdefined( level.bot_gametype_zones_precached[ object_key ] ) );
            level.bot_gametype_zones_precached[ object_key ] = 1;
        }
    }
}

// Namespace bots_gametype_landgrab
// Params 0
// Checksum 0x9f4f4492, Offset: 0x455
// Size: 0x12d
function bot_landgrab_think()
{
    self notify( #"bot_landgrab_think" );
    self endon( #"bot_landgrab_think" );
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
        
        var_b176fae21df10829 = self.current_zone;
        
        if ( isdefined( var_b176fae21df10829 ) && !zone_is_active( var_b176fae21df10829 ) )
        {
            var_b176fae21df10829 = undefined;
        }
        
        if ( !isdefined( var_b176fae21df10829 ) )
        {
            active_zones = get_active_zones();
            
            if ( active_zones.size > 0 )
            {
                var_b176fae21df10829 = utility::array_random( active_zones );
            }
        }
        
        if ( !isdefined( var_b176fae21df10829 ) )
        {
            if ( bots_scripted_defense::is_defending() )
            {
                bots_scripted_defense::function_87e8deae08ce1a0();
            }
            
            self.current_zone = undefined;
            self [[ self.personality_update_function ]]();
            continue;
        }
        
        if ( !bot_is_capturing_zone( var_b176fae21df10829 ) )
        {
            function_b6d4860efee55933( var_b176fae21df10829 );
        }
    }
}

// Namespace bots_gametype_landgrab
// Params 0
// Checksum 0xa6e628fc, Offset: 0x58a
// Size: 0x9d
function get_active_zones()
{
    active_zones = [];
    
    foreach ( zone in level.zones )
    {
        if ( zone_is_active( zone ) && zone_is_precached( zone ) )
        {
            active_zones[ active_zones.size ] = zone;
        }
    }
    
    return active_zones;
}

// Namespace bots_gametype_landgrab
// Params 1
// Checksum 0x2e3342b0, Offset: 0x630
// Size: 0x2d, Type: bool
function zone_is_precached( zone )
{
    object_key = bots_gametype_common::function_df1624ff6e509697( zone );
    return isdefined( level.bot_gametype_zones_precached[ object_key ] );
}

// Namespace bots_gametype_landgrab
// Params 1
// Checksum 0xd2a233b3, Offset: 0x666
// Size: 0x24, Type: bool
function zone_is_active( zone )
{
    if ( zone.visibleteam == "any" )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_landgrab
// Params 1
// Checksum 0x49f8fe8d, Offset: 0x693
// Size: 0x24, Type: bool
function bot_is_capturing_zone( zone )
{
    if ( !bots_scripted_defense::is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_landgrab
// Params 1
// Checksum 0xed50308, Offset: 0x6c0
// Size: 0x64
function function_b6d4860efee55933( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    bots_scripted_defense::capture_zone( gameobjects_shared::get_origin( zone ), zone.tacpoints, zone, optional_params );
}

