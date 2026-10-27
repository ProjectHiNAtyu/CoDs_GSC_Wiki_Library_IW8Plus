// scripts\mp\bots\bots_gametype_rescue.gsc  (hash_6433cef13f2ceb0c.gscc) (size: 3967 Bytes / 0xf7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd800c79 (3447721081)
// size ...... 3967 (0xf7f)
// includes .. 5   (offset: 0xe83)
// strings ... 16  (offset: 0xeab)
// dev strs .. 0   (offset: 0xf7f)
// exports ... 10  (offset: 0x92b)
// cseg ...... 0x141 + 0x7ea (0x92b)
// imports ... 32  (offset: 0xabb)
// animtree1 . 0   (offset: 0xf7f)
// animtree2 . 0   (offset: 0xf7f)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;

#namespace bots_gametype_rescue;

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0xe24bd8f2, Offset: 0x15f
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_rescue();
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x9d3aca5a, Offset: 0x177
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_rescue_think;
    autopilot::initialize( undefined, undefined, [ "bot_rescue_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x5cba6945, Offset: 0x1b2
// Size: 0x29
function setup_bot_rescue()
{
    level.var_446ad1473db1520e = game[ "attackers" ];
    level.var_d7ed3bdcb00a6cee = game[ "defenders" ];
    thread bot_rescue_ai_director_update();
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x76c2fbd7, Offset: 0x1e3
// Size: 0x399
function bot_rescue_think()
{
    self notify( #"bot_rescue_think" );
    self endon( #"bot_rescue_think" );
    self endon( #"death_or_disconnect" );
    self endon( #"spawned" );
    level endon( #"game_ended" );
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( self.health <= 0 || self.liveragdoll )
        {
            wait 0.05;
            continue;
        }
        
        if ( !isdefined( self.role ) )
        {
            function_9a316e5319f540d();
        }
        
        if ( !isdefined( self.hostage_target ) )
        {
            self.hostage_target = utility::array_random( level.hostages );
        }
        
        if ( isdefined( self.hostage_target ) && self.hostage_target.interactteam == "none" && !isdefined( self.hostage_target.ownerteam ) )
        {
            self.hostage_target = utility::array_random( level.hostages );
        }
        
        if ( !isdefined( self.hostage_target ) )
        {
            wait 0.05;
            continue;
        }
        
        if ( self.team == level.var_446ad1473db1520e )
        {
            if ( isdefined( self.hostage_target.carrier ) )
            {
                clear_defend();
                
                if ( isalive( self.hostage_target.carrier ) )
                {
                    self botsetscriptgoal( self.hostage_target.carrier.origin, 16, "critical" );
                }
                else
                {
                    self botsetscriptgoal( self.hostage_target.curorigin, 16, "critical" );
                }
            }
            else if ( !bots_scripted_defense::is_defending_point( self.hostage_target.curorigin ) && self.hostage_target.interactteam != "none" )
            {
                optional_params[ "score_flags" ] = "strict_los";
                self botclearscriptgoal();
                bots_scripted_defense::protect_point( self.hostage_target.curorigin, level.protect_radius, optional_params );
            }
        }
        else if ( self.team == level.var_d7ed3bdcb00a6cee )
        {
            if ( function_2df95d4df780af4e() )
            {
                if ( !isdefined( self.hostage_extract_target ) )
                {
                    self.hostage_extract_target = utility::array_random( level.extractzones );
                }
                
                clear_defend();
                self botsetscriptgoal( self.hostage_extract_target.curorigin, 16, "critical" );
            }
            else if ( isdefined( self.hostage_target.carrier ) )
            {
                if ( !bots_scripted_defense::function_737443eaedb33690() )
                {
                    clear_defend();
                    self botclearscriptgoal();
                    bots_scripted_defense::guard_player( self.hostage_target.carrier, 500 );
                }
            }
            else
            {
                clear_defend();
                
                if ( self botgetscriptgoaltype() == "critical" )
                {
                    self botclearscriptgoal();
                }
                
                self botsetscriptgoal( self.hostage_target.curorigin, 16, "objective" );
                self botsetobjectiveradius( 50 );
                result = bots_util::bot_waittill_goal_or_fail();
                
                if ( result == "goal" )
                {
                    self botpressbutton( "use", 1 );
                    result = bots_util::bot_usebutton_wait( 1 );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x8687434c, Offset: 0x584
// Size: 0xc, Type: bool
function function_2df95d4df780af4e()
{
    return istrue( self.hashostage );
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x3c469d96, Offset: 0x599
// Size: 0x49
function function_9a316e5319f540d()
{
    if ( self.team == level.var_446ad1473db1520e )
    {
        bots_gametype_common::bot_gametype_set_role( "defender" );
        return;
    }
    
    if ( self.team == level.var_d7ed3bdcb00a6cee )
    {
        bots_gametype_common::bot_gametype_set_role( "attacker" );
    }
}

// Namespace bots_gametype_rescue
// Params 1
// Checksum 0xb9117a54, Offset: 0x5ea
// Size: 0x11c
function function_4085090a6e8e5ab2( hostage )
{
    var_6b3461445dc63dd9 = [];
    var_561bcb7dbcb773ac = bots_gametype_common::get_living_players_on_team( level.var_446ad1473db1520e );
    
    foreach ( player in var_561bcb7dbcb773ac )
    {
        if ( isai( player ) && isdefined( player.role ) && player.role == "defender" )
        {
            if ( player.hostage_target == hostage )
            {
                var_6b3461445dc63dd9[ var_6b3461445dc63dd9.size ] = player;
            }
            
            continue;
        }
        
        if ( distancesquared( player.origin, hostage.curorigin ) < level.protect_radius * level.protect_radius )
        {
            var_6b3461445dc63dd9[ var_6b3461445dc63dd9.size ] = player;
        }
    }
    
    return var_6b3461445dc63dd9;
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0x7367692c, Offset: 0x70f
// Size: 0x12
function clear_defend()
{
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
}

// Namespace bots_gametype_rescue
// Params 0
// Checksum 0xa169dc4f, Offset: 0x729
// Size: 0x202
function bot_rescue_ai_director_update()
{
    level notify( #"bot_rescue_ai_director_update" );
    level endon( #"bot_rescue_ai_director_update" );
    level endon( #"game_ended" );
    level.protect_radius = 725;
    
    while ( true )
    {
        foreach ( i in level.hostages )
        {
            foreach ( j in level.hostages )
            {
                var_3482595f3f8cd2af = function_4085090a6e8e5ab2( i );
                var_34825a5f3f8cd4e2 = function_4085090a6e8e5ab2( j );
                
                if ( var_3482595f3f8cd2af.size > var_34825a5f3f8cd4e2.size + 1 )
                {
                    var_75f5c998daa1e88a = [];
                    
                    foreach ( player in var_3482595f3f8cd2af )
                    {
                        if ( isai( player ) )
                        {
                            var_75f5c998daa1e88a[ var_75f5c998daa1e88a.size ] = player;
                        }
                    }
                    
                    if ( var_75f5c998daa1e88a.size > 0 )
                    {
                        defender = utility::array_random( var_75f5c998daa1e88a );
                        defender bots_scripted_defense::function_87e8deae08ce1a0();
                        defender.hostage_target = j;
                    }
                }
            }
        }
        
        wait 0.5;
    }
}

