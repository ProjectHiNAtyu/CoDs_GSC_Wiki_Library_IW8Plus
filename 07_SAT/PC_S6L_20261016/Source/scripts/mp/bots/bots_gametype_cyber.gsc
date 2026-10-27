// scripts\mp\bots\bots_gametype_cyber.gsc  (hash_365357707594b8f4.gscc) (size: 7140 Bytes / 0x1be4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9eba878e (2663024526)
// size ...... 7140 (0x1be4)
// includes .. 10  (offset: 0x1a2c)
// strings ... 28  (offset: 0x1a7c)
// dev strs .. 0   (offset: 0x1be4)
// exports ... 14  (offset: 0x10c8)
// cseg ...... 0x21e + 0xeaa (0x10c8)
// imports ... 61  (offset: 0x12f8)
// animtree1 . 0   (offset: 0x1be4)
// animtree2 . 0   (offset: 0x1be4)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;

#namespace bots_gametype_cyber;

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0xfb67b9, Offset: 0x23c
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_cyber();
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0x750aff3, Offset: 0x254
// Size: 0x81
function setup_callbacks()
{
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "gametype_think" ] = &bot_cyber_think;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
    level.bot_funcs[ "emp_picked_up_cancel" ] = &bot_abort_emp_pickup;
    level.bot_funcs[ "tactical_revive_override" ] = &bot_abort_tactical_goal_for_revive;
    autopilot::initialize( undefined, undefined, [ "bot_cyber_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0x7463b92a, Offset: 0x2dd
// Size: 0xda
function setup_bot_cyber()
{
    bots_gametype_common::function_fe1f636ad76a5211();
    bots_util::bot_waittill_bots_enabled();
    succeeded = bots_gametype_common::bot_verify_and_cache_bombzones( [ "_allies", "_axis", "attackers", "defenders" ] );
    
    if ( succeeded )
    {
        foreach ( bombzone in level.objectives )
        {
            bombzone thread bots_gametype_common::monitor_bombzone_control();
        }
        
        level.protect_radius = 600;
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0xd305baee, Offset: 0x3bf
// Size: 0x464
function bot_cyber_think()
{
    self notify( #"hash_c2bcd845a14d70b4" );
    self endon( #"hash_c2bcd845a14d70b4" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    init_bot_game_cyber();
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
            update_game_cyber();
            level.next_game_update_time = gettime() + 100;
        }
        
        if ( !player::isreallyalive( self ) )
        {
            continue;
        }
        
        if ( !isdefined( level.team_planted_bomb ) )
        {
            if ( !isdefined( level.bomb_carrier ) )
            {
                if ( bots_tactical_goals::has_tactical_goal( "seek_cyber_emp", undefined ) == 0 )
                {
                    action_thread = &cyber_bot_pickup_emp;
                    extra_params = spawnstruct();
                    extra_params.object = level.cyberemp.trigger;
                    extra_params.script_goal_radius = 16;
                    extra_params.should_abort = level.bot_funcs[ "emp_picked_up_cancel" ];
                    extra_params.action_thread = action_thread;
                    cyberemporigin = getclosestpointonnavmesh( level.cyberemp.curorigin, self );
                    bots_tactical_goals::new_tactical_goal( "seek_cyber_emp", cyberemporigin, 99, extra_params );
                }
            }
            else if ( self.isbombcarrier )
            {
                if ( !bots_tactical_goals::has_tactical_goal() )
                {
                    bombzone = level.objectives[ utility::get_enemy_team( self.team ) ];
                    var_8c91f76f96080f7f = bots_gametype_common::function_932ed5184bc553f2( bombzone, 1 );
                    self botclearscriptgoal();
                    self botsetscriptgoal( var_8c91f76f96080f7f, 0, "critical", var_8c91f76f96080f7f.angles[ 1 ] );
                    pathresult = bots_util::bot_waittill_goal_or_fail();
                    
                    if ( pathresult == "goal" )
                    {
                        self botpressbutton( "use", level.planttime + 2 );
                        level utility::waittill_any_timeout( level.planttime + 2, "bomb_planted" );
                    }
                    
                    self botclearscriptgoal();
                }
            }
            else if ( level.bomb_carrier.team == self.team )
            {
                if ( !bots_scripted_defense::is_defending() )
                {
                    bots_scripted_defense::guard_player( level.bomb_carrier, 400 );
                }
            }
            else if ( gettime() > self.next_time_hunt_carrier || sighttracepassed( self.origin + ( 0, 0, 77 ), level.bomb_carrier.origin + ( 0, 0, 77 ), 0, self ) )
            {
                self botsetscriptgoal( level.bomb_carrier.origin, 16, "hunt" );
                self.next_time_hunt_carrier = gettime() + randomintrange( 4500, 5500 );
            }
            
            continue;
        }
        
        bombzone = level.objectives[ utility::get_enemy_team( level.team_planted_bomb ) ];
        
        if ( self.team == level.team_planted_bomb )
        {
            if ( !is_defending_bombzone() )
            {
                bots_scripted_defense::protect_point( bombzone.curorigin, 600 );
            }
            
            continue;
        }
        
        if ( level.bomb_defuser == self )
        {
            defuse_target_origin = bots_gametype_common::function_b31545b4843bdcf1( bombzone ).origin;
            self botsetscriptgoal( defuse_target_origin, 20, "critical" );
            result = bots_util::bot_waittill_goal_or_fail( undefined, "no_longer_bomb_defuser" );
            
            if ( result == "goal" )
            {
                self botpressbutton( "use", level.defusetime + 2 );
                waittill_usebutton_released_or_time_or_bomb_planted( level.defusetime + 2 );
            }
            
            continue;
        }
        
        if ( !bots_scripted_defense::is_defending() )
        {
            optional_params[ "entrance_points_index" ] = "zone" + bombzone.label;
            bots_scripted_defense::capture_point( bombzone.curorigin, 200, optional_params );
        }
    }
}

// Namespace bots_gametype_cyber
// Params 1
// Checksum 0xe7e7a3c8, Offset: 0x82b
// Size: 0x27, Type: bool
function bot_abort_emp_pickup( goal )
{
    if ( isdefined( level.cyberemp.carrier ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_cyber
// Params 1
// Checksum 0x8d0a840, Offset: 0x85b
// Size: 0x4a
function cyber_bot_pickup_emp( goal )
{
    self botpressbutton( "use", 0.5 );
    botpersonality = self botgetpersonality();
    
    if ( botpersonality == "default" || botpersonality == "camper" )
    {
        wait 0.5;
    }
}

// Namespace bots_gametype_cyber
// Params 1
// Checksum 0x1e10ad30, Offset: 0x8ad
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

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0x970e3d92, Offset: 0x912
// Size: 0x8, Type: bool
function is_defending_bombzone()
{
    return bots_scripted_defense::is_protecting();
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0xc3947673, Offset: 0x923
// Size: 0x1a
function init_bot_game_cyber()
{
    if ( level.bots_gametype_initialized )
    {
        return;
    }
    
    level.bots_gametype_initialized = 1;
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0xf8854e85, Offset: 0x945
// Size: 0x385
function update_game_cyber()
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
                    player bots_scripted_defense::function_87e8deae08ce1a0();
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
                level.bomb_defuser bots_scripted_defense::function_87e8deae08ce1a0();
                
                if ( isdefined( prev_defuser ) )
                {
                    prev_defuser notify( #"no_longer_bomb_defuser" );
                }
            }
        }
    }
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0x44ed2bb7, Offset: 0xcd2
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
            if ( isalive( player ) && game_utility_common::isaiteamparticipant( player ) && player.team == self.team && player bots_scripted_defense::is_defending() )
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

// Namespace bots_gametype_cyber
// Params 1
// Checksum 0x3232d958, Offset: 0xed2
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
    
    if ( !bots_scripted_defense::is_defending() && !bots_scripted_defense::is_protecting() && !bots_scripted_defense::function_737443eaedb33690() )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_cyber
// Params 0
// Checksum 0xe755b209, Offset: 0xf42
// Size: 0x185, Type: bool
function bot_abort_tactical_goal_for_revive()
{
    if ( level.bombplanted )
    {
        return false;
    }
    
    if ( self == level.cyberemp.carrier )
    {
        return false;
    }
    
    if ( self.isbotmedicrole )
    {
        return false;
    }
    
    totalaliveplayers = teams::getteamdata( self.team, "aliveCount" );
    totalteamplayers = teams::getteamdata( self.team, "teamCount" );
    totaldeadplayers = totalteamplayers - totalaliveplayers;
    
    if ( totaldeadplayers == 0 )
    {
        return false;
    }
    
    medics = 0;
    var_449fc66e3519033d = 0;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( self.isbotmedicrole )
        {
            medics++;
        }
    }
    
    var_ddd408a6c11fa82e = int( clamp( totalteamplayers - 2, 1, 3 ) );
    
    if ( medics < var_ddd408a6c11fa82e + 1 )
    {
        var_449fc66e3519033d = 1;
    }
    
    if ( var_449fc66e3519033d )
    {
        if ( totalteamplayers == 2 )
        {
            var_3a532dfecb704b3a = 1;
        }
        else
        {
            var_3a532dfecb704b3a = totalaliveplayers / totalteamplayers <= 0.7;
        }
        
        if ( var_3a532dfecb704b3a )
        {
            return true;
        }
    }
    
    return false;
}

