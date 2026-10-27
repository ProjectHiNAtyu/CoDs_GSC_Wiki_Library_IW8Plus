// scripts\mp\bots\bots_gametype_dom.gsc  (hash_35f1c253181907b1.gscc) (size: 19030 Bytes / 0x4a56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xafd9fc46 (2950298694)
// size ...... 19030 (0x4a56)
// includes .. 15  (offset: 0x46a6)
// strings ... 50  (offset: 0x471e)
// dev strs .. 13  (offset: 0x49ba)
// exports ... 46  (offset: 0x2f3a)
// cseg ...... 0x378 + 0x2bc2 (0x2f3a)
// imports ... 123 (offset: 0x366a)
// animtree1 . 0   (offset: 0x4a56)
// animtree2 . 0   (offset: 0x4a56)
#using script_382bf8d77c4fd348;
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\dom;

#namespace bots_gametype_dom;

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xfba83c81, Offset: 0x396
// Size: 0x36
function main()
{
    level.var_ae4d3fde002fedb4 = 1;
    setup_callbacks();
    setup_bot_dom( 3, 5 );
    level thread bots_util_mp::bot_monitor_enemy_camp_spots( &bots_util_mp::bot_valid_camp_assassin );
    
    /#
        thread function_b77fdc050c8bfa30();
    #/
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x705379dd, Offset: 0x3d4
// Size: 0x87
function setup_callbacks()
{
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "gametype_think" ] = &bot_dom_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_dom;
    level.bot_funcs[ "leader_dialog" ] = &bot_dom_leader_dialog;
    level.bot_funcs[ "get_watch_tacpoint_chance" ] = &function_32954fde1431a2a7;
    autopilot::initialize( undefined, undefined, [ "bot_dom_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x520bcbad, Offset: 0x463
// Size: 0x3b, Type: bool
function crate_can_use( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return false;
    }
    
    if ( !game_utility_common::isteamparticipant( self ) )
    {
        return true;
    }
    
    return bots_scripted_defense::is_protecting();
}

/#

    // Namespace bots_gametype_dom
    // Params 0
    // Checksum 0x825a361e, Offset: 0x4a7
    // Size: 0x1ee, Type: dev
    function function_b77fdc050c8bfa30()
    {
        while ( !isdefined( level.bot_gametype_precaching_done ) )
        {
            wait 0.05;
        }
        
        drawing_was_on = 0;
        
        while ( true )
        {
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
            {
                drawing_was_on = 1;
                flags = level.objectives;
                
                foreach ( flag in flags )
                {
                    bots_debug::function_8777d84a0c0c5802( 1, flag, ( 0, 1, 0 ), 1 );
                    
                    foreach ( tacpoint in flag.tacpoints )
                    {
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, ( 0, 1, 0 ), 1, 4 );
                    }
                }
            }
            else if ( drawing_was_on )
            {
                foreach ( flag in flags )
                {
                    bots_debug::function_8777d84a0c0c5802( 0, flag );
                }
                
                drawing_was_on = 0;
            }
            
            waitframe();
        }
    }

#/

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x66541c96, Offset: 0x69d
// Size: 0x1fd
function monitor_flag_control()
{
    self notify( #"monitor_flag_control" );
    self endon( #"monitor_flag_control" );
    self endon( #"death" );
    level endon( #"game_ended" );
    flag_origin = gameobjects_shared::get_origin( self );
    nearesttacpoint = findclosesttacpointinsight( flag_origin );
    
    if ( !isdefined( nearesttacpoint ) )
    {
        nearesttacpoint = findclosesttacpoint( flag_origin );
        
        if ( !isdefined( nearesttacpoint ) )
        {
            assertmsg( "<dev string:x24>" + flag_origin );
            return;
        }
    }
    
    for ( ;; )
    {
        wait 1;
        team = undefined;
        
        if ( self.type_hash == #"gameobject_type_capture_zone" )
        {
            var_4a7cd465ff58f423 = namespace_277c922f0d0dc523::get_claim_team_hash( self );
            
            if ( var_4a7cd465ff58f423 == #"hash_7118f9343873352b" )
            {
                team = game[ "attackers" ];
            }
            else if ( var_4a7cd465ff58f423 == #"hash_ce911e3bbe99421f" )
            {
                team = game[ "defenders" ];
            }
            else
            {
                team = dom::getflagteam();
            }
        }
        else if ( isdefined( self.contestedtime ) )
        {
            team = "all";
        }
        else if ( self.claimteam != "none" )
        {
            team = self.claimteam;
        }
        else
        {
            team = dom::getflagteam();
        }
        
        zones = getzonesnearest( nearesttacpoint, 100 );
        
        if ( zones.size > 0 )
        {
            foreach ( zone in zones )
            {
                if ( team == "all" )
                {
                    botzonesetteam( zone, "free" );
                    continue;
                }
                
                if ( team == "none" || team == "neutral" )
                {
                    botzonesetteam( zone, "free" );
                    continue;
                }
                
                botzonesetteam( zone, team );
            }
        }
    }
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xdfc5d0e9, Offset: 0x8a2
// Size: 0x74
function monitor_flag_ownership()
{
    self notify( #"monitor_flag_ownership" );
    self endon( #"monitor_flag_ownership" );
    self endon( #"death" );
    level endon( #"game_ended" );
    prev_team = dom::getflagteam();
    
    for ( ;; )
    {
        current_team = dom::getflagteam();
        
        if ( current_team != prev_team )
        {
            level notify( #"flag_changed_ownership" );
        }
        
        prev_team = current_team;
        wait 0.05;
    }
}

// Namespace bots_gametype_dom
// Params 2
// Checksum 0x9b7b0fac, Offset: 0x91e
// Size: 0x23a
function setup_bot_dom( var_afb7c94eb279e4f5, var_e1ba5c9638b23e0a )
{
    /#
        setdevdvarifuninitialized( @"hash_d19b61818b442235", 0 );
        setdevdvarifuninitialized( @"hash_e1e41766847222dc", 0 );
    #/
    
    bots_util::bot_waittill_bots_enabled();
    flags = level.objectives;
    assert( flags.size == var_afb7c94eb279e4f5 );
    bots_gametype_common::bot_cache_entrances_to_gametype_array( flags, "flag", 1 );
    bot_cache_flag_distances( flags );
    
    foreach ( flag in flags )
    {
        flag thread monitor_flag_control();
        flag thread monitor_flag_ownership();
        
        if ( flag.objectivekey != "_a" && flag.objectivekey != "_b" && flag.objectivekey != "_c" )
        {
            assertmsg( "<dev string:x5c>" + gameobjects_shared::get_origin( flag ) + "<dev string:x79>" );
        }
        
        flag.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( flag, 1 );
        flag.last_time_secured[ "allies" ] = 0;
        flag.last_time_secured[ "axis" ] = 0;
        
        /#
            if ( flag.tacpoints.size < var_e1ba5c9638b23e0a )
            {
                wait_time = 1;
                
                if ( gettime() < 5000 )
                {
                    wait_time = max( 1, 5 - gettime() / 1000 );
                }
                
                wait wait_time;
                assertmsg( "<dev string:xa8>" + flag.objectivekey + "<dev string:xba>" + gameobjects_shared::get_origin( flag ) + "<dev string:xc9>" );
            }
        #/
    }
    
    level.bot_dom_override_flag_targets = [];
    level.bot_dom_override_flag_targets[ "axis" ] = [];
    level.bot_dom_override_flag_targets[ "allies" ] = [];
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xa0c7860c, Offset: 0xb60
// Size: 0x145
function bot_cache_flag_distances( flags )
{
    if ( !isdefined( level.flag_distances ) )
    {
        level.flag_distances = [];
    }
    
    var_92f53d88de9b4052 = [];
    i = 0;
    
    foreach ( flag in flags )
    {
        var_92f53d88de9b4052[ i ] = flag;
        i++;
    }
    
    for ( i = 0; i < var_92f53d88de9b4052.size - 1 ; i++ )
    {
        for ( j = i + 1; j < var_92f53d88de9b4052.size ; j++ )
        {
            var_14d56c94fff2675a = distance( gameobjects_shared::get_origin( var_92f53d88de9b4052[ i ] ), gameobjects_shared::get_origin( var_92f53d88de9b4052[ j ] ) );
            i_label = get_flag_label( var_92f53d88de9b4052[ i ] );
            j_label = get_flag_label( var_92f53d88de9b4052[ j ] );
            level.flag_distances[ i_label ][ j_label ] = var_14d56c94fff2675a;
            level.flag_distances[ j_label ][ i_label ] = var_14d56c94fff2675a;
        }
    }
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xb8385b31, Offset: 0xcad
// Size: 0xf3
function should_start_cautious_approach_dom( firstcheck )
{
    if ( firstcheck )
    {
        if ( self.current_flag dom::getflagteam() == "neutral" && flag_has_never_been_captured( self.current_flag ) )
        {
            my_spawn_flag = get_closest_flag( self.lastspawnpoint.origin );
            
            if ( my_spawn_flag == self.current_flag )
            {
                return 0;
            }
            else
            {
                enemy_spawn_flag = get_farthest_flag( self.lastspawnpoint.origin );
                var_5f31ef4d42a585f2 = distancesquared( gameobjects_shared::get_origin( my_spawn_flag ), gameobjects_shared::get_origin( self.current_flag ) );
                var_4c767f0d7407af12 = distancesquared( gameobjects_shared::get_origin( enemy_spawn_flag ), gameobjects_shared::get_origin( self.current_flag ) );
                
                if ( var_5f31ef4d42a585f2 < var_4c767f0d7407af12 )
                {
                    return 0;
                }
            }
        }
    }
    
    return bots_strategy::should_start_cautious_approach_default( firstcheck );
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x74824afc, Offset: 0xda9
// Size: 0x1c, Type: bool
function bot_dom_debug_should_capture_all()
{
    /#
        if ( getdvarint( @"hash_d19b61818b442235" ) == 1 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x194ac56, Offset: 0xdce
// Size: 0x1c, Type: bool
function bot_dom_debug_should_protect_all()
{
    /#
        if ( getdvarint( @"hash_e1e41766847222dc" ) == 1 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x707f090, Offset: 0xdf3
// Size: 0x18d
function bot_dom_think()
{
    self notify( #"bot_dom_think" );
    self endon( #"bot_dom_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self.force_new_goal = 0;
    self.new_goal_time = 0;
    self.next_strat_level_check = 0;
    self.last_losing_flag_react = undefined;
    self.var_e7a00069434f0c69 = undefined;
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
    for ( ;; )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        bots_util_mp::bot_update_camp_assassin();
        
        if ( gettime() > self.next_strat_level_check )
        {
            self.next_strat_level_check = gettime() + 10000;
            self.strategy_level = self botgetdifficultysetting( "strategyLevel" );
        }
        
        if ( gettime() > self.new_goal_time || self.force_new_goal )
        {
            if ( should_delay_flag_decision() )
            {
                self.new_goal_time = gettime() + 5000;
            }
            else if ( isdefined( self.var_e7a00069434f0c69 ) && gettime() - self.var_e7a00069434f0c69 < 1000 )
            {
            }
            else
            {
                self.force_new_goal = 0;
                bot_choose_flag();
                self.new_goal_time = gettime() + randomintrange( 30000, 45000 );
            }
        }
        
        utility::waittill_notify_or_timeout( "needs_new_flag_goal", 1 );
    }
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x4fbf9ec2, Offset: 0xf88
// Size: 0xbe, Type: bool
function should_delay_flag_decision()
{
    if ( self.force_new_goal )
    {
        return false;
    }
    
    if ( !bots_scripted_defense::is_capturing() )
    {
        return false;
    }
    
    if ( self.current_flag dom::getflagteam() == self.team )
    {
        return false;
    }
    
    flag_capture_radius = get_flag_capture_radius();
    
    if ( distancesquared( self.origin, gameobjects_shared::get_origin( self.current_flag ) ) < flag_capture_radius * 2 * flag_capture_radius * 2 )
    {
        ally_flags = get_ally_flags( self.team );
        
        if ( ally_flags.size == 2 && !arraycontains( ally_flags, self.current_flag ) && !bot_allowed_to_3_cap() )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xc53a6c61, Offset: 0x104f
// Size: 0x15
function get_override_flag_targets()
{
    return level.bot_dom_override_flag_targets[ self.team ];
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x581b4091, Offset: 0x106d
// Size: 0x19, Type: bool
function has_override_flag_targets()
{
    override_targets = get_override_flag_targets();
    return override_targets.size > 0;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xa69bf5f, Offset: 0x108f
// Size: 0x15, Type: bool
function flag_has_been_captured_before( flag )
{
    return !flag_has_never_been_captured( flag );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x285421ec, Offset: 0x10ad
// Size: 0x17
function flag_has_never_been_captured( flag )
{
    return flag.firstcapture;
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xcd828cb9, Offset: 0x10cd
// Size: 0x9dc
function bot_choose_flag()
{
    flag = undefined;
    var_554e1c0d9987a4bf = [];
    var_c29ea0c6f8e51920 = [];
    var_58cf29d8753d555 = !level.precappoints;
    override_targets = get_override_flag_targets();
    
    if ( override_targets.size > 0 )
    {
        all_possible_flags = override_targets;
    }
    else
    {
        all_possible_flags = level.objectives;
    }
    
    foreach ( flag in all_possible_flags )
    {
        team = flag dom::getflagteam();
        
        if ( var_58cf29d8753d555 )
        {
            if ( flag_has_been_captured_before( flag ) )
            {
                var_58cf29d8753d555 = 0;
            }
            else if ( !isdefined( team ) )
            {
                assertmsg( "<dev string:xfc>" );
            }
            else if ( team != "neutral" && team != "none" && team != "tie" && team != "all" )
            {
                string1 = "With " + game_utility::gettimepassed() / 1000 + " seconds passed, ";
                string2 = "flag '" + flag.objectivekey + "' is uncaptured (level.preCapPoints: " + level.precappoints + ", flag.firstCapture: " + flag.firstcapture + ") ";
                string3 = "but it somehow already has an owning team: '" + team + "'";
                assertmsg( string1 + string2 + string3 );
            }
        }
        
        if ( team != self.team )
        {
            var_554e1c0d9987a4bf[ var_554e1c0d9987a4bf.size ] = flag;
            continue;
        }
        
        if ( gameobjects_shared::function_7ed0697b0eea44f8( flag ) )
        {
            var_554e1c0d9987a4bf[ var_554e1c0d9987a4bf.size ] = flag;
            continue;
        }
        
        var_c29ea0c6f8e51920[ var_c29ea0c6f8e51920.size ] = flag;
    }
    
    assert( has_override_flag_targets() || var_554e1c0d9987a4bf.size + var_c29ea0c6f8e51920.size == 3 );
    attacking = undefined;
    
    if ( var_554e1c0d9987a4bf.size == 3 )
    {
        assert( var_c29ea0c6f8e51920.size == 0 );
        attacking = 1;
    }
    else if ( var_554e1c0d9987a4bf.size == 2 )
    {
        assert( var_c29ea0c6f8e51920.size <= 1 );
        
        if ( var_c29ea0c6f8e51920.size == 1 )
        {
            if ( !bot_should_defend_flag( var_c29ea0c6f8e51920[ 0 ], 1 ) )
            {
                attacking = 1;
            }
            else
            {
                attacking = !bot_should_defend( 0.34 );
            }
            
            if ( bots_util_mp::bot_get_max_players_on_team( self.team ) == 1 )
            {
                attacking = 1;
            }
        }
        else if ( var_c29ea0c6f8e51920.size == 0 )
        {
            attacking = 1;
        }
    }
    else if ( var_554e1c0d9987a4bf.size == 1 )
    {
        assert( var_c29ea0c6f8e51920.size <= 2 );
        
        if ( var_c29ea0c6f8e51920.size == 2 )
        {
            if ( bot_allowed_to_3_cap() )
            {
                if ( !bot_should_defend_flag( var_c29ea0c6f8e51920[ 0 ], 2 ) && !bot_should_defend_flag( var_c29ea0c6f8e51920[ 1 ], 2 ) )
                {
                    attacking = 1;
                }
                else if ( self.strategy_level == 0 )
                {
                    attacking = !bot_should_defend( 0.34 );
                }
                else
                {
                    attacking = !bot_should_defend( 0.5 );
                }
            }
            else
            {
                attacking = 0;
            }
        }
        else if ( var_c29ea0c6f8e51920.size == 1 )
        {
            if ( !bot_should_defend_flag( var_c29ea0c6f8e51920[ 0 ], 1 ) )
            {
                attacking = 1;
            }
            else
            {
                attacking = !bot_should_defend( 0.34 );
            }
        }
        else if ( var_c29ea0c6f8e51920.size == 0 )
        {
            attacking = 1;
        }
    }
    else if ( var_554e1c0d9987a4bf.size == 0 )
    {
        assert( var_c29ea0c6f8e51920.size <= 3 );
        attacking = 0;
    }
    
    assert( isdefined( attacking ) );
    
    if ( attacking )
    {
        assert( var_554e1c0d9987a4bf.size >= 1 && var_554e1c0d9987a4bf.size <= 3 );
        
        if ( var_554e1c0d9987a4bf.size > 1 )
        {
            var_b015612ed58b012d = bots_gametype_common::function_dbd73e86391f9bd2( self.origin, var_554e1c0d9987a4bf );
        }
        else
        {
            var_b015612ed58b012d = var_554e1c0d9987a4bf;
        }
        
        var_1d312ff4bf058381 = 0;
        
        if ( var_1d312ff4bf058381 )
        {
            capture_flag( var_b015612ed58b012d[ var_b015612ed58b012d.size - 1 ], "objective" );
            return;
        }
        
        if ( var_58cf29d8753d555 && !has_override_flag_targets() )
        {
            assert( var_b015612ed58b012d.size == 3 );
            var_864fce2bae109f2e = get_num_allies_capturing_flag( var_b015612ed58b012d[ 0 ], 1 );
            
            if ( var_864fce2bae109f2e < min_num_bots_assaulting_first_flag() )
            {
                flag_num = 0;
            }
            else
            {
                var_e6e0bcbcd3970d3c = 20;
                var_fcdb7e55fcb0d88 = 65;
                var_a8b8da1df793862 = 15;
                
                if ( self.strategy_level == 0 )
                {
                    var_e6e0bcbcd3970d3c = 50;
                    var_fcdb7e55fcb0d88 = 25;
                    var_a8b8da1df793862 = 25;
                }
                else if ( self.strategy_level == 1 )
                {
                    var_e6e0bcbcd3970d3c = 40;
                    var_fcdb7e55fcb0d88 = 40;
                    var_a8b8da1df793862 = 20;
                }
                
                flag_num = undefined;
                random_roll = randomint( 100 );
                
                if ( random_roll < var_e6e0bcbcd3970d3c )
                {
                    flag_num = 0;
                }
                else if ( random_roll < var_e6e0bcbcd3970d3c + var_fcdb7e55fcb0d88 )
                {
                    flag_num = 1;
                }
                else if ( random_roll < var_e6e0bcbcd3970d3c + var_fcdb7e55fcb0d88 + var_a8b8da1df793862 )
                {
                    flag_num = 2;
                }
                
                assert( isdefined( flag_num ) );
            }
            
            goal_type = undefined;
            
            if ( flag_num == 0 )
            {
                goal_type = "critical";
            }
            
            capture_flag( var_b015612ed58b012d[ flag_num ], goal_type );
            return;
        }
        
        if ( var_b015612ed58b012d.size == 1 )
        {
            flag = var_b015612ed58b012d[ 0 ];
        }
        else if ( distancesquared( gameobjects_shared::get_origin( var_b015612ed58b012d[ 0 ] ), self.origin ) < 102400 )
        {
            flag = var_b015612ed58b012d[ 0 ];
        }
        else
        {
            assert( var_b015612ed58b012d.size >= 2 && var_b015612ed58b012d.size <= 3 );
            var_65deaa595bb259db = [];
            var_4d3a7609621126e0 = [];
            
            for ( i = 0; i < var_b015612ed58b012d.size ; i++ )
            {
                dist = distance( gameobjects_shared::get_origin( var_b015612ed58b012d[ i ] ), self.origin );
                var_4d3a7609621126e0[ i ] = dist;
                var_65deaa595bb259db[ i ] = dist;
            }
            
            if ( var_c29ea0c6f8e51920.size == 1 )
            {
                var_9b5dbfd0326477b2 = 1.5;
                
                for ( i = 0; i < var_65deaa595bb259db.size ; i++ )
                {
                    var_65deaa595bb259db[ i ] += level.flag_distances[ get_flag_label( var_b015612ed58b012d[ i ] ) ][ get_flag_label( var_c29ea0c6f8e51920[ 0 ] ) ] * var_9b5dbfd0326477b2;
                }
            }
            
            if ( self.strategy_level == 0 )
            {
                random_roll = randomint( 100 );
                
                if ( random_roll < 50 )
                {
                    flag = var_b015612ed58b012d[ 0 ];
                }
                else if ( random_roll < 50 + 50 / ( var_b015612ed58b012d.size - 1 ) )
                {
                    flag = var_b015612ed58b012d[ 1 ];
                }
                else
                {
                    flag = var_b015612ed58b012d[ 2 ];
                }
            }
            else if ( var_65deaa595bb259db.size == 2 )
            {
                var_1635b7ef205a6a7[ 0 ] = 50;
                var_1635b7ef205a6a7[ 1 ] = 50;
                
                for ( i = 0; i < var_b015612ed58b012d.size ; i++ )
                {
                    if ( var_65deaa595bb259db[ i ] < var_65deaa595bb259db[ 1 - i ] )
                    {
                        var_1635b7ef205a6a7[ i ] += 20;
                        var_1635b7ef205a6a7[ 1 - i ] -= 20;
                    }
                    
                    if ( var_4d3a7609621126e0[ i ] < 640 )
                    {
                        var_1635b7ef205a6a7[ i ] += 15;
                        var_1635b7ef205a6a7[ 1 - i ] -= 15;
                    }
                    
                    if ( var_b015612ed58b012d[ i ] dom::getflagteam() == "neutral" )
                    {
                        var_1635b7ef205a6a7[ i ] += 15;
                        var_1635b7ef205a6a7[ 1 - i ] -= 15;
                    }
                }
                
                random_roll = randomint( 100 );
                
                if ( random_roll < var_1635b7ef205a6a7[ 0 ] )
                {
                    flag = var_b015612ed58b012d[ 0 ];
                }
                else
                {
                    flag = var_b015612ed58b012d[ 1 ];
                }
            }
            else if ( var_65deaa595bb259db.size == 3 )
            {
                var_1635b7ef205a6a7[ 0 ] = 34;
                var_1635b7ef205a6a7[ 1 ] = 33;
                var_1635b7ef205a6a7[ 2 ] = 33;
                
                for ( i = 0; i < var_b015612ed58b012d.size ; i++ )
                {
                    var_94d2ee2c1364b643 = ( i + 1 ) % 3;
                    var_94d2ef2c1364b876 = ( i + 2 ) % 3;
                    
                    if ( var_65deaa595bb259db[ i ] < var_65deaa595bb259db[ var_94d2ee2c1364b643 ] && var_65deaa595bb259db[ i ] < var_65deaa595bb259db[ var_94d2ef2c1364b876 ] )
                    {
                        var_1635b7ef205a6a7[ i ] += 36;
                        var_1635b7ef205a6a7[ var_94d2ee2c1364b643 ] -= 18;
                        var_1635b7ef205a6a7[ var_94d2ef2c1364b876 ] -= 18;
                    }
                    
                    if ( var_4d3a7609621126e0[ i ] < 640 )
                    {
                        var_1635b7ef205a6a7[ i ] += 15;
                        var_1635b7ef205a6a7[ var_94d2ee2c1364b643 ] -= 7;
                        var_1635b7ef205a6a7[ var_94d2ef2c1364b876 ] -= 8;
                    }
                    
                    if ( var_b015612ed58b012d[ i ] dom::getflagteam() == "neutral" )
                    {
                        var_1635b7ef205a6a7[ i ] += 15;
                        var_1635b7ef205a6a7[ var_94d2ee2c1364b643 ] -= 7;
                        var_1635b7ef205a6a7[ var_94d2ef2c1364b876 ] -= 8;
                    }
                }
                
                random_roll = randomint( 100 );
                
                if ( random_roll < var_1635b7ef205a6a7[ 0 ] )
                {
                    flag = var_b015612ed58b012d[ 0 ];
                }
                else if ( random_roll < var_1635b7ef205a6a7[ 0 ] + var_1635b7ef205a6a7[ 1 ] )
                {
                    flag = var_b015612ed58b012d[ 1 ];
                }
                else
                {
                    flag = var_b015612ed58b012d[ 2 ];
                }
            }
        }
    }
    else
    {
        assert( var_c29ea0c6f8e51920.size > 0 );
        
        if ( var_c29ea0c6f8e51920.size > 1 )
        {
            var_6ec98b9c80ecd760 = bots_gametype_common::function_dbd73e86391f9bd2( self.origin, var_c29ea0c6f8e51920 );
        }
        else
        {
            var_6ec98b9c80ecd760 = var_c29ea0c6f8e51920;
        }
        
        foreach ( test_flag in var_6ec98b9c80ecd760 )
        {
            if ( bot_should_defend_flag( test_flag, var_c29ea0c6f8e51920.size ) )
            {
                flag = test_flag;
                break;
            }
        }
        
        if ( !isdefined( flag ) )
        {
            assert( var_6ec98b9c80ecd760.size > 0 );
            
            if ( self.strategy_level == 0 )
            {
                flag = var_c29ea0c6f8e51920[ 0 ];
            }
            else if ( var_6ec98b9c80ecd760.size == 2 )
            {
                third_flag = get_other_flag( var_6ec98b9c80ecd760[ 0 ], var_6ec98b9c80ecd760[ 1 ] );
                var_41df7a383f530141 = bots_gametype_common::function_dbd73e86391f9bd2( gameobjects_shared::get_origin( third_flag ), var_6ec98b9c80ecd760 );
                random_roll = randomint( 100 );
                
                if ( random_roll < 70 )
                {
                    flag = var_41df7a383f530141[ 0 ];
                }
                else
                {
                    flag = var_41df7a383f530141[ 1 ];
                }
            }
            else
            {
                assert( var_6ec98b9c80ecd760.size == 1 || var_6ec98b9c80ecd760.size == 3 );
                flag = var_6ec98b9c80ecd760[ 0 ];
            }
        }
    }
    
    if ( attacking )
    {
        capture_flag( flag );
        return;
    }
    
    defend_flag( flag );
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x525a3a6b, Offset: 0x1ab1
// Size: 0x26
function min_num_bots_assaulting_first_flag()
{
    team_limit = bots_util_mp::bot_get_max_players_on_team( self.team );
    return ceil( team_limit / 3 );
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xc8fbfcfc, Offset: 0x1ae0
// Size: 0x9e
function bot_allowed_to_3_cap()
{
    if ( self.strategy_level == 0 )
    {
        return 1;
    }
    
    override_targets = get_override_flag_targets();
    
    if ( override_targets.size == 3 )
    {
        return 1;
    }
    
    enemy_score = gamescore::getteamscore( utility::get_enemy_team( self.team ) );
    my_score = gamescore::getteamscore( self.team );
    var_d792beb355bdb66 = 200 - enemy_score;
    var_876aee173f7963b4 = 200 - my_score;
    var_300ea2cbd51c68e6 = var_876aee173f7963b4 * 0.5 > var_d792beb355bdb66;
    return var_300ea2cbd51c68e6;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xd275806a, Offset: 0x1b87
// Size: 0x7a
function bot_should_defend( var_95938cc8d689c6af )
{
    assert( var_95938cc8d689c6af >= 0 && var_95938cc8d689c6af <= 1 );
    
    if ( randomfloat( 1 ) < var_95938cc8d689c6af )
    {
        return 1;
    }
    
    personality_type = level.bot_personality_type[ self.personality ];
    
    if ( personality_type == "stationary" )
    {
        return 1;
    }
    else if ( personality_type == "active" )
    {
        return 0;
    }
    
    assertmsg( "<dev string:x111>" );
}

// Namespace bots_gametype_dom
// Params 3
// Checksum 0x26ae1655, Offset: 0x1c09
// Size: 0xce
function capture_flag( var_652a39b2414c0bb1, override_goal_type, var_82cb54bb39331833 )
{
    assert( isdefined( var_652a39b2414c0bb1 ) );
    self.current_flag = var_652a39b2414c0bb1;
    self.var_e7a00069434f0c69 = gettime();
    
    if ( bot_dom_debug_should_protect_all() )
    {
        optional_params[ "override_goal_type" ] = override_goal_type;
        optional_params[ "entrance_points_index" ] = get_flag_label( var_652a39b2414c0bb1 );
        bots_scripted_defense::protect_point( gameobjects_shared::get_origin( var_652a39b2414c0bb1 ), get_flag_protect_radius(), optional_params );
    }
    else
    {
        optional_params[ "override_goal_type" ] = override_goal_type;
        optional_params[ "entrance_points_index" ] = get_flag_label( var_652a39b2414c0bb1 );
        bots_scripted_defense::capture_zone( gameobjects_shared::get_origin( var_652a39b2414c0bb1 ), var_652a39b2414c0bb1.tacpoints, var_652a39b2414c0bb1, optional_params );
    }
    
    if ( !var_82cb54bb39331833 )
    {
        thread monitor_flag_status( var_652a39b2414c0bb1 );
    }
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x5f935f68, Offset: 0x1cdf
// Size: 0xb5
function defend_flag( var_1e8731c681160cd1 )
{
    assert( isdefined( var_1e8731c681160cd1 ) );
    self.current_flag = var_1e8731c681160cd1;
    self.var_e7a00069434f0c69 = gettime();
    
    if ( bot_dom_debug_should_capture_all() )
    {
        optional_params[ "entrance_points_index" ] = get_flag_label( var_1e8731c681160cd1 );
        bots_scripted_defense::capture_zone( gameobjects_shared::get_origin( var_1e8731c681160cd1 ), var_1e8731c681160cd1.tacpoints, var_1e8731c681160cd1, optional_params );
    }
    else
    {
        optional_params[ "entrance_points_index" ] = get_flag_label( var_1e8731c681160cd1 );
        optional_params[ "nearest_tacpoint_to_center" ] = var_1e8731c681160cd1.nearest_tacpoint;
        bots_scripted_defense::protect_point( gameobjects_shared::get_origin( var_1e8731c681160cd1 ), get_flag_protect_radius(), optional_params );
    }
    
    thread monitor_flag_status( var_1e8731c681160cd1 );
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0x8f010074, Offset: 0x1d9c
// Size: 0x22
function get_flag_capture_radius()
{
    if ( !isdefined( level.capture_radius ) )
    {
        level.capture_radius = 158;
    }
    
    return level.capture_radius;
}

// Namespace bots_gametype_dom
// Params 0
// Checksum 0xbc84ea38, Offset: 0x1dc7
// Size: 0x87
function get_flag_protect_radius()
{
    if ( !isdefined( level.protect_radius ) )
    {
        worldbounds = getnavbounds();
        var_41e85416dd9b9a8d = worldbounds.halfsize[ 0 ] * 2;
        var_f2ab902bc98cc80 = worldbounds.halfsize[ 1 ] * 2;
        average_side = ( var_41e85416dd9b9a8d + var_f2ab902bc98cc80 ) / 2;
        level.protect_radius = min( 1000, average_side / 3.5 );
    }
    
    return level.protect_radius;
}

// Namespace bots_gametype_dom
// Params 2
// Checksum 0x4625c98b, Offset: 0x1e57
// Size: 0x1c5
function bot_dom_leader_dialog( dialog, location )
{
    if ( issubstr( dialog, "losing" ) && dialog != "losing_score" && dialog != "losing_time" && dialog != "gamestate_domlosing" )
    {
        var_286c3e4b0795e583 = getsubstr( dialog, dialog.size - 2 );
        flag_losing = get_specific_flag_by_label( var_286c3e4b0795e583 );
        assert( isdefined( flag_losing ), "<dev string:x11d>" + dialog + "<dev string:x139>" );
        
        if ( isdefined( flag_losing ) && bot_allow_to_capture_flag( flag_losing ) )
        {
            self botmemoryevent( "known_enemy", undefined, gameobjects_shared::get_origin( flag_losing ) );
            self function_529c3c83df97116d( location, 300 );
            
            if ( ( !isdefined( self.last_losing_flag_react ) || gettime() - self.last_losing_flag_react > 10000 ) && ( !isdefined( self.var_e7a00069434f0c69 ) || gettime() - self.var_e7a00069434f0c69 >= 1000 ) )
            {
                if ( bots_scripted_defense::is_protecting() )
                {
                    var_a6664d06852c1f1a = distancesquared( self.origin, gameobjects_shared::get_origin( flag_losing ) ) < 490000;
                    var_16ea89ed832566da = bot_is_protecting_flag( flag_losing );
                    
                    if ( var_a6664d06852c1f1a || var_16ea89ed832566da )
                    {
                        capture_flag( flag_losing );
                        self.last_losing_flag_react = gettime();
                    }
                }
            }
        }
    }
    else if ( issubstr( dialog, "secured" ) )
    {
        var_286c3e4b0795e583 = getsubstr( dialog, dialog.size - 2 );
        flag_taken = get_specific_flag_by_label( var_286c3e4b0795e583 );
        assert( isdefined( flag_taken ) );
        flag_taken.last_time_secured[ self.team ] = gettime();
    }
    
    bots_util_mp::bot_leader_dialog( dialog, location );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x4543cab3, Offset: 0x2024
// Size: 0x3f, Type: bool
function bot_allow_to_capture_flag( flag )
{
    override_targets = get_override_flag_targets();
    
    if ( !isdefined( override_targets ) || override_targets.size == 0 )
    {
        return true;
    }
    
    if ( arraycontains( override_targets, flag ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xce1ab07d, Offset: 0x206c
// Size: 0x421
function monitor_flag_status( flag )
{
    self notify( #"monitor_flag_status" );
    self endon( #"monitor_flag_status" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_bcbe26edd16dc517 = get_num_ally_flags( self.team );
    capture_radius_sq = get_flag_capture_radius() * get_flag_capture_radius();
    var_a20afd9974bfb133 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
    keep_monitoring = 1;
    
    while ( keep_monitoring )
    {
        needs_new_goal = 0;
        current_flag_team = flag dom::getflagteam();
        var_9e01cd5f8c1c37d2 = get_num_ally_flags( self.team );
        enemy_flags = get_enemy_flags( self.team );
        
        if ( bots_scripted_defense::is_capturing() )
        {
            if ( current_flag_team == self.team && !gameobjects_shared::function_7ed0697b0eea44f8( flag ) )
            {
                if ( !bot_dom_debug_should_capture_all() )
                {
                    needs_new_goal = 1;
                }
            }
            
            if ( var_9e01cd5f8c1c37d2 == 2 && current_flag_team != self.team && !bot_allowed_to_3_cap() )
            {
                if ( distancesquared( self.origin, gameobjects_shared::get_origin( flag ) ) > capture_radius_sq )
                {
                    needs_new_goal = 1;
                }
            }
            
            foreach ( enemy_flag in enemy_flags )
            {
                if ( enemy_flag != flag && bot_allow_to_capture_flag( enemy_flag ) )
                {
                    if ( distancesquared( self.origin, gameobjects_shared::get_origin( enemy_flag ) ) < var_a20afd9974bfb133 )
                    {
                        needs_new_goal = 1;
                    }
                }
            }
            
            hasusetime = gameobjects_shared::get_use_time_seconds( flag ) > 0;
            
            if ( gameobjects_common::function_8a27a916a385b65c( flag, self ) && !hasusetime )
            {
                if ( self bothasscriptgoal() )
                {
                    script_goal = self botgetscriptgoal();
                    script_goal_radius = self botgetscriptgoalradius();
                    
                    if ( distancesquared( self.origin, script_goal ) < squared( script_goal_radius ) )
                    {
                        nearest_tacpoint_bot = self getnearesttacpoint();
                        
                        if ( isdefined( nearest_tacpoint_bot ) )
                        {
                            seek_new_dest = undefined;
                            
                            foreach ( defend_tac in flag.tacpoints )
                            {
                                if ( !tacpointsvisible( defend_tac, nearest_tacpoint_bot, 1 ) )
                                {
                                    seek_new_dest = defend_tac.groundpos;
                                    break;
                                }
                            }
                            
                            if ( isdefined( seek_new_dest ) )
                            {
                                self.defense_investigate_specific_point = seek_new_dest;
                                self notify( #"defend_force_goal_recalculation" );
                            }
                        }
                    }
                }
            }
        }
        
        if ( bots_scripted_defense::is_protecting() )
        {
            if ( current_flag_team != self.team )
            {
                if ( !bot_dom_debug_should_protect_all() )
                {
                    needs_new_goal = 1;
                }
            }
            else if ( var_9e01cd5f8c1c37d2 == 1 && var_bcbe26edd16dc517 > 1 )
            {
                needs_new_goal = 1;
            }
            else if ( gameobjects_shared::function_7ed0697b0eea44f8( flag ) )
            {
                needs_new_goal = 1;
            }
        }
        
        var_bcbe26edd16dc517 = var_9e01cd5f8c1c37d2;
        
        if ( needs_new_goal )
        {
            self.force_new_goal = 1;
            keep_monitoring = 0;
            self notify( #"needs_new_flag_goal" );
            continue;
        }
        
        result = level utility::waittill_notify_or_timeout_return( "flag_changed_ownership", 1 + randomfloatrange( 0, 2 ) );
        var_1dd9d08548cc8a74 = result == "timeout";
        
        if ( !var_1dd9d08548cc8a74 )
        {
            assert( self.strategy_level <= 3 );
            wait_time = max( ( 3 - self.strategy_level ) * 1 + randomfloatrange( -0.5, 0.5 ), 0 );
            wait wait_time;
        }
    }
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xee1a9df8, Offset: 0x2495
// Size: 0x165
function function_32954fde1431a2a7( tacpoint )
{
    if ( tacpoint == self.var_ed2c61ea014d90ab )
    {
        return 1;
    }
    
    if ( !isdefined( self.current_flag ) )
    {
        return 1;
    }
    
    var_82c01dce214e294a = 0;
    var_dcf7d7c0376ce1b0 = get_flag_label( self.current_flag );
    ally_flags = get_ally_flags( self.team );
    
    foreach ( ally_flag in ally_flags )
    {
        if ( ally_flag != self.current_flag )
        {
            var_82c01dce214e294a = tacpoint bots_util_mp::function_6ed0ed07336b5fee( var_dcf7d7c0376ce1b0, get_flag_label( ally_flag ) );
            
            if ( var_82c01dce214e294a )
            {
                third_flag = get_other_flag( self.current_flag, ally_flag );
                third_flag_team = third_flag dom::getflagteam();
                
                if ( third_flag_team != self.team )
                {
                    if ( tacpoint bots_util_mp::function_6ed0ed07336b5fee( var_dcf7d7c0376ce1b0, get_flag_label( third_flag ) ) )
                    {
                        var_82c01dce214e294a = 0;
                    }
                }
            }
        }
    }
    
    if ( var_82c01dce214e294a )
    {
        return 0.2;
    }
    
    return 1;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x306250ad, Offset: 0x2603
// Size: 0x5a
function get_flag_label( flag )
{
    flag_label = "";
    
    if ( isdefined( flag.teleport_zone ) )
    {
        flag_label += flag.teleport_zone + "_";
    }
    
    flag_label += "flag" + flag.objectivekey;
    return flag_label;
}

// Namespace bots_gametype_dom
// Params 2
// Checksum 0xabd3c1e3, Offset: 0x2666
// Size: 0xac
function get_other_flag( flag1, flag2 )
{
    assert( level.objectives.size == 3 );
    
    foreach ( objective in level.objectives )
    {
        if ( objective != flag1 && objective != flag2 )
        {
            return objective;
        }
    }
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x2cf00929, Offset: 0x271a
// Size: 0x54
function get_specific_flag_by_letter( flag_letter )
{
    assert( flag_letter == "<dev string:x13b>" || flag_letter == "<dev string:x13d>" || flag_letter == "<dev string:x13f>" );
    flag_label = "_" + tolower( flag_letter );
    return get_specific_flag_by_label( flag_label );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x4469a75f, Offset: 0x2777
// Size: 0x90
function get_specific_flag_by_label( flag_label )
{
    foreach ( objective in level.objectives )
    {
        if ( objective.objectivekey == flag_label )
        {
            return objective;
        }
    }
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xc694e0f3, Offset: 0x280f
// Size: 0xc3
function get_closest_flag( origin )
{
    closest_flag = undefined;
    closest_flag_dist_sq = undefined;
    
    foreach ( objective in level.objectives )
    {
        var_8c37ace620ac520f = distancesquared( gameobjects_shared::get_origin( objective ), origin );
        
        if ( !isdefined( closest_flag_dist_sq ) || var_8c37ace620ac520f < closest_flag_dist_sq )
        {
            closest_flag = objective;
            closest_flag_dist_sq = var_8c37ace620ac520f;
        }
    }
    
    return closest_flag;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x12893104, Offset: 0x28db
// Size: 0xc3
function get_farthest_flag( origin )
{
    farthest_flag = undefined;
    var_ba9668e7b4d812d6 = undefined;
    
    foreach ( objective in level.objectives )
    {
        var_8c37ace620ac520f = distancesquared( gameobjects_shared::get_origin( objective ), origin );
        
        if ( !isdefined( var_ba9668e7b4d812d6 ) || var_8c37ace620ac520f > var_ba9668e7b4d812d6 )
        {
            farthest_flag = objective;
            var_ba9668e7b4d812d6 = var_8c37ace620ac520f;
        }
    }
    
    return farthest_flag;
}

// Namespace bots_gametype_dom
// Params 2
// Checksum 0x4fbe67a8, Offset: 0x29a7
// Size: 0xff
function get_num_allies_capturing_flag( flag, ignore_humans )
{
    num_capturing_flag = 0;
    
    foreach ( other_player in level.participants )
    {
        if ( !isdefined( other_player.team ) )
        {
            continue;
        }
        
        if ( other_player.team == self.team && other_player != self && game_utility_common::isteamparticipant( other_player ) )
        {
            if ( isai( other_player ) )
            {
                if ( other_player bot_is_capturing_flag( flag ) )
                {
                    num_capturing_flag++;
                }
                
                continue;
            }
            
            if ( !ignore_humans )
            {
                if ( other_player istouching( flag ) )
                {
                    num_capturing_flag++;
                }
            }
        }
    }
    
    return num_capturing_flag;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xef20373f, Offset: 0x2aaf
// Size: 0x20
function bot_is_capturing_flag( flag )
{
    if ( !bots_scripted_defense::is_capturing() )
    {
        return 0;
    }
    
    return bot_target_is_flag( flag );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0xeda6c67a, Offset: 0x2ad8
// Size: 0x20
function bot_is_protecting_flag( flag )
{
    if ( !bots_scripted_defense::is_protecting() )
    {
        return 0;
    }
    
    return bot_target_is_flag( flag );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x10b10784, Offset: 0x2b01
// Size: 0x18, Type: bool
function bot_target_is_flag( flag )
{
    return self.current_flag == flag;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x259a9932, Offset: 0x2b22
// Size: 0xa5
function get_num_ally_flags( team )
{
    count = 0;
    
    foreach ( objective in level.objectives )
    {
        flag_team = objective dom::getflagteam();
        
        if ( flag_team == team )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x27d2c569, Offset: 0x2bd0
// Size: 0xb0
function get_enemy_flags( team )
{
    flags = [];
    
    foreach ( objective in level.objectives )
    {
        flag_team = objective dom::getflagteam();
        
        if ( flag_team == utility::get_enemy_team( team ) )
        {
            flags[ flags.size ] = objective;
        }
    }
    
    return flags;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x747db5bd, Offset: 0x2c89
// Size: 0xa9
function get_ally_flags( team )
{
    flags = [];
    
    foreach ( objective in level.objectives )
    {
        flag_team = objective dom::getflagteam();
        
        if ( flag_team == team )
        {
            flags[ flags.size ] = objective;
        }
    }
    
    return flags;
}

// Namespace bots_gametype_dom
// Params 2
// Checksum 0x373dae1f, Offset: 0x2d3b
// Size: 0x41, Type: bool
function bot_should_defend_flag( potential_flag, num_flags_defending )
{
    var_aa1453588f5fea75 = get_max_num_defenders_wanted_per_flag( num_flags_defending );
    players_defending_flag = get_players_defending_flag( potential_flag );
    return players_defending_flag.size < var_aa1453588f5fea75;
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x60a942e9, Offset: 0x2d85
// Size: 0x46
function get_max_num_defenders_wanted_per_flag( num_flags_defending )
{
    team_limit = bots_util_mp::bot_get_max_players_on_team( self.team );
    
    if ( num_flags_defending == 1 )
    {
        return ceil( team_limit / 6 );
    }
    
    return ceil( team_limit / 3 );
}

// Namespace bots_gametype_dom
// Params 1
// Checksum 0x55198275, Offset: 0x2dd3
// Size: 0x166
function get_players_defending_flag( potential_flag )
{
    flag_protect_radius = get_flag_protect_radius();
    bots_defending = [];
    
    foreach ( other_player in level.participants )
    {
        if ( !isdefined( other_player.team ) )
        {
            continue;
        }
        
        if ( other_player.team == self.team && other_player != self && game_utility_common::isteamparticipant( other_player ) )
        {
            if ( isai( other_player ) )
            {
                if ( other_player bot_is_protecting_flag( potential_flag ) )
                {
                    bots_defending[ bots_defending.size ] = other_player;
                }
                
                continue;
            }
            
            var_7df29630ac56eef1 = gettime() - potential_flag.last_time_secured[ self.team ];
            
            if ( var_7df29630ac56eef1 < 10000 )
            {
                continue;
            }
            
            /#
                if ( other_player isufo() || other_player isnoclip() )
                {
                    continue;
                }
            #/
            
            if ( distancesquared( gameobjects_shared::get_origin( potential_flag ), other_player.origin ) < flag_protect_radius * flag_protect_radius )
            {
                bots_defending[ bots_defending.size ] = other_player;
            }
        }
    }
    
    return bots_defending;
}

