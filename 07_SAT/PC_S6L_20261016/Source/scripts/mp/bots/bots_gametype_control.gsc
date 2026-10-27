// scripts\mp\bots\bots_gametype_control.gsc  (hash_29c0d2eb0c9a2888.gscc) (size: 2521 Bytes / 0x9d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcde98c9d (3454635165)
// size ...... 2521 (0x9d9)
// includes .. 6   (offset: 0x931)
// strings ... 7   (offset: 0x961)
// dev strs .. 3   (offset: 0x9b5)
// exports ... 9   (offset: 0x551)
// cseg ...... 0xf8 + 0x459 (0x551)
// imports ... 22  (offset: 0x6b9)
// animtree1 . 0   (offset: 0x9d9)
// animtree2 . 0   (offset: 0x9d9)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;

#namespace bots_gametype_control;

// Namespace bots_gametype_control
// Params 0
// Checksum 0x759c04c6, Offset: 0x116
// Size: 0x25
function main()
{
    level.var_ae4d3fde002fedb4 = 1;
    setup_callbacks();
    setup_bot_control();
    
    /#
        thread bots_gametype_common::function_a6cacb00e9275066();
    #/
}

// Namespace bots_gametype_control
// Params 0
// Checksum 0x93da068, Offset: 0x143
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_control_think;
    autopilot::initialize( undefined, undefined, [ "bot_control_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_control
// Params 0
// Checksum 0x8c577e61, Offset: 0x17e
// Size: 0x148
function setup_bot_control()
{
    bots_util::bot_waittill_bots_enabled();
    var_b149307f9ac27374 = 0;
    valid_objectives = [];
    
    foreach ( objective in level.objectives )
    {
        if ( !function_4909b59442350834( objective ) )
        {
            continue;
        }
        
        valid_objectives[ valid_objectives.size ] = objective;
        objective thread bots_gametype_common::monitor_zone_control();
        objective.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( objective, 1 );
        
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
        bots_gametype_common::bot_cache_entrances_to_zones( valid_objectives );
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_control
// Params 0
// Checksum 0xb2f0577b, Offset: 0x2ce
// Size: 0x125
function bot_control_think()
{
    self notify( #"bot_control_think" );
    self endon( #"bot_control_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    self.current_zone = undefined;
    
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
        
        var_6a4cb8bb728cfa46 = undefined;
        
        if ( isdefined( self.current_zone ) && function_4909b59442350834( self.current_zone ) )
        {
            var_6a4cb8bb728cfa46 = self.current_zone;
        }
        else
        {
            active_zones = function_d5ca8ab7c7c7bf31();
            
            if ( active_zones.size > 0 )
            {
                var_6a4cb8bb728cfa46 = utility::array_random( active_zones );
            }
        }
        
        if ( isdefined( var_6a4cb8bb728cfa46 ) )
        {
            if ( !bot_is_capturing_zone( var_6a4cb8bb728cfa46 ) )
            {
                function_3b6ae903ef3464b3( var_6a4cb8bb728cfa46 );
            }
            
            continue;
        }
        
        self [[ self.personality_update_function ]]();
    }
}

// Namespace bots_gametype_control
// Params 1
// Checksum 0xe6a9372c, Offset: 0x3fb
// Size: 0x22
function function_4909b59442350834( objective )
{
    is_active = gameobjects_shared::is_activated( objective );
    return is_active;
}

// Namespace bots_gametype_control
// Params 1
// Checksum 0x559ab437, Offset: 0x426
// Size: 0x24, Type: bool
function bot_is_capturing_zone( zone )
{
    if ( !bots_scripted_defense::is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_control
// Params 0
// Checksum 0x780a736f, Offset: 0x453
// Size: 0x91
function function_d5ca8ab7c7c7bf31()
{
    active_zones = [];
    
    foreach ( zone in level.objectives )
    {
        if ( function_4909b59442350834( zone ) )
        {
            active_zones[ active_zones.size ] = zone;
        }
    }
    
    return active_zones;
}

// Namespace bots_gametype_control
// Params 1
// Checksum 0xcb1875f4, Offset: 0x4ed
// Size: 0x64
function function_3b6ae903ef3464b3( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    bots_scripted_defense::capture_zone( gameobjects_shared::get_origin( zone ), zone.tacpoints, zone, optional_params );
}

