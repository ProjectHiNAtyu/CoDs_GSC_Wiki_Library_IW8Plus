// scripts\mp\bots\bots_gametype_grnd.gsc  (hash_18397ad45a54daf2.gscc) (size: 1615 Bytes / 0x64f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d8ae117 (1837818135)
// size ...... 1615 (0x64f)
// includes .. 6   (offset: 0x5e3)
// strings ... 5   (offset: 0x613)
// dev strs .. 0   (offset: 0x64f)
// exports ... 7   (offset: 0x2af)
// cseg ...... 0xb7 + 0x1f8 (0x2af)
// imports ... 19  (offset: 0x3c7)
// animtree1 . 0   (offset: 0x64f)
// animtree2 . 0   (offset: 0x64f)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;

#namespace bots_gametype_grnd;

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0x472141a3, Offset: 0xd5
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_grnd();
}

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0x99a42e4d, Offset: 0xed
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_grnd_think;
    autopilot::initialize( undefined, undefined, [ "bot_grnd_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0xed0d4377, Offset: 0x128
// Size: 0x21
function setup_bot_grnd()
{
    bots_util::bot_waittill_bots_enabled( 1 );
    level.protect_radius = 128;
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0xc319acd, Offset: 0x151
// Size: 0xf9
function bot_grnd_think()
{
    self notify( #"bot_grnd_think" );
    self endon( #"bot_grnd_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self botclearscriptgoal();
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    thread clear_defend();
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 0.05;
        
        if ( bots_tactical_goals::has_tactical_goal() )
        {
            continue;
        }
        
        if ( !self bothasscriptgoal() )
        {
            tacpoint = function_9872bdc0435c7675();
            
            if ( isdefined( tacpoint ) )
            {
                self botsetscriptgoal( tacpoint, 0, "objective" );
            }
            
            continue;
        }
        
        if ( !namespace_14346d439f44a158::is_defending() )
        {
            self botclearscriptgoal();
            tacpoint = function_9872bdc0435c7675();
            
            if ( isdefined( tacpoint ) )
            {
                namespace_14346d439f44a158::protect_point( tacpoint.groundpos, level.protect_radius );
            }
        }
    }
}

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0x347fc07b, Offset: 0x252
// Size: 0x27
function clear_defend()
{
    while ( true )
    {
        level waittill( #"zone_reset" );
        
        if ( namespace_14346d439f44a158::is_defending() )
        {
            namespace_14346d439f44a158::function_87e8deae08ce1a0();
        }
    }
}

// Namespace bots_gametype_grnd
// Params 0
// Checksum 0xc937f987, Offset: 0x281
// Size: 0x2e
function function_9872bdc0435c7675()
{
    tacpoints = bots_gametype_common::function_3491b57e9cace1d5( level.zone );
    
    if ( tacpoints.size > 0 )
    {
        return utility::array_random( tacpoints );
    }
}

