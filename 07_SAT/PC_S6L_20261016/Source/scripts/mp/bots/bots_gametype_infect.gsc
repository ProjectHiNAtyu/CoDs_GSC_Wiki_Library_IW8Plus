// scripts\mp\bots\bots_gametype_infect.gsc  (hash_44d14862ec2d2300.gscc) (size: 5257 Bytes / 0x1489 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dbb1f34 (1572544308)
// size ...... 5257 (0x1489)
// includes .. 8   (offset: 0x1359)
// strings ... 16  (offset: 0x1399)
// dev strs .. 0   (offset: 0x1489)
// exports ... 11  (offset: 0xca1)
// cseg ...... 0x186 + 0xb1b (0xca1)
// imports ... 43  (offset: 0xe59)
// animtree1 . 0   (offset: 0x1489)
// animtree2 . 0   (offset: 0x1489)
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\equipment;

#namespace bots_gametype_infect;

// Namespace bots_gametype_infect
// Params 0
// Checksum 0xffdfdb25, Offset: 0x1a4
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_infect();
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0x1f56e736, Offset: 0x1bc
// Size: 0x48
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_infect_think;
    level.bot_funcs[ "should_pickup_weapons" ] = &bot_should_pickup_weapons_infect;
    autopilot::initialize( undefined, undefined, [ "bot_infect_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0x1caa7c57, Offset: 0x20c
// Size: 0x2a
function setup_bot_infect()
{
    level.bots_gametype_handles_class_choice = 1;
    level.bots_ignore_team_balance = 1;
    level.bots_gametype_handles_team_choice = 1;
    thread bot_infect_ai_director_update();
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0xe4479d36, Offset: 0x23e
// Size: 0x29, Type: bool
function bot_should_pickup_weapons_infect()
{
    if ( level.infect_chosefirstinfected && self.team == "axis" )
    {
        return false;
    }
    
    return bots::bot_should_pickup_weapons();
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0x7fc5b2fe, Offset: 0x270
// Size: 0xec
function bot_infect_think()
{
    self notify( #"bot_infect_think" );
    self endon( #"bot_infect_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    childthread bot_infect_retrieve_knife();
    
    while ( true )
    {
        if ( level.infect_chosefirstinfected )
        {
            if ( self.team == "axis" && self botgetpersonality() != "run_and_gun" )
            {
                bots_util_mp::bot_set_personality( "run_and_gun" );
            }
        }
        
        if ( self.bot_team != self.team )
        {
            self.bot_team = self.team;
        }
        
        if ( self.team == "axis" )
        {
            result = bots_strategy::bot_melee_tactical_insertion_check();
            
            if ( !isdefined( result ) || result )
            {
                self botclearscriptgoal();
            }
        }
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0x50a4af4f, Offset: 0x364
// Size: 0x452
function bot_infect_ai_director_update()
{
    level notify( #"bot_infect_ai_director_update" );
    level endon( #"bot_infect_ai_director_update" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        infected_players = [];
        non_infected_players = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.initial_spawn_time ) && player.health > 0 && isdefined( player.team ) && ( player.team == "allies" || player.team == "axis" ) )
            {
                player.initial_spawn_time = gettime();
            }
            
            if ( isdefined( player.initial_spawn_time ) && gettime() - player.initial_spawn_time > 5000 )
            {
                if ( !isdefined( player.team ) )
                {
                    continue;
                }
                
                if ( player.team == "axis" )
                {
                    infected_players[ infected_players.size ] = player;
                    continue;
                }
                
                if ( player.team == "allies" )
                {
                    non_infected_players[ non_infected_players.size ] = player;
                }
            }
        }
        
        if ( infected_players.size > 0 && non_infected_players.size > 0 )
        {
            var_9a932473e9d28f6 = 1;
            
            foreach ( non_infected_player in non_infected_players )
            {
                if ( isbot( non_infected_player ) )
                {
                    var_9a932473e9d28f6 = 0;
                }
            }
            
            if ( var_9a932473e9d28f6 )
            {
                foreach ( player in non_infected_players )
                {
                    if ( !isdefined( player.last_infected_hiding_time ) )
                    {
                        player.last_infected_hiding_time = gettime();
                        player.last_infected_hiding_loc = player.origin;
                        player.time_spent_hiding = 0;
                    }
                    
                    if ( gettime() >= player.last_infected_hiding_time + 5000 )
                    {
                        player.last_infected_hiding_time = gettime();
                        var_b586a4394dfcba77 = distancesquared( player.origin, player.last_infected_hiding_loc );
                        player.last_infected_hiding_loc = player.origin;
                        
                        if ( var_b586a4394dfcba77 < 90000 )
                        {
                            player.time_spent_hiding += 5000;
                            
                            if ( player.time_spent_hiding >= 20000 )
                            {
                                infected_players_sorted = utility::get_array_of_closest( player.origin, infected_players );
                                
                                foreach ( infected_player in infected_players_sorted )
                                {
                                    if ( isbot( infected_player ) )
                                    {
                                        goal_type = infected_player botgetscriptgoaltype();
                                        
                                        if ( goal_type != "tactical" && goal_type != "critical" )
                                        {
                                            infected_player thread hunt_human( player );
                                            break;
                                        }
                                    }
                                }
                            }
                            
                            continue;
                        }
                        
                        player.time_spent_hiding = 0;
                        player.last_infected_hiding_loc = player.origin;
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_infect
// Params 1
// Checksum 0xec659f57, Offset: 0x7be
// Size: 0x3c
function hunt_human( player_hunting )
{
    self endon( #"death_or_disconnect" );
    self botsetscriptgoal( player_hunting.origin, 0, "critical" );
    bots_util::bot_waittill_goal_or_fail();
    self botclearscriptgoal();
}

// Namespace bots_gametype_infect
// Params 0
// Checksum 0xddbeb837, Offset: 0x802
// Size: 0x2cc
function bot_infect_retrieve_knife()
{
    if ( self.team == "axis" )
    {
        self.can_melee_enemy_time = 0;
        self.melee_enemy = undefined;
        self.melee_enemy_tacpoint = undefined;
        self.var_a4eddcf9b9e73359 = 0;
        self.var_30b1e09a10d506d8 = undefined;
        self.var_32a0555e70721595 = 0;
        throwknifechance = self botgetdifficultysetting( "throwKnifeChance" );
        
        if ( throwknifechance < 0.25 )
        {
            self botsetdifficultysetting( "throwKnifeChance", 0.25 );
        }
        
        self botsetdifficultysetting( "allowGrenades", 1 );
        
        while ( true )
        {
            if ( self.loadoutequipmentprimary == "equip_throwing_knife" )
            {
                throwing_knife_ammo = equipment_mp::getequipmentammo( "equip_throwing_knife" );
                
                if ( game_utility_common::isgameparticipant( self.enemy ) )
                {
                    time = gettime();
                    
                    if ( self.melee_enemy != self.enemy )
                    {
                        self.melee_enemy = self.enemy;
                        self.melee_enemy_tacpoint = self.enemy getnearesttacpoint();
                        self.var_a4eddcf9b9e73359 = time;
                    }
                    else
                    {
                        meleedistsq = squared( self botgetdifficultysetting( "meleeDist" ) );
                        
                        if ( distancesquared( self.enemy.origin, self.origin ) <= meleedistsq )
                        {
                            self.can_melee_enemy_time = time;
                        }
                        
                        melee_enemy_tacpoint = self.enemy getnearesttacpoint();
                        var_30b1e09a10d506d8 = self getnearesttacpoint();
                        
                        if ( self.melee_enemy_tacpoint != melee_enemy_tacpoint )
                        {
                            self.var_a4eddcf9b9e73359 = time;
                            self.melee_enemy_tacpoint = melee_enemy_tacpoint;
                        }
                        
                        if ( self.var_30b1e09a10d506d8 != var_30b1e09a10d506d8 )
                        {
                            self.var_32a0555e70721595 = time;
                            self.var_30b1e09a10d506d8 = var_30b1e09a10d506d8;
                        }
                        else if ( distancesquared( self.origin, self.var_30b1e09a10d506d8.groundpos ) > 9216 )
                        {
                            self.var_e6d2c512e23e4803 = time;
                        }
                        
                        if ( self.can_melee_enemy_time + 3000 < time )
                        {
                            if ( self.var_32a0555e70721595 + 3000 < time )
                            {
                                if ( self.var_a4eddcf9b9e73359 + 3000 < time )
                                {
                                    if ( bot_infect_angle_too_steep_for_knife_throw( self.origin, self.enemy.origin ) )
                                    {
                                        bots_util::bot_queued_process( "bot_infect_retrieve_knife -> find tacpoint", "find_tacpoint_can_see_ent", &function_3e3c0f0ac838bdb3, self.enemy, self.var_30b1e09a10d506d8 );
                                    }
                                    
                                    if ( throwing_knife_ammo == 0 )
                                    {
                                        equipment_mp::setequipmentammo( "equip_throwing_knife", 1 );
                                    }
                                    
                                    utility::waittill_any_timeout_no_endon_death( 30, "enemy" );
                                    self botclearscriptgoal();
                                }
                            }
                        }
                    }
                }
            }
            
            wait 0.25;
        }
    }
}

// Namespace bots_gametype_infect
// Params 2
// Checksum 0xe3467e14, Offset: 0xad6
// Size: 0x3e, Type: bool
function bot_infect_angle_too_steep_for_knife_throw( testorigin, testdest )
{
    if ( abs( testorigin[ 2 ] - testdest[ 2 ] ) > 56 && distance2dsquared( testorigin, testdest ) < 2304 )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_infect
// Params 2
// Checksum 0x6c559f6b, Offset: 0xb1d
// Size: 0x184
function function_3e3c0f0ac838bdb3( targetent, starttacpoint )
{
    if ( !( isdefined( targetent ) && isdefined( starttacpoint ) ) )
    {
        return;
    }
    
    neighbortacpoints = function_a034a927128ada11( starttacpoint.groundpos, 256, 0 );
    
    if ( isdefined( neighbortacpoints ) && neighbortacpoints.size )
    {
        var_3400f1b9e1c7c57c = arrayrandomize( neighbortacpoints );
        
        foreach ( tacpoint in var_3400f1b9e1c7c57c )
        {
            if ( bot_infect_angle_too_steep_for_knife_throw( tacpoint.groundpos, targetent.origin ) )
            {
                continue;
            }
            
            var_e9dbd8d42dd37abf = self geteye() - self.origin;
            start = tacpoint.groundpos + var_e9dbd8d42dd37abf;
            end = targetent.origin;
            
            if ( isplayer( targetent ) )
            {
                end = targetent utility::function_68061c3d21a6d57a();
            }
            
            if ( sighttracepassed( start, end, 0, self, targetent ) )
            {
                yaw = vectortoyaw( end - start );
                self botsetscriptgoal( tacpoint, 0, "critical", yaw );
                bots_util::bot_waittill_goal_or_fail( 3 );
                return;
            }
            
            wait 0.05;
        }
    }
}

