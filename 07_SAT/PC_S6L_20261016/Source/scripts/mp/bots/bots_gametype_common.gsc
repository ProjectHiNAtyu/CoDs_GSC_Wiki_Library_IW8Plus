// scripts\mp\bots\bots_gametype_common.gsc  (hash_7f989e71b934c9fc.gscc) (size: 19192 Bytes / 0x4af8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd565d72 (3444989298)
// size ...... 19192 (0x4af8)
// includes .. 12  (offset: 0x47dc)
// strings ... 24  (offset: 0x483c)
// dev strs .. 23  (offset: 0x49d4)
// exports ... 41  (offset: 0x334c)
// cseg ...... 0x1c0 + 0x318c (0x334c)
// imports ... 107 (offset: 0x39b4)
// animtree1 . 0   (offset: 0x4af8)
// animtree2 . 0   (offset: 0x4af8)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\trigger_group;
#using scripts\common\utility;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gameobjects;

#namespace bots_gametype_common;

// Namespace bots_gametype_common
// Params 0
// Checksum 0x4db21aac, Offset: 0x1de
// Size: 0x188
function bot_cache_entrances_to_bombzones()
{
    assert( isdefined( level.objectives ) );
    entrance_origin_points = [];
    entrance_labels = [];
    index = 0;
    
    foreach ( zone in level.objectives )
    {
        assert( isdefined( zone.tacpoints ), "<dev string:x24>" );
        
        if ( isdefined( zone.tacpoints ) )
        {
            if ( zone.tacpoints.size > 0 )
            {
                if ( isent( zone ) && zone.trigger islinked() )
                {
                }
                else if ( isdefined( zone.objectivekey ) )
                {
                    entrance_origin_points[ index ] = utility::array_random( zone.tacpoints ).origin;
                    entrance_labels[ index ] = "zone" + zone.objectivekey;
                    index++;
                }
                else
                {
                    assert( zone.objectivekey, "<dev string:x79>" );
                }
                
                continue;
            }
            
            assert( zone.tacpoints.size > 0, "<dev string:xd1>" );
        }
    }
    
    bot_cache_entrances( entrance_origin_points, entrance_labels );
}

// Namespace bots_gametype_common
// Params 3
// Checksum 0xf4953677, Offset: 0x36e
// Size: 0x1d4
function bot_cache_entrances_to_gametype_array( array, label_prefix, calculate_paths )
{
    assert( isdefined( array ) );
    
    if ( game_utility::gettimepassed() < 5000 )
    {
        wait 1;
    }
    
    entrance_origin_points = [];
    entrance_labels = [];
    int_array_index = 0;
    
    foreach ( gameobject in array )
    {
        gameobject_origin = gameobjects_shared::get_origin( gameobject );
        gameobject.nearest_tacpoint = findclosesttacpointinsight( gameobject_origin );
        
        if ( !isdefined( gameobject.nearest_tacpoint ) )
        {
            tacpoints = function_7801d05a86b06144( gameobject_origin, 256, 0 );
            
            if ( tacpoints.size > 0 )
            {
                gameobject.nearest_tacpoint = tacpoints[ 0 ];
            }
        }
        
        if ( !isdefined( gameobject.nearest_tacpoint ) )
        {
            assertmsg( "<dev string:x129>" + gameobject_origin );
            continue;
        }
        
        if ( distance( gameobject.nearest_tacpoint.groundpos, gameobject_origin ) > 200 )
        {
            assertmsg( "<dev string:x168>" + gameobject_origin + "<dev string:x180>" + gameobject.nearest_tacpoint.groundpos );
            gameobject.nearest_tacpoint = undefined;
            continue;
        }
        
        entrance_origin_points[ int_array_index ] = gameobject.nearest_tacpoint;
        entrance_labels[ int_array_index ] = label_prefix + gameobject.objectivekey;
        int_array_index++;
    }
    
    bot_cache_entrances( entrance_origin_points, entrance_labels, calculate_paths );
}

