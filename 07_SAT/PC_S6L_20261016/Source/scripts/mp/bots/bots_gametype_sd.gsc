// scripts\mp\bots\bots_gametype_sd.gsc  (hash_6dddb002636f198a.gscc) (size: 21668 Bytes / 0x54a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf0b86f93 (4038619027)
// size ...... 21668 (0x54a4)
// includes .. 14  (offset: 0x4f34)
// strings ... 59  (offset: 0x4fa4)
// dev strs .. 17  (offset: 0x53d4)
// exports ... 41  (offset: 0x3728)
// cseg ...... 0x426 + 0x3302 (0x3728)
// imports ... 128 (offset: 0x3d90)
// animtree1 . 0   (offset: 0x54a4)
// animtree2 . 0   (offset: 0x54a4)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\spawnlogic;

#namespace bots_gametype_sd;

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x74a44a27, Offset: 0x444
// Size: 0x10
function main()
{
    setup_callbacks();
    bot_sd_start();
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x2266e282, Offset: 0x45c
// Size: 0x81
function setup_callbacks()
{
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "gametype_think" ] = &bot_sd_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_sd;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
    level.bot_funcs[ "notify_enemy_bots_bomb_used" ] = &notify_enemy_team_bomb_used;
    autopilot::initialize( undefined, undefined, [ "bot_sd_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x417c967a, Offset: 0x4e5
// Size: 0x13
function bot_sd_start()
{
    /#
        thread bots_gametype_common::function_542131a1e15d65d6();
    #/
    
    setup_bot_sd();
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0xa0ef34e8, Offset: 0x500
// Size: 0x8c, Type: bool
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
    
    if ( !game_utility_common::isteamparticipant( self ) )
    {
        return true;
    }
    
    if ( !isdefined( self.role ) )
    {
        return false;
    }
    
    switch ( self.role )
    {
        case #"hash_26452ec2b730b2b1":
        case #"hash_700eb8b52182808d":
        case #"hash_9af4ed111fd5e8cf":
            return false;
    }
    
    return true;
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x4574ae45, Offset: 0x595
// Size: 0x18a
function setup_bot_sd()
{
    level.bots_disable_team_switching = 1;
    level.initial_pickup_wait_time = 3000;
    bots_gametype_common::function_fe1f636ad76a5211();
    bots_util::bot_waittill_bots_enabled();
    level.bot_sd_override_zone_targets = [];
    level.bot_sd_override_zone_targets[ "axis" ] = [];
    level.bot_sd_override_zone_targets[ "allies" ] = [];
    level.bot_default_sd_role_behavior[ "atk_bomber" ] = &atk_bomber_update;
    level.bot_default_sd_role_behavior[ "clear_target_zone" ] = &clear_target_zone_update;
    level.bot_default_sd_role_behavior[ "defend_planted_bomb" ] = &defend_planted_bomb_update;
    level.bot_default_sd_role_behavior[ "defuser" ] = &bomb_defuser_update;
    level.bot_default_sd_role_behavior[ "investigate_someone_using_bomb" ] = &investigate_someone_using_bomb_update;
    level.bot_default_sd_role_behavior[ "camp_bomb" ] = &camp_bomb_update;
    level.bot_default_sd_role_behavior[ "defender" ] = &defender_update;
    level.bot_default_sd_role_behavior[ "backstabber" ] = &backstabber_update;
    level.bot_default_sd_role_behavior[ "random_killer" ] = &random_killer_update;
    succeeded = 0;
    
    if ( getprojectname() == "ZUL" )
    {
        succeeded = bots_gametype_common::bot_verify_and_cache_bombzones( [ "_a", "_b", "_c" ] );
    }
    else
    {
        succeeded = bots_gametype_common::bot_verify_and_cache_bombzones( [ "_a", "_b" ] );
    }
    
    if ( succeeded )
    {
        thread bombzone_control_zones();
        thread bot_sd_ai_director_update();
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x9f3808b3, Offset: 0x727
// Size: 0x8d
function bombzone_control_zones()
{
    flags::function_2f3408423ccc9b2e( "bombZones_ready" );
    wait 0.5;
    
    foreach ( bombzone in level.objectives )
    {
        bombzone thread bots_gametype_common::monitor_bombzone_control();
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x2c4a3237, Offset: 0x7bc
// Size: 0x500
function bot_sd_think()
{
    self notify( #"bot_sd_think" );
    self endon( #"bot_sd_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.has_started_thinking = undefined;
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    attacker_team = game[ "attackers" ];
    var_77b4db567818d0cc = 1;
    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
    
    if ( isdefined( level.sdbomb ) && bomb_carrier == self && self.role == "atk_bomber" )
    {
        var_77b4db567818d0cc = 0;
    }
    
    if ( var_77b4db567818d0cc )
    {
        self.role = undefined;
        
        if ( level.atk_bomber == self )
        {
            level.atk_bomber = undefined;
        }
    }
    
    self.suspend_sd_role = undefined;
    self.has_started_thinking = 0;
    self.atk_bomber_no_path_to_bomb_count = 0;
    self.scripted_path_style = undefined;
    self.defender_set_script_pathstyle = undefined;
    self.defuser_bad_path_counter = 0;
    bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
    
    if ( !isdefined( level.initial_bomb_location ) && !level.multibomb )
    {
        level.initial_bomb_location = bomb_origin;
        level.initial_bomb_location_nearest_tacpoint = findclosesttacpointinsight( bomb_origin );
    }
    
    if ( self.team == attacker_team && !isdefined( level.can_pickup_bomb_time ) )
    {
        var_600da5bc6761bba3 = 0;
        
        if ( !level.multibomb )
        {
            players = bots_gametype_common::get_living_players_on_team( attacker_team );
            
            foreach ( player in players )
            {
                if ( !isai( player ) )
                {
                    var_600da5bc6761bba3 = 1;
                }
            }
        }
        
        if ( var_600da5bc6761bba3 )
        {
            time = 6000;
            level.can_pickup_bomb_time = gettime() + time;
            badplace_cylinder( "bomb", time / 1000, bomb_origin, 75, 300, attacker_team );
        }
    }
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait randomintrange( 1, 3 ) * 0.05;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        self.has_started_thinking = 1;
        
        if ( !isdefined( self.role ) )
        {
            initialize_sd_role();
        }
        
        if ( isdefined( self.suspend_sd_role ) )
        {
            continue;
        }
        
        if ( self.team == attacker_team )
        {
            bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
            
            if ( !level.multibomb && isdefined( level.can_pickup_bomb_time ) && gettime() < level.can_pickup_bomb_time && !isdefined( bomb_carrier ) )
            {
                bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
                
                if ( !bots_scripted_defense::is_defending_point( bomb_origin ) )
                {
                    var_23f92859a855dad9 = findclosesttacpointinsight( bomb_origin );
                    
                    if ( isdefined( var_23f92859a855dad9 ) )
                    {
                        optional_params[ "nearest_tacpoint_to_center" ] = var_23f92859a855dad9;
                        bots_scripted_defense::protect_point( bomb_origin, 900, optional_params );
                    }
                    else
                    {
                        level.can_pickup_bomb_time = gettime();
                    }
                }
            }
            else
            {
                self [[ level.bot_default_sd_role_behavior[ self.role ] ]]();
            }
            
            continue;
        }
        
        if ( level.bombplanted )
        {
            if ( isdefined( level.sdbombmodel ) && distancesquared( self.origin, level.sdbombmodel.origin ) > squared( level.protect_radius * 2 ) )
            {
                if ( !isdefined( self.defender_set_script_pathstyle ) )
                {
                    self.defender_set_script_pathstyle = 1;
                    self botsetpathingstyle( "scripted" );
                }
            }
            else if ( isdefined( self.defender_set_script_pathstyle ) && !isdefined( self.scripted_path_style ) )
            {
                self.defender_set_script_pathstyle = undefined;
                self botsetpathingstyle( undefined );
            }
        }
        
        if ( level.bombplanted && isdefined( level.sdbombmodel ) && isdefined( level.bomb_defuser ) && self.role != "defuser" )
        {
            if ( !bots_scripted_defense::is_defending_point( level.sdbombmodel.origin ) )
            {
                self botclearscriptgoal();
                bots_scripted_defense::protect_point( level.sdbombmodel.origin, level.protect_radius );
            }
            
            continue;
        }
        
        self [[ level.bot_default_sd_role_behavior[ self.role ] ]]();
    }
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x12e62a25, Offset: 0xcc4
// Size: 0x62
function bomber_disable_movement_for_time( time )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self botsetflag( "disable_movement", 1 );
    self botsetstance( "stand" );
    wait time;
    self botsetflag( "disable_movement", 0 );
    self botsetstance( "none" );
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x9ebb1915, Offset: 0xd2e
// Size: 0x669
function atk_bomber_update()
{
    self endon( #"new_role" );
    assert( level.atk_bomber == self );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
    
    if ( isdefined( level.sdbomb ) && isalive( bomb_carrier ) && bomb_carrier != self )
    {
        wait 0.7;
        
        /#
            if ( isalive( bomb_carrier ) && bomb_carrier != self )
            {
                println( "<dev string:x24>" + self.role );
                println( "<dev string:x3a>" + bomb_carrier.name );
                println( "<dev string:x53>" + ( bomb_carrier.role ?? "<dev string:x71>" ) );
                assertmsg( "<dev string:x7b>" + self.name + "<dev string:x80>" );
            }
        #/
    }
    
    if ( !self.isbombcarrier && !level.multibomb )
    {
        if ( level.bombplanted )
        {
            assertmsg( "<dev string:x7b>" + self.name + "<dev string:xdc>" );
            level.atk_bomber = undefined;
            bots_tactical_goals::enable_tactical_goals();
            bot_set_role( "defend_planted_bomb" );
            return;
        }
        
        if ( isdefined( level.sdbomb ) )
        {
            bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
            
            if ( !isdefined( self.last_bomb_location ) )
            {
                self.last_bomb_location = bomb_origin;
            }
            
            if ( distancesquared( self.last_bomb_location, bomb_origin ) > 4 )
            {
                self botclearscriptgoal();
                self.last_bomb_location = bomb_origin;
            }
        }
        
        /#
            if ( self bothasscriptgoal() )
            {
                goal = self botgetscriptgoal();
                
                if ( distancesquared( goal, self.origin ) < 100 )
                {
                    if ( !isdefined( self.var_323d2f695e39e1a6 ) || distancesquared( self.var_323d2f695e39e1a6, goal ) >= 100 )
                    {
                        assertmsg( "<dev string:x130>" + goal + "<dev string:x19b>" + gameobjects_shared::get_origin( level.sdbomb ) );
                    }
                    
                    self.var_323d2f695e39e1a6 = goal;
                }
            }
        #/
        
        if ( self.atk_bomber_no_path_to_bomb_count >= 2 )
        {
            bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
            tacpoints = function_7801d05a86b06144( bomb_origin, 512, 0 );
            
            if ( tacpoints.size > 0 )
            {
                best_tacpoint = tacpoints[ 0 ];
            }
            
            if ( isdefined( best_tacpoint ) )
            {
                self botsetscriptgoal( best_tacpoint.groundpos, 20, "critical" );
                bots_util::bot_waittill_goal_or_fail();
                
                if ( isdefined( level.sdbomb ) )
                {
                    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
                    
                    if ( !isdefined( bomb_carrier ) )
                    {
                        gameobjects_shared::function_5a2d24ac6af6b087( level.sdbomb, self );
                    }
                }
                
                return;
            }
            
            assertmsg( "<dev string:x1ac>" + bomb_origin );
            return;
        }
        
        if ( !self bothasscriptgoal() )
        {
            bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
            var_bb2903ceb6bc80b9 = self getclosestreachablepointonnavmesh( bomb_origin );
            
            if ( isdefined( var_bb2903ceb6bc80b9 ) )
            {
                set_goal = self botsetscriptgoal( bomb_origin, 0, "critical" );
                
                if ( set_goal )
                {
                    childthread bomber_monitor_no_path();
                }
            }
            else
            {
                tacpoints = function_7801d05a86b06144( bomb_origin, 512, 0 );
                
                if ( tacpoints.size > 0 )
                {
                    self botsetscriptgoal( tacpoints[ 0 ], 0, "critical" );
                    bots_util::bot_waittill_goal_or_fail();
                }
                
                if ( isdefined( level.sdbomb ) )
                {
                    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
                    
                    if ( !isdefined( bomb_carrier ) )
                    {
                        var_bb2903ceb6bc80b9 = self getclosestreachablepointonnavmesh( bomb_origin );
                        
                        if ( !isdefined( var_bb2903ceb6bc80b9 ) )
                        {
                            level.sdbomb gameobjects::setpickedup( self );
                        }
                    }
                }
            }
        }
        
        return;
    }
    
    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
    assert( self == bomb_carrier || level.multibomb );
    
    if ( gettime() < self.dont_plant_until_time )
    {
        return;
    }
    
    if ( !isdefined( level.bomb_zone_assaulting ) )
    {
        level.bomb_zone_assaulting = utility::array_random( level.objectives );
    }
    
    self.bombzonegoal = level.bomb_zone_assaulting;
    
    if ( !isdefined( level.initial_bomb_pickup_time ) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time )
    {
        level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
        thread bomber_disable_movement_for_time( level.initial_pickup_wait_time / 1000 );
        wait level.initial_pickup_wait_time / 1000;
    }
    
    self botclearscriptgoal();
    
    if ( level.attack_behavior == "rush" )
    {
        self botsetpathingstyle( "scripted" );
        var_8c91f76f96080f7f = bots_gametype_common::function_932ed5184bc553f2( self.bombzonegoal, 1 );
        
        if ( !isdefined( var_8c91f76f96080f7f ) )
        {
            foreach ( objective in level.objectives )
            {
                if ( objective != level.bomb_zone_assaulting )
                {
                    level.bomb_zone_assaulting = objective;
                    return;
                }
            }
        }
        
        self botsetscriptgoal( var_8c91f76f96080f7f, 0, "critical" );
    }
    
    pathresult = bots_util::bot_waittill_goal_or_fail();
    
    if ( pathresult == "goal" )
    {
        time_left = get_round_end_time() - gettime();
        var_59b724c2a68d0a75 = time_left - level.planttime * 2 * 1000;
        var_9c5d2bb9487a212f = gettime() + var_59b724c2a68d0a75;
        
        if ( var_59b724c2a68d0a75 > 0 )
        {
            bots_util::bot_waittill_out_of_combat_or_time( var_59b724c2a68d0a75 );
        }
        
        emergency_plant = gettime() >= var_9c5d2bb9487a212f;
        succeeded = bots_gametype_common::bombzone_press_use( level.planttime + 2, "bomb_planted", emergency_plant );
        self botclearscriptgoal();
        
        if ( succeeded )
        {
            assert( level.bombplanted );
            bots_tactical_goals::enable_tactical_goals();
            bot_set_role( "defend_planted_bomb" );
            return;
        }
        
        assert( !level.bombplanted );
        
        if ( var_59b724c2a68d0a75 > 5000 )
        {
            self.dont_plant_until_time = gettime() + 5000;
        }
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xbb30fe40, Offset: 0x139f
// Size: 0x27
function get_round_end_time()
{
    if ( level.bombplanted )
    {
        return level.defuseendtime;
    }
    
    return gettime() + gamelogic_mp::gettimeremaining();
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x2359346f, Offset: 0x13ce
// Size: 0x65
function bomber_monitor_no_path()
{
    self notify( #"bomber_monitor_no_path" );
    self endon( #"death_or_disconnect" );
    self endon( #"goal" );
    self endon( #"bomber_monitor_no_path" );
    level.sdbomb endon( #"pickup_object" );
    
    while ( true )
    {
        self waittill( #"bad_path_no_path_to_script_goal" );
        self.atk_bomber_no_path_to_bomb_count++;
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xeb40ffc9, Offset: 0x143b
// Size: 0x182
function clear_target_zone_update()
{
    self endon( #"new_role" );
    
    if ( isdefined( level.atk_bomber ) )
    {
        if ( level.attack_behavior == "rush" )
        {
            if ( !isdefined( self.set_initial_rush_goal ) )
            {
                if ( !level.multibomb )
                {
                    optional_params[ "nearest_tacpoint_to_center" ] = level.initial_bomb_location_nearest_tacpoint;
                    bots_scripted_defense::protect_point( level.initial_bomb_location, 900, optional_params );
                    wait randomfloatrange( 0, 4 );
                    bots_scripted_defense::function_87e8deae08ce1a0();
                }
                
                self.set_initial_rush_goal = 1;
            }
            
            if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
            {
                set_force_sprint();
            }
            
            if ( isai( level.atk_bomber ) && isdefined( level.atk_bomber.bombzonegoal ) )
            {
                bombzonetarget = level.atk_bomber.bombzonegoal;
            }
            else if ( isdefined( level.bomb_zone_assaulting ) )
            {
                bombzonetarget = level.bomb_zone_assaulting;
            }
            else
            {
                bombzonetarget = bots_gametype_common::find_closest_bombzone_to_player( level.atk_bomber );
            }
            
            bombzone_origin = bots_gametype_common::function_9b9031dc40095287( bombzonetarget );
            
            if ( !bots_scripted_defense::is_defending_point( bombzone_origin ) )
            {
                optional_params[ "min_goal_time" ] = 2;
                optional_params[ "max_goal_time" ] = 4;
                optional_params[ "override_origin_tacpoint" ] = utility::array_random( bombzonetarget.tacpoints );
                bots_scripted_defense::protect_point( bombzone_origin, level.protect_radius, optional_params );
            }
        }
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x842fb1a5, Offset: 0x15c5
// Size: 0x9a
function defend_planted_bomb_update()
{
    self endon( #"new_role" );
    
    if ( level.bombplanted && isdefined( level.sdbombmodel ) )
    {
        if ( level.attack_behavior == "rush" )
        {
            disable_force_sprint();
        }
        
        if ( !bots_scripted_defense::is_defending_point( level.sdbombmodel.origin ) )
        {
            optional_params[ "score_flags" ] = "strongly_avoid_center";
            bots_scripted_defense::protect_point( level.sdbombmodel.origin, level.protect_radius, optional_params );
        }
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xa1c91b3a, Offset: 0x1667
// Size: 0x2c7
function bomb_defuser_update()
{
    self endon( #"new_role" );
    
    if ( level.bombdefused || !isdefined( level.sdbombmodel ) )
    {
        return;
    }
    
    zone = find_ticking_bomb();
    
    if ( !isdefined( zone ) )
    {
        return;
    }
    
    [ var_2c176c1b7849cf49 ] = utility::get_array_of_closest( level.sdbombmodel.origin, zone.tacpoints );
    defuse_target_origin = ( level.sdbombmodel.origin[ 0 ], level.sdbombmodel.origin[ 1 ], var_2c176c1b7849cf49.groundpos[ 2 ] );
    
    if ( self.defuser_bad_path_counter <= 1 )
    {
        var_a5d8b7f31efe5326 = cautious_approach_till_close( defuse_target_origin, undefined );
    }
    else
    {
        self botclearscriptgoal();
        var_a5d8b7f31efe5326 = self botsetscriptgoal( defuse_target_origin, 20, "critical" );
    }
    
    if ( !var_a5d8b7f31efe5326 )
    {
        return;
    }
    
    pathresult = bots_util::bot_waittill_goal_or_fail();
    
    if ( pathresult == "bad_path" )
    {
        self.defuser_bad_path_counter++;
        
        if ( self.defuser_bad_path_counter >= 4 )
        {
            while ( true )
            {
                tacpoints = function_7801d05a86b06144( defuse_target_origin, 50, 0 );
                potential_index = self.defuser_bad_path_counter - 4;
                
                if ( tacpoints.size <= potential_index )
                {
                    closest_point = self getclosestreachablepointonnavmesh( defuse_target_origin );
                    
                    if ( isdefined( closest_point ) )
                    {
                        self botsetscriptgoal( closest_point, 20, "critical" );
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    self botsetscriptgoal( tacpoints[ potential_index ], 20, "critical" );
                }
                
                pathresult = bots_util::bot_waittill_goal_or_fail();
                
                if ( pathresult == "bad_path" )
                {
                    self.defuser_bad_path_counter++;
                    continue;
                }
                
                break;
            }
        }
    }
    
    if ( pathresult == "goal" )
    {
        time_left = get_round_end_time() - gettime();
        var_6c4e2a2d4bfead6e = time_left - level.defusetime * 2 * 1000;
        var_ed305e455b26c778 = gettime() + var_6c4e2a2d4bfead6e;
        
        if ( var_6c4e2a2d4bfead6e > 0 )
        {
            bots_util::bot_waittill_out_of_combat_or_time( var_6c4e2a2d4bfead6e );
        }
        
        emergency_defuse = gettime() >= var_ed305e455b26c778;
        var_64cc8ec2d35a0a48 = level.sdbombmodel.origin[ 2 ] - self.origin[ 2 ];
        succeeded = bots_gametype_common::bombzone_press_use( level.defusetime + 2, "bomb_defused", emergency_defuse, var_64cc8ec2d35a0a48 > 40 );
        
        if ( !succeeded && self.defuser_bad_path_counter >= 4 )
        {
            self.defuser_bad_path_counter++;
        }
        
        self botclearscriptgoal();
        bots_tactical_goals::enable_tactical_goals();
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xe3d6315b, Offset: 0x1936
// Size: 0x7c
function investigate_someone_using_bomb_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    closest_bomb_zone = bots_gametype_common::find_closest_bombzone_to_player( self );
    self botsetscriptgoal( utility::array_random( closest_bomb_zone.tacpoints ), 0, "critical" );
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        wait 2;
        bot_set_role( self.prev_role );
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xe1aceb59, Offset: 0x19ba
// Size: 0xc0
function camp_bomb_update()
{
    self endon( #"new_role" );
    bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
    
    if ( isdefined( bomb_carrier ) )
    {
        if ( self.prev_role == "defender" )
        {
            self.defend_zone = bots_gametype_common::find_closest_bombzone_to_player( self );
        }
        
        bot_set_role( self.prev_role );
        return;
    }
    
    bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
    
    if ( !bots_scripted_defense::is_defending_point( bomb_origin ) )
    {
        optional_params[ "nearest_tacpoint_to_center" ] = level.sdbomb.var_409544c03a0ffff;
        bots_scripted_defense::protect_point( bomb_origin, level.protect_radius, optional_params );
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x46ec084e, Offset: 0x1a82
// Size: 0x7f
function defender_update()
{
    self endon( #"new_role" );
    bomb_origin = bots_gametype_common::function_9b9031dc40095287( self.defend_zone );
    
    if ( !bots_scripted_defense::is_defending_point( bomb_origin ) )
    {
        optional_params[ "score_flags" ] = "strict_los";
        optional_params[ "override_origin_tacpoint" ] = utility::array_random( self.defend_zone.tacpoints );
        bots_scripted_defense::protect_point( bomb_origin, level.protect_radius, optional_params );
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x65e43c6a, Offset: 0x1b09
// Size: 0x3ad
function backstabber_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    if ( !isdefined( self.backstabber_stage ) )
    {
        self.backstabber_stage = "1_move_to_midpoint";
    }
    
    if ( self.backstabber_stage == "1_move_to_midpoint" )
    {
        var_379fa9020248271c = bots_gametype_common::function_9b9031dc40095287( level.objectives[ "_a" ] );
        var_e755eb11841e1c6d = bots_gametype_common::function_9b9031dc40095287( level.objectives[ "_b" ] );
        midpoint = ( ( var_379fa9020248271c[ 0 ] + var_e755eb11841e1c6d[ 0 ] ) * 0.5, ( var_379fa9020248271c[ 1 ] + var_e755eb11841e1c6d[ 1 ] ) * 0.5, ( var_379fa9020248271c[ 2 ] + var_e755eb11841e1c6d[ 2 ] ) * 0.5 );
        tacpoints = function_7801d05a86b06144( midpoint, 512, 0 );
        
        if ( tacpoints.size == 0 )
        {
            bot_set_role( "random_killer" );
            return;
        }
        
        tacpoint_picked = undefined;
        total_weights = int( tacpoints.size * ( tacpoints.size + 1 ) * 0.5 );
        random_num_picked = randomint( total_weights );
        
        for ( i = 0; i < tacpoints.size ; i++ )
        {
            tacpoint_weight = tacpoints.size - i;
            
            if ( random_num_picked < tacpoint_weight )
            {
                tacpoint_picked = tacpoints[ i ];
                break;
            }
            
            random_num_picked -= tacpoint_weight;
        }
        
        self botsetpathingstyle( "scripted" );
        set_goal = self botsetscriptgoal( tacpoint_picked, 0, "guard" );
        
        if ( set_goal )
        {
            pathresult = bots_util::bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                wait randomfloatrange( 1, 4 );
                self.backstabber_stage = "2_move_to_enemy_spawn";
            }
        }
    }
    
    if ( self.backstabber_stage == "2_move_to_enemy_spawn" )
    {
        spawnkey = spawnlogic::function_d5c160a4110b573e();
        
        if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
        {
            attacker_spawns = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, spawnlogic::function_61ba521db28762a7() );
        }
        else
        {
            attacker_spawns = spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
        }
        
        assert( attacker_spawns.size > 0, "<dev string:x1e6>" );
        spawn_target = utility::array_random( attacker_spawns );
        self botsetpathingstyle( "scripted" );
        set_goal = self botsetscriptgoal( spawn_target.origin, 250, "guard" );
        
        if ( set_goal )
        {
            pathresult = bots_util::bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                self.backstabber_stage = "3_move_to_bombzone";
            }
        }
    }
    
    if ( self.backstabber_stage == "3_move_to_bombzone" )
    {
        if ( !isdefined( self.bombzone_picked ) )
        {
            self.bombzone_picked = utility::array_random( level.objectives );
        }
        
        self botsetpathingstyle( undefined );
        set_goal = self botsetscriptgoal( utility::array_random( self.bombzone_picked.tacpoints ).origin, 160, "objective" );
        
        if ( set_goal )
        {
            pathresult = bots_util::bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                self botclearscriptgoal();
                self.backstabber_stage = "2_move_to_enemy_spawn";
                
                foreach ( objective in level.objectives )
                {
                    if ( objective != self.bombzone_picked )
                    {
                        self.bombzone_picked = objective;
                        break;
                    }
                }
            }
        }
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x965e7b9a, Offset: 0x1ebe
// Size: 0x2b
function random_killer_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    self [[ self.personality_update_function ]]();
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xc6cbe3e8, Offset: 0x1ef1
// Size: 0x28
function set_force_sprint()
{
    if ( !isdefined( self.always_sprint ) )
    {
        self botsetflag( "force_sprint", 1 );
        self.always_sprint = 1;
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xe3ae9fe4, Offset: 0x1f21
// Size: 0x25
function disable_force_sprint()
{
    if ( isdefined( self.always_sprint ) )
    {
        self botsetflag( "force_sprint", 0 );
        self.always_sprint = undefined;
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x5095d7d9, Offset: 0x1f4e
// Size: 0x26
function set_scripted_pathing_style()
{
    if ( !isdefined( self.scripted_path_style ) )
    {
        self botsetpathingstyle( "scripted" );
        self.scripted_path_style = 1;
    }
}

// Namespace bots_gametype_sd
// Params 2
// Checksum 0xff7a6820, Offset: 0x1f7c
// Size: 0xc4
function cautious_approach_till_close( target, label )
{
    capture_radius = level.capture_radius;
    optional_params[ "entrance_points_index" ] = label;
    bots_scripted_defense::capture_point( target, capture_radius, optional_params );
    wait 0.05;
    
    while ( distancesquared( self.origin, target ) > capture_radius * capture_radius && bots_scripted_defense::is_defending() )
    {
        timeleft = get_round_end_time() - gettime();
        
        if ( timeleft < 20000 )
        {
            set_scripted_pathing_style();
            set_force_sprint();
            break;
        }
        
        wait 0.05;
    }
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    return self botsetscriptgoal( target, 20, "critical" );
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x964f2fce, Offset: 0x2049
// Size: 0xa4
function notify_enemy_team_bomb_used( type )
{
    players = bots_gametype_common::get_ai_hearing_bomb_plant_sound( type );
    
    foreach ( player in players )
    {
        if ( isdefined( player.role ) )
        {
            player bot_set_role( "investigate_someone_using_bomb" );
        }
    }
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0xaa6fd2be, Offset: 0x20f5
// Size: 0x12f
function should_start_cautious_approach_sd( firstcheck )
{
    var_c0f6db6802cec4f1 = 2000;
    var_f097ac34555c3be = var_c0f6db6802cec4f1 * var_c0f6db6802cec4f1;
    
    if ( firstcheck )
    {
        if ( get_round_end_time() - gettime() < 15000 )
        {
            return 0;
        }
        
        alive_enemies_exist = 0;
        enemy_team = utility::get_enemy_team( self.team );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( isalive( player ) && player.team == enemy_team )
            {
                alive_enemies_exist = 1;
            }
        }
        
        return alive_enemies_exist;
    }
    
    return distancesquared( self.origin, self.bot_defending_center ) <= var_f097ac34555c3be && self botpursuingscriptgoal();
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0xc11a627c, Offset: 0x222c
// Size: 0x123
function get_players_defending_zone( zone )
{
    var_62c5abc4bbc3fc14 = [];
    var_fc1cc539da24b8e1 = bots_gametype_common::get_living_players_on_team( game[ "defenders" ] );
    
    foreach ( player in var_fc1cc539da24b8e1 )
    {
        if ( isai( player ) && isdefined( player.role ) && player.role == "defender" )
        {
            if ( player.defend_zone == zone )
            {
                var_62c5abc4bbc3fc14[ var_62c5abc4bbc3fc14.size ] = player;
            }
            
            continue;
        }
        
        zone_origin = bots_gametype_common::function_9b9031dc40095287( zone );
        
        if ( distancesquared( player.origin, zone_origin ) < level.protect_radius * level.protect_radius )
        {
            var_62c5abc4bbc3fc14[ var_62c5abc4bbc3fc14.size ] = player;
        }
    }
    
    return var_62c5abc4bbc3fc14;
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x1c90b203, Offset: 0x2358
// Size: 0x184
function find_ticking_bomb()
{
    if ( isdefined( level.tickingobject ) )
    {
        foreach ( zone in level.objectives )
        {
            zone_origin = bots_gametype_common::function_9b9031dc40095287( zone );
            
            if ( distancesquared( level.tickingobject.origin, zone_origin ) < 90000 )
            {
                return zone;
            }
        }
        
        return;
    }
    
    closest_zone = undefined;
    closest_distance_squared = 3.40282e+38;
    
    foreach ( zone in game_utility_mp::get_gametype_objectives( self.instanceid ) )
    {
        if ( !isdefined( zone.ticking_object ) )
        {
            continue;
        }
        
        zone_origin = gameobjects_shared::get_origin( zone );
        distance_squared = distancesquared( self.origin, zone_origin );
        
        if ( distance_squared < closest_distance_squared )
        {
            closest_zone = zone;
            closest_distance_squared = distance_squared;
        }
    }
    
    return closest_zone;
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x9ab06a46, Offset: 0x24e5
// Size: 0x42
function get_specific_zone( zone_letter )
{
    assert( zone_letter == "<dev string:x212>" || zone_letter == "<dev string:x214>" );
    zone_letter = "_" + tolower( zone_letter );
    return level.objectives[ zone_letter ];
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xc3d51384, Offset: 0x2530
// Size: 0x72
function bomber_wait_for_death()
{
    self endon( #"hash_3192204203af4758" );
    self endon( #"new_role" );
    self waittill( #"death_or_disconnect" );
    level.atk_bomber = undefined;
    level.last_atk_bomber_death_time = gettime();
    
    if ( isdefined( self ) )
    {
        self.role = undefined;
    }
    
    ai_attackers = bots_gametype_common::get_living_players_on_team( game[ "attackers" ], 1 );
    force_all_players_to_role( ai_attackers, undefined );
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x45e881b1, Offset: 0x25aa
// Size: 0x5f
function bomber_wait_for_bomb_reset()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3192204203af4758" );
    level.sdbomb endon( #"pickup_object" );
    level.sdbomb waittill( #"reset" );
    
    if ( game_utility_common::isaiteamparticipant( self ) )
    {
        self botclearscriptgoal();
    }
    
    bot_set_role( "atk_bomber" );
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x22d00741, Offset: 0x2611
// Size: 0x7a
function set_new_bomber()
{
    assert( game_utility_common::isteamparticipant( self ) );
    level.atk_bomber = self;
    bot_set_role( "atk_bomber" );
    thread bomber_wait_for_death();
    
    if ( !level.multibomb )
    {
        thread bomber_wait_for_bomb_reset();
    }
    
    if ( isai( self ) )
    {
        bots_tactical_goals::disable_tactical_goals();
        
        if ( level.attack_behavior == "rush" && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            set_force_sprint();
        }
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x93e95c8b, Offset: 0x2693
// Size: 0x491
function initialize_sd_role()
{
    if ( self.team == game[ "attackers" ] )
    {
        if ( level.bombplanted )
        {
            bot_set_role( "defend_planted_bomb" );
        }
        else if ( !isdefined( level.atk_bomber ) )
        {
            set_new_bomber();
        }
        else if ( level.attack_behavior == "rush" )
        {
            bot_set_role( "clear_target_zone" );
        }
        
        return;
    }
    
    backstabbers = get_players_by_role( "backstabber" );
    defenders = get_players_by_role( "defender" );
    personality_type = level.bot_personality_type[ self.personality ];
    strategy_level = self botgetdifficultysetting( "strategyLevel" );
    
    if ( personality_type == "active" )
    {
        if ( !isdefined( self.role ) && level.allow_backstabbers && strategy_level > 0 )
        {
            if ( backstabbers.size == 0 )
            {
                bot_set_role( "backstabber" );
            }
            else
            {
                var_b11674b3766c3371 = 1;
                
                foreach ( stabber in backstabbers )
                {
                    var_1b32f7395b6ffc5c = level.bot_personality_type[ stabber.personality ];
                    
                    if ( var_1b32f7395b6ffc5c == "active" )
                    {
                        var_b11674b3766c3371 = 0;
                        break;
                    }
                }
                
                if ( var_b11674b3766c3371 )
                {
                    bot_set_role( "backstabber" );
                    backstabbers[ 0 ] bot_set_role( undefined );
                }
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            if ( defenders.size < 4 )
            {
                bot_set_role( "defender" );
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            random_choice = randomint( 4 );
            
            if ( random_choice == 3 && level.allow_random_killers && strategy_level > 0 )
            {
                bot_set_role( "random_killer" );
            }
            else if ( random_choice == 2 && level.allow_backstabbers && strategy_level > 0 )
            {
                bot_set_role( "backstabber" );
            }
            else
            {
                bot_set_role( "defender" );
            }
        }
    }
    else if ( personality_type == "stationary" )
    {
        if ( !isdefined( self.role ) )
        {
            if ( defenders.size < 4 )
            {
                bot_set_role( "defender" );
            }
            else
            {
                foreach ( defender in defenders )
                {
                    var_70143639ce342daf = level.bot_personality_type[ defender.personality ];
                    
                    if ( var_70143639ce342daf == "active" )
                    {
                        bot_set_role( "defender" );
                        defender bot_set_role( undefined );
                        break;
                    }
                }
            }
        }
        
        if ( !isdefined( self.role ) && level.allow_backstabbers && strategy_level > 0 )
        {
            if ( backstabbers.size == 0 )
            {
                bot_set_role( "backstabber" );
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            bot_set_role( "defender" );
        }
    }
    
    if ( self.role == "defender" )
    {
        assert( level.objectives.size == 2 );
        possible_zones = level.objectives;
        
        if ( has_override_zone_targets( self.team ) )
        {
            possible_zones = get_override_zone_targets( self.team );
        }
        
        if ( possible_zones.size == 1 )
        {
            self.defend_zone = possible_zones[ "_a" ];
            return;
        }
        
        var_7438f1bfbe061324 = get_players_defending_zone( possible_zones[ "_a" ] );
        var_7438f2bfbe061557 = get_players_defending_zone( possible_zones[ "_b" ] );
        
        if ( var_7438f1bfbe061324.size < var_7438f2bfbe061557.size )
        {
            self.defend_zone = possible_zones[ "_a" ];
            return;
        }
        
        if ( var_7438f2bfbe061557.size < var_7438f1bfbe061324.size )
        {
            self.defend_zone = possible_zones[ "_b" ];
            return;
        }
        
        self.defend_zone = utility::array_random( possible_zones );
    }
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x729e1195, Offset: 0x2b2c
// Size: 0x4b
function bot_set_role( new_role )
{
    if ( isai( self ) )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
        self botsetpathingstyle( undefined );
    }
    
    self.prev_role = self.role;
    self.role = new_role;
    self notify( #"new_role" );
}

// Namespace bots_gametype_sd
// Params 2
// Checksum 0x42daa7b8, Offset: 0x2b7f
// Size: 0x39
function bot_set_role_delayed( new_role, wait_time )
{
    self endon( #"death_or_disconnect" );
    self endon( #"new_role" );
    wait wait_time;
    bot_set_role( new_role );
}

// Namespace bots_gametype_sd
// Params 3
// Checksum 0x8dc3af92, Offset: 0x2bc0
// Size: 0xaf
function force_all_players_to_role( players, role, max_random_wait_time )
{
    foreach ( player in players )
    {
        if ( isdefined( max_random_wait_time ) )
        {
            player thread bot_set_role_delayed( role, randomfloatrange( 0, max_random_wait_time ) );
            continue;
        }
        
        player thread bot_set_role( role );
    }
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x754047d0, Offset: 0x2c77
// Size: 0x18
function get_override_zone_targets( team )
{
    return level.bot_sd_override_zone_targets[ team ];
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x126c6e5c, Offset: 0x2c98
// Size: 0x25, Type: bool
function has_override_zone_targets( team )
{
    override_targets = get_override_zone_targets( team );
    return override_targets.size > 0;
}

// Namespace bots_gametype_sd
// Params 1
// Checksum 0x7e9b9d41, Offset: 0x2cc6
// Size: 0xc7
function get_players_by_role( role )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( isalive( player ) && game_utility_common::isteamparticipant( player ) && isdefined( player.role ) && player.role == role )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0x5a03015d, Offset: 0x2d96
// Size: 0x971
function bot_sd_ai_director_update()
{
    level notify( #"bot_sd_ai_director_update" );
    level endon( #"bot_sd_ai_director_update" );
    level endon( #"game_ended" );
    level.allow_backstabbers = randomint( 3 ) <= 1;
    level.allow_random_killers = randomint( 3 ) <= 1;
    level.attack_behavior = "rush";
    level.protect_radius = 725;
    level.capture_radius = 140;
    
    while ( true )
    {
        if ( isdefined( level.sdbomb ) )
        {
            bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
            
            if ( isdefined( bomb_carrier ) && !isai( bomb_carrier ) )
            {
                level.bomb_zone_assaulting = bots_gametype_common::find_closest_bombzone_to_player( bomb_carrier );
            }
        }
        
        if ( !level.bombplanted )
        {
            living_attackers = bots_gametype_common::get_living_players_on_team( game[ "attackers" ] );
            
            foreach ( player in living_attackers )
            {
                if ( player.isbombcarrier )
                {
                    level.can_pickup_bomb_time = gettime();
                    
                    if ( player != level.atk_bomber )
                    {
                        if ( isalive( level.atk_bomber ) )
                        {
                            level.atk_bomber bot_set_role( undefined );
                            level.atk_bomber notify( #"hash_3192204203af4758" );
                        }
                        
                        player set_new_bomber();
                    }
                }
            }
            
            bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
            
            if ( !level.multibomb && !isdefined( bomb_carrier ) )
            {
                bomb_origin = gameobjects_shared::get_origin( level.sdbomb );
                var_f49675950ccbe172 = findclosesttacpointinsight( bomb_origin );
                
                if ( isdefined( var_f49675950ccbe172 ) )
                {
                    level.sdbomb.var_409544c03a0ffff = var_f49675950ccbe172;
                    var_7abc256bc2935f81 = 0;
                    var_9e9ebdd5902464e9 = bots_gametype_common::get_living_players_on_team( game[ "defenders" ], 1 );
                    
                    foreach ( ai in var_9e9ebdd5902464e9 )
                    {
                        nearest_tacpoint_bot = ai getnearesttacpoint();
                        strategy_level = ai botgetdifficultysetting( "strategyLevel" );
                        
                        if ( strategy_level > 0 && ai.role != "camp_bomb" && isdefined( nearest_tacpoint_bot ) && tacpointsvisible( var_f49675950ccbe172, nearest_tacpoint_bot, 1 ) )
                        {
                            if ( ai function_6c6e0a8bb89a022e( bomb_origin ) )
                            {
                                if ( strategy_level >= 2 || distancesquared( ai.origin, bomb_origin ) < squared( 700 ) )
                                {
                                    var_7abc256bc2935f81 = 1;
                                    break;
                                }
                            }
                        }
                    }
                    
                    if ( var_7abc256bc2935f81 )
                    {
                        foreach ( ai in var_9e9ebdd5902464e9 )
                        {
                            if ( ai.role != "camp_bomb" && ai botgetdifficultysetting( "strategyLevel" ) > 0 )
                            {
                                ai bot_set_role( "camp_bomb" );
                            }
                        }
                    }
                }
            }
            
            possible_zones = level.objectives;
            
            if ( has_override_zone_targets( game[ "defenders" ] ) )
            {
                possible_zones = get_override_zone_targets( game[ "defenders" ] );
            }
            
            foreach ( i in possible_zones )
            {
                foreach ( j in possible_zones )
                {
                    var_3482595f3f8cd2af = get_players_defending_zone( i );
                    var_34825a5f3f8cd4e2 = get_players_defending_zone( j );
                    
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
                            defender.defend_zone = j;
                        }
                    }
                }
            }
        }
        else
        {
            if ( isdefined( level.atk_bomber ) )
            {
                level.atk_bomber = undefined;
            }
            
            if ( !isalive( level.bomb_defuser ) )
            {
                var_f93d2f3306e52cdb = [];
                defenders = get_players_by_role( "defender" );
                backstabbers = get_players_by_role( "backstabber" );
                random_killers = get_players_by_role( "random_killer" );
                
                if ( defenders.size > 0 )
                {
                    var_f93d2f3306e52cdb = defenders;
                }
                else if ( backstabbers.size > 0 )
                {
                    var_f93d2f3306e52cdb = backstabbers;
                }
                else if ( random_killers.size > 0 )
                {
                    var_f93d2f3306e52cdb = random_killers;
                }
                
                if ( var_f93d2f3306e52cdb.size > 0 && isdefined( level.sdbombmodel ) )
                {
                    [ level.bomb_defuser ] = utility::get_array_of_closest( level.sdbombmodel.origin, var_f93d2f3306e52cdb );
                    level.bomb_defuser bot_set_role( "defuser" );
                    level.bomb_defuser bots_tactical_goals::disable_tactical_goals();
                    level.bomb_defuser thread defuser_wait_for_death();
                }
            }
            
            if ( !isdefined( level.sd_bomb_just_planted ) )
            {
                level.sd_bomb_just_planted = 1;
                attackers = bots_gametype_common::get_living_players_on_team( game[ "attackers" ] );
                
                foreach ( player in attackers )
                {
                    if ( isdefined( player.role ) )
                    {
                        if ( player.role == "atk_bomber" )
                        {
                            player thread bot_set_role( undefined );
                            continue;
                        }
                        
                        if ( player.role != "defend_planted_bomb" )
                        {
                            player thread bot_set_role_delayed( "defend_planted_bomb", randomfloatrange( 0, 3 ) );
                        }
                    }
                }
            }
        }
        
        /#
            if ( !level.multibomb && !level.bombplanted && ( !isdefined( level.last_atk_bomber_death_time ) || gettime() - level.last_atk_bomber_death_time > 300 ) )
            {
                attackers = bots_gametype_common::get_living_players_on_team( game[ "<dev string:x216>" ] );
                
                if ( attackers.size > 0 )
                {
                    carriers = [];
                    var_2e1179d1ef71d864 = [];
                    var_7047eafa81ed4dcb = 0;
                    
                    foreach ( player in attackers )
                    {
                        if ( player.has_started_thinking )
                        {
                            var_7047eafa81ed4dcb = 1;
                        }
                        
                        if ( game_utility_common::isteamparticipant( player ) )
                        {
                            if ( player.isbombcarrier )
                            {
                                carriers[ carriers.size ] = player;
                            }
                            
                            if ( player.role == "<dev string:x220>" )
                            {
                                var_2e1179d1ef71d864[ var_2e1179d1ef71d864.size ] = player;
                            }
                        }
                    }
                    
                    if ( var_7047eafa81ed4dcb )
                    {
                        if ( var_2e1179d1ef71d864.size != 1 )
                        {
                            assertmsg( "<dev string:x22b>" + var_2e1179d1ef71d864.size + "<dev string:x266>" + attackers.size );
                        }
                        else
                        {
                            assert( var_2e1179d1ef71d864[ 0 ] == level.atk_bomber );
                        }
                    }
                    
                    assert( carriers.size <= 1 );
                    
                    if ( carriers.size == 1 )
                    {
                        bomb_carrier = gameobjects_shared::carryobject_get_carrier( level.sdbomb );
                        assert( isdefined( var_2e1179d1ef71d864[ 0 ] ) );
                        assert( carriers[ 0 ] == bomb_carrier );
                        assert( carriers[ 0 ] == var_2e1179d1ef71d864[ 0 ] );
                    }
                }
            }
        #/
        
        wait 0.5;
    }
}

// Namespace bots_gametype_sd
// Params 0
// Checksum 0xb612ef86, Offset: 0x370f
// Size: 0x19
function defuser_wait_for_death()
{
    self waittill( #"death_or_disconnect" );
    level.bomb_defuser = undefined;
}

