// scripts\mp\bots\bots_util.gsc  (hash_6a4dd5b41c09d1dc.gscc) (size: 23426 Bytes / 0x5b82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43d4dc21 (1138023457)
// size ...... 23426 (0x5b82)
// includes .. 11  (offset: 0x5682)
// strings ... 57  (offset: 0x56da)
// dev strs .. 21  (offset: 0x5a82)
// exports ... 58  (offset: 0x3a86)
// cseg ...... 0x342 + 0x3744 (0x3a86)
// imports ... 150 (offset: 0x4396)
// animtree1 . 0   (offset: 0x5b82)
// animtree2 . 0   (offset: 0x5b82)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\debug;
#using scripts\common\game_utility;
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\common\utility\game;
#using scripts\mp\parachute;

#namespace bots_util_mp;

// Namespace bots_util_mp
// Params 2
// Checksum 0xf5818eea, Offset: 0x360
// Size: 0x11c
function bot_goal_can_override( goal_type_1, goal_type_2 )
{
    if ( goal_type_1 == "none" )
    {
        return ( goal_type_2 == "none" );
    }
    else if ( goal_type_1 == "hunt" )
    {
        return ( goal_type_2 == "hunt" || goal_type_2 == "none" );
    }
    else if ( goal_type_1 == "guard" )
    {
        return ( goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none" );
    }
    else if ( goal_type_1 == "objective" )
    {
        return ( goal_type_2 == "objective" || goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none" );
    }
    else if ( goal_type_1 == "critical" )
    {
        return ( goal_type_2 == "critical" || goal_type_2 == "objective" || goal_type_2 == "guard" || goal_type_2 == "hunt" || goal_type_2 == "none" );
    }
    else if ( goal_type_1 == "tactical" )
    {
        return 1;
    }
    
    assert( 0, "<dev string:x24>" );
}

// Namespace bots_util_mp
// Params 0
// Checksum 0xa8d83d03, Offset: 0x484
// Size: 0xd9
function function_3a78b8550144eb18()
{
    var_54518471791f7b8 = self function_278f1d2ef9886d91();
    
    if ( isdefined( var_54518471791f7b8 ) )
    {
        minxp = progression_utility::getrankinfominxp( var_54518471791f7b8[ "rank" ] ) ?? 0;
        maxxp = progression_utility::getrankinfomaxxp( var_54518471791f7b8[ "rank" ] ) ?? 0;
        var_54518471791f7b8[ "rankxp" ] = randomintrange( minxp, maxxp + 1 );
        self.pers[ "rankxp" ] = var_54518471791f7b8[ "rankxp" ];
        self.pers[ "rank" ] = progression_utility::getrankforxp( self.pers[ "rankxp" ] );
        self.pers[ "prestige" ] = var_54518471791f7b8[ "prestige" ];
        self setrank( self.pers[ "rank" ], self.pers[ "prestige" ] );
    }
}

// Namespace bots_util_mp
// Params 0
// Checksum 0xdfdd4191, Offset: 0x565
// Size: 0x80
function function_984f6e9dc42adc38()
{
    if ( isdvardefined( @"hash_ef7ffe5706136ad9" ) && isbot( self ) )
    {
        debug_personality = getdvar( @"hash_ef7ffe5706136ad9" );
        
        if ( debug_personality != "none" )
        {
            return debug_personality;
        }
    }
    
    if ( isdvardefined( @"hash_4c81dcae285a8b13" ) && isautopilot( self ) )
    {
        var_b4df13db3f69ad52 = getdvar( @"hash_4c81dcae285a8b13" );
        
        if ( var_b4df13db3f69ad52 != "none" )
        {
            return var_b4df13db3f69ad52;
        }
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x99a58d5, Offset: 0x5ee
// Size: 0x5a
function bot_set_personality( personality )
{
    debug_personality = function_984f6e9dc42adc38();
    
    if ( isdefined( debug_personality ) )
    {
        personality = debug_personality;
    }
    
    previous_personality = self botgetpersonality();
    self botsetpersonality( personality );
    bots_personality::bot_assign_personality_functions();
    self botclearscriptgoal();
    
    if ( previous_personality != personality )
    {
        bots_loadout::function_605c93dfe43e02ee();
    }
}

// Namespace bots_util_mp
// Params 0
// Checksum 0xc09745aa, Offset: 0x650
// Size: 0x39
function function_39a1d810f2bdb905()
{
    if ( isdvardefined( @"bot_debugdifficulty" ) )
    {
        debug_difficulty = getdvar( @"bot_debugdifficulty" );
        
        if ( debug_difficulty != "none" )
        {
            return debug_difficulty;
        }
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x675f85c3, Offset: 0x692
// Size: 0x8d
function bot_set_difficulty( difficulty )
{
    debug_difficulty = function_39a1d810f2bdb905();
    
    if ( isdefined( debug_difficulty ) )
    {
        difficulty = debug_difficulty;
    }
    
    if ( difficulty == "mixed" )
    {
        difficulty = function_15fe6c599d3e7e77();
    }
    
    previous_difficulty = self botgetdifficulty();
    self botsetdifficulty( difficulty );
    self.difficulty = difficulty;
    self.pers[ "bot_difficulty" ] = difficulty;
    
    if ( isplayer( self ) && previous_difficulty != difficulty )
    {
        function_3a78b8550144eb18();
        bots_loadout::function_605c93dfe43e02ee();
    }
}

// Namespace bots_util_mp
// Params 0
// Checksum 0xa53c99cf, Offset: 0x727
// Size: 0x31a
function function_15fe6c599d3e7e77()
{
    if ( isdefined( self.pers[ "bot_chosen_difficulty" ] ) )
    {
        return self.pers[ "bot_chosen_difficulty" ];
    }
    
    my_team = self.team ?? self.pers[ "team" ];
    assert( isdefined( my_team ) );
    bot_difficulty_types = [];
    bot_difficulty_types[ bot_difficulty_types.size ] = "easy";
    bot_difficulty_types[ bot_difficulty_types.size ] = "normal";
    bot_difficulty_types[ bot_difficulty_types.size ] = "hard";
    var_e48bf65f4bb8978d = [];
    
    foreach ( difficulty_type in bot_difficulty_types )
    {
        var_e48bf65f4bb8978d[ difficulty_type ] = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !( isautopilot( player ) || isbot( player ) ) )
        {
            continue;
        }
        
        player_team = player.team ?? player.pers[ "team" ];
        
        if ( player_team == my_team || !level.teambased )
        {
            difficulty = player botgetdifficulty();
            
            if ( difficulty != "mixed" )
            {
                difficulty_type = function_82d8dc8ba7eee745( difficulty );
                var_e48bf65f4bb8978d[ difficulty_type ]++;
            }
        }
    }
    
    var_c132cf41069a3eeb = 9999;
    
    foreach ( count in var_e48bf65f4bb8978d )
    {
        if ( count < var_c132cf41069a3eeb )
        {
            var_c132cf41069a3eeb = count;
        }
    }
    
    difficulty_type_options = [];
    
    foreach ( difficulty_type, count in var_e48bf65f4bb8978d )
    {
        if ( count == var_c132cf41069a3eeb )
        {
            difficulty_type_options[ difficulty_type_options.size ] = difficulty_type;
        }
    }
    
    difficulty_type_picked = utility::array_random( difficulty_type_options );
    self.pers[ "bot_chosen_difficulty" ] = get_difficulty_for_difficulty_type( difficulty_type_picked );
    return self.pers[ "bot_chosen_difficulty" ];
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xc16148b0, Offset: 0xa4a
// Size: 0x69
function get_difficulty_for_difficulty_type( difficulty_type )
{
    if ( difficulty_type == "easy" )
    {
        return "recruit";
    }
    
    if ( difficulty_type == "normal" )
    {
        return "regular";
    }
    
    if ( difficulty_type == "hard" )
    {
        return utility::array_random( [ "hardened", "veteran" ] );
    }
    
    assertmsg( "<dev string:x6d>" );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x353a759, Offset: 0xabb
// Size: 0x79
function function_82d8dc8ba7eee745( difficulty )
{
    if ( difficulty == "recruit" )
    {
        return "easy";
    }
    
    if ( difficulty == "regular" )
    {
        return "normal";
    }
    
    if ( difficulty == "hardened" || difficulty == "veteran" || difficulty == "elite" || difficulty == "master" )
    {
        return "hard";
    }
    
    assertmsg( "<dev string:x6d>" );
}

// Namespace bots_util_mp
// Params 3
// Checksum 0x4ab80981, Offset: 0xb3c
// Size: 0xc1
function entrance_visible_from( entrance_origin, from_origin, stance )
{
    assert( stance == "<dev string:x79>" || stance == "<dev string:x7f>" || stance == "<dev string:x86>" );
    prone_offset = ( 0, 0, 11 );
    crouch_offset = ( 0, 0, 40 );
    offset = undefined;
    
    if ( stance == "stand" )
    {
        return 1;
    }
    else if ( stance == "crouch" )
    {
        offset = crouch_offset;
    }
    else if ( stance == "prone" )
    {
        offset = prone_offset;
    }
    
    return sighttracepassed( from_origin + offset, entrance_origin + offset, 0, undefined );
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x7d5ee576, Offset: 0xc06
// Size: 0x74, Type: bool
function function_6ed0ed07336b5fee( label1, label2 )
{
    if ( !isdefined( self.on_path_from ) )
    {
        return false;
    }
    
    if ( isdefined( self.on_path_from[ label1 ][ label2 ] ) && self.on_path_from[ label1 ][ label2 ] )
    {
        return true;
    }
    
    if ( isdefined( self.on_path_from[ label2 ][ label1 ] ) && self.on_path_from[ label2 ][ label1 ] )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x3ec39cb7, Offset: 0xc83
// Size: 0x175, Type: bool
function bot_allowed_to_use_killstreaks()
{
    assert( isalive( self ) );
    
    if ( !level.allowkillstreaks )
    {
        return false;
    }
    
    if ( self function_bece775663e54d92() )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_fefb65986b76a7e7" ) )
        {
            return false;
        }
    #/
    
    if ( game_utility_mp::iskillstreakdenied() )
    {
        return false;
    }
    
    if ( bots_util::bot_is_remote_or_linked() )
    {
        return false;
    }
    
    if ( self isusingturret() )
    {
        return false;
    }
    
    if ( isdefined( level.nukeinfo.incoming ) )
    {
        return false;
    }
    
    if ( self.underwater )
    {
        return false;
    }
    
    if ( self.controlsfrozen )
    {
        return false;
    }
    
    if ( self isoffhandweaponreadytothrow() )
    {
        return false;
    }
    
    if ( game_utility_mp::getgametypenumlives() > 0 )
    {
        var_ba88cf4965183c62 = 1;
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && !isalliedsentient( self, player ) )
            {
                var_ba88cf4965183c62 = 0;
            }
        }
        
        if ( var_ba88cf4965183c62 )
        {
            return false;
        }
    }
    
    if ( self.botdisablekillstreaks )
    {
        return false;
    }
    
    if ( !bots_util::bot_in_combat( 500 ) )
    {
        return true;
    }
    
    if ( !isalive( self.enemy ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x34372982, Offset: 0xe01
// Size: 0x1f8
function bot_recent_point_of_interest()
{
    result = undefined;
    var_a6a2179315263471 = botmemoryflags( "investigated", "killer_died" );
    var_64d6abe4e475884f = botmemoryflags( "investigated" );
    var_f3d50279b4b31ff4 = utility::array_random( botgetmemoryevents( 0, gettime() - 10000, 1, "death", var_a6a2179315263471, self ) );
    
    if ( isdefined( var_f3d50279b4b31ff4 ) )
    {
        result = var_f3d50279b4b31ff4;
        self.bot_memory_goal_time = 10000;
    }
    else
    {
        var_b54cffbe7500a868 = undefined;
        
        if ( self botgetscriptgoaltype() != "none" )
        {
            var_b54cffbe7500a868 = self botgetscriptgoal();
        }
        
        var_a5fbe6433b83197 = botgetmemoryevents( 0, gettime() - 45000, 1, "kill", var_64d6abe4e475884f, self );
        var_ac2d6904a921de0 = botgetmemoryevents( 0, gettime() - 45000, 1, "death", var_a6a2179315263471, self );
        var_f3d50279b4b31ff4 = utility::array_random( arraycombine( var_a5fbe6433b83197, var_ac2d6904a921de0 ) );
        
        if ( isdefined( var_f3d50279b4b31ff4 ) > 0 && ( !isdefined( var_b54cffbe7500a868 ) || distancesquared( var_b54cffbe7500a868, var_f3d50279b4b31ff4 ) > 1000000 ) )
        {
            result = var_f3d50279b4b31ff4;
            self.bot_memory_goal_time = 45000;
        }
    }
    
    if ( isdefined( result ) )
    {
        var_475f23c4c013c45b = undefined;
        var_b163178276476e23 = findclosesttacpointinsight( result );
        
        if ( !isdefined( var_b163178276476e23 ) )
        {
            var_b163178276476e23 = findclosesttacpoint( result );
        }
        
        if ( isdefined( var_b163178276476e23 ) )
        {
            var_475f23c4c013c45b = var_b163178276476e23.navzoneindex;
        }
        
        myzone = undefined;
        mytacpoint = self getnearesttacpoint();
        
        if ( isdefined( mytacpoint ) )
        {
            myzone = mytacpoint.navzoneindex;
        }
        
        if ( isdefined( var_475f23c4c013c45b ) && isdefined( myzone ) && var_475f23c4c013c45b != -1 && myzone != var_475f23c4c013c45b )
        {
            activity = botzonegetcount( var_475f23c4c013c45b, self.team, "ally" ) + botzonegetcount( var_475f23c4c013c45b, self.team, "path_ally" );
            
            if ( activity > 1 )
            {
                result = undefined;
            }
        }
    }
    
    if ( isdefined( result ) )
    {
        self.bot_memory_goal = result;
    }
    
    return result;
}

/#

    // Namespace bots_util_mp
    // Params 9
    // Checksum 0x9c15eae5, Offset: 0x1002
    // Size: 0x73, Type: dev
    function bot_draw_cylinder( pos, rad, height, duration, stop_notify, color, depthtest, sides, alpha )
    {
        if ( !isdefined( duration ) )
        {
            duration = 0;
        }
        
        level thread bot_draw_cylinder_think( pos, rad, height, duration, stop_notify, color, depthtest, sides, alpha );
    }

    // Namespace bots_util_mp
    // Params 9
    // Checksum 0x79f5ba2b, Offset: 0x107d
    // Size: 0x1be, Type: dev
    function bot_draw_cylinder_think( pos, rad, height, seconds, stop_notify, color, depthtest, sides, alpha )
    {
        if ( isdefined( stop_notify ) )
        {
            level endon( stop_notify );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        if ( !isdefined( sides ) )
        {
            sides = 20;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        stop_time = gettime() + seconds * 1000;
        currad = rad;
        curheight = height;
        
        for ( ;; )
        {
            if ( seconds > 0 && stop_time <= gettime() )
            {
                return;
            }
            
            for ( r = 0; r < sides ; r++ )
            {
                theta = r / sides * 360;
                theta2 = ( r + 1 ) / sides * 360;
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ), color, alpha, depthtest );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ), color, alpha, depthtest );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), color, alpha, depthtest );
            }
            
            waitframe();
        }
    }

    // Namespace bots_util_mp
    // Params 5
    // Checksum 0xd6f91b60, Offset: 0x1243
    // Size: 0x133, Type: dev
    function bot_draw_circle( center, radius, color, depthtest, segments )
    {
        if ( !isdefined( segments ) )
        {
            segments = 16;
        }
        
        anglefrac = 360 / segments;
        circlepoints = [];
        
        for ( i = 0; i < segments ; i++ )
        {
            angle = anglefrac * i;
            xadd = cos( angle ) * radius;
            yadd = sin( angle ) * radius;
            x = center[ 0 ] + xadd;
            y = center[ 1 ] + yadd;
            z = center[ 2 ];
            circlepoints[ circlepoints.size ] = ( x, y, z );
        }
        
        for ( i = 0; i < circlepoints.size ; i++ )
        {
            start = circlepoints[ i ];
            
            if ( i + 1 >= circlepoints.size )
            {
                end = circlepoints[ 0 ];
            }
            else
            {
                end = circlepoints[ i + 1 ];
            }
            
            line( start, end, color, 1, depthtest );
        }
    }

#/

// Namespace bots_util_mp
// Params 8
// Checksum 0xd7257bb8, Offset: 0x137e
// Size: 0xa15
function bot_watch_tacpoints( tacpoints, yaw, yaw_fov, end_time, end1, end2, end3, end4 )
{
    self notify( #"bot_watch_tacpoints" );
    self endon( #"bot_watch_tacpoints" );
    self endon( #"bot_watch_tacpoints_stop" );
    self endon( #"using_remote" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( end1 ) )
    {
        self endon( end1 );
    }
    
    if ( isdefined( end2 ) )
    {
        self endon( end2 );
    }
    
    if ( isdefined( end3 ) )
    {
        self endon( end3 );
    }
    
    if ( isdefined( end4 ) )
    {
        self endon( end4 );
    }
    
    assert( isdefined( tacpoints ) );
    wait 0.5;
    keep_waiting = 1;
    
    if ( self isusingturret() )
    {
        keep_waiting = 0;
    }
    
    radius_sq = squared( self botgetscriptgoalradius() );
    
    while ( keep_waiting )
    {
        if ( self bothasscriptgoal() && self botpursuingscriptgoal() )
        {
            if ( distancesquared( self botgetscriptgoal(), self.origin ) < radius_sq )
            {
                if ( length( self getvelocity() ) <= 1 )
                {
                    keep_waiting = 0;
                }
            }
        }
        
        if ( keep_waiting )
        {
            wait 0.05;
        }
    }
    
    tacpoint_height_offset = ( 0, 0, 40 );
    
    if ( isdefined( tacpoints ) )
    {
        self.watch_tacpoints = [];
        
        foreach ( tacpoint in tacpoints )
        {
            tacpoint_invalid = 0;
            
            if ( distance2dsquared( self.origin, tacpoint.groundpos ) <= 40 )
            {
                tacpoint_invalid = 1;
            }
            
            self_eye = self geteye();
            var_e582e834147af9e6 = vectordot( ( 0, 0, 1 ), vectornormalize( tacpoint.groundpos + tacpoint_height_offset - self_eye ) );
            
            if ( abs( var_e582e834147af9e6 ) > 0.92 )
            {
                tacpoint_invalid = 1;
                assert( abs( tacpoint.groundpos[ 2 ] - self_eye[ 2 ] ) < 1000, "<dev string:x8c>" + self_eye + "<dev string:xc5>" + tacpoint.groundpos );
            }
            
            if ( !tacpoint_invalid )
            {
                self.watch_tacpoints[ self.watch_tacpoints.size ] = tacpoint;
            }
        }
    }
    
    if ( !isdefined( self.watch_tacpoints ) )
    {
        return;
    }
    
    thread watch_tacpoints_aborted();
    self.watch_tacpoints = arrayrandomize( self.watch_tacpoints );
    assert( isdefined( self.entity_number ) );
    
    foreach ( tacpoint in self.watch_tacpoints )
    {
        tacpoint.watch_tacpoint_chance[ self.entity_number ] = 1;
        tacpoint.var_40758809a01da5b5[ self.entity_number ] = 1;
    }
    
    var_5c673bc55653c791 = [];
    
    for ( i = 0; i < self.watch_tacpoints.size ; i++ )
    {
        var_5c673bc55653c791[ i ] = [];
        var_8adf67edd972fd07 = vectornormalize( self.watch_tacpoints[ i ].groundpos - self.origin );
        
        for ( j = 0; j < self.watch_tacpoints.size ; j++ )
        {
            if ( i == j )
            {
                continue;
            }
            
            var_8adf68edd972ff3a = vectornormalize( self.watch_tacpoints[ j ].groundpos - self.origin );
            dot = vectordot( var_8adf67edd972fd07, var_8adf68edd972ff3a );
            
            if ( dot > 0.94 )
            {
                var_5c673bc55653c791[ i ][ var_5c673bc55653c791[ i ].size ] = j;
            }
        }
    }
    
    while ( true )
    {
        var_ef805a44b404fa2c = -1;
        most_neighbors = 0;
        
        for ( i = 0; i < self.watch_tacpoints.size ; i++ )
        {
            if ( var_5c673bc55653c791[ i ].size > most_neighbors )
            {
                var_ef805a44b404fa2c = i;
                most_neighbors = var_5c673bc55653c791[ i ].size;
            }
        }
        
        if ( var_ef805a44b404fa2c == -1 )
        {
            break;
        }
        
        var_1c0d7a5cd08ccb1d = self.watch_tacpoints[ var_ef805a44b404fa2c ];
        var_1c0d7a5cd08ccb1d.watch_tacpoint_chance[ self.entity_number ] = 0.5;
        var_1c0d7a5cd08ccb1d.var_40758809a01da5b5[ self.entity_number ] = 0.5;
        var_5c673bc55653c791[ var_ef805a44b404fa2c ] = [];
        
        for ( i = 0; i < var_5c673bc55653c791.size ; i++ )
        {
            if ( arraycontains( var_5c673bc55653c791[ i ], var_ef805a44b404fa2c ) )
            {
                var_5c673bc55653c791[ i ] = arrayremove( var_5c673bc55653c791[ i ], var_ef805a44b404fa2c );
            }
        }
    }
    
    starttime = gettime();
    var_f152b8cb042e1465 = starttime;
    var_c8eeb4b09a6339b4 = [];
    yawangles = undefined;
    
    if ( isdefined( yaw ) )
    {
        yawangles = ( 0, yaw, 0 );
    }
    
    var_cbd7bedd6d14daa9 = isdefined( yawangles ) && isdefined( yaw_fov );
    var_360458a79a4819f2 = undefined;
    var_a836dfc3ef044e3c = undefined;
    wait 0.1;
    
    for ( ;; )
    {
        now = gettime();
        self notify( #"still_watching_tacpoints" );
        
        if ( now >= end_time )
        {
            return;
        }
        
        if ( bots_tactical_goals::has_tactical_goal() )
        {
            self botlookatpoint( undefined );
            wait 0.2;
            continue;
        }
        
        if ( !self bothasscriptgoal() || !self botpursuingscriptgoal() )
        {
            wait 0.2;
            continue;
        }
        
        if ( isdefined( var_a836dfc3ef044e3c ) && var_a836dfc3ef044e3c.watch_tacpoint_chance[ self.entity_number ] == 0 )
        {
            var_f152b8cb042e1465 = now;
        }
        
        if ( self.watch_tacpoints.size > 0 )
        {
            var_c587a83f8022fa04 = 0;
            
            if ( isdefined( self.enemy ) )
            {
                var_67a45c012d627799 = self lastknownpos( self.enemy );
                var_21600034d8c2d274 = self lastknowntime( self.enemy );
                
                if ( var_21600034d8c2d274 && now - var_21600034d8c2d274 < 5000 )
                {
                    direnemy = vectornormalize( var_67a45c012d627799 - self.origin );
                    maxdot = 0;
                    
                    for ( i = 0; i < self.watch_tacpoints.size ; i++ )
                    {
                        dirtacpoint = vectornormalize( self.watch_tacpoints[ i ].groundpos - self.origin );
                        dot = vectordot( direnemy, dirtacpoint );
                        
                        if ( dot > maxdot )
                        {
                            maxdot = dot;
                            var_a836dfc3ef044e3c = self.watch_tacpoints[ i ];
                            var_c587a83f8022fa04 = 1;
                        }
                    }
                }
            }
            
            if ( !var_c587a83f8022fa04 && now >= var_f152b8cb042e1465 )
            {
                var_d30e511c60d4451a = [];
                
                for ( i = 0; i < self.watch_tacpoints.size ; i++ )
                {
                    tacpoint = self.watch_tacpoints[ i ];
                    tacpoint_num = gettacpointuniqueindex( tacpoint );
                    
                    if ( var_cbd7bedd6d14daa9 && !utility::within_fov( self.origin, yawangles, tacpoint.groundpos, yaw_fov ) )
                    {
                        continue;
                    }
                    
                    if ( distance2dsquared( self.origin, tacpoint.groundpos ) <= 10 )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( var_c8eeb4b09a6339b4[ tacpoint_num ] ) )
                    {
                        var_c8eeb4b09a6339b4[ tacpoint_num ] = 0;
                    }
                    
                    if ( self function_6c6e0a8bb89a022e( tacpoint.groundpos + ( 0, 0, 35 ) ) )
                    {
                        var_c8eeb4b09a6339b4[ tacpoint_num ] = now;
                    }
                    
                    for ( index = 0; index < var_d30e511c60d4451a.size ; index++ )
                    {
                        if ( var_c8eeb4b09a6339b4[ gettacpointuniqueindex( var_d30e511c60d4451a[ index ] ) ] > var_c8eeb4b09a6339b4[ tacpoint_num ] )
                        {
                            break;
                        }
                    }
                    
                    arrayinsert( var_d30e511c60d4451a, tacpoint, index );
                }
                
                var_360458a79a4819f2 = var_a836dfc3ef044e3c;
                var_a836dfc3ef044e3c = undefined;
                
                if ( var_d30e511c60d4451a.size == 1 )
                {
                    var_a836dfc3ef044e3c = var_d30e511c60d4451a[ 0 ];
                }
                else if ( var_d30e511c60d4451a.size > 1 )
                {
                    var_afcd0adae93a724e = [];
                    total_weight = 0;
                    
                    for ( i = 0; i < var_d30e511c60d4451a.size ; i++ )
                    {
                        this_tacpoint = var_d30e511c60d4451a[ i ];
                        var_fe451726396a8890 = 1 - i / ( var_d30e511c60d4451a.size - 1 ) * 0.5;
                        assert( isdefined( self.entity_number ) );
                        assert( isdefined( this_tacpoint.watch_tacpoint_chance ) );
                        var_4f5432936dd6e6fa = this_tacpoint.watch_tacpoint_chance[ self.entity_number ];
                        assert( isdefined( var_4f5432936dd6e6fa ) );
                        var_a4205457b2c21d25 = spawnstruct();
                        var_a4205457b2c21d25.tacpoint = this_tacpoint;
                        var_a4205457b2c21d25.modified_chance = var_4f5432936dd6e6fa * var_fe451726396a8890;
                        var_afcd0adae93a724e[ var_afcd0adae93a724e.size ] = var_a4205457b2c21d25;
                        total_weight += var_fe451726396a8890;
                    }
                    
                    random_choice = randomfloat( total_weight );
                    
                    for ( i = 0; i < var_afcd0adae93a724e.size ; i++ )
                    {
                        if ( random_choice < var_afcd0adae93a724e[ i ].modified_chance )
                        {
                            var_a836dfc3ef044e3c = var_afcd0adae93a724e[ i ].tacpoint;
                            break;
                        }
                        
                        random_choice -= var_afcd0adae93a724e[ i ].modified_chance;
                    }
                }
                
                if ( isdefined( var_a836dfc3ef044e3c ) )
                {
                    var_f152b8cb042e1465 = now + randomintrange( 3000, 5000 );
                    var_a104f062293bdfd4 = var_360458a79a4819f2 != var_a836dfc3ef044e3c;
                    
                    if ( var_a104f062293bdfd4 && self.var_1a299b1f8b7a04e6 )
                    {
                        childthread bot_handle_stance_for_look( var_a836dfc3ef044e3c );
                    }
                }
            }
            
            if ( isdefined( var_a836dfc3ef044e3c ) )
            {
                look_at_point = var_a836dfc3ef044e3c.groundpos + tacpoint_height_offset;
                
                if ( distance2dsquared( self.origin, look_at_point ) <= 10 )
                {
                    self botlookatpoint( undefined );
                    var_a836dfc3ef044e3c = undefined;
                    var_f152b8cb042e1465 = 0;
                }
                else
                {
                    self botlookatpoint( look_at_point, 0.4, "script_search" );
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xfc8a777a, Offset: 0x1d9b
// Size: 0xcf
function bot_handle_stance_for_look( var_a836dfc3ef044e3c )
{
    if ( isdefined( self.cur_defend_stance ) )
    {
        stance_desired = self.cur_defend_stance;
        
        if ( stance_desired == "prone" && self getstance() == "prone" )
        {
            self botsetstance( "crouch" );
            wait 1;
        }
        
        if ( stance_desired == "prone" )
        {
            if ( function_9b78f37c61f3eedd( self getnearesttacpoint(), var_a836dfc3ef044e3c ) )
            {
                self botsetstance( "prone" );
            }
            else
            {
                stance_desired = "crouch";
            }
        }
        
        if ( stance_desired == "crouch" )
        {
            if ( function_e6fd73f97c831653( self getnearesttacpoint(), var_a836dfc3ef044e3c ) )
            {
                self botsetstance( "crouch" );
            }
            else
            {
                stance_desired = "stand";
            }
        }
        
        if ( stance_desired == "stand" )
        {
            self botsetstance( "stand" );
        }
    }
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x5b80d9d, Offset: 0x1e72
// Size: 0x9a
function function_9b78f37c61f3eedd( tacpointfrom, tacpointto )
{
    var_32656f1582238b73 = gettacpointuniqueindex( tacpointto );
    
    if ( !isdefined( tacpointfrom.var_9efc38ca5231b6cd[ var_32656f1582238b73 ] ) )
    {
        tacpoints_visible = sighttracepassed( tacpointfrom.groundpos + ( 0, 0, 11 ), tacpointto.groundpos + ( 0, 0, 11 ), 0, undefined );
        tacpointfrom.var_9efc38ca5231b6cd[ var_32656f1582238b73 ] = tacpoints_visible;
    }
    
    return tacpointfrom.var_9efc38ca5231b6cd[ var_32656f1582238b73 ];
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x964dc7ca, Offset: 0x1f15
// Size: 0x9a
function function_e6fd73f97c831653( tacpointfrom, tacpointto )
{
    var_32656f1582238b73 = gettacpointuniqueindex( tacpointto );
    
    if ( !isdefined( tacpointfrom.var_d64ba2a57e2ae695[ var_32656f1582238b73 ] ) )
    {
        tacpoints_visible = sighttracepassed( tacpointfrom.groundpos + ( 0, 0, 40 ), tacpointto.groundpos + ( 0, 0, 11 ), 0, undefined );
        tacpointfrom.var_d64ba2a57e2ae695[ var_32656f1582238b73 ] = tacpoints_visible;
    }
    
    return tacpointfrom.var_d64ba2a57e2ae695[ var_32656f1582238b73 ];
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x250ba6e7, Offset: 0x1fb8
// Size: 0x9e
function watch_tacpoints_stop()
{
    self notify( #"bot_watch_tacpoints_stop" );
    
    if ( isdefined( self.watch_tacpoints ) )
    {
        foreach ( tacpoint in self.watch_tacpoints )
        {
            function_3adb017715570d23( tacpoint );
        }
    }
    
    self.watch_tacpoints = undefined;
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x5acfc610, Offset: 0x205e
// Size: 0x70
function function_3adb017715570d23( tacpoint )
{
    assert( isdefined( self.entity_number ) );
    assert( isdefined( tacpoint.watch_tacpoint_chance ) );
    tacpoint.watch_tacpoint_chance[ self.entity_number ] = undefined;
    assert( isdefined( tacpoint.var_40758809a01da5b5 ) );
    tacpoint.var_40758809a01da5b5[ self.entity_number ] = undefined;
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x3f409b35, Offset: 0x20d6
// Size: 0x69
function watch_tacpoints_aborted()
{
    self notify( #"watch_tacpoints_aborted" );
    self endon( #"watch_tacpoints_aborted" );
    self endon( #"bot_watch_tacpoints_stop" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        msg = utility::waittill_any_timeout( 0.5, "still_watching_tacpoints" );
        
        if ( msg != "still_watching_tacpoints" )
        {
            thread watch_tacpoints_stop();
            return;
        }
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xfcb8cf9d, Offset: 0x2147
// Size: 0x202
function function_d041b15a08f29830( scalar )
{
    assert( isdefined( self.watch_tacpoints ) );
    
    if ( self.watch_tacpoints.size <= 0 )
    {
        return;
    }
    
    tacpoints_testing = self.watch_tacpoints;
    mytacpoint = self getnearesttacpoint();
    
    if ( !isdefined( mytacpoint ) )
    {
        return 0;
    }
    
    var_7a9149eab2e99afe = function_5a0bc874a4a08aa1( mytacpoint.navzoneindex );
    
    foreach ( zone in var_7a9149eab2e99afe )
    {
        if ( botzonegetcount( zone, self.team, "enemy_predict" ) <= 0 )
        {
            continue;
        }
        
        if ( tacpoints_testing.size == 0 )
        {
            break;
        }
        
        var_7da73c34a3682b04 = vectornormalize( getzoneorigin( zone ) - self.origin );
        
        for ( i = 0; i < tacpoints_testing.size ; i++ )
        {
            tacpoint_zone_index = tacpoints_testing[ i ].navzoneindex;
            var_358e23f82c37313 = 0;
            
            if ( zone == tacpoint_zone_index )
            {
                var_358e23f82c37313 = 1;
            }
            else
            {
                var_bb7ee79398f1a3b4 = vectornormalize( tacpoints_testing[ i ].groundpos - self.origin );
                dot = vectordot( var_bb7ee79398f1a3b4, var_7da73c34a3682b04 );
                
                if ( dot > 0.2 )
                {
                    var_358e23f82c37313 = 1;
                }
            }
            
            if ( var_358e23f82c37313 )
            {
                tacpoints_testing[ i ].watch_tacpoint_chance[ self.entity_number ] *= scalar;
                tacpoints_testing[ i ] = tacpoints_testing[ tacpoints_testing.size - 1 ];
                tacpoints_testing[ tacpoints_testing.size - 1 ] = undefined;
                i--;
            }
        }
    }
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x1082c4a5, Offset: 0x2351
// Size: 0xa8
function bot_leader_dialog( dialog, location )
{
    if ( isdefined( location ) && location != ( 0, 0, 0 ) )
    {
        assert( isdefined( self ) );
        assert( isdefined( self.origin ) );
        
        if ( !self function_6c6e0a8bb89a022e( location ) )
        {
            lookatloc = self botpredictseepoint( location );
            
            if ( isdefined( lookatloc ) )
            {
                self botlookatpoint( lookatloc + ( 0, 0, 40 ), 1, "script_seek" );
            }
        }
        
        self botmemoryevent( "known_enemy", undefined, location );
        self function_529c3c83df97116d( location, 300 );
    }
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x6707612d, Offset: 0x2401
// Size: 0x239
function bot_get_known_attacker( attacker, inflictor )
{
    if ( isdefined( inflictor ) && isdefined( inflictor.classname ) )
    {
        if ( inflictor.classname == "grenade" )
        {
            /#
                if ( isdefined( attacker ) && !isdefined( attacker.classname ) )
                {
                    println( "<dev string:xe5>" );
                    
                    if ( isdefined( attacker.code_classname ) )
                    {
                        println( "<dev string:x113>" + attacker.code_classname );
                    }
                    
                    if ( isdefined( attacker.name ) )
                    {
                        println( "<dev string:x12d>" + attacker.name );
                    }
                    
                    if ( isdefined( attacker.model ) )
                    {
                        println( "<dev string:x13d>" + attacker.model );
                    }
                    
                    if ( isdefined( attacker.owner ) )
                    {
                        if ( isdefined( attacker.owner.classname ) )
                        {
                            println( "<dev string:x14e>" + attacker.owner.classname );
                        }
                        
                        if ( isdefined( attacker.owner.name ) )
                        {
                            println( "<dev string:x160>" + attacker.owner.name );
                        }
                    }
                }
            #/
            
            if ( attacker.classname == "worldspawn" )
            {
                return;
            }
            
            if ( !bot_ent_is_anonymous_mine( inflictor ) )
            {
                return attacker;
            }
        }
        else if ( inflictor.classname == "rocket" )
        {
            var_7237854e3be197ca = inflictor.vehicle_fired_from;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
            
            if ( inflictor.type == "remote" )
            {
                return inflictor;
            }
            
            var_7237854e3be197ca = inflictor.owner;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        else if ( inflictor.classname == "worldspawn" || inflictor.classname == "trigger_hurt" )
        {
            return;
        }
        else if ( inflictor.classname == "script_vehicle" )
        {
            var_7237854e3be197ca = inflictor.owner;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        return inflictor;
    }
    
    return attacker;
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xd85cfa6c, Offset: 0x2643
// Size: 0x83, Type: bool
function bot_ent_is_anonymous_mine( ent )
{
    weap_name = ent.weapon_name;
    
    if ( !isdefined( weap_name ) )
    {
        weap_name = ent.weaponname;
    }
    
    if ( !isdefined( weap_name ) )
    {
        return false;
    }
    
    if ( issubstr( weap_name, "c4_mp" ) )
    {
        return true;
    }
    
    if ( issubstr( weap_name, "claymore_mp" ) )
    {
        return true;
    }
    
    if ( issubstr( weap_name, "mine_mp" ) )
    {
        return true;
    }
    
    if ( issubstr( weap_name, "proximity_explosive_mp" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_util_mp
// Params 2
// Checksum 0xbddd5f30, Offset: 0x26cf
// Size: 0x36, Type: bool
function bot_vectors_are_equal( vec1, vec2 )
{
    return vec1[ 0 ] == vec2[ 0 ] && vec1[ 1 ] == vec2[ 1 ] && vec1[ 2 ] == vec2[ 2 ];
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x2b8682ac, Offset: 0x270e
// Size: 0x66
function bot_add_to_bot_level_targets( target_to_add )
{
    target_to_add.high_priority_for = [];
    
    if ( target_to_add.bot_interaction_type == "use" )
    {
        bot_add_to_bot_use_targets( target_to_add );
        return;
    }
    
    if ( target_to_add.bot_interaction_type == "damage" )
    {
        bot_add_to_bot_damage_targets( target_to_add );
        return;
    }
    
    assertmsg( "<dev string:x16d>" );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x5164ac16, Offset: 0x277c
// Size: 0x32
function bot_remove_from_bot_level_targets( target_to_remove )
{
    target_to_remove.already_used = 1;
    level.level_specific_bot_targets = arrayremove( level.level_specific_bot_targets, target_to_remove );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x17b5adf9, Offset: 0x27b6
// Size: 0x102
function bot_add_to_bot_use_targets( var_358367d5ca434870 )
{
    if ( !issubstr( var_358367d5ca434870.code_classname, "trigger_use" ) )
    {
        assertmsg( "<dev string:x1b8>" );
        return;
    }
    
    if ( !isdefined( var_358367d5ca434870.target ) )
    {
        assertmsg( "<dev string:x1f7>" );
        return;
    }
    
    if ( isdefined( var_358367d5ca434870.bot_target ) )
    {
        assertmsg( "<dev string:x230>" );
        return;
    }
    
    if ( !isdefined( var_358367d5ca434870.use_time ) )
    {
        assertmsg( "<dev string:x277>" );
        return;
    }
    
    use_trigger_targets = getnodearray( var_358367d5ca434870.target, #targetname );
    
    if ( use_trigger_targets.size != 1 )
    {
        assertmsg( "<dev string:x2a6>" );
        return;
    }
    
    var_358367d5ca434870.bot_target = use_trigger_targets[ 0 ];
    
    if ( !isdefined( level.level_specific_bot_targets ) )
    {
        level.level_specific_bot_targets = [];
    }
    
    level.level_specific_bot_targets[ level.level_specific_bot_targets.size ] = var_358367d5ca434870;
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x82079ec4, Offset: 0x28c0
// Size: 0xa8
function bot_add_to_bot_damage_targets( new_damage_target )
{
    if ( !issubstr( new_damage_target.code_classname, "trigger_damage" ) )
    {
        assertmsg( "<dev string:x2e2>" );
        return;
    }
    
    damage_trigger_targets = getnodearray( new_damage_target.target, #targetname );
    
    if ( damage_trigger_targets.size != 2 )
    {
        assertmsg( "<dev string:x327>" );
        return;
    }
    
    new_damage_target.bot_targets = damage_trigger_targets;
    
    if ( !isdefined( level.level_specific_bot_targets ) )
    {
        level.level_specific_bot_targets = [];
    }
    
    level.level_specific_bot_targets[ level.level_specific_bot_targets.size ] = new_damage_target;
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x124b308, Offset: 0x2970
// Size: 0x96
function bot_get_string_index_for_integer( array, integer_index )
{
    current_index = 0;
    
    foreach ( string_index, array_value in array )
    {
        if ( current_index == integer_index )
        {
            return string_index;
        }
        
        current_index++;
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xd8fc180d, Offset: 0x2a0f
// Size: 0x29
function bot_get_max_players_on_team( team )
{
    assert( level.var_ae4d3fde002fedb4 );
    return level.bot_max_players_on_team[ team ];
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x8738cf78, Offset: 0x2a41
// Size: 0xf
function bot_get_team_limit()
{
    return int( bot_get_client_limit() / 2 );
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x4e6a80fb, Offset: 0x2a59
// Size: 0x1d
function bot_get_client_limit()
{
    return minint( getdvarint( @"party_maxplayers", 0 ), level.maxclients );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xd85b7457, Offset: 0x2a7f
// Size: 0x2f6
function bot_monitor_enemy_camp_spots( validatefunc )
{
    level endon( #"game_ended" );
    self notify( #"bot_monitor_enemy_camp_spots" );
    self endon( #"bot_monitor_enemy_camp_spots" );
    level.enemy_camp_spots = [];
    level.enemy_camp_assassin_goal = [];
    level.enemy_camp_assassin = [];
    
    while ( true )
    {
        wait 1;
        updated = [];
        
        if ( !isdefined( validatefunc ) )
        {
            continue;
        }
        
        foreach ( participant in level.participants )
        {
            if ( !isdefined( participant.team ) )
            {
                continue;
            }
            
            if ( participant [[ validatefunc ]]() && !isdefined( updated[ participant.team ] ) )
            {
                level.enemy_camp_assassin[ participant.team ] = undefined;
                level.enemy_camp_spots[ participant.team ] = participant botpredictenemycampspots( 1 );
                
                if ( isdefined( level.enemy_camp_spots[ participant.team ] ) )
                {
                    if ( !isdefined( level.enemy_camp_assassin_goal[ participant.team ] ) || !arraycontains( level.enemy_camp_spots[ participant.team ], level.enemy_camp_assassin_goal[ participant.team ] ) )
                    {
                        level.enemy_camp_assassin_goal[ participant.team ] = utility::array_random( level.enemy_camp_spots[ participant.team ] );
                    }
                    
                    if ( isdefined( level.enemy_camp_assassin_goal[ participant.team ] ) )
                    {
                        aiallies = [];
                        
                        foreach ( otherparticipant in level.participants )
                        {
                            if ( !isdefined( otherparticipant.team ) )
                            {
                                continue;
                            }
                            
                            if ( otherparticipant [[ validatefunc ]]() && otherparticipant.team == participant.team )
                            {
                                aiallies[ aiallies.size ] = otherparticipant;
                            }
                        }
                        
                        aiallies = sortbydistance( aiallies, level.enemy_camp_assassin_goal[ participant.team ] );
                        
                        if ( aiallies.size > 0 )
                        {
                            level.enemy_camp_assassin[ participant.team ] = aiallies[ 0 ];
                        }
                    }
                }
                
                updated[ participant.team ] = 1;
            }
        }
    }
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x906145e8, Offset: 0x2d7d
// Size: 0x76, Type: bool
function bot_valid_camp_assassin()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isai( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.team ) )
    {
        return false;
    }
    
    if ( self.team == "spectator" )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !game_utility_common::isaiteamparticipant( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.personality ) || self.personality == "camper" )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x8ffad582, Offset: 0x2dfc
// Size: 0x79
function bot_update_camp_assassin()
{
    if ( !isdefined( level.enemy_camp_assassin ) )
    {
        return;
    }
    
    if ( !isdefined( level.enemy_camp_assassin[ self.team ] ) )
    {
        return;
    }
    
    if ( level.enemy_camp_assassin[ self.team ] == self )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
        self botsetscriptgoal( level.enemy_camp_assassin_goal[ self.team ], 128, "objective" );
        self botsetobjectiveradius( 256 );
        bots_util::bot_waittill_goal_or_fail();
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x78748d7d, Offset: 0x2e7d
// Size: 0x63
function set_high_priority_target_for_bot( bot )
{
    assert( isdefined( self.bot_interaction_type ) );
    
    if ( !( isdefined( self.high_priority_for ) && arraycontains( self.high_priority_for, bot ) ) )
    {
        self.high_priority_for[ self.high_priority_for.size ] = bot;
        bot notify( #"hash_6d9fbbd5bc0a6a7a" );
    }
}

// Namespace bots_util_mp
// Params 2
// Checksum 0xdb731e42, Offset: 0x2ee8
// Size: 0x3d
function add_to_bot_use_targets( var_358367d5ca434870, use_time )
{
    var_358367d5ca434870.use_time = use_time;
    var_358367d5ca434870.bot_interaction_type = "use";
    bot_add_to_bot_level_targets( var_358367d5ca434870 );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x6794f77e, Offset: 0x2f2d
// Size: 0x15
function remove_from_bot_use_targets( var_b446fe41095f3106 )
{
    bot_remove_from_bot_level_targets( var_b446fe41095f3106 );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x782507fa, Offset: 0x2f4a
// Size: 0x15
function add_to_bot_damage_targets( new_damage_target )
{
    bot_add_to_bot_level_targets( new_damage_target );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x697caefb, Offset: 0x2f67
// Size: 0x15
function remove_from_bot_damage_targets( damage_target_to_remove )
{
    bot_remove_from_bot_level_targets( damage_target_to_remove );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xa41be22c, Offset: 0x2f84
// Size: 0x34
function notify_enemy_bots_bomb_used( type )
{
    if ( isdefined( level.bot_funcs[ "notify_enemy_bots_bomb_used" ] ) )
    {
        self [[ level.bot_funcs[ "notify_enemy_bots_bomb_used" ] ]]( type );
    }
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x6a8f3d7e, Offset: 0x2fc0
// Size: 0x1a
function function_1882f18076610076( pos )
{
    return getclosestpointonnavmesh( pos, undefined, 0, 0, 1, 0, 1 );
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x121ae772, Offset: 0x2fe3
// Size: 0x7f
function function_cdc8a7497ee4f596( point, timeout = 2 )
{
    legalpoint = function_26196082e7a55bbd( point, timeout );
    
    if ( !isdefined( legalpoint ) )
    {
        return 0;
    }
    
    timepassed = 0;
    
    while ( !function_5c445a8a5cdf8de6( legalpoint ) )
    {
        wait 0.1;
        timepassed += 0.1;
        
        if ( timepassed >= timeout )
        {
            return function_5c445a8a5cdf8de6( legalpoint );
        }
    }
    
    self botlookatpoint( undefined );
    return 1;
}

// Namespace bots_util_mp
// Params 3
// Checksum 0x1fab7c8b, Offset: 0x306b
// Size: 0x55
function function_f904775ead9c970( entity, seconds, anglerange )
{
    randomrange = randomintrange( anglerange * -1, anglerange );
    self botsetscriptmove( entity.angles[ 1 ] + randomrange, seconds, 0.1 );
    wait seconds;
}

// Namespace bots_util_mp
// Params 2
// Checksum 0x5faf9538, Offset: 0x30c8
// Size: 0x7a, Type: bool
function function_5c445a8a5cdf8de6( point, facingangle = 5 )
{
    todirection = point - self.origin;
    forward = anglestoforward( self.angles );
    dot = vectordot2( forward, todirection );
    angle = acos( clamp( dot, -1, 1 ) );
    return angle <= facingangle;
}

// Namespace bots_util_mp
// Params 2
// Checksum 0xe724a2b2, Offset: 0x314b
// Size: 0x2f
function function_26196082e7a55bbd( targetpoint, seconds )
{
    targetpoint = function_e4204a4fad0d6dbc( targetpoint );
    self botlookatpoint( targetpoint, seconds, "script_forced" );
    return targetpoint;
}

// Namespace bots_util_mp
// Params 1, eflags: 0x4
// Checksum 0x238fa3f1, Offset: 0x3183
// Size: 0xde
function private function_e4204a4fad0d6dbc( targetpoint )
{
    if ( !isdefined( targetpoint ) )
    {
        return;
    }
    
    if ( function_24c37c487e157486( targetpoint ) )
    {
        return targetpoint;
    }
    
    boteyepos = self geteye();
    var_57a9cbbf1bc64121 = targetpoint - boteyepos;
    height = var_57a9cbbf1bc64121[ 2 ];
    assert( height > 0 );
    
    if ( height < 1 )
    {
        return;
    }
    
    var_18a474abb8c32caf = length2dsquared( var_57a9cbbf1bc64121 );
    
    if ( var_18a474abb8c32caf < 1 )
    {
        var_b74c6c7cda7c1530 = anglestoforward( self.angles );
    }
    else
    {
        var_b74c6c7cda7c1530 = var_57a9cbbf1bc64121;
    }
    
    var_b74c6c7cda7c1530 = vectornormalize( ( var_b74c6c7cda7c1530[ 0 ], var_b74c6c7cda7c1530[ 1 ], 0 ) );
    var_499d21c761bcc517 = height * 0.46631;
    var_d991e502b3a629b4 = var_499d21c761bcc517 * var_b74c6c7cda7c1530;
    targetvector = var_d991e502b3a629b4 + ( 0, 0, height );
    return boteyepos + targetvector;
}

// Namespace bots_util_mp
// Params 1
// Checksum 0x83835802, Offset: 0x326a
// Size: 0x28
function function_24c37c487e157486( targetpoint )
{
    var_57a9cbbf1bc64121 = targetpoint - self geteye();
    return function_fc1e1a7234df77dd( var_57a9cbbf1bc64121 );
}

// Namespace bots_util_mp
// Params 1
// Checksum 0xa6ceafdb, Offset: 0x329b
// Size: 0x29, Type: bool
function function_fc1e1a7234df77dd( eyetopoint )
{
    return vectordot( vectornormalize( eyetopoint ), ( 0, 0, 1 ) ) <= 0.939693;
}

// Namespace bots_util_mp
// Params 0
// Checksum 0x13347a90, Offset: 0x32cd
// Size: 0x224
function function_478281ff275ed942()
{
    if ( isbrgamemode() )
    {
        minx = min( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        miny = min( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxy = max( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        minz = level.br_level.c130_sealeveloverride;
        maxz = level.br_level.c130_heightoverride;
    }
    else
    {
        x1 = level.mapcorners[ 1 ].origin[ 0 ];
        x2 = level.mapcorners[ 0 ].origin[ 0 ];
        y1 = level.mapcorners[ 1 ].origin[ 1 ];
        y2 = level.mapcorners[ 0 ].origin[ 1 ];
        minx = min( x1, x2 );
        maxx = max( x1, x2 );
        miny = min( y1, y2 );
        maxy = max( y1, y2 );
        minz = parachute::getc130sealevel();
        maxz = parachute::getc130height();
    }
    
    randompoint = ( randomfloatrange( minx, maxx ), randomfloatrange( miny, maxy ), randomfloatrange( minz, maxz ) );
    return function_1882f18076610076( randompoint );
}

// Namespace bots_util_mp
// Params 6
// Checksum 0x8a5eea88, Offset: 0x34fa
// Size: 0x275
function function_b835a2f4a5581b50( position, radius, sortbydistance, ignoreclassname, ignoretype, ignoremodel )
{
    scriptmodels = getentarrayinradius( "script_model", #code_classname, position, radius );
    scriptorigins = getentarrayinradius( "script_origin", #code_classname, position, radius );
    scriptables = getscriptablearrayinradius( undefined, undefined, position, radius );
    entitylessscriptables = getentitylessscriptablearray( undefined, undefined, position, radius );
    objects = arraycombine( scriptmodels, scriptorigins, scriptables, entitylessscriptables );
    
    if ( !isdefined( ignoreclassname ) )
    {
        ignoreclassname = [];
    }
    
    if ( !isdefined( ignoretype ) )
    {
        ignoretype = [];
    }
    
    if ( !isdefined( ignoremodel ) )
    {
        ignoremodel = [];
    }
    
    interactableobjs = [];
    
    foreach ( object in objects )
    {
        if ( !isdefined( object.classname ) )
        {
            continue;
        }
        
        if ( arraycontains( ignoreclassname, object.classname ) )
        {
            continue;
        }
        
        if ( object.model && arraycontains( ignoremodel, object.model ) )
        {
            continue;
        }
        
        ignore = 0;
        
        foreach ( type in ignoretype )
        {
            if ( isstring( object.type ) && issubstr( object.type, type ) )
            {
                ignore = 1;
                break;
            }
        }
        
        if ( !ignore && object getscriptableindex() >= 0 && object getscriptableisusableonanypart() || isent( object ) && object isusable() )
        {
            interactableobjs[ interactableobjs.size ] = object;
        }
    }
    
    return sortbydistance ? sortbydistance( interactableobjs, position ) : interactableobjs;
}

// Namespace bots_util_mp
// Params 7
// Checksum 0xde946b55, Offset: 0x3778
// Size: 0x284
function function_fe389706fe156403( position, radius, sortbydistance, var_57b4b72183c366e9, ignoreclassname, ignoretype, ignoremodel )
{
    scriptmodels = getentarrayinradius( "script_model", #code_classname, position, radius );
    scriptorigins = getentarrayinradius( "script_origin", #code_classname, position, radius );
    var_b55da9be1edbac21 = getentarrayinradius( "script_brushmodel", #code_classname, position, radius );
    scriptvehicles = getentarrayinradius( "script_vehicle", #code_classname, position, radius );
    scriptables = getscriptablearrayinradius( undefined, undefined, position, radius );
    objects = arraycombine( scriptmodels, scriptorigins, var_b55da9be1edbac21, scriptvehicles, scriptables );
    
    if ( !isdefined( ignoreclassname ) )
    {
        ignoreclassname = [];
    }
    
    if ( !isdefined( ignoretype ) )
    {
        ignoretype = [];
    }
    
    if ( !isdefined( ignoremodel ) )
    {
        ignoremodel = [];
    }
    
    damageableobjs = [];
    
    foreach ( object in objects )
    {
        if ( arraycontains( ignoreclassname, object.classname ) || !var_57b4b72183c366e9 && issentient( object ) )
        {
            continue;
        }
        
        if ( self.model && arraycontains( ignoremodel, self.model ) )
        {
            continue;
        }
        
        ignore = 0;
        
        foreach ( type in ignoretype )
        {
            if ( isstring( object.type ) && issubstr( object.type, type ) )
            {
                ignore = 1;
                break;
            }
        }
        
        if ( !ignore && object getcandamage() )
        {
            damageableobjs[ damageableobjs.size ] = object;
        }
    }
    
    return sortbydistance ? sortbydistance( damageableobjs, position ) : damageableobjs;
}

// Namespace bots_util_mp
// Params 3
// Checksum 0xaa5db228, Offset: 0x3a05
// Size: 0x80
function function_a55bf32f8c8ac4bb( targetent, interactdist, interactoffset )
{
    interactpos = targetent.origin - interactdist * anglestoforward( targetent.angles );
    interactpos += interactoffset;
    
    /#
        if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
        {
            debug::sphere( interactpos, 6, ( 1, 0, 0 ), 5 );
        }
    #/
    
    return interactpos;
}

