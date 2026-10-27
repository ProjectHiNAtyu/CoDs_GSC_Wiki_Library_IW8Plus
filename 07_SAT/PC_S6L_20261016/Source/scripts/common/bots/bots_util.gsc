// scripts\common\bots\bots_util.gsc  (hash_6276e85e5a96fa38.gscc) (size: 12197 Bytes / 0x2fa5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7951d8c6 (2035407046)
// size ...... 12197 (0x2fa5)
// includes .. 2   (offset: 0x2d99)
// strings ... 19  (offset: 0x2da9)
// dev strs .. 18  (offset: 0x2ea1)
// exports ... 41  (offset: 0x1da5)
// cseg ...... 0x20b + 0x1b9a (0x1da5)
// imports ... 77  (offset: 0x240d)
// animtree1 . 0   (offset: 0x2fa5)
// animtree2 . 0   (offset: 0x2fa5)
#using scripts\common\game_utility;
#using scripts\common\utility;

#namespace bots_util;

// Namespace bots_util
// Params 4
// Checksum 0x8e3962c2, Offset: 0x229
// Size: 0x15f
function function_785b7ca2538863b0( min_dist, max_dist, vector_dot, var_1996f34d05032341 )
{
    var_3f4b399be4a15181 = function_a034a927128ada11( self.origin, max_dist, min_dist );
    var_713659199552a321 = [];
    var_c0b99a92fbc47fb7 = self getnearesttacpoint();
    bot_dir = anglestoforward( self getplayerangles() );
    bot_dir_norm = vectornormalize( bot_dir * ( 1, 1, 0 ) );
    
    foreach ( tacpoint in var_3f4b399be4a15181 )
    {
        var_4c41dd523f5ba203 = vectornormalize( ( tacpoint.groundpos - self.origin ) * ( 1, 1, 0 ) );
        dot = vectordot( var_4c41dd523f5ba203, bot_dir_norm );
        
        if ( dot > vector_dot )
        {
            if ( !var_1996f34d05032341 || isdefined( var_c0b99a92fbc47fb7 ) && tacpointsvisible( tacpoint, var_c0b99a92fbc47fb7 ) )
            {
                var_713659199552a321[ var_713659199552a321.size ] = tacpoint;
            }
        }
    }
    
    return var_713659199552a321;
}

// Namespace bots_util
// Params 2
// Checksum 0xc03d40ce, Offset: 0x391
// Size: 0x73
function function_4eb61a3985ad712c( tacpointarray, onlycull )
{
    if ( tacpointarray.size > 500 && !onlycull )
    {
        tacpointarray = function_7a2f256e52489a6( tacpointarray );
    }
    
    maxnumscoreitems = botgetmaxnumscoreitems();
    
    while ( tacpointarray.size > maxnumscoreitems )
    {
        index_to_remove = randomint( tacpointarray.size );
        tacpointarray[ index_to_remove ] = tacpointarray[ tacpointarray.size - 1 ];
        tacpointarray[ tacpointarray.size - 1 ] = undefined;
    }
    
    return tacpointarray;
}

// Namespace bots_util
// Params 1
// Checksum 0x1c82a397, Offset: 0x40d
// Size: 0x21
function bot_waittill_bots_enabled( var_2ec2e2b005cef623 )
{
    while ( !bot_bots_enabled_or_added( var_2ec2e2b005cef623 ) )
    {
        wait 0.5;
    }
}