// Namespace bots_gametype_common
// Params 3
// Checksum 0x520929b3, Offset: 0x54a
// Size: 0x3ee
function bot_cache_entrances( var_c16428779cb8c6b1, label_array, calculate_paths )
{
    assert( isdefined( var_c16428779cb8c6b1 ) );
    assert( isdefined( label_array ) );
    assert( var_c16428779cb8c6b1.size > 0 );
    assert( label_array.size > 0 );
    assert( var_c16428779cb8c6b1.size == label_array.size );
    wait 0.1;
    entrance_points = [];
    
    for ( i = 0; i < var_c16428779cb8c6b1.size ; i++ )
    {
        index = label_array[ i ];
        entrance_points[ index ] = findentrances( var_c16428779cb8c6b1[ i ] );
        waitframe();
        var_b0690a29ad0cb53e = 0;
        var_34b988fb9233948c = 1;
        
        if ( game_utility::gettimepassed() >= 5000 )
        {
            var_34b988fb9233948c = 4;
        }
        
        for ( j = 0; j < entrance_points[ index ].size ; j++ )
        {
            entrance = entrance_points[ index ][ j ];
            entrance.is_precalculated_entrance = 1;
            origin_i = function_584300b677a80dc( var_c16428779cb8c6b1[ i ] );
            entrance.prone_visible_from[ index ] = bots_util_mp::entrance_visible_from( entrance.origin, origin_i, "prone" );
            var_b0690a29ad0cb53e++;
            
            if ( var_b0690a29ad0cb53e >= var_34b988fb9233948c )
            {
                var_b0690a29ad0cb53e = 0;
                waitframe();
            }
            
            entrance.crouch_visible_from[ index ] = bots_util_mp::entrance_visible_from( entrance.origin, origin_i, "crouch" );
            var_b0690a29ad0cb53e++;
            
            if ( var_b0690a29ad0cb53e >= var_34b988fb9233948c )
            {
                var_b0690a29ad0cb53e = 0;
                waitframe();
            }
        }
    }
    
    /#
        precalculated_paths = [];
    #/
    
    if ( calculate_paths )
    {
        for ( i = 0; i < var_c16428779cb8c6b1.size ; i++ )
        {
            for ( j = i + 1; j < var_c16428779cb8c6b1.size ; j++ )
            {
                tacpoints_on_path = undefined;
                
                if ( var_c16428779cb8c6b1[ i ].navzoneindex != -1 && var_c16428779cb8c6b1[ j ].navzoneindex != -1 )
                {
                    tacpoints_on_path = function_e07d46c4837d64f2( var_c16428779cb8c6b1[ i ], var_c16428779cb8c6b1[ j ] );
                    assert( isdefined( tacpoints_on_path ), "<dev string:x1bb>" + label_array[ i ] + "<dev string:x1d8>" + function_584300b677a80dc( var_c16428779cb8c6b1[ i ] ) + "<dev string:x1da>" + label_array[ j ] + "<dev string:x1d8>" + function_584300b677a80dc( var_c16428779cb8c6b1[ j ] ) + "<dev string:x1df>" );
                }
                
                if ( !isdefined( tacpoints_on_path ) )
                {
                    continue;
                }
                
                /#
                    precalculated_paths[ label_array[ i ] ][ label_array[ j ] ] = tacpoints_on_path;
                    precalculated_paths[ label_array[ j ] ][ label_array[ i ] ] = tacpoints_on_path;
                #/
                
                foreach ( tacpoint in tacpoints_on_path )
                {
                    tacpoint.on_path_from[ label_array[ i ] ][ label_array[ j ] ] = 1;
                }
                
                waitframe();
            }
        }
    }
    
    /#
        if ( calculate_paths )
        {
            if ( !isdefined( level.precalculated_paths ) )
            {
                level.precalculated_paths = [];
            }
        }
    #/
    
    if ( !isdefined( level.entrance_origin_points ) )
    {
        level.entrance_origin_points = [];
    }
    
    if ( !isdefined( level.entrance_indices ) )
    {
        level.entrance_indices = [];
    }
    
    if ( !isdefined( level.entrance_points ) )
    {
        level.entrance_points = [];
    }
    
    /#
        if ( calculate_paths )
        {
            level.precalculated_paths = function_c6c06162c8e6ae75( level.precalculated_paths, precalculated_paths );
        }
    #/
    
    origin_array = [];
    
    for ( i = 0; i < var_c16428779cb8c6b1.size ; i++ )
    {
        origin_array[ i ] = function_584300b677a80dc( var_c16428779cb8c6b1[ i ] );
    }
    
    level.entrance_origin_points = arraycombine( level.entrance_origin_points, origin_array );
    level.entrance_indices = arraycombine( level.entrance_indices, label_array );
    level.entrance_points = function_c6c06162c8e6ae75( level.entrance_points, entrance_points );
    level.entrance_points_finished_caching = 1;
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0xa42ecaaf, Offset: 0x940
// Size: 0x35
function function_584300b677a80dc( origin_element )
{
    if ( istacpoint( origin_element ) )
    {
        return origin_element.groundpos;
    }
    
    assert( isvector( origin_element ) );
    return origin_element;
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0xf3b17af3, Offset: 0x97d
// Size: 0x134
function function_e07d46c4837d64f2( tacpoint1, tacpoint2 )
{
    assert( istacpoint( tacpoint1 ) );
    assert( tacpoint1.navzoneindex != -1 );
    assert( istacpoint( tacpoint2 ) );
    assert( tacpoint2.navzoneindex != -1 );
    var_1d31f8e492076053 = getzonenodeforzoneindex( tacpoint1.navzoneindex );
    var_1d31f9e492076286 = getzonenodeforzoneindex( tacpoint2.navzoneindex );
    zonepath = getnodesonpath( var_1d31f8e492076053, var_1d31f9e492076286 );
    var_9ea43b12d0f201ef = [];
    
    foreach ( zonenode in zonepath )
    {
        var_b1da9de59d1e83c8 = getzonetacpoints( getzoneindexforzonenode( zonenode ) );
        var_9ea43b12d0f201ef = arraycombine( var_9ea43b12d0f201ef, var_b1da9de59d1e83c8 );
        waitframe();
    }
    
    return var_9ea43b12d0f201ef;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x2070f7b7, Offset: 0xaba
// Size: 0xa7
function function_fe1f636ad76a5211()
{
    wait 1;
    
    foreach ( objective in level.objectives )
    {
        if ( !isdefined( objective.tacpoints ) )
        {
            objective.tacpoints = function_3491b57e9cace1d5( objective, 1 );
        }
    }
    
    level.var_3cea2151bc5f621b = 1;
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0xdc2700a5, Offset: 0xb69
// Size: 0x4a
function function_9b9031dc40095287( objective )
{
    if ( isent( objective ) && objective.trigger islinked() )
    {
        return objective.trigger.origin;
    }
    
    return gameobjects_shared::get_origin( objective );
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0xab54d7c8, Offset: 0xbbb
// Size: 0x153
function function_3491b57e9cace1d5( game_object, touching )
{
    if ( gameobjects_common::has_trigger_group( game_object ) )
    {
        all_tacpoints = [];
        trigger_group = gameobjects_common::get_trigger_group( game_object );
        triggers = trigger_group::get_triggers( trigger_group );
        
        foreach ( trigger in triggers )
        {
            tacpoints_in_trigger = function_bad8552afaeb33fd( trigger, touching );
            
            foreach ( tacpoint in tacpoints_in_trigger )
            {
                all_tacpoints = arraycombineunique( all_tacpoints, [ tacpoint ] );
            }
        }
        
        return all_tacpoints;
    }
    
    return function_bad8552afaeb33fd( game_object.trigger, touching );
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x2bbae40b, Offset: 0xd17
// Size: 0x36
function function_df1624ff6e509697( game_object )
{
    if ( isdefined( game_object.name_hash ) )
    {
        return game_object.name_hash;
    }
    
    return game_object.trigger getentitynumber();
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0x40b28081, Offset: 0xd56
// Size: 0xb5
function function_dbd73e86391f9bd2( origin, game_object_array )
{
    result = [];
    
    for ( remaining = game_object_array; remaining.size > 0 ; remaining = arrayremove( remaining, best ) )
    {
        best = remaining[ 0 ];
        best_dist = distancesquared( origin, gameobjects_shared::get_origin( best ) );
        
        for ( i = 1; i < remaining.size ; i++ )
        {
            dist = distancesquared( origin, gameobjects_shared::get_origin( remaining[ i ] ) );
            
            if ( dist < best_dist )
            {
                best = remaining[ i ];
                best_dist = dist;
            }
        }
        
        result[ result.size ] = best;
    }
    
    return result;
}

/#

    // Namespace bots_gametype_common
    // Params 0
    // Checksum 0xf9367155, Offset: 0xe14
    // Size: 0xf, Type: dev
    function function_ef46137f247c5723()
    {
        return level.var_ef46137f247c5723;
    }

#/

// Namespace bots_gametype_common
// Params 1
// Checksum 0x583a2599, Offset: 0xe2b
// Size: 0xd3
function bot_gametype_get_num_players_on_team( team )
{
    num_on_team = 0;
    
    foreach ( player in level.participants )
    {
        if ( game_utility_common::isteamparticipant( player ) && isdefined( player.team ) && player.team == team )
        {
            /#
                if ( function_ef46137f247c5723() && !isai( player ) )
                {
                    continue;
                }
            #/
            
            num_on_team++;
        }
    }
    
    return num_on_team;
}

// Namespace bots_gametype_common
// Params 3
// Checksum 0x5fea84b1, Offset: 0xf07
// Size: 0x142
function bot_gametype_get_allied_attackers_for_team( team, attack_origin, defend_radius )
{
    attackers = bot_gametype_get_players_by_role( "attacker", team );
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) && isdefined( player.team ) && player.team == team )
        {
            /#
                if ( function_ef46137f247c5723() )
                {
                    continue;
                }
                
                if ( player isufo() || player isnoclip() )
                {
                    continue;
                }
            #/
            
            if ( player bot_gametype_human_player_always_considered_attacker() )
            {
                attackers[ attackers.size ] = player;
                continue;
            }
            
            if ( !player function_ffc41043a3a0a51a() )
            {
                if ( isdefined( attack_origin ) && distancesquared( attack_origin, player.origin ) > squared( defend_radius ) )
                {
                    attackers[ attackers.size ] = player;
                }
            }
        }
    }
    
    return attackers;
}

// Namespace bots_gametype_common
// Params 3
// Checksum 0xc6fb5538, Offset: 0x1052
// Size: 0x142
function bot_gametype_get_allied_defenders_for_team( team, defend_origin, defend_radius )
{
    defenders = bot_gametype_get_players_by_role( "defender", team );
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) && isdefined( player.team ) && player.team == team )
        {
            /#
                if ( function_ef46137f247c5723() )
                {
                    continue;
                }
                
                if ( player isufo() || player isnoclip() )
                {
                    continue;
                }
            #/
            
            if ( player bot_gametype_human_player_always_considered_defender() )
            {
                defenders[ defenders.size ] = player;
                continue;
            }
            
            if ( !player function_aaf36a3eeab429d6() )
            {
                if ( isdefined( defend_origin ) && distancesquared( defend_origin, player.origin ) <= squared( defend_radius ) )
                {
                    defenders[ defenders.size ] = player;
                }
            }
        }
    }
    
    return defenders;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x7b1a0fe3, Offset: 0x119d
// Size: 0x1d
function bot_gametype_human_player_always_considered_attacker()
{
    if ( isdefined( level.bot_gametype_human_player_always_attacker ) )
    {
        return self [[ level.bot_gametype_human_player_always_attacker ]]();
    }
    
    return 0;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xd36d76ee, Offset: 0x11c3
// Size: 0x1d
function function_ffc41043a3a0a51a()
{
    if ( isdefined( level.var_2ad52700d3f8deb1 ) )
    {
        return self [[ level.var_2ad52700d3f8deb1 ]]();
    }
    
    return 0;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xb0fb0c4d, Offset: 0x11e9
// Size: 0x1d
function bot_gametype_human_player_always_considered_defender()
{
    if ( isdefined( level.bot_gametype_human_player_always_defender ) )
    {
        return self [[ level.bot_gametype_human_player_always_defender ]]();
    }
    
    return 0;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x188c7540, Offset: 0x120f
// Size: 0x1d
function function_aaf36a3eeab429d6()
{
    if ( isdefined( level.var_aa1e78884fada2d1 ) )
    {
        return self [[ level.var_aa1e78884fada2d1 ]]();
    }
    
    return 0;
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x5188d3a0, Offset: 0x1235
// Size: 0x24
function bot_gametype_set_role( new_role )
{
    self.role = new_role;
    self botclearscriptgoal();
    bots_scripted_defense::function_87e8deae08ce1a0();
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0xe45a66b8, Offset: 0x1261
// Size: 0xf2
function bot_gametype_get_players_by_role( role, team )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( isdefined( player.team ) && isalive( player ) && game_utility_common::isteamparticipant( player ) && player.team == team && isdefined( player.role ) && player.role == role )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xd169fa85, Offset: 0x135c
// Size: 0x28a
function bot_gametype_initialize_attacker_defender_role()
{
    attackers = [[ level.bot_gametype_allied_attackers_for_team ]]( self.team );
    defenders = [[ level.bot_gametype_allied_defenders_for_team ]]( self.team );
    attacker_limit = [[ level.bot_gametype_attacker_limit_for_team ]]( self.team );
    defender_limit = [[ level.bot_gametype_defender_limit_for_team ]]( self.team );
    personality_type = level.bot_personality_type[ self.personality ];
    
    if ( personality_type == "active" )
    {
        if ( attackers.size >= attacker_limit )
        {
            var_789f7fcf69555bf8 = 0;
            
            foreach ( attacker in attackers )
            {
                if ( isai( attacker ) && level.bot_personality_type[ attacker.personality ] == "stationary" && attacker bot_can_switch_to_defender() )
                {
                    attacker.role = undefined;
                    var_789f7fcf69555bf8 = 1;
                    break;
                }
            }
            
            if ( var_789f7fcf69555bf8 )
            {
                bot_gametype_set_role( "attacker" );
            }
            else
            {
                bot_gametype_set_role( "defender" );
            }
        }
        else
        {
            bot_gametype_set_role( "attacker" );
        }
        
        return;
    }
    
    if ( personality_type == "stationary" )
    {
        if ( defenders.size >= defender_limit )
        {
            var_789f7fcf69555bf8 = 0;
            
            foreach ( defender in defenders )
            {
                if ( isai( defender ) && level.bot_personality_type[ defender.personality ] == "active" && defender bot_can_switch_to_attacker() )
                {
                    defender.role = undefined;
                    var_789f7fcf69555bf8 = 1;
                    break;
                }
            }
            
            if ( var_789f7fcf69555bf8 )
            {
                bot_gametype_set_role( "defender" );
            }
            else
            {
                bot_gametype_set_role( "attacker" );
            }
            
            return;
        }
        
        bot_gametype_set_role( "defender" );
    }
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x21fe279e, Offset: 0x15ee
// Size: 0x332
function bot_gametype_attacker_defender_ai_director_update()
{
    level notify( #"bot_gametype_attacker_defender_ai_director_update" );
    level endon( #"bot_gametype_attacker_defender_ai_director_update" );
    level endon( #"game_ended" );
    teams = [ "allies", "axis" ];
    var_f53be1806f8b9eeb = gettime() + 2000;
    
    while ( true )
    {
        if ( gettime() > var_f53be1806f8b9eeb )
        {
            var_f53be1806f8b9eeb = gettime() + 1000;
            
            foreach ( team in teams )
            {
                attackers = [[ level.bot_gametype_allied_attackers_for_team ]]( team );
                defenders = [[ level.bot_gametype_allied_defenders_for_team ]]( team );
                attacker_limit = [[ level.bot_gametype_attacker_limit_for_team ]]( team );
                defender_limit = [[ level.bot_gametype_defender_limit_for_team ]]( team );
                
                if ( attackers.size > attacker_limit )
                {
                    ai_attackers = [];
                    removed_attacker = 0;
                    
                    foreach ( attacker in attackers )
                    {
                        if ( isai( attacker ) && attacker bot_can_switch_to_defender() )
                        {
                            if ( level.bot_personality_type[ attacker.personality ] == "stationary" )
                            {
                                attacker bot_gametype_set_role( "defender" );
                                removed_attacker = 1;
                                break;
                            }
                            
                            ai_attackers[ ai_attackers.size ] = attacker;
                        }
                    }
                    
                    if ( !removed_attacker && ai_attackers.size > 0 )
                    {
                        utility::array_random( ai_attackers ) bot_gametype_set_role( "defender" );
                    }
                }
                
                if ( defenders.size > defender_limit )
                {
                    ai_defenders = [];
                    removed_defender = 0;
                    
                    foreach ( defender in defenders )
                    {
                        if ( isai( defender ) && defender bot_can_switch_to_attacker() )
                        {
                            if ( level.bot_personality_type[ defender.personality ] == "active" )
                            {
                                defender bot_gametype_set_role( "attacker" );
                                removed_defender = 1;
                                break;
                            }
                            
                            ai_defenders[ ai_defenders.size ] = defender;
                        }
                    }
                    
                    if ( !removed_defender && ai_defenders.size > 0 )
                    {
                        utility::array_random( ai_defenders ) bot_gametype_set_role( "attacker" );
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x2cf1a22d, Offset: 0x1928
// Size: 0x1e
function bot_can_switch_to_attacker()
{
    if ( isdefined( level.bot_gametype_allowed_to_switch_to_attacker ) )
    {
        return self [[ level.bot_gametype_allowed_to_switch_to_attacker ]]();
    }
    
    return 1;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xe710a183, Offset: 0x194f
// Size: 0x1e
function bot_can_switch_to_defender()
{
    if ( isdefined( level.bot_gametype_allowed_to_switch_to_defender ) )
    {
        return self [[ level.bot_gametype_allowed_to_switch_to_defender ]]();
    }
    
    return 1;
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x365f53d6, Offset: 0x1976
// Size: 0x1e5, Type: bool
function bot_verify_and_cache_bombzones( valid_labels )
{
    var_61fbb895c8a0f79e = 0;
    
    /#
        foreach ( bombzone in level.objectives )
        {
            wait_time = 1;
            
            if ( gettime() < 5000 )
            {
                wait_time = max( 1, 5 - gettime() / 1000 );
            }
            
            objectivekey = bombzone.objectivekey ?? gameobjects_common::get_objective_key( bombzone );
            
            if ( !isdefined( objectivekey ) || !arraycontains( valid_labels, objectivekey ) )
            {
                wait wait_time;
                msg = "<dev string:x202>";
                
                foreach ( objectivekey in valid_labels )
                {
                    msg += "<dev string:x230>" + objectivekey + "<dev string:x233>";
                }
                
                assertmsg( msg );
                return false;
            }
            
            if ( bombzone.tacpoints.size < 5 )
            {
                wait wait_time;
                assertmsg( "<dev string:x235>" + objectivekey + "<dev string:x240>" + function_9b9031dc40095287( bombzone ) + "<dev string:x24f>" );
                
                if ( bombzone.tacpoints.size < 1 )
                {
                    var_61fbb895c8a0f79e = 1;
                }
            }
        }
    #/
    
    if ( !var_61fbb895c8a0f79e )
    {
        bot_cache_entrances_to_bombzones();
    }
    
    return !var_61fbb895c8a0f79e;
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0x29d1c663, Offset: 0x1b64
// Size: 0x24d
function bot_cache_entrances_to_zones( zones, var_e276263db4106252 )
{
    entrance_origin_points = [];
    entrance_labels = [];
    global_index = 0;
    
    foreach ( zone in zones )
    {
        per_zone_index = 0;
        zone.entrance_indices = [];
        zone.zone_bounds = function_d4efb0d51a4abbce( zone );
        zone.center_tacpoint = function_61757a3272e4aea6( zone, 0, 0 );
        combinations = [ ( 0, 0, 0 ), ( 1, 1, 0 ), ( 1, -1, 0 ), ( -1, 1, 0 ), ( -1, -1, 0 ) ];
        
        foreach ( bound in combinations )
        {
            tacpoint = function_61757a3272e4aea6( zone, bound[ 0 ], bound[ 1 ] );
            entrance_origin_points[ global_index ] = tacpoint.groundpos;
            
            if ( var_e276263db4106252 )
            {
                key = zone.objectivekey + zone.iconname;
            }
            else
            {
                key = zone.objectivekey;
            }
            
            var_ef838bc793b7a904 = key + "_" + per_zone_index;
            entrance_labels[ global_index ] = var_ef838bc793b7a904;
            zone.entrance_indices[ zone.entrance_indices.size ] = var_ef838bc793b7a904;
            global_index++;
            per_zone_index++;
        }
    }
    
    bot_cache_entrances( entrance_origin_points, entrance_labels );
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x6fec2f8b, Offset: 0x1db9
// Size: 0x2a2
function function_d4efb0d51a4abbce( zone )
{
    assert( isdefined( zone.tacpoints ) );
    bounds = spawnstruct();
    bounds.min_pt = ( 999999, 999999, 999999 );
    bounds.max_pt = ( -999999, -999999, -999999 );
    
    foreach ( tacpoint in zone.tacpoints )
    {
        bounds.min_pt = ( min( tacpoint.groundpos[ 0 ], bounds.min_pt[ 0 ] ), min( tacpoint.groundpos[ 1 ], bounds.min_pt[ 1 ] ), min( tacpoint.groundpos[ 2 ], bounds.min_pt[ 2 ] ) );
        bounds.max_pt = ( max( tacpoint.groundpos[ 0 ], bounds.max_pt[ 0 ] ), max( tacpoint.groundpos[ 1 ], bounds.max_pt[ 1 ] ), max( tacpoint.groundpos[ 2 ], bounds.max_pt[ 2 ] ) );
    }
    
    bounds.center = ( ( bounds.min_pt[ 0 ] + bounds.max_pt[ 0 ] ) / 2, ( bounds.min_pt[ 1 ] + bounds.max_pt[ 1 ] ) / 2, ( bounds.min_pt[ 2 ] + bounds.max_pt[ 2 ] ) / 2 );
    bounds.half_size = ( bounds.max_pt[ 0 ] - bounds.center[ 0 ], bounds.max_pt[ 1 ] - bounds.center[ 1 ], bounds.max_pt[ 2 ] - bounds.center[ 2 ] );
    bounds.radius = max( bounds.half_size[ 0 ], bounds.half_size[ 1 ] );
    return bounds;
}

// Namespace bots_gametype_common
// Params 3
// Checksum 0xf61f5f60, Offset: 0x2064
// Size: 0x17f
function function_61757a3272e4aea6( zone, var_6992c3d697f7f591, var_a0b15c743f34cd12 )
{
    assert( var_6992c3d697f7f591 >= -1 && var_6992c3d697f7f591 <= 1 );
    assert( var_a0b15c743f34cd12 >= -1 && var_a0b15c743f34cd12 <= 1 );
    bounds_point = ( zone.zone_bounds.center[ 0 ] + var_6992c3d697f7f591 * zone.zone_bounds.half_size[ 0 ], zone.zone_bounds.center[ 1 ] + var_a0b15c743f34cd12 * zone.zone_bounds.half_size[ 1 ], 0 );
    closest_tacpoint = undefined;
    closest_dist_sq = 9999999;
    
    foreach ( tacpoint in zone.tacpoints )
    {
        dist_sq = distance2dsquared( tacpoint.groundpos, bounds_point );
        
        if ( dist_sq < closest_dist_sq )
        {
            closest_dist_sq = dist_sq;
            closest_tacpoint = tacpoint;
        }
    }
    
    assert( isdefined( closest_tacpoint ) );
    return closest_tacpoint;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xc7f6438a, Offset: 0x21ec
// Size: 0x184
function monitor_zone_control()
{
    self notify( #"monitor_zone_control" );
    self endon( #"monitor_zone_control" );
    self endon( #"death" );
    level endon( #"game_ended" );
    objectiveorigin = function_9b9031dc40095287( self );
    nearesttacpoint = findclosesttacpointinsight( objectiveorigin );
    
    if ( !isdefined( nearesttacpoint ) )
    {
        nearesttacpoint = findclosesttacpoint( objectiveorigin );
        
        if ( !isdefined( nearesttacpoint ) )
        {
            assertmsg( "<dev string:x2c6>" + objectiveorigin );
            return;
        }
    }
    
    zones = getzonesnearest( nearesttacpoint, 100 );
    assert( zones.size > 0, "<dev string:x2fa>" + objectiveorigin + "<dev string:x30a>" );
    
    for ( ;; )
    {
        game_object = self;
        
        if ( isdefined( self.gameobject ) )
        {
            game_object = self.gameobject;
        }
        
        ownerteam = game_object gameobjects::getownerteam();
        
        foreach ( zone in zones )
        {
            if ( !isdefined( ownerteam ) || ownerteam == "neutral" || ownerteam == "none" )
            {
                botzonesetteam( zone, "free" );
                continue;
            }
            
            botzonesetteam( zone, ownerteam );
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xf7878081, Offset: 0x2378
// Size: 0x19b
function monitor_bombzone_control()
{
    self notify( #"monitor_bombzone_control" );
    self endon( #"monitor_bombzone_control" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isent( self.trigger ) && self.trigger islinked() )
    {
        return;
    }
    
    bombzone_origin = function_9b9031dc40095287( self );
    nearesttacpoint = findclosesttacpointinsight( bombzone_origin );
    
    if ( !isdefined( nearesttacpoint ) )
    {
        nearesttacpoint = findclosesttacpoint( bombzone_origin );
        
        if ( !isdefined( nearesttacpoint ) )
        {
            assertmsg( "<dev string:x320>" + bombzone_origin );
            return;
        }
    }
    
    zones = getzonesnearest( nearesttacpoint, 100 );
    
    if ( zones.size == 0 )
    {
        assertmsg( "<dev string:x359>" + bombzone_origin + "<dev string:x30a>" );
        return;
    }
    
    for ( ;; )
    {
        var_418ab41a5098ad38 = gameobjects_shared::get_use_team_name( self );
        
        if ( self.bombplanted )
        {
            zoneteam = utility::get_enemy_team( var_418ab41a5098ad38 );
        }
        else
        {
            zoneteam = var_418ab41a5098ad38;
        }
        
        if ( zoneteam != "allies" && zoneteam != "axis" )
        {
            zoneteam = "free";
        }
        
        foreach ( zone in zones )
        {
            botzonesetteam( zone, zoneteam );
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x4c6ceab7, Offset: 0x251b
// Size: 0xd4
function find_closest_bombzone_to_player( player )
{
    closest_zone = undefined;
    closest_zone_distsq = 999999999;
    
    foreach ( zone in level.objectives )
    {
        zone_origin = function_9b9031dc40095287( zone );
        distsq = distancesquared( zone_origin, player.origin );
        
        if ( distsq < closest_zone_distsq )
        {
            closest_zone = zone;
            closest_zone_distsq = distsq;
        }
    }
    
    return closest_zone;
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0x283d2669, Offset: 0x25f8
// Size: 0xfc
function get_living_players_on_team( team, var_8ac30a18a31e253e )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( player::isreallyalive( player ) && game_utility_common::isteamparticipant( player ) && player.team == team )
        {
            if ( !isdefined( var_8ac30a18a31e253e ) || var_8ac30a18a31e253e && isai( player ) && isdefined( player.role ) )
            {
                players[ players.size ] = player;
            }
        }
    }
    
    return players;
}

// Namespace bots_gametype_common
// Params 2
// Checksum 0x17532e3e, Offset: 0x26fd
// Size: 0x280
function function_932ed5184bc553f2( bombzone, var_4f16c9331a3c2be6 )
{
    tacpoint_target = undefined;
    valid_tacpoints = [];
    
    foreach ( tacpoint in bombzone.tacpoints )
    {
        if ( navistacpointreachable( self, tacpoint ) )
        {
            valid_tacpoints[ valid_tacpoints.size ] = tacpoint;
        }
    }
    
    if ( valid_tacpoints.size == 0 )
    {
        str1 = "Bot at location " + self.origin;
        str2 = " was unable to find any reachable tacpoints near bomb zone '" + bombzone.objectivekey;
        str3 = "' at location " + function_9b9031dc40095287( bombzone );
        assertmsg( str1 + str2 + str3 );
        return;
    }
    
    if ( valid_tacpoints.size >= 2 )
    {
        if ( var_4f16c9331a3c2be6 )
        {
            bottargets_sorted = self bottacpointscoremultiple( valid_tacpoints, "exposed" );
        }
        else
        {
            bottargets_sorted = self bottacpointscoremultiple( valid_tacpoints, "hide_anywhere", "ignore_occupancy" );
        }
        
        var_483587b21496a062 = self botgetdifficultysetting( "strategyLevel" ) * 0.3;
        var_8b91601f09dd498b = ( self botgetdifficultysetting( "strategyLevel" ) + 1 ) * 0.15;
        bot_targets_randomized = arrayrandomize( valid_tacpoints );
        
        foreach ( tacpoint in bot_targets_randomized )
        {
            if ( !arraycontains( bottargets_sorted, tacpoint ) )
            {
                bottargets_sorted[ bottargets_sorted.size ] = tacpoint;
            }
        }
        
        assert( bottargets_sorted.size >= 2 );
        
        if ( randomfloat( 1 ) < var_483587b21496a062 )
        {
            tacpoint_target = bottargets_sorted[ 0 ];
        }
        else if ( randomfloat( 1 ) < var_8b91601f09dd498b )
        {
            tacpoint_target = bottargets_sorted[ 1 ];
        }
        else
        {
            tacpoint_target = utility::array_random( bottargets_sorted );
        }
    }
    else if ( valid_tacpoints.size == 1 )
    {
        tacpoint_target = valid_tacpoints[ 0 ];
    }
    
    assert( isdefined( tacpoint_target ), "<dev string:x36e>" + bombzone.objectivekey + "<dev string:x380>" );
    return tacpoint_target;
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0x2a60667e, Offset: 0x2986
// Size: 0x1fa
function function_b31545b4843bdcf1( bombzone )
{
    tacpoint_target = undefined;
    valid_tacpoints = [];
    
    foreach ( tacpoint in bombzone.tacpoints )
    {
        if ( navistacpointreachable( self, tacpoint ) )
        {
            valid_tacpoints[ valid_tacpoints.size ] = tacpoint;
        }
    }
    
    if ( valid_tacpoints.size >= 2 )
    {
        bottargets_sorted = self bottacpointscoremultiple( valid_tacpoints, "hide_anywhere", "ignore_occupancy" );
        var_f70d8784da9d6bd = self botgetdifficultysetting( "strategyLevel" ) * 0.3;
        var_534c1c852b2734f2 = ( self botgetdifficultysetting( "strategyLevel" ) + 1 ) * 0.15;
        bot_targets_randomized = arrayrandomize( valid_tacpoints );
        
        foreach ( tacpoint in bot_targets_randomized )
        {
            if ( !arraycontains( bottargets_sorted, tacpoint ) )
            {
                bottargets_sorted[ bottargets_sorted.size ] = tacpoint;
            }
        }
        
        assert( bottargets_sorted.size >= 2 );
        
        if ( randomfloat( 1 ) < var_f70d8784da9d6bd )
        {
            return bottargets_sorted[ 0 ];
        }
        else if ( randomfloat( 1 ) < var_534c1c852b2734f2 )
        {
            return bottargets_sorted[ 1 ];
        }
        else
        {
            return utility::array_random( bottargets_sorted );
        }
    }
    else if ( valid_tacpoints.size == 1 )
    {
        tacpoint_target = valid_tacpoints[ 0 ];
    }
    
    assert( isdefined( tacpoint_target ), "<dev string:x36e>" + bombzone.objectivekey + "<dev string:x380>" );
    return tacpoint_target;
}

// Namespace bots_gametype_common
// Params 4
// Checksum 0x352794ec, Offset: 0x2b89
// Size: 0xf2
function bombzone_press_use( time, self_end_notify, emergency_plant, dont_prone )
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
        childthread notify_planter_on_whizby();
        childthread notify_planter_on_damage();
    }
    
    self botpressbutton( "use", time );
    result = bots_util::bot_usebutton_wait( time, self_end_notify, "use_interrupted" );
    self botsetstance( "none" );
    self botclearbutton( "use" );
    succeeded = result == self_end_notify;
    return succeeded;
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0x2103f54c, Offset: 0x2c84
// Size: 0x9b
function notify_planter_on_whizby()
{
    self endon( #"hash_494c92cda8594596" );
    this_bombzone = find_closest_bombzone_to_player( self );
    self waittill( #"bulletwhizby", shooter );
    
    if ( shooter.team != self.team )
    {
        usetime = gameobjects_shared::get_use_time_seconds( this_bombzone );
        curprogress = gameobjects_shared::get_use_progress( this_bombzone ) ?? 0;
        time_left = usetime - curprogress;
        
        if ( time_left > 1000 )
        {
            self notify( #"use_interrupted" );
        }
    }
}

// Namespace bots_gametype_common
// Params 0
// Checksum 0xef498f1b, Offset: 0x2d27
// Size: 0x55
function notify_planter_on_damage()
{
    self endon( #"hash_494c92cda8594596" );
    self waittill( #"damage", amount, attacker );
    
    if ( attacker.team != self.team )
    {
        self notify( #"use_interrupted" );
    }
}

// Namespace bots_gametype_common
// Params 1
// Checksum 0xf14e409d, Offset: 0x2d84
// Size: 0x143
function get_ai_hearing_bomb_plant_sound( type )
{
    assert( isdefined( level.silentplant ) );
    var_1f27a087b6af305f = [];
    
    if ( !level.silentplant )
    {
        players = get_living_players_on_team( utility::get_enemy_team( self.team ) );
        
        foreach ( player in players )
        {
            if ( !isai( player ) )
            {
                continue;
            }
            
            hearing_dist = 0;
            
            if ( type == "plant" )
            {
                hearing_dist = 300 + player botgetdifficultysetting( "strategyLevel" ) * 100;
            }
            else if ( type == "defuse" )
            {
                hearing_dist = 500 + player botgetdifficultysetting( "strategyLevel" ) * 500;
            }
            
            if ( distancesquared( player.origin, self.origin ) < squared( hearing_dist ) )
            {
                var_1f27a087b6af305f[ var_1f27a087b6af305f.size ] = player;
            }
        }
    }
    
    return var_1f27a087b6af305f;
}

/#

    // Namespace bots_gametype_common
    // Params 0
    // Checksum 0x7d66e570, Offset: 0x2ed0
    // Size: 0x16f, Type: dev
    function function_542131a1e15d65d6()
    {
        while ( !isdefined( level.var_3cea2151bc5f621b ) )
        {
            wait 0.05;
        }
        
        while ( true )
        {
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
            {
                zones = level.objectives;
                
                if ( isdefined( level.extra_bomb_zones ) )
                {
                    zones = arraycombine( zones, level.extra_bomb_zones );
                }
                
                foreach ( bombzone in zones )
                {
                    foreach ( tacpoint in bombzone.tacpoints )
                    {
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 8, 10, 0.05, undefined, ( 0, 1, 0 ), 1, 4 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots_gametype_common
    // Params 0
    // Checksum 0xa1f074d2, Offset: 0x3047
    // Size: 0x305, Type: dev
    function function_a6cacb00e9275066()
    {
        if ( !isdefined( level.objectives ) )
        {
            wait 0.05;
        }
        
        foreach ( zone in level.objectives )
        {
            bots_debug::function_8777d84a0c0c5802( 0, zone );
        }
        
        while ( !isdefined( level.var_acfff33730ed3d7f ) )
        {
            wait 0.05;
        }
        
        was_on = 0;
        
        while ( true )
        {
            zone_array = level.objectives;
            
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
            {
                setdevdvarifuninitialized( @"hash_c08da04217f1024b", -1 );
                was_on = 1;
                
                foreach ( index, zone in zone_array )
                {
                    var_8a524458529d55ca = getdvarint( @"hash_c08da04217f1024b", -1 );
                    
                    if ( var_8a524458529d55ca >= zone_array.size )
                    {
                        setdvar( @"hash_c08da04217f1024b", zone_array.size - 1 );
                    }
                    
                    if ( var_8a524458529d55ca >= 0 )
                    {
                        if ( index != var_8a524458529d55ca )
                        {
                            bots_debug::function_8777d84a0c0c5802( 0, zone );
                            continue;
                        }
                    }
                    
                    color = ( 0, 1, 0 );
                    
                    if ( zone == level.zone )
                    {
                        color = ( 1, 0, 0 );
                    }
                    
                    if ( !gameobjects_shared::is_activated( zone ) )
                    {
                        gameobjects_shared::activate( zone );
                    }
                    
                    bots_debug::function_8777d84a0c0c5802( 1, zone, color, 1 );
                    
                    foreach ( tacpoint in zone.tacpoints )
                    {
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, color, 1, 4 );
                    }
                }
            }
            else if ( was_on )
            {
                was_on = 0;
                
                foreach ( zone in zone_array )
                {
                    bots_debug::function_8777d84a0c0c5802( 0, zone );
                }
            }
            
            waitframe();
        }
    }

#/
