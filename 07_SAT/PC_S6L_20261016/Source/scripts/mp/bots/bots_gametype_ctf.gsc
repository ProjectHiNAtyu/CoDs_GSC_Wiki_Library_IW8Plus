// scripts\mp\bots\bots_gametype_ctf.gsc  (hash_1bcfb8587606a596.gscc) (size: 7992 Bytes / 0x1f38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4b90c51 (2763590737)
// size ...... 7992 (0x1f38)
// includes .. 9   (offset: 0x1d34)
// strings ... 28  (offset: 0x1d7c)
// dev strs .. 1   (offset: 0x1f2c)
// exports ... 23  (offset: 0x1140)
// cseg ...... 0x237 + 0xf09 (0x1140)
// imports ... 69  (offset: 0x14d8)
// animtree1 . 0   (offset: 0x1f38)
// animtree2 . 0   (offset: 0x1f38)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;

#namespace bots_gametype_ctf;

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0xcab7ef29, Offset: 0x255
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_ctf();
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x5882f29e, Offset: 0x26d
// Size: 0x5d
function setup_callbacks()
{
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "gametype_think" ] = &bot_ctf_think;
    level.bot_funcs[ "get_watch_tacpoint_chance" ] = &function_222a36d5d0aae558;
    autopilot::initialize( undefined, undefined, [ "bot_ctf_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x43a9d6d7, Offset: 0x2d2
// Size: 0x309
function setup_bot_ctf()
{
    /#
        if ( false )
        {
            level.var_ef46137f247c5723 = 1;
        }
    #/
    
    level.bot_gametype_attacker_limit_for_team = &ctf_bot_attacker_limit_for_team;
    level.bot_gametype_defender_limit_for_team = &ctf_bot_defender_limit_for_team;
    level.bot_gametype_allied_attackers_for_team = &function_ca445b1b6beb9e01;
    level.bot_gametype_allied_defenders_for_team = &function_739d1ee5f67a11a5;
    level.bot_gametype_allowed_to_switch_to_defender = &bot_ctf_can_switch_to_defender;
    level.bot_gametype_human_player_always_attacker = &bot_ctf_player_always_attacker;
    bots_util::bot_waittill_bots_enabled();
    
    while ( !isdefined( level.teamflags ) )
    {
        wait 0.05;
    }
    
    level.teamflags[ "allies" ].objectivekey = "allies";
    level.teamflags[ "axis" ].objectivekey = "axis";
    bots_gametype_common::bot_cache_entrances_to_gametype_array( level.teamflags, "flag_", 1 );
    var_d5e02027fae68472 = findclosesttacpointinsight( level.teamflags[ "allies" ].curorigin );
    
    if ( !isdefined( var_d5e02027fae68472 ) )
    {
        var_d5e02027fae68472 = findclosesttacpoint( level.teamflags[ "allies" ].curorigin );
    }
    
    if ( isdefined( var_d5e02027fae68472 ) )
    {
        allieszones = getzonesnearest( var_d5e02027fae68472, 100 );
        
        if ( allieszones.size > 0 )
        {
            foreach ( zone in allieszones )
            {
                botzonesetteam( zone, "allies" );
            }
        }
    }
    
    var_764d37f7634c25f5 = findclosesttacpointinsight( level.teamflags[ "axis" ].curorigin );
    
    if ( !isdefined( var_764d37f7634c25f5 ) )
    {
        var_764d37f7634c25f5 = findclosesttacpoint( level.teamflags[ "axis" ].curorigin );
    }
    
    if ( isdefined( var_764d37f7634c25f5 ) )
    {
        axiszones = getzonesnearest( var_764d37f7634c25f5, 100 );
        
        if ( axiszones.size > 0 )
        {
            foreach ( zone in axiszones )
            {
                botzonesetteam( zone, "axis" );
            }
        }
    }
    
    level.capzones[ "allies" ].nearest_tacpoint = level.teamflags[ "allies" ].nearest_tacpoint;
    level.capzones[ "axis" ].nearest_tacpoint = level.teamflags[ "axis" ].nearest_tacpoint;
    thread bot_ctf_ai_director_update();
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0x8e47bbd9, Offset: 0x5e3
// Size: 0x41
function crate_can_use( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return 0;
    }
    
    if ( bot_ctf_player_has_flag() )
    {
        return 0;
    }
    
    return bot_ctf_flag_is_home_of_team( self.team );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x1ba70ee8, Offset: 0x62d
// Size: 0x48d
function bot_ctf_think()
{
    self notify( #"bot_ctf_think" );
    self endon( #"bot_ctf_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self.next_flag_hide_time = 0;
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    set_scripted_pathing_style = 0;
    var_b48805b0081c08e4 = 0;
    
    for ( ;; )
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
        
        if ( !isdefined( self.role ) )
        {
            bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
        }
        
        enemy_team = team_utility::getotherteam( self.team );
        
        if ( bot_ctf_flag_is_home_of_team( self.team ) )
        {
            if ( isdefined( level.bot_known_flag_carrier_loc[ enemy_team ] ) )
            {
                level.bot_known_flag_carrier_loc[ enemy_team ] = undefined;
            }
        }
        
        sprint_desired = 0;
        
        if ( self.role == "attacker" )
        {
            if ( bot_ctf_player_has_flag() )
            {
                sprint_desired = 1;
            }
            else if ( !bot_ctf_enemy_team_flag_is_picked_up() )
            {
                sprint_desired = distancesquared( self.origin, level.teamflags[ enemy_team ].curorigin ) < squared( get_flag_protect_radius() );
            }
        }
        else if ( !bot_ctf_flag_is_home_of_team( self.team ) )
        {
            sprint_desired = !bot_ctf_my_team_flag_is_picked_up();
        }
        
        self botsetflag( "force_sprint", sprint_desired );
        var_b48805b0081c08e4 = 0;
        
        if ( bot_ctf_player_has_flag() )
        {
            if ( bot_ctf_flag_is_home_of_team( self.team ) )
            {
                clear_defend();
                var_b48805b0081c08e4 = 1;
                
                if ( !set_scripted_pathing_style )
                {
                    set_scripted_pathing_style = 1;
                    self botsetpathingstyle( "scripted" );
                }
                
                self botsetscriptgoal( level.capzones[ self.team ].curorigin, 16, "critical" );
            }
            else if ( bots_gametype_common::bot_gametype_get_num_players_on_team( self.team ) == 1 )
            {
                bot_ctf_recover_flag();
            }
            else if ( gettime() > self.next_flag_hide_time )
            {
                clear_defend();
                tacpoints = function_a034a927128ada11( level.capzones[ self.team ].curorigin, 900, 0, 300 );
                hide_tacpoint = bots_util::function_ec1247a9311f67a4( "bot_ctf_think -> tacpoint pick hide anywhere", tacpoints, tacpoints.size * 0.15, "hide_anywhere" );
                
                if ( !isdefined( hide_tacpoint ) )
                {
                    hide_tacpoint = level.capzones[ self.team ].nearest_tacpoint;
                }
                
                assert( isdefined( hide_tacpoint ) );
                success = self botsetscriptgoal( hide_tacpoint, 0, "critical" );
                
                if ( success )
                {
                    self.next_flag_hide_time = gettime() + 15000;
                }
            }
        }
        else if ( self.role == "attacker" )
        {
            if ( bot_ctf_enemy_team_flag_is_picked_up() )
            {
                if ( !namespace_14346d439f44a158::function_737443eaedb33690() )
                {
                    clear_defend();
                    self botclearscriptgoal();
                    allied_flag_carrier = level.teamflags[ enemy_team ].carrier;
                    namespace_14346d439f44a158::guard_player( allied_flag_carrier, 500 );
                }
            }
            else
            {
                clear_defend();
                
                if ( self botgetscriptgoaltype() == "critical" )
                {
                    self botclearscriptgoal();
                }
                
                self botsetscriptgoal( level.teamflags[ enemy_team ].curorigin, 16, "objective" );
                self botsetobjectiveradius( 300 );
            }
        }
        else
        {
            assert( self.role == "<dev string:x24>" );
            
            if ( !bot_ctf_flag_is_home_of_team( self.team ) )
            {
                bot_ctf_recover_flag();
            }
            else if ( !is_protecting_flag() )
            {
                self botclearscriptgoal();
                optional_params[ "score_flags" ] = "strict_los";
                optional_params[ "entrance_points_index" ] = "flag_" + level.teamflags[ self.team ].objectivekey;
                optional_params[ "nearest_tacpoint_to_center" ] = level.teamflags[ self.team ].nearest_tacpoint;
                namespace_14346d439f44a158::protect_point( level.teamflags[ self.team ].curorigin, get_flag_protect_radius(), optional_params );
            }
        }
        
        if ( set_scripted_pathing_style && !var_b48805b0081c08e4 )
        {
            set_scripted_pathing_style = 0;
            self botsetpathingstyle( undefined );
        }
    }
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0xcd523df, Offset: 0xac2
// Size: 0x29e
function bot_ctf_recover_flag()
{
    known_flag_origin = undefined;
    my_flag = level.teamflags[ self.team ];
    flag_carrier = my_flag.carrier;
    
    if ( !isdefined( flag_carrier ) )
    {
        known_flag_origin = my_flag.curorigin;
    }
    else if ( self botcanseeentity( flag_carrier ) )
    {
        known_flag_origin = flag_carrier.origin;
        
        if ( self botgetdifficultysetting( "strategyLevel" ) > 0 && !bot_ctf_flag_is_home_of_team( self.team ) )
        {
            if ( !isdefined( level.bot_known_flag_carrier_loc ) )
            {
                level.bot_known_flag_carrier_loc = [];
            }
            
            if ( !isdefined( level.bot_known_flag_carrier_loc[ flag_carrier.team ] ) )
            {
                level.bot_known_flag_carrier_loc[ flag_carrier.team ] = [];
            }
            
            level.bot_known_flag_carrier_loc[ flag_carrier.team ][ "origin" ] = known_flag_origin;
            level.bot_known_flag_carrier_loc[ flag_carrier.team ][ "time" ] = gettime();
        }
    }
    else if ( isdefined( my_flag.curcarrierorigin ) )
    {
        if ( isdefined( my_flag.compassicons[ "friendly" ] ) )
        {
            if ( my_flag.objidpingfriendly )
            {
                known_flag_origin = my_flag.curcarrierorigin;
            }
            else
            {
                known_flag_origin = flag_carrier.origin;
            }
        }
    }
    else
    {
        known_flag_origin = my_flag.curorigin;
    }
    
    if ( isdefined( known_flag_origin ) )
    {
        clear_defend();
        self botsetscriptgoal( known_flag_origin, 16, "critical" );
        return;
    }
    
    var_40add155bce37725 = undefined;
    var_1cbe35bf974998bc = undefined;
    
    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        if ( isdefined( level.bot_known_flag_carrier_loc[ flag_carrier.team ] ) )
        {
            var_1cbe35bf974998bc = gettime() - level.bot_known_flag_carrier_loc[ flag_carrier.team ][ "time" ];
            
            if ( var_1cbe35bf974998bc < 10000 )
            {
                var_40add155bce37725 = level.bot_known_flag_carrier_loc[ flag_carrier.team ][ "origin" ];
            }
        }
    }
    
    if ( isdefined( var_40add155bce37725 ) )
    {
        if ( var_1cbe35bf974998bc < 5000 )
        {
            clear_defend();
            self botsetscriptgoal( var_40add155bce37725, 16, "critical" );
        }
        else if ( !namespace_14346d439f44a158::is_patrolling() )
        {
            namespace_14346d439f44a158::function_87e8deae08ce1a0();
            namespace_14346d439f44a158::patrol_area( var_40add155bce37725, 400 );
        }
        
        return;
    }
    
    clear_defend();
    current_goal_type = self botgetscriptgoaltype();
    
    if ( current_goal_type == "objective" || current_goal_type == "critical" )
    {
        self botclearscriptgoal();
    }
    
    bots_personality::update_personality_default();
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0xefeacf6, Offset: 0xd68
// Size: 0x12
function clear_defend()
{
    if ( namespace_14346d439f44a158::is_defending() )
    {
        namespace_14346d439f44a158::function_87e8deae08ce1a0();
    }
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x400526ee, Offset: 0xd82
// Size: 0x8
function is_protecting_flag()
{
    return namespace_14346d439f44a158::is_protecting();
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x8d6da61a, Offset: 0xd93
// Size: 0xa2
function get_flag_protect_radius()
{
    if ( isalive( self ) && !isdefined( level.protect_radius ) )
    {
        worldbounds = getnavbounds();
        var_41e85416dd9b9a8d = worldbounds.halfsize[ 0 ] * 2;
        var_f2ab902bc98cc80 = worldbounds.halfsize[ 1 ] * 2;
        average_side = ( var_41e85416dd9b9a8d + var_f2ab902bc98cc80 ) / 2;
        level.protect_radius = min( 800, average_side / 5.5 );
    }
    
    if ( !isdefined( level.protect_radius ) )
    {
        return 900;
    }
    
    return level.protect_radius;
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0x52f3d892, Offset: 0xe3e
// Size: 0xde
function ctf_bot_attacker_limit_for_team( team )
{
    team_limit = bots_gametype_common::bot_gametype_get_num_players_on_team( team );
    
    if ( team_limit == 1 )
    {
        return 1;
    }
    
    if ( bot_ctf_flag_is_home_of_team( team ) )
    {
        var_50c78282d23bda18 = team_limit * 0.67;
    }
    else
    {
        enemy_team = team_utility::getotherteam( team );
        
        if ( bot_ctf_flag_is_home_of_team( enemy_team ) )
        {
            var_50c78282d23bda18 = team_limit * 0.5;
        }
        else
        {
            var_50c78282d23bda18 = team_limit * 0.4;
        }
    }
    
    var_794a5a0be98082d5 = int( ceil( var_50c78282d23bda18 ) );
    my_score = game[ "teamScores" ][ team ];
    enemy_score = game[ "teamScores" ][ utility::get_enemy_team( team ) ];
    
    if ( my_score + 1 < enemy_score )
    {
        var_794a5a0be98082d5 = int( min( var_794a5a0be98082d5 + 1, team_limit ) );
    }
    
    return var_794a5a0be98082d5;
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0xb6ad51d5, Offset: 0xf25
// Size: 0x2b
function ctf_bot_defender_limit_for_team( team )
{
    team_limit = bots_gametype_common::bot_gametype_get_num_players_on_team( team );
    return team_limit - ctf_bot_attacker_limit_for_team( team );
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0xf7297184, Offset: 0xf59
// Size: 0x30
function function_ca445b1b6beb9e01( team )
{
    return bots_gametype_common::bot_gametype_get_allied_attackers_for_team( team, level.capzones[ team ].curorigin, get_flag_protect_radius() );
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0xf7297184, Offset: 0xf92
// Size: 0x30
function function_739d1ee5f67a11a5( team )
{
    return bots_gametype_common::bot_gametype_get_allied_defenders_for_team( team, level.capzones[ team ].curorigin, get_flag_protect_radius() );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x84da6b78, Offset: 0xfcb
// Size: 0x2d
function bot_ctf_ai_director_update()
{
    level notify( #"bot_ctf_ai_director_update" );
    level endon( #"bot_ctf_ai_director_update" );
    level endon( #"game_ended" );
    thread bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0x741864f8, Offset: 0x1000
// Size: 0x5f
function function_222a36d5d0aae558( tacpoint )
{
    if ( tacpoint == self.var_ed2c61ea014d90ab )
    {
        return 1;
    }
    
    if ( !is_protecting_flag() )
    {
        return 1;
    }
    
    var_2bf48cb30974f358 = tacpoint bots_util_mp::function_6ed0ed07336b5fee( "flag_allies", "flag_axis" );
    
    if ( var_2bf48cb30974f358 )
    {
        return 1;
    }
    
    return 0.2;
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0x213d88f3, Offset: 0x1068
// Size: 0x1e, Type: bool
function bot_ctf_flag_is_home_of_team( team )
{
    return level.teamflags[ team ] gameobjects::ishome();
}

// Namespace bots_gametype_ctf
// Params 1
// Checksum 0x85b4e1e3, Offset: 0x108f
// Size: 0x23, Type: bool
function bot_ctf_flag_picked_up_of_team( team )
{
    return isdefined( level.teamflags[ team ].carrier );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x774ad3bf, Offset: 0x10bb
// Size: 0x11, Type: bool
function bot_ctf_my_team_flag_is_picked_up()
{
    return bot_ctf_flag_picked_up_of_team( self.team );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x1fb4739b, Offset: 0x10d5
// Size: 0x25, Type: bool
function bot_ctf_enemy_team_flag_is_picked_up()
{
    enemy_team = team_utility::getotherteam( self.team );
    return bot_ctf_flag_picked_up_of_team( enemy_team );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x5102f27e, Offset: 0x1103
// Size: 0xc, Type: bool
function bot_ctf_player_has_flag()
{
    return isdefined( self.carryflag );
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0xbe11ed1d, Offset: 0x1118
// Size: 0xf, Type: bool
function bot_ctf_can_switch_to_defender()
{
    if ( bot_ctf_player_has_flag() )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_ctf
// Params 0
// Checksum 0x45898577, Offset: 0x1130
// Size: 0xf, Type: bool
function bot_ctf_player_always_attacker()
{
    if ( bot_ctf_player_has_flag() )
    {
        return true;
    }
    
    return false;
}