// Namespace bots_util
// Params 1
// Checksum 0xf5b3d690, Offset: 0x436
// Size: 0x1b, Type: bool
function bot_bots_enabled_or_added( var_2ec2e2b005cef623 )
{
    if ( bots_exist( var_2ec2e2b005cef623 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_util
// Params 1
// Checksum 0x15de8819, Offset: 0x45a
// Size: 0x5a
function bot_waittill_out_of_combat_or_time( time )
{
    start_time = gettime();
    
    while ( true )
    {
        if ( isdefined( time ) )
        {
            if ( gettime() > start_time + time )
            {
                return;
            }
        }
        
        if ( !isdefined( self.enemy ) )
        {
            return;
        }
        else if ( !bot_in_combat() )
        {
            return;
        }
        
        wait 0.05;
    }
}

// Namespace bots_util
// Params 1
// Checksum 0x70c7f5c8, Offset: 0x4bc
// Size: 0x57, Type: bool
function bot_in_combat( optional_time )
{
    if ( self.last_enemy_sight_time == 0 )
    {
        return false;
    }
    
    var_801537ab76f5e0e2 = gettime() - self.last_enemy_sight_time;
    check_time = level.bot_out_of_combat_time;
    
    if ( isdefined( optional_time ) )
    {
        check_time = optional_time;
    }
    
    return var_801537ab76f5e0e2 < check_time;
}

// Namespace bots_util
// Params 4
// Checksum 0xaeec399a, Offset: 0x51c
// Size: 0xdc
function bot_waittill_goal_or_fail( optional_time, optional_param_1, optional_param_2, optional_param_3 )
{
    if ( !isdefined( optional_param_1 ) && isdefined( optional_param_2 ) )
    {
        assert( 0, "<dev string:x24>" );
    }
    
    if ( !( isdefined( optional_param_1 ) && isdefined( optional_param_2 ) ) && isdefined( optional_param_3 ) )
    {
        assert( 0, "<dev string:x76>" );
    }
    
    wait_array = [ "goal", "bad_path", "script_goal_changed" ];
    
    if ( isdefined( optional_param_1 ) )
    {
        wait_array[ wait_array.size ] = optional_param_1;
    }
    
    if ( isdefined( optional_param_2 ) )
    {
        wait_array[ wait_array.size ] = optional_param_2;
    }
    
    if ( isdefined( optional_param_3 ) )
    {
        wait_array[ wait_array.size ] = optional_param_3;
    }
    
    if ( isdefined( optional_time ) )
    {
        result = utility::waittill_any_in_array_or_timeout( wait_array, optional_time );
    }
    else
    {
        result = utility::waittill_any_in_array_return( wait_array );
    }
    
    return result;
}

// Namespace bots_util
// Params 3
// Checksum 0x33158c77, Offset: 0x601
// Size: 0x5f
function bot_usebutton_wait( time, var_d466293d33138f08, var_d4662c3d331395a1 )
{
    level endon( #"game_ended" );
    childthread use_button_stopped_notify();
    result = utility::waittill_any_timeout( time, var_d466293d33138f08, var_d4662c3d331395a1, "use_button_no_longer_pressed", "finished_use" );
    self notify( #"hash_494c92cda8594596" );
    return result;
}

// Namespace bots_util
// Params 2
// Checksum 0xa8cd12c6, Offset: 0x669
// Size: 0x44
function use_button_stopped_notify( var_d466293d33138f08, var_d4662c3d331395a1 )
{
    self endon( #"hash_494c92cda8594596" );
    wait 0.05;
    
    while ( self usebuttonpressed() )
    {
        wait 0.05;
    }
    
    self notify( #"use_button_no_longer_pressed" );
}

// Namespace bots_util
// Params 1
// Checksum 0x9a266626, Offset: 0x6b5
// Size: 0xa7, Type: bool
function bots_exist( var_2ec2e2b005cef623 )
{
    foreach ( player in level.participants )
    {
        if ( isai( player ) || isautopilot( player ) )
        {
            if ( var_2ec2e2b005cef623 )
            {
                if ( !game_utility_common::isteamparticipant( player ) )
                {
                    continue;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace bots_util
// Params 3
// Checksum 0x41721812, Offset: 0x765
// Size: 0x2e6
function bot_get_entrances_for_stance_and_index( stance, index, var_d084f3ad45fa98e7 )
{
    assert( !isdefined( stance ) || stance == "<dev string:xd4>" || stance == "<dev string:xda>" || stance == "<dev string:xe1>" );
    
    if ( !isdefined( level.entrance_points_finished_caching ) )
    {
        return;
    }
    
    assert( isdefined( index ) );
    
    if ( isarray( index ) )
    {
        if ( var_d084f3ad45fa98e7 )
        {
            closest_label = undefined;
            var_9eab19dab9ce05c7 = 999999999;
            
            foreach ( label in index )
            {
                var_7eff8c5da08014a = function_f02c63b99c9614c9( level.entrance_indices, label );
                var_fed6dca9787f8b65 = level.entrance_origin_points[ var_7eff8c5da08014a ];
                var_fbf11e4918953888 = distancesquared( self.origin, var_fed6dca9787f8b65 );
                
                if ( var_fbf11e4918953888 < var_9eab19dab9ce05c7 )
                {
                    closest_label = label;
                    var_9eab19dab9ce05c7 = var_fbf11e4918953888;
                }
            }
            
            index = closest_label;
            assert( isdefined( index ) );
        }
        else
        {
            index = utility::array_random( index );
        }
    }
    
    assert( isdefined( level.entrance_points ) );
    assert( isdefined( level.entrance_points[ index ] ), index );
    entrances = level.entrance_points[ index ];
    
    if ( !isdefined( stance ) || stance == "stand" )
    {
        return entrances;
    }
    
    if ( stance == "crouch" )
    {
        acceptable_tacpoints = [];
        
        foreach ( tacpoint in entrances )
        {
            if ( tacpoint.crouch_visible_from[ index ] )
            {
                acceptable_tacpoints[ acceptable_tacpoints.size ] = tacpoint;
            }
        }
        
        return acceptable_tacpoints;
    }
    
    if ( stance == "prone" )
    {
        acceptable_tacpoints = [];
        
        foreach ( tacpoint in entrances )
        {
            if ( tacpoint.prone_visible_from[ index ] )
            {
                acceptable_tacpoints[ acceptable_tacpoints.size ] = tacpoint;
            }
        }
        
        return acceptable_tacpoints;
    }
}

// Namespace bots_util
// Params 5
// Checksum 0x7e54d2a9, Offset: 0xa54
// Size: 0xc9
function bot_pick_random_point_in_radius( center_point, tacpoint_radius, var_5377866164f370c0, close_dist, far_dist )
{
    point_picked = undefined;
    tacpoints = function_a034a927128ada11( center_point, tacpoint_radius, 0, 500, 2048 );
    
    if ( tacpoints.size >= 2 )
    {
        point_picked = bot_find_random_midpoint( tacpoints, var_5377866164f370c0 );
    }
    
    if ( !isdefined( point_picked ) )
    {
        if ( !isdefined( close_dist ) )
        {
            close_dist = 0;
        }
        
        if ( !isdefined( far_dist ) )
        {
            far_dist = 1;
        }
        
        rand_dist = randomfloatrange( self.bot_defending_radius * close_dist, self.bot_defending_radius * far_dist );
        rand_dir = anglestoforward( ( 0, randomint( 360 ), 0 ) );
        point_picked = center_point + rand_dir * rand_dist;
    }
    
    return point_picked;
}

// Namespace bots_util
// Params 3
// Checksum 0x19d4c042, Offset: 0xb26
// Size: 0x9e
function bot_pick_random_point_from_set( center_point, tacpoint_set, var_5377866164f370c0 )
{
    point_picked = undefined;
    
    if ( tacpoint_set.size >= 2 )
    {
        tacpoints_to_use = arraycopy( tacpoint_set );
        point_picked = bot_find_random_midpoint( tacpoints_to_use, var_5377866164f370c0 );
    }
    
    if ( !isdefined( point_picked ) )
    {
        rand_tacpoint_picked = utility::array_random( tacpoint_set );
        var_eb64955e05cec39d = rand_tacpoint_picked.origin - center_point;
        point_picked = center_point + vectornormalize( var_eb64955e05cec39d ) * length( var_eb64955e05cec39d ) * randomfloat( 1 );
    }
    
    return point_picked;
}

// Namespace bots_util
// Params 2
// Checksum 0xf4975281, Offset: 0xbcd
// Size: 0xd3
function bot_find_random_midpoint( tacpoints, var_5377866164f370c0 )
{
    while ( tacpoints.size >= 2 )
    {
        var_fcfee4cd1b513b68 = randomint( tacpoints.size );
        tacpoint1 = tacpoints[ var_fcfee4cd1b513b68 ];
        tacpoints[ var_fcfee4cd1b513b68 ] = tacpoints[ tacpoints.size - 1 ];
        tacpoints[ tacpoints.size - 1 ] = undefined;
        var_fcfee7cd1b514201 = randomint( tacpoints.size );
        tacpoint2 = tacpoints[ var_fcfee7cd1b514201 ];
        tacpoints[ var_fcfee7cd1b514201 ] = tacpoints[ tacpoints.size - 1 ];
        tacpoints[ tacpoints.size - 1 ] = undefined;
        
        if ( tacpointsvisible( tacpoint1, tacpoint2 ) )
        {
            midpoint = ( tacpoint1.groundpos + tacpoint2.groundpos ) * 0.5;
            
            if ( !isdefined( var_5377866164f370c0 ) || self [[ var_5377866164f370c0 ]]( midpoint ) )
            {
                return midpoint;
            }
        }
    }
}

// Namespace bots_util
// Params 0
// Checksum 0xd10d4d5b, Offset: 0xca8
// Size: 0x237
function bot_queued_process_manager()
{
    level.bot_queued_process_queue = [];
    
    while ( true )
    {
        waittillframeend();
        
        if ( level.bot_queued_process_queue.size > 0 )
        {
            process = level.bot_queued_process_queue[ 0 ];
            
            if ( isdefined( process ) && isdefined( process.owner ) )
            {
                assert( isdefined( process.func ) );
                process.owner.var_9f3be5974f56c1b = 1;
                
                if ( !isalive( process.owner ) )
                {
                    var_e05191752fd8108c = self.var_e05191752fd8108c ?? -1;
                    bot_death_time = self.bot_death_time ?? -1;
                    assertmsg( "<dev string:xe7>" + process.owner.name + "<dev string:xf0>" + process.name + "<dev string:x11a>" + "<dev string:x130>" + gettime() + "<dev string:x13a>" + bot_death_time + "<dev string:x147>" + var_e05191752fd8108c );
                }
                else
                {
                    assert( isbot( process.owner ) || isautopilot( process.owner ), "<dev string:xe7>" + process.owner.name + "<dev string:xf0>" + process.name + "<dev string:x15a>" );
                }
                
                result = process.owner [[ process.func ]]( flat_args( process.vararg, process.varargcount ) );
                process.owner.var_9f3be5974f56c1b = undefined;
                process.owner notify( process.name_complete, result );
            }
            
            for ( i = 0; i < level.bot_queued_process_queue.size - 1 ; i++ )
            {
                level.bot_queued_process_queue[ i ] = level.bot_queued_process_queue[ i + 1 ];
            }
            
            level.bot_queued_process_queue[ level.bot_queued_process_queue.size - 1 ] = undefined;
        }
        
        waitframe();
    }
}

// Namespace bots_util
// Params 0
// Checksum 0xa5b91ce4, Offset: 0xee7
// Size: 0xf3
function function_b5df752f95e3ba()
{
    assert( isarray( level.bot_queued_process_queue ) );
    assert( isbot( self ) || isautopilot( self ), "<dev string:xe7>" + self.name + "<dev string:x179>" );
    self.var_e05191752fd8108c = gettime();
    
    for ( i = 0; i < level.bot_queued_process_queue.size ; i++ )
    {
        process = level.bot_queued_process_queue[ i ];
        
        if ( process.owner == self )
        {
            for ( j = i; j < level.bot_queued_process_queue.size - 1 ; j++ )
            {
                level.bot_queued_process_queue[ j ] = level.bot_queued_process_queue[ j + 1 ];
            }
            
            level.bot_queued_process_queue[ level.bot_queued_process_queue.size - 1 ] = undefined;
            i--;
        }
    }
}

// Namespace bots_util
// Params 5, eflags: 0x40 variadic
// Checksum 0x30275811, Offset: 0xfe2
// Size: 0x2bd
function bot_queued_process( source, process_name, process_func, ... )
{
    assert( isarray( level.bot_queued_process_queue ) );
    assert( isbot( self ) || isautopilot( self ), "<dev string:xe7>" + self.name + "<dev string:x1c3>" + process_name + "<dev string:x15a>" );
    
    if ( !isalive( self ) )
    {
        var_e05191752fd8108c = self.var_e05191752fd8108c ?? -1;
        bot_death_time = self.bot_death_time ?? -1;
        assertmsg( "<dev string:xe7>" + self.name + "<dev string:x1c3>" + process_name + "<dev string:x11a>" + "<dev string:x130>" + gettime() + "<dev string:x13a>" + bot_death_time + "<dev string:x147>" + var_e05191752fd8108c );
    }
    
    assert( !self.var_9f3be5974f56c1b );
    process = spawnstruct();
    process.owner = self;
    process.source = source;
    process.name = process_name;
    process.name_complete = process.name + "|" + source + "|" + self getentitynumber() + "|" + gettime() + "|done";
    process.func = process_func;
    process.vararg = vararg;
    process.varargcount = varargcount;
    
    /#
        foreach ( existing_process in level.bot_queued_process_queue )
        {
            if ( existing_process.owner == process.owner && existing_process.name_complete == process.name_complete )
            {
                assertmsg( "<dev string:x1f2>" + self getentitynumber() + "<dev string:x1f8>" + "<dev string:x232>" + existing_process.name_complete + "<dev string:x245>" + process.name_complete );
                return;
            }
        }
    #/
    
    level.bot_queued_process_queue[ level.bot_queued_process_queue.size ] = process;
    self waittill( process.name_complete, result );
    return result;
}

// Namespace bots_util
// Params 2, eflags: 0x40 variadic
// Checksum 0x8a9993e7, Offset: 0x12a8
// Size: 0x37
function function_aa09e61c1e39cf69( ... )
{
    assert( isarray( vararg[ 0 ] ) && vararg[ 0 ].size > 0 );
    return self bottacpointpick( flat_args( vararg, varargcount ) );
}

// Namespace bots_util
// Params 6, eflags: 0x40 variadic
// Checksum 0x47a4db5f, Offset: 0x12e8
// Size: 0x79
function function_ec1247a9311f67a4( source, tacpoints, var_c49e1dc9451ce763, scoringtype, ... )
{
    assert( isdefined( tacpoints ) );
    assert( isarray( tacpoints ) );
    assert( tacpoints.size > 0 );
    return bot_queued_process( source, "BotTacPointPick", &function_aa09e61c1e39cf69, tacpoints, var_c49e1dc9451ce763, scoringtype, flat_args( vararg, varargcount ) );
}

// Namespace bots_util
// Params 2, eflags: 0x40 variadic
// Checksum 0xed3eed0f, Offset: 0x136a
// Size: 0x37
function function_ece5c5e66210e78e( ... )
{
    assert( isarray( vararg[ 0 ] ) && vararg[ 0 ].size > 0 );
    return self bottacpointpickmultiple( flat_args( vararg, varargcount ) );
}

// Namespace bots_util
// Params 7, eflags: 0x40 variadic
// Checksum 0xf9525704, Offset: 0x13aa
// Size: 0x84
function function_75c1dc4534eb4f5d( source, tacpoints, var_c49e1dc9451ce763, var_f7551e333b6feae2, scoringtype, ... )
{
    assert( isdefined( tacpoints ) );
    assert( isarray( tacpoints ) );
    assert( tacpoints.size > 0 );
    return bot_queued_process( source, "BotTacPointPickMultiple", &function_ece5c5e66210e78e, tacpoints, var_c49e1dc9451ce763, var_f7551e333b6feae2, scoringtype, flat_args( vararg, varargcount ) );
}

// Namespace bots_util
// Params 1
// Checksum 0x80c2b876, Offset: 0x1437
// Size: 0x12
function function_49a03bdfb6323905( var_acef6b0fde2dfabf )
{
    return findentrances( var_acef6b0fde2dfabf );
}

// Namespace bots_util
// Params 2
// Checksum 0xe9269d2f, Offset: 0x1452
// Size: 0x29
function function_f3e86dad4d2f79dc( source, var_acef6b0fde2dfabf )
{
    return bot_queued_process( source, "FindEntrances", &function_49a03bdfb6323905, var_acef6b0fde2dfabf );
}

// Namespace bots_util
// Params 5, eflags: 0x40 variadic
// Checksum 0x8d64fd56, Offset: 0x1484
// Size: 0x3e
function bot_queued_process_generic( source, process_name, process_func, ... )
{
    return bot_queued_process( source, process_name, process_func, flat_args( vararg, varargcount ) );
}

// Namespace bots_util
// Params 0
// Checksum 0x59027820, Offset: 0x14cb
// Size: 0xa1
function function_37a3a6193a454294()
{
    var_f7016fbc6a3d3300 = getdvar( @"hash_60a0d5bfe9495df6" );
    
    if ( var_f7016fbc6a3d3300 )
    {
        return;
    }
    
    var_77ff22fce9e81fd0 = getdvar( @"hash_7a6544615037bf02" );
    
    if ( var_77ff22fce9e81fd0 )
    {
        return getxhashasset( var_77ff22fce9e81fd0 );
    }
    
    if ( level.gametypebundle.var_fd3a1a6b45be175c )
    {
        var_22b1f128d031cc4f = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_cf5eb6a6c8fdc3a8" ];
        
        if ( var_22b1f128d031cc4f && var_22b1f128d031cc4f.behaviortreeasset )
        {
            return var_22b1f128d031cc4f.behaviortreeasset;
        }
    }
}

// Namespace bots_util
// Params 0
// Checksum 0xc3dbcb9e, Offset: 0x1575
// Size: 0x9c
function function_8a733bde8a63352d()
{
    var_bfbe643343ed59f9 = getdvar( @"hash_a0c22b1c6174a80a", "" );
    
    if ( var_bfbe643343ed59f9 != "" )
    {
        return getxhashasset( var_bfbe643343ed59f9 );
    }
    
    if ( level.gametypebundle.var_fd3a1a6b45be175c )
    {
        var_42f07e466884ca9 = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_fc3e08496426bcba" ];
        
        if ( var_42f07e466884ca9 && var_42f07e466884ca9.botbtconstants )
        {
            return var_42f07e466884ca9.botbtconstants;
        }
    }
    
    return getxhashasset( %"hash_11eb7b386fce50f7" );
}

// Namespace bots_util
// Params 0
// Checksum 0x69de095, Offset: 0x161a
// Size: 0x9, Type: bool
function function_deef484b5b3a3977()
{
    return isdefined( function_37a3a6193a454294() );
}

// Namespace bots_util
// Params 0
// Checksum 0xe066cf19, Offset: 0x162c
// Size: 0x1a, Type: bool
function bot_is_remote_or_linked()
{
    return utility::isusingremote() || self islinked() || self isusingremoteturret();
}

// Namespace bots_util
// Params 3
// Checksum 0x158a8171, Offset: 0x164f
// Size: 0x73, Type: bool
function function_443e66298844a5a( point, radius = 256, height = 72 )
{
    closestpoint = getclosestpointonnavmesh( point );
    var_b16376d34a3f4eb0 = closestpoint - point;
    
    if ( length2dsquared( var_b16376d34a3f4eb0 ) > radius * radius )
    {
        return false;
    }
    
    if ( abs( var_b16376d34a3f4eb0[ 2 ] ) > height )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_util
// Params 0
// Checksum 0xbcca6ed0, Offset: 0x16cb
// Size: 0xe7
function function_50f097cf2d8512b1()
{
    weapon_list = undefined;
    
    if ( self.weaponlist.size > 0 )
    {
        weapon_list = self.weaponlist;
    }
    else
    {
        weapon_list = self getweaponslistprimaries();
    }
    
    weapon_list_guns = [];
    
    foreach ( weapon in weapon_list )
    {
        if ( !weapon.ismelee && ( weapon.type == "bullet" || weapon.type == "projectile" ) )
        {
            weapon_list_guns[ weapon_list_guns.size ] = weapon;
        }
    }
    
    return weapon_list_guns;
}

// Namespace bots_util
// Params 0
// Checksum 0x9d85eb99, Offset: 0x17bb
// Size: 0xa0
function bot_get_total_gun_ammo()
{
    total_ammo = 0;
    weapon_list = function_50f097cf2d8512b1();
    
    foreach ( weapon in weapon_list )
    {
        total_ammo += self getweaponammoclip( weapon );
        total_ammo += self getweaponammostock( weapon );
    }
    
    return total_ammo;
}

// Namespace bots_util
// Params 0
// Checksum 0x28714911, Offset: 0x1864
// Size: 0xa, Type: bool
function bot_out_of_ammo()
{
    return bot_get_total_gun_ammo() <= 0;
}

// Namespace bots_util
// Params 1
// Checksum 0xcdeb7974, Offset: 0x1877
// Size: 0xc1, Type: bool
function bot_get_low_on_ammo( minfrac )
{
    weapon_list = function_50f097cf2d8512b1();
    
    foreach ( weapon in weapon_list )
    {
        max_clip_ammo = weaponclipsize( weapon );
        stock_ammo = self getweaponammostock( weapon );
        
        if ( stock_ammo <= max_clip_ammo )
        {
            return true;
        }
        
        if ( self getfractionmaxammo( weapon ) <= minfrac )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_util
// Params 1
// Checksum 0x34711411, Offset: 0x1941
// Size: 0xe2
function bot_get_low_on_all_ammo( minfrac )
{
    weapon_list = function_50f097cf2d8512b1();
    low_on_all_ammo = 0;
    lowammo = 0;
    
    foreach ( weapon in weapon_list )
    {
        max_clip_ammo = weaponclipsize( weapon );
        stock_ammo = self getweaponammostock( weapon );
        
        if ( stock_ammo <= max_clip_ammo || self getfractionmaxammo( weapon ) <= minfrac )
        {
            lowammo++;
        }
    }
    
    if ( lowammo == weapon_list.size )
    {
        low_on_all_ammo = 1;
    }
    
    return low_on_all_ammo;
}

// Namespace bots_util
// Params 0
// Checksum 0xec859646, Offset: 0x1a2c
// Size: 0x93
function bot_get_grenade_ammo()
{
    total_grenades = 0;
    offhand_list = self getweaponslistoffhands();
    
    foreach ( weapon in offhand_list )
    {
        total_grenades += self getweaponammostock( weapon );
    }
    
    return total_grenades;
}

// Namespace bots_util
// Params 2
// Checksum 0x3d258e1f, Offset: 0x1ac8
// Size: 0x5b
function bot_force_stance_for_time( stance, seconds )
{
    self notify( #"bot_force_stance_for_time" );
    self endon( #"bot_force_stance_for_time" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self botsetstance( stance );
    wait seconds;
    self botsetstance( "none" );
}

// Namespace bots_util
// Params 1
// Checksum 0xbc9c242, Offset: 0x1b2b
// Size: 0x64
function bot_disable_movement_for_time( time )
{
    self notify( #"hash_5bb290ffd5e7723c" );
    self endon( #"hash_5bb290ffd5e7723c" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self botsetflag( "disable_movement", 1 );
    wait time;
    self botsetflag( "disable_movement", 0 );
}

// Namespace bots_util
// Params 1
// Checksum 0xe12b895b, Offset: 0x1b97
// Size: 0x64
function function_d84fd08da3207687( time )
{
    self notify( #"hash_7e2dd3888c9e1ea2" );
    self endon( #"hash_7e2dd3888c9e1ea2" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self botsetflag( "disable_attack", 1 );
    wait time;
    self botsetflag( "disable_attack", 0 );
}

// Namespace bots_util
// Params 2
// Checksum 0xee7f77bd, Offset: 0x1c03
// Size: 0x37, Type: bool
function function_647587f8e2d828a7( position, radius )
{
    navpoint = self getclosestreachablepointonnavmesh( position );
    return distance( navpoint, position ) <= ( radius ?? 100 );
}

// Namespace bots_util
// Params 2
// Checksum 0x24f2ba40, Offset: 0x1c43
// Size: 0x161, Type: bool
function bot_item_matches_purpose( purpose, weaponitem )
{
    assert( isdefined( weaponitem ) );
    
    switch ( purpose )
    {
        case #"hash_c668866445f6783d":
            rootstring = getweaponrootstring( weaponitem );
            
            switch ( rootstring )
            {
                case #"hash_36b7174a04de8799":
                    return true;
            }
            
            break;
        case #"hash_82ea0e6e4f123b62":
            rootstring = getweaponrootstring( weaponitem );
            
            switch ( rootstring )
            {
                case #"hash_1cd346c1ee356308":
                case #"hash_333525cef39d0c66":
                case #"hash_4714926c2f3e2d15":
                case #"hash_67182e3e0048056f":
                case #"hash_f7d2b3d20ecdcc2c":
                    return true;
            }
            
            switch ( weaponitem.var_5e3a1c87edc1edd5 )
            {
                case #"hash_22d2079b97c4a1a4":
                case #"at_mine":
                case #"shockstick_proximity":
                    return true;
            }
            
            break;
        case #"hash_b88634b3edd5e12":
            switch ( weaponitem.var_5e3a1c87edc1edd5 )
            {
                case #"c4":
                    return true;
            }
            
            break;
        case #"hash_ef605d4a0c81fb31":
            switch ( weaponitem.basename )
            {
                case #"hash_af8ceb5f2fc2f9cd":
                    return true;
            }
            
            break;
    }
    
    return false;
}

