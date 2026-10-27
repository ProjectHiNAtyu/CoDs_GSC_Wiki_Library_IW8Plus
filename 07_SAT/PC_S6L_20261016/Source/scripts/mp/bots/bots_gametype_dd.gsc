// scripts\mp\bots\bots_gametype_dd.gsc  (hash_2edb9a86730eee9d.gscc) (size: 10217 Bytes / 0x27e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d35ab72 (1832233842)
// size ...... 10217 (0x27e9)
// includes .. 7   (offset: 0x25b5)
// strings ... 31  (offset: 0x25ed)
// dev strs .. 0   (offset: 0x27e9)
// exports ... 27  (offset: 0x1939)
// cseg ...... 0x245 + 0x16f4 (0x1939)
// imports ... 64  (offset: 0x1d71)
// animtree1 . 0   (offset: 0x27e9)
// animtree2 . 0   (offset: 0x27e9)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\utility\game;
#using scripts\mp\gamelogic;

#namespace bots_gametype_dd;

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x2a4ce2a, Offset: 0x263
// Size: 0x10
function main()
{
    setup_callbacks();
    bot_dd_start();
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x59a10c2, Offset: 0x27b
// Size: 0x48
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_dd_think;
    level.bot_funcs[ "notify_enemy_bots_bomb_used" ] = &notify_enemy_team_bomb_used;
    autopilot::initialize( undefined, undefined, [ "bot_dd_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x377c1277, Offset: 0x2cb
// Size: 0x13
function bot_dd_start()
{
    /#
        thread bots_gametype_common::function_542131a1e15d65d6();
    #/
    
    setup_bot_dd();
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x33109c6, Offset: 0x2e6
// Size: 0xc3
function setup_bot_dd()
{
    bots_gametype_common::function_fe1f636ad76a5211();
    bots_util::bot_waittill_bots_enabled();
    succeeded = bots_gametype_common::bot_verify_and_cache_bombzones( [ "_a", "_b" ] );
    
    if ( succeeded )
    {
        foreach ( bombzone in level.objectives )
        {
            bombzone thread bots_gametype_common::monitor_bombzone_control();
        }
        
        thread bot_dd_ai_director_update();
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xd92cb09c, Offset: 0x3b1
// Size: 0x38c
function bot_dd_think()
{
    self notify( #"bot_dd_think" );
    self endon( #"bot_dd_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "grenade_objectives", 1 );
    self.current_bombzone = undefined;
    self.defuser_bad_path_counter = 0;
    
    for ( ;; )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 0.05;
        
        if ( isdefined( self.current_bombzone ) && !bombzone_is_active( self.current_bombzone ) )
        {
            self.current_bombzone = undefined;
            bot_dd_clear_role();
        }
        
        if ( game_utility_mp::inovertime() )
        {
            assert( level.objectives.size == 1 );
            is_attacker = level.objectives[ "_a" ].ownerteam != self.team;
        }
        else
        {
            is_attacker = self.team == game[ "attackers" ];
        }
        
        if ( is_attacker )
        {
            bot_pick_new_zone( "attack" );
            
            if ( !isdefined( self.current_bombzone ) )
            {
                continue;
            }
            
            bot_try_switch_attack_zone();
            bot_choose_attack_role();
            
            if ( self.role == "sweep_zone" )
            {
                if ( !bots_scripted_defense::is_defending_point( self.current_bombzone.curorigin ) )
                {
                    optional_params[ "min_goal_time" ] = 2;
                    optional_params[ "max_goal_time" ] = 4;
                    optional_params[ "override_origin_tacpoint" ] = utility::array_random( self.current_bombzone.tacpoints );
                    bots_scripted_defense::protect_point( self.current_bombzone.curorigin, level.protect_radius, optional_params );
                }
            }
            else if ( self.role == "defend_zone" )
            {
                if ( !bots_scripted_defense::is_defending_point( level.ddbombmodel[ self.current_bombzone.objectivekey ].origin ) )
                {
                    optional_params[ "score_flags" ] = "strongly_avoid_center";
                    bots_scripted_defense::protect_point( level.ddbombmodel[ self.current_bombzone.objectivekey ].origin, level.protect_radius, optional_params );
                }
            }
            else if ( self.role == "investigate_someone_using_bomb" )
            {
                investigate_someone_using_bomb();
            }
            else if ( self.role == "atk_bomber" )
            {
                plant_bomb();
            }
            
            continue;
        }
        
        bot_pick_new_zone( "defend" );
        
        if ( !isdefined( self.current_bombzone ) )
        {
            continue;
        }
        
        bot_choose_defend_role();
        
        if ( self.role == "defend_zone" )
        {
            if ( !bots_scripted_defense::is_defending_point( self.current_bombzone.curorigin ) )
            {
                optional_params[ "score_flags" ] = "strict_los";
                optional_params[ "override_origin_tacpoint" ] = utility::array_random( self.current_bombzone.tacpoints );
                bots_scripted_defense::protect_point( self.current_bombzone.curorigin, level.protect_radius, optional_params );
            }
            
            continue;
        }
        
        if ( self.role == "investigate_someone_using_bomb" )
        {
            investigate_someone_using_bomb();
            continue;
        }
        
        if ( self.role == "defuser" )
        {
            defuse_bomb();
        }
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0xa1061a74, Offset: 0x745
// Size: 0xb7
function notify_enemy_team_bomb_used( type )
{
    var_8ec89991bdc8412 = bots_gametype_common::find_closest_bombzone_to_player( self );
    players = bots_gametype_common::get_ai_hearing_bomb_plant_sound( type );
    
    foreach ( player in players )
    {
        if ( var_8ec89991bdc8412 == player.current_bombzone )
        {
            player bot_dd_set_role( "investigate_someone_using_bomb" );
        }
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x8040dd11, Offset: 0x804
// Size: 0x107
function plant_bomb()
{
    self endon( #"change_role" );
    assert( isdefined( self.current_bombzone ) );
    var_8c91f76f96080f7f = bots_gametype_common::function_932ed5184bc553f2( self.current_bombzone, 0 );
    self botsetscriptgoal( var_8c91f76f96080f7f, 0, "critical" );
    pathresult = bots_util::bot_waittill_goal_or_fail( undefined, "change_role" );
    
    if ( pathresult == "goal" )
    {
        time_left = gamelogic_mp::gettimeremaining();
        var_59b724c2a68d0a75 = time_left - level.planttime * 2 * 1000;
        var_9c5d2bb9487a212f = gettime() + var_59b724c2a68d0a75;
        
        if ( var_59b724c2a68d0a75 > 0 )
        {
            bots_util::bot_waittill_out_of_combat_or_time( var_59b724c2a68d0a75 );
        }
        
        emergency_plant = var_9c5d2bb9487a212f > 0 && gettime() >= var_9c5d2bb9487a212f;
        succeeded = bots_gametype_common::bombzone_press_use( level.planttime + 2, "bomb_planted", emergency_plant );
        self botclearscriptgoal();
        
        if ( succeeded )
        {
            bot_dd_clear_role();
        }
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x9ee80624, Offset: 0x913
// Size: 0x239
function defuse_bomb()
{
    self endon( #"change_role" );
    self botsetpathingstyle( "scripted" );
    assert( isdefined( self.current_bombzone ) );
    defuse_target_origin = bots_gametype_common::function_b31545b4843bdcf1( self.current_bombzone ).origin;
    self botsetscriptgoal( defuse_target_origin, 20, "critical" );
    pathresult = bots_util::bot_waittill_goal_or_fail( undefined, "change_role" );
    
    if ( pathresult == "bad_path" )
    {
        self.defuser_bad_path_counter++;
        
        if ( self.defuser_bad_path_counter >= 4 )
        {
            while ( true )
            {
                nodes = getnodesinradiussorted( defuse_target_origin, 50, 0 );
                potential_index = self.defuser_bad_path_counter - 4;
                
                if ( nodes.size <= potential_index )
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
                    self botsetscriptgoal( nodes[ potential_index ].origin, 20, "critical" );
                }
                
                pathresult = bots_util::bot_waittill_goal_or_fail( undefined, "change_role" );
                
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
        time_passed = gettime() - self.current_bombzone.startbombtime;
        time_left = level.bombtimer * 1000 - time_passed;
        var_6c4e2a2d4bfead6e = time_left - level.defusetime * 2 * 1000;
        var_ed305e455b26c778 = gettime() + var_6c4e2a2d4bfead6e;
        
        if ( var_6c4e2a2d4bfead6e > 0 )
        {
            bots_util::bot_waittill_out_of_combat_or_time( var_6c4e2a2d4bfead6e );
        }
        
        emergency_defuse = var_ed305e455b26c778 > 0 && gettime() >= var_ed305e455b26c778;
        succeeded = bots_gametype_common::bombzone_press_use( level.defusetime + 2, "bomb_defused", emergency_defuse );
        
        if ( !succeeded && self.defuser_bad_path_counter >= 4 )
        {
            self.defuser_bad_path_counter++;
        }
        
        self botclearscriptgoal();
        
        if ( succeeded )
        {
            bot_dd_clear_role();
        }
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x277afd13, Offset: 0xb54
// Size: 0x6a
function investigate_someone_using_bomb()
{
    self endon( #"change_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    self botsetscriptgoal( utility::array_random( self.current_bombzone.tacpoints ), 0, "critical" );
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        wait 2;
        bot_dd_clear_role();
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0x51f8fef7, Offset: 0xbc6
// Size: 0x12a
function get_player_defusing_zone( zone )
{
    players_defending_zone = get_players_at_zone( zone, self.team );
    
    foreach ( player in players_defending_zone )
    {
        if ( !isai( player ) )
        {
            if ( player.isdefusing )
            {
                return player;
            }
        }
    }
    
    foreach ( player in players_defending_zone )
    {
        if ( isai( player ) )
        {
            if ( player.role == "defuser" )
            {
                return player;
            }
        }
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0xaf4e60a8, Offset: 0xcf9
// Size: 0x12a
function get_player_planting_zone( zone )
{
    players_attacking_zone = get_players_at_zone( zone, self.team );
    
    foreach ( player in players_attacking_zone )
    {
        if ( !isai( player ) )
        {
            if ( player.isplanting )
            {
                return player;
            }
        }
    }
    
    foreach ( player in players_attacking_zone )
    {
        if ( isai( player ) )
        {
            if ( player.role == "atk_bomber" )
            {
                return player;
            }
        }
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0xc0b0743a, Offset: 0xe2c
// Size: 0x24, Type: bool
function bombzone_is_active( zone )
{
    if ( zone.visibleteam == "any" )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xda09becf, Offset: 0xe59
// Size: 0x91
function get_active_bombzones()
{
    active_bombzones = [];
    
    foreach ( zone in level.objectives )
    {
        if ( bombzone_is_active( zone ) )
        {
            active_bombzones[ active_bombzones.size ] = zone;
        }
    }
    
    return active_bombzones;
}

// Namespace bots_gametype_dd
// Params 2
// Checksum 0x4545a0dc, Offset: 0xef3
// Size: 0xf9
function get_players_at_zone( zone, team )
{
    var_3c84c39e151ea26e = [];
    var_fc1cc539da24b8e1 = bots_gametype_common::get_living_players_on_team( team );
    
    foreach ( player in var_fc1cc539da24b8e1 )
    {
        if ( isai( player ) )
        {
            if ( player.current_bombzone == zone )
            {
                var_3c84c39e151ea26e[ var_3c84c39e151ea26e.size ] = player;
            }
            
            continue;
        }
        
        if ( distancesquared( player.origin, zone.curorigin ) < level.protect_radius * level.protect_radius )
        {
            var_3c84c39e151ea26e[ var_3c84c39e151ea26e.size ] = player;
        }
    }
    
    return var_3c84c39e151ea26e;
}

// Namespace bots_gametype_dd
// Params 2
// Checksum 0xb80e075a, Offset: 0xff5
// Size: 0x81
function bot_pick_dd_zone_with_fewer_defenders( zones, difference )
{
    assert( zones.size == 2 );
    num_at_zone[ 0 ] = get_players_at_zone( zones[ 0 ], game[ "defenders" ] ).size;
    num_at_zone[ 1 ] = get_players_at_zone( zones[ 1 ], game[ "defenders" ] ).size;
    
    if ( num_at_zone[ 0 ] > num_at_zone[ 1 ] + difference )
    {
        return zones[ 1 ];
    }
    
    if ( num_at_zone[ 0 ] + difference < num_at_zone[ 1 ] )
    {
        return zones[ 0 ];
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0x5e48a977, Offset: 0x107e
// Size: 0x6a
function bot_pick_new_zone( type )
{
    new_zone = undefined;
    
    if ( type == "attack" )
    {
        new_zone = bot_choose_attack_zone();
    }
    else if ( type == "defend" )
    {
        new_zone = bot_choose_defend_zone();
    }
    
    if ( isdefined( new_zone ) && self.current_bombzone != new_zone )
    {
        self.current_bombzone = new_zone;
        bot_dd_clear_role();
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xb675a147, Offset: 0x10f0
// Size: 0x19f
function bot_choose_defend_zone()
{
    active_bombzones = get_active_bombzones();
    zone_wanted = undefined;
    
    if ( active_bombzones.size == 1 )
    {
        zone_wanted = active_bombzones[ 0 ];
    }
    else if ( active_bombzones.size == 2 )
    {
        num_at_zone[ 0 ] = get_players_at_zone( active_bombzones[ 0 ], game[ "defenders" ] ).size;
        num_at_zone[ 1 ] = get_players_at_zone( active_bombzones[ 1 ], game[ "defenders" ] ).size;
        bomb_planted_on[ 0 ] = is_bomb_planted_on( active_bombzones[ 0 ] );
        bomb_planted_on[ 1 ] = is_bomb_planted_on( active_bombzones[ 1 ] );
        
        if ( bomb_planted_on[ 0 ] && bomb_planted_on[ 1 ] || !bomb_planted_on[ 0 ] && !bomb_planted_on[ 1 ] )
        {
            difference = 0;
            
            if ( isdefined( self.current_bombzone ) )
            {
                difference = 1;
            }
            
            zone_wanted = bot_pick_dd_zone_with_fewer_defenders( active_bombzones, difference );
            
            if ( !isdefined( zone_wanted ) && !isdefined( self.current_bombzone ) )
            {
                zone_wanted = utility::array_random( active_bombzones );
            }
        }
        else if ( bomb_planted_on[ 0 ] || bomb_planted_on[ 1 ] )
        {
            bomb_planted_on_index = bomb_planted_on[ 0 ] ? 0 : 1;
            var_be5797dd46a83456 = !bomb_planted_on[ 0 ] ? 0 : 1;
            
            if ( num_at_zone[ bomb_planted_on_index ] > num_at_zone[ var_be5797dd46a83456 ] + 2 )
            {
                zone_wanted = active_bombzones[ var_be5797dd46a83456 ];
            }
            else if ( num_at_zone[ bomb_planted_on_index ] <= num_at_zone[ var_be5797dd46a83456 ] )
            {
                zone_wanted = active_bombzones[ bomb_planted_on_index ];
            }
            else if ( !isdefined( self.current_bombzone ) )
            {
                if ( num_at_zone[ bomb_planted_on_index ] >= num_at_zone[ var_be5797dd46a83456 ] + 2 )
                {
                    zone_wanted = active_bombzones[ var_be5797dd46a83456 ];
                }
                else if ( num_at_zone[ bomb_planted_on_index ] < num_at_zone[ var_be5797dd46a83456 ] + 2 )
                {
                    zone_wanted = active_bombzones[ bomb_planted_on_index ];
                }
            }
        }
    }
    
    return zone_wanted;
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0xfd9745f8, Offset: 0x1298
// Size: 0x9d
function get_other_active_zone( test_zone )
{
    active_zones = get_active_bombzones();
    assert( active_zones.size <= 2 );
    
    foreach ( zone in active_zones )
    {
        if ( zone != test_zone )
        {
            return zone;
        }
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xadb393c3, Offset: 0x133d
// Size: 0xd0
function bot_choose_attack_zone()
{
    if ( isdefined( self.current_bombzone ) )
    {
        return;
    }
    
    if ( !isdefined( level.current_zone_target ) || !bombzone_is_active( level.current_zone_target ) || gettime() > level.next_target_switch_time )
    {
        level.next_target_switch_time = gettime() + 1000 * randomintrange( 30, 45 );
        level.current_zone_target = utility::array_random( get_active_bombzones() );
    }
    
    if ( !isdefined( level.current_zone_target ) )
    {
        return;
    }
    
    target_zone = level.current_zone_target;
    nontarget_zone = get_other_active_zone( target_zone );
    self.current_bombzone = undefined;
    
    if ( isdefined( nontarget_zone ) )
    {
        if ( randomfloat( 1 ) < 0.25 )
        {
            return nontarget_zone;
        }
    }
    
    return target_zone;
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x1f129358, Offset: 0x1416
// Size: 0x99
function bot_try_switch_attack_zone()
{
    assert( isdefined( self.current_bombzone ) );
    other_zone = get_other_active_zone( self.current_bombzone );
    
    if ( isdefined( other_zone ) )
    {
        dist_to_target = distance( self.origin, self.current_bombzone.curorigin );
        var_dace1e1d63e0dc82 = distance( self.origin, other_zone.curorigin );
        
        if ( var_dace1e1d63e0dc82 < dist_to_target * 0.6 )
        {
            self.current_bombzone = other_zone;
        }
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x136dda32, Offset: 0x14b7
// Size: 0x120
function bot_choose_attack_role()
{
    assert( isdefined( self.current_bombzone ) );
    
    if ( isdefined( self.role ) )
    {
        if ( self.role == "investigate_someone_using_bomb" )
        {
            return;
        }
    }
    
    new_role = undefined;
    
    if ( is_bomb_planted_on( self.current_bombzone ) )
    {
        new_role = "defend_zone";
    }
    else
    {
        current_bomber = get_player_planting_zone( self.current_bombzone );
        
        if ( !isdefined( current_bomber ) || current_bomber == self )
        {
            new_role = "atk_bomber";
        }
        else if ( isai( current_bomber ) )
        {
            var_c9dc974fc0633c77 = distance( self.origin, self.current_bombzone.curorigin );
            var_876e8715da72b544 = distance( current_bomber.origin, self.current_bombzone.curorigin );
            
            if ( var_c9dc974fc0633c77 < var_876e8715da72b544 * 0.9 )
            {
                new_role = "atk_bomber";
                current_bomber bot_dd_clear_role();
            }
        }
    }
    
    if ( !isdefined( new_role ) )
    {
        new_role = "sweep_zone";
    }
    
    bot_dd_set_role( new_role );
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xff519e7a, Offset: 0x15df
// Size: 0x116
function bot_choose_defend_role()
{
    assert( isdefined( self.current_bombzone ) );
    
    if ( isdefined( self.role ) )
    {
        if ( self.role == "investigate_someone_using_bomb" )
        {
            return;
        }
    }
    
    new_role = undefined;
    
    if ( is_bomb_planted_on( self.current_bombzone ) )
    {
        current_defuser = get_player_defusing_zone( self.current_bombzone );
        
        if ( !isdefined( current_defuser ) || current_defuser == self )
        {
            new_role = "defuser";
        }
        else if ( isai( current_defuser ) )
        {
            var_c9dc974fc0633c77 = distance( self.origin, self.current_bombzone.curorigin );
            var_959c944cc0a59f35 = distance( current_defuser.origin, self.current_bombzone.curorigin );
            
            if ( var_c9dc974fc0633c77 < var_959c944cc0a59f35 * 0.9 )
            {
                new_role = "defuser";
                current_defuser bot_dd_clear_role();
            }
        }
    }
    
    if ( !isdefined( new_role ) )
    {
        new_role = "defend_zone";
    }
    
    bot_dd_set_role( new_role );
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0x3da431f4, Offset: 0x16fd
// Size: 0x2d
function bot_dd_set_role( new_role )
{
    if ( self.role != new_role )
    {
        bot_dd_clear_role();
        self.role = new_role;
    }
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0x2b6f324c, Offset: 0x1732
// Size: 0x36
function bot_dd_clear_role()
{
    self.role = undefined;
    self botclearscriptgoal();
    self botsetpathingstyle( undefined );
    bots_scripted_defense::function_87e8deae08ce1a0();
    self notify( #"change_role" );
    self.defuser_bad_path_counter = 0;
}

// Namespace bots_gametype_dd
// Params 0
// Checksum 0xe63fcd5d, Offset: 0x1770
// Size: 0x1a8
function bot_dd_ai_director_update()
{
    level notify( #"bot_dd_ai_director_update" );
    level endon( #"bot_dd_ai_director_update" );
    level endon( #"game_ended" );
    level.protect_radius = 725;
    
    while ( true )
    {
        foreach ( zone in level.objectives )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player.role ) && player.current_bombzone == zone )
                {
                    if ( !bombzone_is_active( zone ) )
                    {
                        if ( player.role == "atk_bomber" || player.role == "defuser" )
                        {
                            player bot_dd_clear_role();
                        }
                        
                        continue;
                    }
                    
                    if ( is_bomb_planted_on( zone ) )
                    {
                        if ( player.role == "atk_bomber" )
                        {
                            player bot_dd_clear_role();
                        }
                    }
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace bots_gametype_dd
// Params 1
// Checksum 0x94b2efda, Offset: 0x1920
// Size: 0x18, Type: bool
function is_bomb_planted_on( zone )
{
    return istrue( zone.bombplanted );
}

