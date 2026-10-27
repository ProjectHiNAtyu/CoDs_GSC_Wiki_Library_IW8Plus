// scripts\mp\bots\bots_gametype_rugby.gsc  (hash_0f547766b907dd86.gscc) (size: 7821 Bytes / 0x1e8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d52d294 (2639450772)
// size ...... 7821 (0x1e8d)
// includes .. 9   (offset: 0x1ce1)
// strings ... 24  (offset: 0x1d29)
// dev strs .. 4   (offset: 0x1e5d)
// exports ... 20  (offset: 0x1205)
// cseg ...... 0x1cd + 0x1038 (0x1205)
// imports ... 66  (offset: 0x1525)
// animtree1 . 0   (offset: 0x1e8d)
// animtree2 . 0   (offset: 0x1e8d)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\gametypes\rugby;

#namespace bots_gametype_rugby;

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x54d55665, Offset: 0x1eb
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_rugby();
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x4a73e6d8, Offset: 0x203
// Size: 0x6c
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_rugby_think;
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
    level.bot_funcs[ "jugg_picked_up_cancel" ] = &function_3491077bc9ecc84d;
    autopilot::initialize( undefined, undefined, [ "bot_rugby_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0xb0d0df33, Offset: 0x277
// Size: 0x51
function setup_bot_rugby()
{
    function_f723c4f58a2d6bcb();
    bots_util::bot_waittill_bots_enabled();
    succeeded = function_5c6ff5a41fec8755( [ "_allies", "_axis" ] );
    
    if ( succeeded )
    {
        level.protect_radius = 1200;
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0xb04a8759, Offset: 0x2d0
// Size: 0x366
function bot_rugby_think()
{
    self notify( #"bot_rugby_think" );
    self endon( #"bot_rugby_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    /#
        setdevdvarifuninitialized( @"hash_54b3dbf61a166e11", 0 );
        level thread function_4959e75a6e49e6c();
    #/
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    function_8890bfda779ce375();
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    self.next_time_hunt_carrier = gettime();
    
    if ( !isdefined( level.next_game_update_time ) )
    {
        level.next_game_update_time = gettime() + 100;
    }
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( gettime() >= level.next_game_update_time )
        {
            level.next_game_update_time = gettime() + 100;
        }
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( level.rugbyjugg ) )
        {
            if ( bots_tactical_goals::has_tactical_goal( "seek_rugby_jugg", undefined ) == 0 )
            {
                action_thread = &function_810f2d7fe798b9f2;
                extra_params = spawnstruct();
                extra_params.object = level.rugby.activejuggcrates[ 0 ];
                extra_params.script_goal_radius = 16;
                extra_params.should_abort = level.bot_funcs[ "jugg_picked_up_cancel" ];
                extra_params.action_thread = action_thread;
                var_9f4325dbeb7288ba = getclosestpointonnavmesh( level.rugby.activejuggcrates[ 0 ].origin, self );
                bots_tactical_goals::new_tactical_goal( "seek_rugby_jugg", var_9f4325dbeb7288ba, 99, extra_params );
            }
            
            continue;
        }
        
        if ( self == level.rugbyjugg )
        {
            if ( game[ "switchedsides" ] )
            {
                endzone = level.rugby.endzones[ self.team ][ 0 ];
            }
            else
            {
                endzone = level.rugby.endzones[ utility::get_enemy_team( self.team ) ][ 0 ];
            }
            
            var_8c91f76f96080f7f = function_ed59c010f814ba72( endzone.trigger );
            self botsetscriptgoal( var_8c91f76f96080f7f.origin, 0, "critical", var_8c91f76f96080f7f.angles[ 1 ] );
            bots_util::bot_waittill_goal_or_fail();
            continue;
        }
        
        if ( level.rugbyjugg.team == self.team )
        {
            if ( !namespace_14346d439f44a158::is_defending() )
            {
                namespace_14346d439f44a158::guard_player( level.rugbyjugg, 400 );
            }
            
            continue;
        }
        
        if ( gettime() > self.next_time_hunt_carrier || sighttracepassed( self.origin + ( 0, 0, 77 ), level.rugbyjugg.origin + ( 0, 0, 77 ), 0, self ) )
        {
            self botsetscriptgoal( level.rugbyjugg.origin, 16, "hunt" );
            self.next_time_hunt_carrier = gettime() + randomintrange( 4500, 5500 );
        }
    }
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0x625a9f52, Offset: 0x63e
// Size: 0x4e
function function_ed59c010f814ba72( trigger )
{
    if ( trigger.tacpoints.size >= 2 )
    {
        bot_targets_randomized = arrayrandomize( trigger.tacpoints );
        return bot_targets_randomized[ 0 ];
    }
    
    return trigger.tacpoints[ 0 ];
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0xf6862c04, Offset: 0x694
// Size: 0x1d, Type: bool
function function_3491077bc9ecc84d( goal )
{
    if ( isdefined( level.rugbyjugg ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0x888a537, Offset: 0x6ba
// Size: 0x43
function function_810f2d7fe798b9f2( goal )
{
    succeeded = function_6d30374006219338( rugby::function_5a3184d680092b8b() + 2, "jugg_captured", randomint( 100 ) > 50 );
    self botclearscriptgoal();
    
    if ( succeeded )
    {
    }
}

// Namespace bots_gametype_rugby
// Params 4
// Checksum 0xe4bdfb69, Offset: 0x705
// Size: 0xe4
function function_6d30374006219338( time, self_end_notify, emergency_plant, dont_prone )
{
    chance_to_prone = 0;
    
    if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
    {
        chance_to_prone = 40;
    }
    else if ( self botgetdifficultysetting( "strategyLevel" ) >= 2 )
    {
        chance_to_prone = 80;
    }
    
    if ( randomint( 100 ) < chance_to_prone && !dont_prone )
    {
        self botsetstance( "prone" );
        wait 0.2;
    }
    
    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 && !emergency_plant )
    {
    }
    
    self botpressbutton( "use", time );
    result = bots_util::bot_usebutton_wait( time, self_end_notify, "use_interrupted" );
    self botsetstance( "none" );
    self botclearbutton( "use" );
    succeeded = result == self_end_notify;
    return succeeded;
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0x4a3e9cec, Offset: 0x7f2
// Size: 0x5d
function waittill_usebutton_released_or_time_or_bomb_planted( time )
{
    time_started = gettime();
    time_to_end = time_started + time * 1000;
    wait 0.05;
    
    while ( self usebuttonpressed() && gettime() < time_to_end && level.bombplanted )
    {
        wait 0.05;
    }
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0xa2e8060, Offset: 0x857
// Size: 0x8
function is_defending_bombzone()
{
    return namespace_14346d439f44a158::is_protecting();
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x97ba47af, Offset: 0x868
// Size: 0x1a
function function_8890bfda779ce375()
{
    if ( level.bots_gametype_initialized )
    {
        return;
    }
    
    level.bots_gametype_initialized = 1;
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x984e6a57, Offset: 0x88a
// Size: 0x6b
function function_f723c4f58a2d6bcb()
{
    wait 1;
    function_9f7e8b1ffe5c561e( level.rugby.endzones[ "allies" ][ 0 ].trigger );
    function_9f7e8b1ffe5c561e( level.rugby.endzones[ "axis" ][ 0 ].trigger );
    level.var_3cea2151bc5f621b = 1;
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0xe15bae5e, Offset: 0x8fd
// Size: 0x2c
function function_9f7e8b1ffe5c561e( element )
{
    if ( !isdefined( element.tacpoints ) )
    {
        element.tacpoints = function_bad8552afaeb33fd( element );
    }
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x9d19c9b5, Offset: 0x931
// Size: 0x385
function function_b138ca4e70c57422()
{
    if ( !level.bombplanted )
    {
        if ( isdefined( level.team_planted_bomb ) )
        {
            level.team_planted_bomb = undefined;
            level.bomb_carrier = undefined;
        }
        
        prev_carrier = level.bomb_carrier;
        level.bomb_carrier = undefined;
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && player.isbombcarrier )
            {
                level.bomb_carrier = player;
            }
        }
        
        var_c87f1a88739abc7 = 0;
        
        if ( !isdefined( prev_carrier ) && isdefined( level.bomb_carrier ) )
        {
            assert( game_utility_common::isteamparticipant( level.bomb_carrier ) );
            var_c87f1a88739abc7 = 1;
            
            if ( isai( level.bomb_carrier ) )
            {
                level.bomb_carrier thread bomber_think();
            }
        }
        else if ( isdefined( prev_carrier ) && !isdefined( level.bomb_carrier ) )
        {
            var_c87f1a88739abc7 = 1;
        }
        
        if ( var_c87f1a88739abc7 )
        {
            foreach ( player in level.participants )
            {
                if ( game_utility_common::isaiteamparticipant( player ) )
                {
                    player namespace_14346d439f44a158::function_87e8deae08ce1a0();
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( level.bombowner ) && !isdefined( level.team_planted_bomb ) )
    {
        level.team_planted_bomb = level.bombowner.team;
        level.last_time_calc_defuser = gettime();
    }
    
    if ( !isalive( level.bomb_defuser ) || gettime() > level.last_time_calc_defuser + 1000 )
    {
        defusers = [];
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && game_utility_common::isaiteamparticipant( player ) && player.team != level.team_planted_bomb )
            {
                defusers[ defusers.size ] = player;
            }
        }
        
        if ( defusers.size > 0 )
        {
            bombzone = level.objectives[ utility::get_enemy_team( level.team_planted_bomb ) ];
            defusers_sorted = utility::get_array_of_closest( bombzone.curorigin, defusers );
            
            if ( level.bomb_defuser != defusers_sorted[ 0 ] )
            {
                prev_defuser = level.bomb_defuser;
                level.bomb_defuser = defusers_sorted[ 0 ];
                level.bomb_defuser namespace_14346d439f44a158::function_87e8deae08ce1a0();
                
                if ( isdefined( prev_defuser ) )
                {
                    prev_defuser notify( #"no_longer_bomb_defuser" );
                }
            }
        }
    }
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x10c31a6b, Offset: 0xcbe
// Size: 0x1f8
function bomber_think()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !level.bombplanted && self.isbombcarrier )
    {
        followers = [];
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && game_utility_common::isaiteamparticipant( player ) && player.team == self.team && player namespace_14346d439f44a158::is_defending() )
            {
                followers[ followers.size ] = player;
            }
        }
        
        num_behind = 0;
        
        foreach ( follower in followers )
        {
            var_b88d2ef519caf26a = distancesquared( self.origin, follower.origin );
            var_ad4c9d93b2503ac8 = follower.bot_defending_radius * follower.bot_defending_radius;
            var_a53ac3aaa6792366 = follower.bot_defending_radius * 2 * follower.bot_defending_radius * 2;
            
            if ( var_b88d2ef519caf26a > var_ad4c9d93b2503ac8 && var_b88d2ef519caf26a < var_a53ac3aaa6792366 )
            {
                num_behind++;
            }
        }
        
        self setmovespeedscale( 1 - 0.15 * num_behind );
        wait 1;
    }
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0x661ce884, Offset: 0xebe
// Size: 0x67, Type: bool
function crate_can_use( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return false;
    }
    
    if ( !bots::function_c84d79ce363ba645( crate ) )
    {
        return false;
    }
    
    if ( self.isbombcarrier )
    {
        return false;
    }
    
    if ( !namespace_14346d439f44a158::is_defending() && !namespace_14346d439f44a158::is_protecting() && !namespace_14346d439f44a158::function_737443eaedb33690() )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_rugby
// Params 1
// Checksum 0x27730dde, Offset: 0xf2e
// Size: 0x167, Type: bool
function function_5c6ff5a41fec8755( valid_labels )
{
    var_61fbb895c8a0f79e = 0;
    
    foreach ( endzone in level.rugby.endzones )
    {
        /#
            wait_time = 1;
            
            if ( gettime() < 5000 )
            {
                wait_time = max( 1, 5 - gettime() / 1000 );
            }
            
            if ( !isdefined( endzone[ 0 ].trigger ) )
            {
                wait wait_time;
                return false;
            }
            
            if ( endzone[ 0 ].trigger.tacpoints.size < 3 )
            {
                wait wait_time;
                assertmsg( "<dev string:x24>" + "<dev string:x2e>" + endzone[ 0 ].trigger.origin + "<dev string:x3d>" );
                
                if ( endzone[ 0 ].trigger.tacpoints.size < 1 )
                {
                    var_61fbb895c8a0f79e = 1;
                }
            }
        #/
    }
    
    if ( !var_61fbb895c8a0f79e )
    {
        function_6fd1e7152e30ff4f();
    }
    
    return !var_61fbb895c8a0f79e;
}

// Namespace bots_gametype_rugby
// Params 0
// Checksum 0x70b3ecc3, Offset: 0x109e
// Size: 0x116
function function_6fd1e7152e30ff4f()
{
    assert( isdefined( level.rugby.endzones ) );
    entrance_origin_points = [];
    entrance_labels = [];
    index = 0;
    
    foreach ( endzone in level.rugby.endzones )
    {
        entrance_origin_points[ index ] = utility::array_random( endzone[ 0 ].trigger.tacpoints ).origin;
        entrance_labels[ index ] = "zone" + endzone[ 0 ].trigger.objectivekey;
        index++;
    }
    
    bots_gametype_common::bot_cache_entrances( entrance_origin_points, entrance_labels, 1 );
}

/#

    // Namespace bots_gametype_rugby
    // Params 0
    // Checksum 0x7c9569e8, Offset: 0x11bc
    // Size: 0x49, Type: dev
    function function_4959e75a6e49e6c()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f66db1fdabed015d", 0 ) == 1 )
            {
                setdevdvar( @"hash_54b3dbf61a166e11", 0 );
                self botpressbutton( "<dev string:x6e>", 11 );
                wait 0.05;
            }
            
            wait 0.05;
        }
    }

#/
