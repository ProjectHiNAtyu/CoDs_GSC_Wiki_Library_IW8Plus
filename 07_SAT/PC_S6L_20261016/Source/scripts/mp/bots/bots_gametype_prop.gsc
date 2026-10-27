// scripts\mp\bots\bots_gametype_prop.gsc  (hash_271c1d3bb476f574.gscc) (size: 2245 Bytes / 0x8c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdec6c59f (3737568671)
// size ...... 2245 (0x8c5)
// includes .. 3   (offset: 0x821)
// strings ... 11  (offset: 0x839)
// dev strs .. 0   (offset: 0x8c5)
// exports ... 5   (offset: 0x479)
// cseg ...... 0x119 + 0x360 (0x479)
// imports ... 26  (offset: 0x541)
// animtree1 . 0   (offset: 0x8c5)
// animtree2 . 0   (offset: 0x8c5)
#using scripts\common\bots\bots_util;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_util;

#namespace bots_gametype_prop;

// Namespace bots_gametype_prop
// Params 0
// Checksum 0x9b64055d, Offset: 0x137
// Size: 0x25
function main()
{
    setup_callbacks();
    autopilot::initialize( undefined, undefined, [ "bot_default_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_prop
// Params 0
// Checksum 0xa5ddaa25, Offset: 0x164
// Size: 0x26
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &function_715e3e2c6235a93a;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
}

// Namespace bots_gametype_prop
// Params 0
// Checksum 0x4a692ae0, Offset: 0x192
// Size: 0x2cb
function function_715e3e2c6235a93a()
{
    self notify( #"hash_7cbaa3ca5a279c15" );
    self endon( #"hash_7cbaa3ca5a279c15" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    next_search_time = 0;
    
    while ( true )
    {
        wait 0.05;
        
        if ( self function_bece775663e54d92() )
        {
            continue;
        }
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( self botgetpersonality() != "run_and_gun" )
        {
            bots_util_mp::bot_set_personality( "run_and_gun" );
        }
        
        if ( function_4bc2ce8a1c792e8() )
        {
            if ( self botgetscriptgoaltype() != "tactical" )
            {
                zone_count = getzonecount();
                all_possible_zones = [];
                
                for ( i = 0; i < zone_count ; i++ )
                {
                    all_possible_zones[ i ] = i;
                }
                
                all_possible_zones = arrayrandomize( all_possible_zones );
                var_e7100d862b2a407a = [];
                
                for ( i = 0; i < all_possible_zones.size && var_e7100d862b2a407a.size < 512 ; i++ )
                {
                    zone_index_picked = all_possible_zones[ i ];
                    zone_tacpoints = getzonetacpoints( zone_index_picked );
                    zone_tacpoints = function_7a2f256e52489a6( zone_tacpoints );
                    var_e7100d862b2a407a = arraycombine( var_e7100d862b2a407a, zone_tacpoints );
                }
                
                var_e7100d862b2a407a = bots_util::function_4eb61a3985ad712c( var_e7100d862b2a407a, 1 );
                hide_tac = self bottacpointpick( var_e7100d862b2a407a, var_e7100d862b2a407a.size * 0.15, "hide_anywhere" );
                
                if ( isdefined( hide_tac ) )
                {
                    success = self botsetscriptgoal( hide_tac, 0, "tactical" );
                    
                    if ( success )
                    {
                        result = bots_util::bot_waittill_goal_or_fail();
                        
                        if ( result == "goal" )
                        {
                            self botsetflag( "disable_movement", 1 );
                            self botsetflag( "disable_rotation", 1 );
                        }
                        else
                        {
                            self botclearscriptgoal();
                        }
                    }
                }
            }
            
            continue;
        }
        
        if ( level.hide_phase_over )
        {
            if ( self function_9f7a5a4eae48d678() )
            {
                continue;
            }
            
            if ( gettime() > next_search_time )
            {
                enemy = self.enemy;
                
                if ( !isdefined( enemy ) )
                {
                    foreach ( player in level.players )
                    {
                        if ( !isalliedsentient( self, player ) )
                        {
                            enemy = player;
                            break;
                        }
                    }
                }
                
                if ( isdefined( enemy ) && !self botcanseeentity( enemy ) )
                {
                    var_ccb0adbea4bc4422 = function_3f30c865eea2b620();
                    self getenemyinfo( enemy, var_ccb0adbea4bc4422.groundpos );
                    next_search_time = gettime() + 10000;
                    wait 0.5;
                }
                
                continue;
            }
            
            self [[ self.personality_update_function ]]();
        }
    }
}

// Namespace bots_gametype_prop
// Params 0
// Checksum 0xb7bf140d, Offset: 0x465
// Size: 0x13, Type: bool
function function_4bc2ce8a1c792e8()
{
    return self.team == game[ "defenders" ];
}

