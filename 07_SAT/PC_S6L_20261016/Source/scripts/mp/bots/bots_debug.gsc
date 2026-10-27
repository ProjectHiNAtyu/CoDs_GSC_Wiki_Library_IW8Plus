// scripts\mp\bots\bots_debug.gsc  (hash_2d5010318be07ead.gscc) (size: 35653 Bytes / 0x8b45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8160dc87 (2170608775)
// size ...... 35653 (0x8b45)
// includes .. 20  (offset: 0x8361)
// strings ... 0   (offset: 0x8401)
// dev strs .. 115 (offset: 0x8401)
// exports ... 68  (offset: 0x5d01)
// cseg ...... 0x58 + 0x5ca9 (0x5d01)
// imports ... 209 (offset: 0x67a1)
// animtree1 . 0   (offset: 0x8b45)
// animtree2 . 0   (offset: 0x8b45)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\trace;
#using scripts\common\trigger_group;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\dev;
#using scripts\mp\equipment;
#using scripts\mp\operator;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace bots_debug;

/#

    // Namespace bots_debug
    // Params 0
    // Checksum 0x220e688e, Offset: 0x76
    // Size: 0xfb, Type: dev
    function main()
    {
        thread function_79110f14247ab6e4();
        thread function_17da6cccf8cb4182();
        level thread bot_debug_drawing();
        level thread bot_debug_spawns();
        level thread bot_debug_drop();
        level thread function_33e49469b09a2c5f();
        level thread function_84011c672d0d716f();
        level thread function_81c5f7641179b575();
        setdevdvarifuninitialized( @"hash_fcf363902a418e6c", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_32c65368cb96595", "<dev string:x24>" );
        level thread function_fa586798d1cbedb5();
        setdevdvarifuninitialized( @"hash_ce29490b019acd60", "<dev string:x24>" );
        level thread function_400507ecb93c70a7();
        setdevdvarifuninitialized( @"hash_d37d55f3ae9fa226", "<dev string:x26>" );
        setdevdvarifuninitialized( @"hash_64822377536c48af", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_987a9c75b18ab7ed", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_b3e82ec369d8b929", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_9c38beab079f09a2", "<dev string:x24>" );
        level thread function_a687d7c92a633df3();
        level thread function_c7b02753c0aa5e11();
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xbdb3f37c, Offset: 0x179
    // Size: 0xd0, Type: dev
    function bot_player_spawned()
    {
        if ( self.pers[ #"fixedbotspawn" ] )
        {
            function_e47cf5c286dbf8e5();
            return;
        }
        
        if ( getdvarint( @"scr_botphalanx" ) > 0 && !isdefined( self.spawnassignment ) )
        {
            if ( self.team == "<dev string:x28>" )
            {
                self.spawnassignment = level.var_4552bbd1719ea85e;
                level.var_4552bbd1719ea85e++;
            }
            else
            {
                self.spawnassignment = level.var_7b3547487b68a2cb;
                level.var_7b3547487b68a2cb++;
            }
        }
        
        if ( getdvarint( @"scr_forcedposbotspawn" ) > 0 )
        {
            forcebotpos( self, self.team );
        }
        
        if ( getdvarint( @"hash_f5a9982eaa189f7b" ) > 0 )
        {
            dev_mp::function_32d3b2a2c6812a11( self );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x943f4b65, Offset: 0x251
    // Size: 0xb1, Type: dev
    function function_499f7032a6a4fbb8()
    {
        human_spectators = get_all_human_spectators();
        
        foreach ( human in human_spectators )
        {
            spectated_player = human getspectatingplayer();
            
            if ( spectated_player == self )
            {
                return 1;
            }
        }
        
        if ( getdvarint( @"hash_e125675f281d4f47", 0 ) == 1 )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xc2b3f58a, Offset: 0x30a
    // Size: 0x86, Type: dev
    function function_79110f14247ab6e4()
    {
        level endon( #"game_ended" );
        
        while ( getdvarint( @"hash_d46f7bf3970382f9" ) == 0 )
        {
            wait 1;
        }
        
        while ( true )
        {
            if ( self function_bece775663e54d92() )
            {
                wait 1;
                continue;
            }
            
            if ( isdefined( level.players[ 0 ] ) && getdvarint( @"hash_d46f7bf3970382f9" ) != 0 )
            {
                function_ddae382d506efc60( level.players[ 0 ].origin );
            }
            
            wait 0.05;
        }
    }

    // Namespace bots_debug
    // Params 6
    // Checksum 0xd09a3d63, Offset: 0x398
    // Size: 0x1ae, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest )
    {
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        start = pos + forward * size * 0.5;
        start += right * size * 0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * size;
        offset = size * up;
        
        for ( i = 0; i < points.size ; i++ )
        {
            line( points[ i ], points[ i ] + offset, color, alpha, depthtest );
            
            if ( i == points.size - 1 )
            {
                line( points[ i ], points[ 0 ], color, alpha, depthtest );
                line( points[ i ] + offset, points[ 0 ] + offset, color, alpha, depthtest );
                continue;
            }
            
            line( points[ i ], points[ i + 1 ], color, alpha, depthtest );
            line( points[ i ] + offset, points[ i + 1 ] + offset, color, alpha, depthtest );
        }
    }

    // Namespace bots_debug
    // Params 6
    // Checksum 0x4ee508bf, Offset: 0x54e
    // Size: 0x5f, Type: dev
    function drawtraversalbox( pos, color, angles, size, alpha, depthtest )
    {
        pos = ( pos[ 0 ], pos[ 1 ], pos[ 2 ] - size / 2 );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x3291f7e5, Offset: 0x5b5
    // Size: 0x205, Type: dev
    function function_fb6ac7daef216999( var_1d03122996ddcde5 )
    {
        var_f9c2836356fb14db = 0;
        navmeshpt = getclosestpointonnavmesh( self.origin );
        
        if ( abs( navmeshpt[ 2 ] - self.origin[ 2 ] ) > 32 || distance2d( navmeshpt, self.origin ) > 32 )
        {
            var_f9c2836356fb14db = 1;
        }
        
        endnode = undefined;
        
        if ( isdefined( self.target ) )
        {
            endnode = getnode( self.target, #targetname );
        }
        
        if ( isdefined( endnode ) )
        {
            navmeshpt = getclosestpointonnavmesh( self.origin );
            
            if ( abs( navmeshpt[ 2 ] - self.origin[ 2 ] ) > 32 || distance2d( navmeshpt, self.origin ) > 32 )
            {
                var_f9c2836356fb14db = 1;
            }
        }
        
        if ( var_1d03122996ddcde5 && !var_f9c2836356fb14db )
        {
            return;
        }
        
        color = ( 0, 1, 0 );
        
        if ( var_f9c2836356fb14db )
        {
            print3d( self.origin + ( 0, 0, 32 ), self.animscript + "<dev string:x2d>", ( 1, 0, 0 ), 1 );
            color = ( 1, 0, 0 );
        }
        else
        {
            print3d( self.origin + ( 0, 0, 32 ), self.animscript, ( 1, 1, 1 ), 1 );
        }
        
        drawtraversalbox( self.origin, color, ( 0, 0, 0 ), 32, 1, 0 );
        
        if ( isdefined( endnode ) )
        {
            line( self.origin, endnode.origin, color, 1, 0 );
            drawtraversalbox( endnode.origin, ( 0.5, 0.5, 0.5 ), ( 0, 0, 0 ), 32, 1, 1 );
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x88809aec, Offset: 0x7c2
    // Size: 0xe5, Type: dev
    function function_ddae382d506efc60( origin )
    {
        var_61e439791fa914f6 = getdvarint( @"hash_d46f7bf3970382f9" );
        var_1d03122996ddcde5 = 0;
        
        if ( var_61e439791fa914f6 == -1 )
        {
            var_1d03122996ddcde5 = 1;
        }
        
        nodecount = getnodecount();
        
        for ( i = 0; i < nodecount ; i++ )
        {
            node = getnodebyindex( i );
            
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            if ( var_61e439791fa914f6 != 1 && !var_1d03122996ddcde5 )
            {
                dist = distance( node.origin, origin );
                
                if ( dist > var_61e439791fa914f6 )
                {
                    continue;
                }
            }
            
            if ( !isdefined( node.animscript ) || node.animscript == "<dev string:x33>" )
            {
                continue;
            }
            
            node function_fb6ac7daef216999( var_1d03122996ddcde5 );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xaea41116, Offset: 0x8af
    // Size: 0x114, Type: dev
    function function_17da6cccf8cb4182()
    {
        while ( true )
        {
            var_543160cad11bb094 = getdvarint( @"hash_17c8ea3da59bc00c" );
            targetoperatorskin = getdvar( @"hash_256591dcc8aa46d" );
            
            if ( targetoperatorskin == "<dev string:x33>" )
            {
                wait 0.1;
                continue;
            }
            
            foreach ( bot in level.players )
            {
                if ( isbot( bot ) )
                {
                    var_d00eda39aeccf411 = bot getentitynumber();
                    
                    if ( var_543160cad11bb094 == var_d00eda39aeccf411 )
                    {
                        bot teams::function_84495c37fb60e2c( getxhashasset( targetoperatorskin ) );
                        break;
                    }
                }
            }
            
            setdvar( @"hash_17c8ea3da59bc00c", 0 );
            setdvar( @"hash_256591dcc8aa46d", "<dev string:x33>" );
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 4
    // Checksum 0xe341b228, Offset: 0x9cb
    // Size: 0xe5, Type: dev
    function function_8777d84a0c0c5802( enable, gameobject, color, depthtest )
    {
        if ( gameobjects_common::has_trigger_group( gameobject ) )
        {
            trigger_group = gameobjects_common::get_trigger_group( gameobject );
            triggers = trigger_group::get_triggers( trigger_group );
            
            foreach ( trigger in triggers )
            {
                botdebugdrawtrigger( enable, trigger, color, depthtest );
            }
            
            return;
        }
        
        botdebugdrawtrigger( enable, gameobject.trigger, color, depthtest );
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xea53f18, Offset: 0xab8
    // Size: 0x128, Type: dev
    function bot_debug_drawing()
    {
        level endon( #"game_ended" );
        
        while ( !bots_util::bot_bots_enabled_or_added() )
        {
            wait 1;
        }
        
        level.var_bd62e64128d75b0b = [];
        
        for ( i = 0; i < 10 ; i++ )
        {
            level.var_bd62e64128d75b0b[ level.var_bd62e64128d75b0b.size ] = spawnstruct();
        }
        
        level.var_960ef0621974e76d = 0;
        
        for ( ;; )
        {
            if ( getdvarint( @"bot_disableallai" ) )
            {
                wait 0.05;
                continue;
            }
            
            draw_debug_type = getdvar( @"bot_drawdebugspecial" );
            function_28481de0d204de37();
            
            if ( draw_debug_type == "<dev string:x34>" )
            {
                function_cdb3833541fca4a1();
            }
            else if ( draw_debug_type == "<dev string:x3b>" )
            {
                function_6f19ee53bd1a19c2();
            }
            else if ( draw_debug_type == "<dev string:x4b>" )
            {
                function_cdb3833541fca4a1();
                function_6f19ee53bd1a19c2();
            }
            else if ( draw_debug_type == "<dev string:x66>" || draw_debug_type == "<dev string:x77>" )
            {
                function_363e538bc2946a1( draw_debug_type == "<dev string:x66>" );
            }
            else if ( draw_debug_type == "<dev string:x96>" )
            {
                function_2d150b89cacdb95e();
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x9af8212f, Offset: 0xbe8
    // Size: 0x8f, Type: dev
    function function_28481de0d204de37()
    {
        for ( i = 0; i < level.var_960ef0621974e76d ; i++ )
        {
            struct = level.var_bd62e64128d75b0b[ i ];
            
            if ( isdefined( struct.defense_game_object ) )
            {
                if ( isent( struct.defense_game_object ) )
                {
                    botdebugdrawtrigger( 0, struct.defense_game_object );
                    continue;
                }
                
                function_8777d84a0c0c5802( 0, struct.defense_game_object );
            }
        }
        
        level.var_960ef0621974e76d = 0;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x37903b60, Offset: 0xc7f
    // Size: 0x830, Type: dev
    function function_cdb3833541fca4a1()
    {
        assert( level.var_960ef0621974e76d == 0 );
        
        foreach ( player in level.participants )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( player.health > 0 && ( isai( player ) || isautopilot( player ) ) && player bots_scripted_defense::is_defending() )
            {
                var_791ec51eb106d858 = undefined;
                
                for ( i = 0; i < level.var_960ef0621974e76d ; i++ )
                {
                    struct = level.var_bd62e64128d75b0b[ i ];
                    same_defense_type = struct.defense_type == player.bot_defending_type;
                    same_defense_radius = isdefined( struct.defense_radius ) && isdefined( player.bot_defending_radius ) && struct.defense_radius == player.bot_defending_radius;
                    var_432ef1aa5c66e618 = isdefined( struct.defense_game_object ) && isdefined( player.bot_defending_game_object ) && struct.defense_game_object == player.bot_defending_game_object;
                    
                    if ( same_defense_type && ( same_defense_radius || var_432ef1aa5c66e618 ) )
                    {
                        if ( bots_util_mp::bot_vectors_are_equal( struct.defense_center, player.bot_defending_center ) )
                        {
                            var_791ec51eb106d858 = struct;
                            break;
                        }
                    }
                }
                
                if ( isdefined( var_791ec51eb106d858 ) )
                {
                    if ( var_791ec51eb106d858.defense_team != player.team )
                    {
                        var_791ec51eb106d858.cylinder_color = ( 1, 0, 1 );
                    }
                    
                    var_791ec51eb106d858.bots[ var_791ec51eb106d858.bots.size ] = player;
                    continue;
                }
                
                var_967f29054ed51f9 = level.var_bd62e64128d75b0b[ level.var_960ef0621974e76d ];
                level.var_960ef0621974e76d++;
                
                if ( player.team == "<dev string:xa7>" )
                {
                    var_967f29054ed51f9.cylinder_color = ( 0, 0, 1 );
                }
                else if ( player.team == "<dev string:x28>" )
                {
                    var_967f29054ed51f9.cylinder_color = ( 1, 0, 0 );
                }
                
                var_967f29054ed51f9.defense_team = player.team;
                var_967f29054ed51f9.defense_type = player.bot_defending_type;
                var_967f29054ed51f9.defense_radius = player.bot_defending_radius;
                var_967f29054ed51f9.defense_game_object = player.bot_defending_game_object;
                var_967f29054ed51f9.defense_center = player.bot_defending_center;
                var_967f29054ed51f9.defense_tacpoints = player.bot_defending_tacpoints;
                var_967f29054ed51f9.bots = [];
                var_967f29054ed51f9.bots[ var_967f29054ed51f9.bots.size ] = player;
            }
        }
        
        var_5e14a4ac3150a2d8 = [];
        
        for ( i = 0; i < level.var_960ef0621974e76d ; i++ )
        {
            struct = level.var_bd62e64128d75b0b[ i ];
            
            if ( isdefined( struct.defense_tacpoints ) )
            {
                foreach ( tacpoint in struct.defense_tacpoints )
                {
                    bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, struct.cylinder_color, 1, 4 );
                }
            }
            
            if ( isdefined( struct.defense_game_object ) )
            {
                if ( isent( struct.defense_game_object ) )
                {
                    botdebugdrawtrigger( 1, struct.defense_game_object, struct.cylinder_color, 1 );
                }
                else
                {
                    function_8777d84a0c0c5802( 1, struct.defense_game_object, struct.cylinder_color, 1 );
                }
            }
            
            if ( isdefined( struct.defense_radius ) )
            {
                bots_util_mp::bot_draw_cylinder( struct.defense_center, struct.defense_radius, 75, 0.05, undefined, struct.cylinder_color, 1 );
            }
            
            foreach ( bot in struct.bots )
            {
                line_color = undefined;
                
                if ( bot.team == "<dev string:xa7>" )
                {
                    line_color = ( 0, 0, 1 );
                }
                else if ( bot.team == "<dev string:x28>" )
                {
                    line_color = ( 1, 0, 0 );
                }
                
                lineend = bot.origin + ( 0, 0, 25 );
                
                if ( isdefined( struct.defense_center ) )
                {
                    linestart = struct.defense_center + ( 0, 0, 25 );
                    line( linestart, lineend, line_color, 1, 1, 1 );
                }
                
                if ( isdefined( bot.bot_defending_override_origin_tacpoint ) )
                {
                    tacpoint_line_color = ( max( line_color[ 0 ], 0.3 ), max( line_color[ 1 ], 0.3 ), max( line_color[ 2 ], 0.3 ) );
                    line( bot.bot_defending_override_origin_tacpoint.groundpos, lineend, tacpoint_line_color, 1, 1, 1 );
                    found_struct = undefined;
                    
                    foreach ( var_97620e3179266531 in var_5e14a4ac3150a2d8 )
                    {
                        if ( var_97620e3179266531.tacpoint == bot.bot_defending_override_origin_tacpoint )
                        {
                            found_struct = var_97620e3179266531;
                        }
                    }
                    
                    if ( isdefined( found_struct ) )
                    {
                        if ( found_struct.team != bot.team )
                        {
                            found_struct.color = ( 1, 0.3, 1 );
                        }
                        
                        continue;
                    }
                    
                    new_origin_struct = spawnstruct();
                    new_origin_struct.tacpoint = bot.bot_defending_override_origin_tacpoint;
                    new_origin_struct.team = bot.team;
                    new_origin_struct.color = tacpoint_line_color;
                    var_5e14a4ac3150a2d8[ var_5e14a4ac3150a2d8.size ] = new_origin_struct;
                }
            }
        }
        
        foreach ( struct in var_5e14a4ac3150a2d8 )
        {
            bots_util_mp::bot_draw_cylinder( struct.tacpoint.groundpos, 7.5, 10, 0.05, undefined, struct.color, 1, 4 );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x9820f0a5, Offset: 0x14b7
    // Size: 0x3a7, Type: dev
    function function_6f19ee53bd1a19c2()
    {
        foreach ( player in level.participants )
        {
            if ( player.health > 0 && ( isai( player ) || isautopilot( player ) ) && isdefined( player.watch_tacpoints ) )
            {
                player_origin_offset = ( 0, 0, player getplayerviewheight() );
                player_line_start = player.origin + player_origin_offset;
                
                foreach ( tacpoint in player.watch_tacpoints )
                {
                    watch_tacpoint_chance = tacpoint.watch_tacpoint_chance[ player.entity_number ];
                    entrance_color = ( 1 - watch_tacpoint_chance, 1, 1 - watch_tacpoint_chance );
                    
                    if ( watch_tacpoint_chance <= 0.05 )
                    {
                        alpha = 0.1;
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, entrance_color, 1, 8, alpha );
                    }
                    else
                    {
                        alpha = 1;
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, entrance_color, 1, 4, alpha );
                    }
                    
                    line( player_line_start, tacpoint.groundpos, entrance_color, alpha, 1, 1 );
                    
                    if ( isdefined( tacpoint.var_2d524598ce907623 ) )
                    {
                        print3d( tacpoint.groundpos, int( tacpoint.var_2d524598ce907623[ player.team ] ), ( 0, 0, 1 ), alpha, 1.1 );
                        print3d( tacpoint.groundpos + ( 0, 0, 10 ), int( tacpoint.var_2d524598ce907623[ team_utility::getotherteam( player.team ) ] ), ( 1, 0, 0 ), alpha, 1.1 );
                    }
                }
                
                if ( isdefined( player.var_67e7dc12b0565a88 ) )
                {
                    offset = ( 0, 0, 60 );
                    playerstance = player getstance();
                    
                    if ( playerstance == "<dev string:xae>" )
                    {
                        offset = ( 0, 0, 40 );
                    }
                    else if ( playerstance == "<dev string:xb5>" )
                    {
                        offset = ( 0, 0, 11 );
                    }
                    
                    print3d( player.origin + offset, int( player.var_67e7dc12b0565a88[ player.team ] ), ( 0, 0, 1 ), 1, 1.1 );
                    print3d( player.origin + offset + ( 0, 0, 10 ), int( player.var_67e7dc12b0565a88[ team_utility::getotherteam( player.team ) ] ), ( 1, 0, 0 ), 1, 1.1 );
                }
            }
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x16b3e55, Offset: 0x1866
    // Size: 0x2d3, Type: dev
    function function_363e538bc2946a1( var_ef4f90af3766f9b4 )
    {
        if ( !( isdefined( level.entrance_indices ) && isdefined( level.entrance_points ) ) )
        {
            return;
        }
        
        tacpoint_offset = ( 0, 0, 11 );
        standing_offset = ( 0, 0, 55 );
        crouching_offset = ( 0, 0, 40 );
        prone_offset = ( 0, 0, 15 );
        color_visible_base = ( 0, 1, 0 );
        var_11d5de7b5b156d22 = ( 1, 0, 0 );
        color_visible = color_visible_base;
        var_1ee0b77824b0a0fa = var_11d5de7b5b156d22;
        tacpoint_height = 13;
        
        for ( i = 0; i < level.entrance_indices.size ; i++ )
        {
            if ( level.entrance_indices.size > 5 )
            {
                color_shift = i % 5 * 50 / 256;
                color_visible = ( color_visible_base[ 0 ] + color_shift, color_visible_base[ 1 ], color_visible_base[ 2 ] + color_shift );
                var_1ee0b77824b0a0fa = ( var_11d5de7b5b156d22[ 0 ], var_11d5de7b5b156d22[ 1 ] + color_shift, var_11d5de7b5b156d22[ 2 ] + color_shift );
            }
            
            entrance_collection = level.entrance_points[ level.entrance_indices[ i ] ];
            
            for ( j = 0; j < entrance_collection.size ; j++ )
            {
                bots_util_mp::bot_draw_cylinder( entrance_collection[ j ].origin + tacpoint_offset, 10, tacpoint_height, 0.05, undefined, color_visible, 1, 4 );
                line( level.entrance_origin_points[ i ] + standing_offset, entrance_collection[ j ].origin + tacpoint_offset + ( 0, 0, tacpoint_height / 2 ), color_visible, 1, 1, 1 );
                
                if ( var_ef4f90af3766f9b4 )
                {
                    color_to_use = var_1ee0b77824b0a0fa;
                    
                    if ( entrance_collection[ j ].crouch_visible_from[ level.entrance_indices[ i ] ] )
                    {
                        color_to_use = color_visible;
                    }
                    
                    line( level.entrance_origin_points[ i ] + crouching_offset, entrance_collection[ j ].origin + tacpoint_offset + ( 0, 0, tacpoint_height / 2 ), color_to_use, 1, 1, 1 );
                    color_to_use = var_1ee0b77824b0a0fa;
                    
                    if ( entrance_collection[ j ].prone_visible_from[ level.entrance_indices[ i ] ] )
                    {
                        color_to_use = color_visible;
                    }
                    
                    line( level.entrance_origin_points[ i ] + prone_offset, entrance_collection[ j ].origin + tacpoint_offset + ( 0, 0, tacpoint_height / 2 ), color_to_use, 1, 1, 1 );
                }
            }
            
            bots_util_mp::bot_draw_cylinder( level.entrance_origin_points[ i ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xa342952d, Offset: 0x1b41
    // Size: 0x3b3, Type: dev
    function function_2d150b89cacdb95e()
    {
        if ( !( isdefined( level.entrance_indices ) && isdefined( level.precalculated_paths ) ) )
        {
            return;
        }
        
        tacpoint_colors = [ ( 1, 0, 0 ), ( 0, 1, 0 ), ( 0, 0, 1 ), ( 1, 0, 1 ), ( 1, 1, 0 ), ( 0, 1, 1 ), ( 1, 0.6, 0.6 ), ( 0.6, 1, 0.6 ), ( 0.6, 0.6, 1 ), ( 0.1, 0.1, 0.1 ) ];
        
        if ( !isdefined( level.var_d243c85bb1bc0fa1 ) )
        {
            level.var_6e7b9d9caa5f6cec = level.entrance_indices.size - 2;
            level.var_a3dffe4d90e16810 = level.entrance_indices.size - 1;
            level.var_d243c85bb1bc0fa1 = gettime() - 1;
            level.var_ea3e6fa8962cedf = 15000;
        }
        
        if ( gettime() > level.var_d243c85bb1bc0fa1 )
        {
            for ( keep_trying = 1; keep_trying ; keep_trying = !isdefined( level.precalculated_paths[ level.entrance_indices[ level.var_6e7b9d9caa5f6cec ] ][ level.entrance_indices[ level.var_a3dffe4d90e16810 ] ] ) )
            {
                if ( level.var_a3dffe4d90e16810 == level.entrance_indices.size - 1 )
                {
                    if ( level.var_6e7b9d9caa5f6cec == level.entrance_indices.size - 2 )
                    {
                        level.var_6e7b9d9caa5f6cec = 0;
                        level.var_d965550b866eb52d = -1;
                    }
                    else
                    {
                        level.var_6e7b9d9caa5f6cec++;
                    }
                    
                    level.var_a3dffe4d90e16810 = level.var_6e7b9d9caa5f6cec + 1;
                    continue;
                }
                
                level.var_a3dffe4d90e16810++;
            }
            
            level.var_d965550b866eb52d = ( level.var_d965550b866eb52d + 1 ) % tacpoint_colors.size;
            level.var_d243c85bb1bc0fa1 = gettime() + level.var_ea3e6fa8962cedf;
            array = level.precalculated_paths[ level.entrance_indices[ level.var_6e7b9d9caa5f6cec ] ][ level.entrance_indices[ level.var_a3dffe4d90e16810 ] ];
            level.var_b386cf22581f896c = function_7a2f256e52489a6( array );
        }
        
        bots_util_mp::bot_draw_cylinder( level.entrance_origin_points[ level.var_6e7b9d9caa5f6cec ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        bots_util_mp::bot_draw_cylinder( level.entrance_origin_points[ level.var_a3dffe4d90e16810 ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        
        foreach ( tacpoint in level.var_b386cf22581f896c )
        {
            assert( tacpoint bots_util_mp::function_6ed0ed07336b5fee( level.entrance_indices[ level.var_6e7b9d9caa5f6cec ], level.entrance_indices[ level.var_a3dffe4d90e16810 ] ) );
            bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 13, 0.05, undefined, tacpoint_colors[ level.var_d965550b866eb52d ], 1, 4 );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x119d7804, Offset: 0x1efc
    // Size: 0x68, Type: dev
    function function_3a932c51f82f0f37()
    {
        if ( level.var_22773e0b911bedd3 )
        {
            level.var_22773e0b911bedd3 = getdvarint( @"bot_disableallai" ) == 1;
        }
        
        if ( !isnavmeshloaded() && !level.var_22773e0b911bedd3 )
        {
            level.var_22773e0b911bedd3 = 1;
            setdvar( @"bot_disableallai", 1 );
            assertmsg( "<dev string:xbb>" );
        }
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0xd53f941c, Offset: 0x1f6c
    // Size: 0xaa, Type: dev
    function forcebotpos( bot, botteam )
    {
        var_ac9306e55db96674 = getdvarvector( @"forcedbotspawnvec3" );
        verticalbuffer = 12;
        botspacing = 40;
        
        switch ( botteam )
        {
            case #"hash_5f54b9bf7583687f":
                bot setorigin( var_ac9306e55db96674 + ( bot.spawnassignment * botspacing * -1, 0, verticalbuffer ) );
                break;
            case #"hash_7c2d091e6337bf54":
                bot setorigin( var_ac9306e55db96674 + ( bot.spawnassignment * botspacing, 0, verticalbuffer ) );
                break;
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x3154d2c2, Offset: 0x201e
    // Size: 0xa3, Type: dev
    function get_all_humans()
    {
        humans = [];
        
        foreach ( player in level.players )
        {
            if ( player.connected && !isai( player ) )
            {
                humans[ humans.size ] = player;
            }
        }
        
        return humans;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x3990cf3f, Offset: 0x20c9
    // Size: 0xa7, Type: dev
    function get_all_human_spectators()
    {
        humans = get_all_humans();
        human_spectators = [];
        
        foreach ( player in humans )
        {
            if ( player.team == "<dev string:xf2>" )
            {
                human_spectators[ human_spectators.size ] = player;
            }
        }
        
        return human_spectators;
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x1c21e6c2, Offset: 0x2178
    // Size: 0x24a, Type: dev
    function function_f4ab7b07a673d429( objweapon )
    {
        if ( level.testdummy == self && isdefined( self.menu ) && isdefined( self.firstdamagetime ) )
        {
            ttk = gettime() - self.firstdamagetime;
            self.menu[ "<dev string:xfc>" ] setvalue( utility::function_6f5d2e1f1ff70482( ttk ) );
            self.menu[ "<dev string:xfc>" ].alpha = 1;
            breakdown = [];
            breakdown_text = "<dev string:x33>";
            
            if ( weapon_utility::isbulletweapon( objweapon ) )
            {
                foreach ( hitinfo in self.hitsbreakdown )
                {
                    hitloc = hitinfo.hitloc;
                    
                    if ( !isdefined( breakdown[ hitloc ] ) )
                    {
                        hits = 0;
                        
                        foreach ( var_2a9f77a6df79949 in self.hitsbreakdown )
                        {
                            if ( var_2a9f77a6df79949.hitloc == hitloc && hitinfo.damage == var_2a9f77a6df79949.damage )
                            {
                                hits++;
                            }
                        }
                        
                        breakdown[ hitloc ] = hits + "<dev string:x100>" + hitloc + "<dev string:x100>" + hitinfo.damage;
                        breakdown_text += breakdown[ hitloc ] + "<dev string:x102>";
                    }
                }
            }
            else
            {
                breakdown_text = "<dev string:x104>";
            }
            
            self.menu[ "<dev string:x118>" ] setdevtext( breakdown_text );
            self.firstdamagetime = undefined;
            self.hitsbreakdown = [];
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xa138c547, Offset: 0x23ca
    // Size: 0xe6, Type: dev
    function bot_think_debug()
    {
        self notify( #"bot_think_debug" );
        self endon( #"bot_think_debug" );
        self endon( #"exit_autopilot" );
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( self function_bece775663e54d92() )
            {
                wait 1;
                continue;
            }
            
            if ( isdefined( level.var_b5bd61e97202c557 ) )
            {
                bots_tactical_goals::disable_tactical_goals();
                self.ignoreall = 1;
                self botsetstance( "<dev string:x122>" );
                
                if ( !self bothasscriptgoal() )
                {
                    self botsetscriptgoal( level.var_b5bd61e97202c557, 0, "<dev string:x128>" );
                }
                else
                {
                    goal = self botgetscriptgoal();
                    
                    if ( !bots_util_mp::bot_vectors_are_equal( goal, level.var_b5bd61e97202c557 ) )
                    {
                        self botsetscriptgoal( level.var_b5bd61e97202c557, 0, "<dev string:x128>" );
                    }
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xaa4b8950, Offset: 0x24b8
    // Size: 0x247, Type: dev
    function bot_debug_spawns()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_b1abb742e2cbfd7d = getdvarint( @"hash_d2c1e13b48beed87", 0 );
            
            if ( var_b1abb742e2cbfd7d )
            {
                setdvar( @"hash_d2c1e13b48beed87", 0 );
                host = dev_mp::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    host = get_all_humans()[ 0 ];
                    
                    if ( !isdefined( host ) )
                    {
                        continue;
                    }
                }
                
                spawnorigin = function_ef2181d4d3f5fbc( host );
                
                if ( !isdefined( spawnorigin ) )
                {
                    continue;
                }
                
                spawnorigin = getclosestpointonnavmesh( spawnorigin );
                hostangles = host getplayerangles();
                spawnangles = ( 0, hostangles[ 1 ] + 180, 0 );
                
                if ( var_b1abb742e2cbfd7d == 2 )
                {
                    setdvar( @"hash_5e767ceb6b77e053", -2 );
                }
                else
                {
                    setdvar( @"hash_5e767ceb6b77e053", -3 );
                }
                
                setdvar( @"dev_spawnbots", 1 );
                level waittill( #"player_spawned", player );
                player setorigin( spawnorigin );
                player setplayerangles( spawnangles );
                setdvar( @"hash_5e767ceb6b77e053", 0 );
            }
            
            var_4aee147b375848db = getdvarint( @"hash_39a9059930f4ca30", 0 );
            
            if ( var_4aee147b375848db )
            {
                setdvar( @"hash_39a9059930f4ca30", 0 );
                host = dev_mp::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    host = get_all_humans()[ 0 ];
                    
                    if ( !isdefined( host ) )
                    {
                        continue;
                    }
                }
                
                if ( var_4aee147b375848db == 2 )
                {
                    team = host.team;
                }
                else
                {
                    team = utility::get_enemy_team( host.team );
                }
                
                spawnorigin = function_ef2181d4d3f5fbc( host );
                
                if ( !isdefined( spawnorigin ) )
                {
                    continue;
                }
                
                hostangles = host getplayerangles();
                spawnangles = ( 0, hostangles[ 1 ] + 180, 0 );
                randomoffset = ( randomfloatrange( -0.5, 0.5 ), randomfloatrange( -0.5, 0.5 ), 0 );
                fixedspawndata = spawnstruct();
                fixedspawndata.origin = spawnorigin + randomoffset;
                fixedspawndata.angles = spawnangles;
                level thread [[ level.bot_funcs[ "<dev string:x131>" ] ]]( 1, team, undefined, undefined, undefined, undefined, fixedspawndata );
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xe8734dd4, Offset: 0x2707
    // Size: 0x104, Type: dev
    function bot_debug_drop()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_97c01c87ed6b4d4c = getdvarint( @"hash_6fa26f52af139e03", 0 );
            
            if ( var_97c01c87ed6b4d4c )
            {
                setdvar( @"hash_6fa26f52af139e03", 0 );
                host = dev_mp::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    host = get_all_humans()[ 0 ];
                    
                    if ( !isdefined( host ) )
                    {
                        continue;
                    }
                }
                
                start = host geteye();
                dir = anglestoforward( host getplayerangles() );
                end = start + 8000 * dir;
                trace = trace::_bullet_trace( start, end, 1, host );
                var_e66b6c6b5341a71b = undefined;
                
                if ( isplayer( trace[ "<dev string:x13c>" ] ) && player::isreallyalive( trace[ "<dev string:x13c>" ] ) )
                {
                    var_e66b6c6b5341a71b = trace[ "<dev string:x13c>" ];
                }
                
                if ( isbot( var_e66b6c6b5341a71b ) )
                {
                    kick( var_e66b6c6b5341a71b );
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xc5f3672a, Offset: 0x2813
    // Size: 0xdb, Type: dev
    function function_33e49469b09a2c5f()
    {
        level endon( #"game_ended" );
        
        while ( !bots_util::bot_bots_enabled_or_added() )
        {
            wait 1;
        }
        
        setdevdvarifuninitialized( @"hash_886b3374b1579604", "<dev string:x33>" );
        
        for ( ;; )
        {
            if ( getdvarint( @"bot_disableallai" ) )
            {
                wait 0.05;
                continue;
            }
            
            if ( getdvar( @"hash_886b3374b1579604", "<dev string:x33>" ) != "<dev string:x33>" && level.gametype == "<dev string:x143>" )
            {
                setdevdvar( @"hash_886b3374b1579604", "<dev string:x33>" );
                human = get_all_humans()[ 0 ];
                
                if ( isalive( human ) && human.team != "<dev string:xf2>" )
                {
                    level.var_b5bd61e97202c557 = human.origin;
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x89cef08a, Offset: 0x28f6
    // Size: 0x283, Type: dev
    function function_84011c672d0d716f()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            remove_bot_mode = getdvarint( @"hash_8cd9f80a99bccf2f", 0 );
            
            if ( remove_bot_mode )
            {
                setdvar( @"hash_8cd9f80a99bccf2f", 0 );
                
                if ( !isdefined( level.fixedspawnbots ) )
                {
                    continue;
                }
                
                var_5ab4f2da6b98a996 = undefined;
                
                switch ( remove_bot_mode )
                {
                    case 1:
                        var_5ab4f2da6b98a996 = [ "<dev string:x147>" ];
                        var_e7a586e546b18833 = 999;
                        break;
                    case 2:
                        var_5ab4f2da6b98a996 = [ "<dev string:xa7>" ];
                        var_e7a586e546b18833 = 999;
                        break;
                    case 3:
                        var_5ab4f2da6b98a996 = [ "<dev string:x28>" ];
                        var_e7a586e546b18833 = 999;
                        break;
                    case 4:
                        var_5ab4f2da6b98a996 = [ level.players[ 0 ].team ];
                        var_e7a586e546b18833 = 999;
                        break;
                    case 5:
                        var_5ab4f2da6b98a996 = team_utility::getenemyteams( level.players[ 0 ].team );
                        var_e7a586e546b18833 = 999;
                        break;
                    default:
                        var_5ab4f2da6b98a996 = [ "<dev string:x147>" ];
                        var_e7a586e546b18833 = 1;
                        break;
                }
                
                foreach ( bot in level.fixedspawnbots )
                {
                    if ( var_e7a586e546b18833 <= 0 )
                    {
                        break;
                    }
                    
                    if ( !isarray( var_5ab4f2da6b98a996 ) )
                    {
                        break;
                    }
                    
                    foreach ( teamentry in var_5ab4f2da6b98a996 )
                    {
                        if ( teamentry == "<dev string:x147>" || bot.team == teamentry )
                        {
                            kick( bot getentitynumber() );
                            var_e7a586e546b18833--;
                        }
                    }
                }
                
                level.fixedspawnbots = function_5713d46873b29625( level.fixedspawnbots );
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x106152f5, Offset: 0x2b81
    // Size: 0xe2, Type: dev
    function function_ef2181d4d3f5fbc( player )
    {
        angles = player getplayerangles();
        fwd = anglestoforward( angles );
        eye = player geteye();
        end = eye + fwd * 10000;
        traces = trace::ray_trace_get_all_results( eye, end );
        
        foreach ( trace in traces )
        {
            if ( !isdefined( trace[ "<dev string:x13c>" ] ) )
            {
                return trace[ "<dev string:x14b>" ];
            }
        }
        
        return;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xdd57123, Offset: 0x2c6b
    // Size: 0x8e, Type: dev
    function function_e47cf5c286dbf8e5()
    {
        self function_3a7598d6982eb648( 1 );
        origin = self.pers[ #"fixedspawnorigin" ] ?? self.origin;
        origin = isnavmeshloaded() && isdefined( getnavbounds() ) ? getclosestpointonnavmesh( origin ) : origin;
        angles = self.pers[ #"fixedspawnangles" ] ?? self.angles;
        self setorigin( origin );
        self setplayerangles( angles );
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0x6e55e94c, Offset: 0x2d01
    // Size: 0x44, Type: dev
    function function_b18bf657bc478ce5( neworigin, newangles )
    {
        self.pers[ #"fixedspawnorigin" ] = neworigin;
        self.pers[ #"fixedspawnangles" ] = newangles;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x68907d8, Offset: 0x2d4d
    // Size: 0x192, Type: dev
    function function_81c5f7641179b575()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_6f206d86f4bcaedd = getdvarint( @"hash_670fcefaa6d8a693", 0 );
            
            if ( var_6f206d86f4bcaedd )
            {
                setdvar( @"hash_670fcefaa6d8a693", 0 );
                
                if ( var_6f206d86f4bcaedd == 3 && isdefined( level.testdummy ) )
                {
                    kick( level.testdummy getentitynumber() );
                    level.testdummy = undefined;
                    continue;
                }
                
                host = dev_mp::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    continue;
                }
                
                team = utility::get_enemy_team( host.team );
                
                if ( var_6f206d86f4bcaedd == 1 )
                {
                    spawnorigin = function_ef2181d4d3f5fbc( host );
                    
                    if ( !isdefined( spawnorigin ) )
                    {
                        continue;
                    }
                    
                    hostangles = host getplayerangles();
                    spawnangles = ( 0, hostangles[ 1 ] + 180, 0 );
                }
                else
                {
                    results = level function_e59ce7ad7bfc2ef9( host );
                    
                    if ( !isdefined( results ) )
                    {
                        continue;
                    }
                    
                    spawnorigin = results[ "<dev string:x154>" ];
                    spawnangles = results[ "<dev string:x15b>" ];
                }
                
                if ( isdefined( level.testdummy ) )
                {
                    level function_2bee0020da7b9cf4( spawnorigin, spawnangles );
                    continue;
                }
                
                fixedspawndata = spawnstruct();
                fixedspawndata.origin = spawnorigin;
                fixedspawndata.angles = spawnangles;
                level thread [[ level.bot_funcs[ "<dev string:x131>" ] ]]( 1, team, &function_e08d971691d1f247, undefined, undefined, undefined, fixedspawndata );
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x806dff20, Offset: 0x2ee7
    // Size: 0x16, Type: dev
    function function_e08d971691d1f247()
    {
        level.testdummy = self;
        function_fb391de401dc30c();
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0x76c70ed8, Offset: 0x2f05
    // Size: 0x78, Type: dev
    function function_2bee0020da7b9cf4( origin, angles )
    {
        level.testdummy.pers[ #"fixedspawnorigin" ] = origin;
        level.testdummy.pers[ #"fixedspawnangles" ] = angles;
        level.testdummy setorigin( origin );
        level.testdummy setplayerangles( angles );
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xbd3f1a78, Offset: 0x2f85
    // Size: 0x79, Type: dev
    function function_fb391de401dc30c()
    {
        host = dev_mp::devfindhost();
        
        if ( !isdefined( self.hud ) )
        {
            function_e83bc9e5572cc81e( host );
        }
        
        self.var_70fb6f7c09a605d2 = 0;
        self.var_6397f385cb1bfec1 = 0;
        self.firstdamagetime = undefined;
        self.hitsbreakdown = [];
        self.fnbotdamagecallback = &function_909164f2686f6199;
        thread function_6b79276114fbd664();
        thread function_c301099e9ac838b8();
        thread function_362364839d93a3a4();
    }

    // Namespace bots_debug
    // Params 9
    // Checksum 0x2a160136, Offset: 0x3006
    // Size: 0x430, Type: dev
    function function_909164f2686f6199( eattacker, idamage, smeansofdeath, objweapon, einflictor, shitloc, vpoint, lightarmordamage, idflags )
    {
        if ( !isdefined( lightarmordamage ) )
        {
            lightarmordamage = 0;
        }
        
        host = dev_mp::devfindhost();
        
        if ( eattacker != host )
        {
            return;
        }
        
        self.var_70fb6f7c09a605d2++;
        self.var_6397f385cb1bfec1 += idamage + lightarmordamage;
        
        if ( !isdefined( self.firstdamagetime ) )
        {
            self.firstdamagetime = gettime();
            
            if ( self.hitsbreakdown.size == 0 )
            {
                self.menu[ "<dev string:x118>" ].alpha = 0;
            }
            
            self.menu[ "<dev string:xfc>" ].alpha = 0;
        }
        
        if ( vpoint )
        {
            source_pos = eattacker == einflictor ? eattacker geteye() : self.origin;
            range = distance( source_pos, vpoint );
        }
        else
        {
            range = 0;
        }
        
        if ( vpoint && vpoint[ 2 ] < getwaterheightatlocation( vpoint ) || eattacker isswimunderwater() )
        {
            weapondamagetype = 1;
        }
        else if ( idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        index = function_c51ee4ad9ce54d18( eattacker, idamage + lightarmordamage, smeansofdeath, objweapon, shitloc, idflags, weapondamagetype );
        self.hitsbreakdown[ self.hitsbreakdown.size ] = { #range:range, #damage:idamage + lightarmordamage, #hitloc:shitloc + "<dev string:x162>" + index };
        weap_token = strtok( getcompleteweaponname( objweapon ), "<dev string:x164>" );
        weap_name = "<dev string:x33>";
        
        foreach ( tok in weap_token )
        {
            weap_name += tok + "<dev string:x102>";
        }
        
        if ( isdefined( self.armorhealth ) )
        {
            self.menu[ "<dev string:x166>" ] setvalue( self.armorhealth );
        }
        
        if ( weapon_utility::isbulletweapon( objweapon ) )
        {
            loc_dmg_multiplier = getweaponhitlocdamagemultiplier( objweapon, shitloc, weapondamagetype );
            shitloc += "<dev string:x16c>" + loc_dmg_multiplier + "<dev string:x170>";
        }
        
        self.menu[ "<dev string:x172>" ] setvalue( self.health );
        self.menu[ "<dev string:x179>" ] setvalue( idamage + lightarmordamage );
        self.menu[ "<dev string:x180>" ] setvalue( self.var_6397f385cb1bfec1 );
        self.menu[ "<dev string:x18c>" ] setvalue( self.var_70fb6f7c09a605d2 );
        self.menu[ "<dev string:x191>" ] setvalue( range );
        self.menu[ "<dev string:x197>" ] setdevtext( shitloc );
        self.menu[ "<dev string:x19e>" ] setdevtext( weap_name );
        
        if ( self.health - idamage <= 0 )
        {
            weapon_cat = self.menu[ self.menu_breakdown - 1 ];
            breakdown_cat = self.menu[ self.menu_breakdown ];
            breakdown_cat.y = weapon_cat.y + 10 * ( weap_token.size + 2 );
            breakdown = self.menu[ "<dev string:x118>" ];
            breakdown.y = breakdown_cat.y;
            breakdown.alpha = 1;
        }
    }

    // Namespace bots_debug
    // Params 7
    // Checksum 0xe702b5ab, Offset: 0x343e
    // Size: 0x36e, Type: dev
    function function_c51ee4ad9ce54d18( eattacker, damage, smeansofdeath, weapon, shitloc, idflags, weapondamagetype )
    {
        if ( !isdefined( weapondamagetype ) )
        {
            weapondamagetype = 0;
        }
        
        if ( utility::ismeleedamage( smeansofdeath ) )
        {
            return 4;
        }
        
        if ( isdefined( idflags ) && idflags & 8 )
        {
            return 4;
        }
        
        if ( weapon_utility::isbulletweapon( weapon ) )
        {
            damage_multiplier = weapongetdamagelocationmodifier( weapon, shitloc, weapondamagetype ) ?? 1;
            damage_values = [ weapon getmindamage( weapondamagetype ) * damage_multiplier, weapon getmid1damage( weapondamagetype ) * damage_multiplier, weapon getmid2damage( weapondamagetype ) * damage_multiplier, weapon getmid3damage( weapondamagetype ) * damage_multiplier, weapon getmaxdamage( weapondamagetype ) * damage_multiplier ];
            
            foreach ( idx, val in damage_values )
            {
                if ( round( val ) == damage )
                {
                    return idx;
                }
                
                if ( int( val ) == damage )
                {
                    return idx;
                }
            }
            
            if ( level.allowarmor && weapon::isspreadweapon( weapon ) )
            {
                cumulative_damage = 0;
                
                foreach ( damageinfo in self.hitsbreakdown )
                {
                    cumulative_damage += damageinfo.damage;
                    
                    if ( damageinfo.damage == damage )
                    {
                        return int( strtok( damageinfo.hitloc, "<dev string:x162>" )[ 1 ] );
                    }
                }
                
                hand = weapon_utility::function_deff5471cdf04d56( idflags );
                
                foreach ( damageinfo in eattacker.pelletweaponvictimids[ hand ] )
                {
                    if ( damageinfo.var_57dfd4c4337d402e == cumulative_damage + damage )
                    {
                        foreach ( idx, val in damage_values )
                        {
                            if ( round( val ) == damageinfo.pelletdmgpassed[ 0 ] )
                            {
                                return idx;
                            }
                        }
                    }
                }
            }
            
            if ( isbrgamemode() && isdefined( level.brmodifyweapondamage[ removesubstr( weapon.basename, "<dev string:x1a5>" ) ] ) )
            {
                return 4;
            }
            
            return "<dev string:x1a9>";
        }
        
        return 0;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xe818cfb5, Offset: 0x37b4
    // Size: 0x5c, Type: dev
    function function_6b79276114fbd664()
    {
        self endon( #"disconnect" );
        
        for ( ;; )
        {
            waitframe();
            
            if ( isdefined( self.armorhealth ) )
            {
                self.menu[ "<dev string:x166>" ] setvalue( self.armorhealth );
            }
            
            self.menu[ "<dev string:x172>" ] setvalue( self.health );
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x6bb9ff88, Offset: 0x3818
    // Size: 0x97, Type: dev
    function function_c301099e9ac838b8()
    {
        self waittill( #"disconnect" );
        self.hud destroy();
        
        foreach ( menu in self.menu )
        {
            menu destroy();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x400997de, Offset: 0x38b7
    // Size: 0x44, Type: dev
    function function_362364839d93a3a4()
    {
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( #"death" );
            self.var_70fb6f7c09a605d2 = 0;
            self.var_6397f385cb1bfec1 = 0;
            self.hitsbreakdown = [];
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x480ffaff, Offset: 0x3903
    // Size: 0xe9, Type: dev
    function function_e59ce7ad7bfc2ef9( host )
    {
        host endon( #"death" );
        host endon( #"disconnect" );
        placementmodel = spawn( "<dev string:x1db>", ( 0, 0, 0 ) );
        placementmodel setmodel( "<dev string:x1e8>" );
        
        for ( ;; )
        {
            waitframe();
            spawnorigin = function_ef2181d4d3f5fbc( host );
            
            if ( !isdefined( spawnorigin ) )
            {
                continue;
            }
            
            hostangles = host getplayerangles();
            spawnangles = ( 0, hostangles[ 1 ] + 180, 0 );
            placementmodel.origin = spawnorigin;
            placementmodel.angles = spawnangles;
            
            if ( host usebuttonpressed() )
            {
                results = [];
                results[ "<dev string:x154>" ] = spawnorigin;
                results[ "<dev string:x15b>" ] = spawnangles;
                placementmodel delete();
                return results;
            }
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xf097efe4, Offset: 0x39f4
    // Size: 0x399, Type: dev
    function function_e83bc9e5572cc81e( host )
    {
        x = 10;
        y = 120;
        scale = 1;
        self.hud = host function_c3b9e13b55356bb7( "<dev string:x1f8>", x, y, scale, 0.6, 10 );
        menu = [];
        menux = x + 5;
        
        if ( isdefined( host.armorhealth ) )
        {
            menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x203>", menux, y + 10 * ( menu.size + 1 ), scale );
        }
        
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x20b>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x214>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x21d>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x22c>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x23d>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x24c>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x254>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x263>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_c3b9e13b55356bb7( "<dev string:x26c>", menux, y + 10 * ( menu.size + 1 ), scale );
        self.menu_breakdown = menu.size - 1;
        menux = x + 95;
        indexoffset = menu.size;
        
        if ( isdefined( host.armorhealth ) )
        {
            menu[ "<dev string:x166>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        }
        
        menu[ "<dev string:x172>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x179>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x180>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x18c>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:xfc>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x191>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x197>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x19e>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x118>" ] = host function_c3b9e13b55356bb7( "<dev string:x33>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        self.menu = menu;
    }

    // Namespace bots_debug
    // Params 6
    // Checksum 0x64024b46, Offset: 0x3d95
    // Size: 0x128, Type: dev
    function function_c3b9e13b55356bb7( text, x, y, scale, alpha, sort )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( sort ) )
        {
            sort = 20;
        }
        
        hudelem = newclienthudelem( self );
        hudelem.elemtype = "<dev string:x278>";
        hudelem.alpha = alpha;
        hudelem.font = "<dev string:x27d>";
        hudelem.fontscale = scale;
        hudelem.basefontscale = scale;
        hudelem.sort = sort;
        hudelem.x = x;
        hudelem.y = y;
        hudelem.archived = 0;
        hudelem.foreground = 1;
        hudelem.hidewhendead = 1;
        hudelem.hidewheninmenu = 1;
        
        if ( text.size > 0 )
        {
            hudelem setdevtext( text );
        }
        
        return hudelem;
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xd12e85ab, Offset: 0x3ec5
    // Size: 0xb2, Type: dev
    function function_52f11792f4110a6c( var_e426829e4b832d71 )
    {
        bots = [];
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                if ( var_e426829e4b832d71 && !player::isreallyalive( player ) )
                {
                    continue;
                }
                
                bots[ bots.size ] = player;
            }
        }
        
        return bots;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0xbaea827f, Offset: 0x3f7f
    // Size: 0xbc, Type: dev
    function function_944bfd48ce67278e()
    {
        host = dev_mp::devfindhost();
        
        if ( isdefined( host ) )
        {
            if ( host.var_45f7e72b795b2519 && isbot( host.var_cc908aa2d972bedb ) )
            {
                return host.var_cc908aa2d972bedb;
            }
            
            tracestart = host geteye();
            forward = anglestoforward( host getplayerangles() );
            traceend = tracestart + forward * 5000;
            traceresults = trace::ray_trace( tracestart, traceend, host );
            
            if ( isplayer( traceresults[ "<dev string:x13c>" ] ) && isbot( traceresults[ "<dev string:x13c>" ] ) )
            {
                return traceresults[ "<dev string:x13c>" ];
            }
        }
        
        return;
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xf0f885ba, Offset: 0x4043
    // Size: 0x4d, Type: dev
    function is_remote_control_bot( bot )
    {
        host = dev_mp::devfindhost();
        
        if ( isdefined( host ) && host.var_45f7e72b795b2519 && bot == host.var_cc908aa2d972bedb )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x78406779, Offset: 0x4098
    // Size: 0xdc, Type: dev
    function function_400507ecb93c70a7()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level waittill( #"hash_8862918c7aa44ac0", player, bot );
            player notifyonplayercommand( "<dev string:x285>", "<dev string:x294>" );
            player notifyonplayercommand( "<dev string:x285>", "<dev string:x2a0>" );
            player notifyonplayercommand( "<dev string:x285>", "<dev string:x2ac>" );
            player notifyonplayercommand( "<dev string:x285>", "<dev string:x2b8>" );
            level childthread function_62617c15b10fe594( player, bot );
            level waittill( #"hash_6f681f3ba947f2e1" );
            player notifyonplayercommandremove( "<dev string:x285>", "<dev string:x294>" );
            player notifyonplayercommandremove( "<dev string:x285>", "<dev string:x2a0>" );
            player notifyonplayercommandremove( "<dev string:x285>", "<dev string:x2ac>" );
            player notifyonplayercommandremove( "<dev string:x285>", "<dev string:x2b8>" );
        }
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0xd731d3a2, Offset: 0x417c
    // Size: 0x91, Type: dev
    function function_62617c15b10fe594( player, bot )
    {
        level endon( #"game_ended" );
        level endon( #"hash_6f681f3ba947f2e1" );
        level notify( #"hash_8058aedf62d4d3b7" );
        level endon( #"hash_8058aedf62d4d3b7" );
        player thread function_d5d9926b4ad19bd3( bot );
        
        while ( true )
        {
            if ( bot isuseavailable() )
            {
                print3d( bot.origin, "<dev string:x2c6>", ( 1, 0, 0 ), 1, 0.3, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xba9f593, Offset: 0x4215
    // Size: 0x68, Type: dev
    function function_d5d9926b4ad19bd3( bot )
    {
        level endon( #"game_ended" );
        level endon( #"hash_6f681f3ba947f2e1" );
        self notify( #"hash_c25286caa1f51b4c" );
        self endon( #"hash_c25286caa1f51b4c" );
        
        while ( true )
        {
            self waittill( #"hash_cba6e9cc3df0fcd1" );
            
            if ( is_remote_control_bot( bot ) )
            {
                bot bot_use_killstreak();
            }
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x644d2cab, Offset: 0x4285
    // Size: 0x240, Type: dev
    function function_fa586798d1cbedb5()
    {
        level endon( #"game_ended" );
        level thread function_b94e527b2778ea04();
        
        while ( true )
        {
            if ( getdvarint( @"hash_fcf363902a418e6c" ) == 1 )
            {
                level.var_9fb83b378b2eb8d2 = "<dev string:x2e1>";
                bots = function_52f11792f4110a6c( 0 );
                
                foreach ( bot in bots )
                {
                    level function_5bc10ff964b427cd( bot, 1 );
                }
                
                setdvar( @"hash_fcf363902a418e6c", 0 );
            }
            else if ( getdvarint( @"hash_fcf363902a418e6c" ) == 2 )
            {
                level.var_9fb83b378b2eb8d2 = "<dev string:x2e8>";
                bots = function_52f11792f4110a6c( 0 );
                
                foreach ( bot in bots )
                {
                    bot thread function_3ffa67c9822afae3();
                }
                
                setdvar( @"hash_fcf363902a418e6c", 0 );
            }
            else if ( getdvarint( @"hash_32c65368cb96595" ) != 0 )
            {
                level.var_31a4a7c1e2de624 = getdvarint( @"hash_32c65368cb96595" );
                level.var_9fb83b378b2eb8d2 = "<dev string:x2ef>";
                bots = function_52f11792f4110a6c( 0 );
                
                foreach ( bot in bots )
                {
                    bot thread function_a4213301b80ea93d( level.var_31a4a7c1e2de624 );
                }
                
                setdvar( @"hash_32c65368cb96595", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0x23435f11, Offset: 0x44cd
    // Size: 0xef, Type: dev
    function function_5bc10ff964b427cd( bot, var_87232b2b2601b8b )
    {
        if ( var_87232b2b2601b8b )
        {
            if ( bot bothasscriptgoal() )
            {
                bot botclearscriptgoal();
            }
            
            if ( getdvarint( @"bot_disableattack" ) != 1 )
            {
                bot botsetflag( "<dev string:x2f6>", 0 );
            }
            
            bot botsetflag( "<dev string:x305>", 0 );
            bot botsetflag( "<dev string:x319>", 0 );
            bot.personality_update_function = level.bot_pers_update[ bot.personality ];
            
            if ( !isdefined( bot.personality_update_function ) )
            {
                bot.personality_update_function = level.bot_pers_update[ "<dev string:x32c>" ];
            }
            
            return;
        }
        
        bot botsetflag( "<dev string:x2f6>", 1 );
        bot botsetflag( "<dev string:x305>", 1 );
        bot botsetflag( "<dev string:x319>", 1 );
        bot.personality_update_function = &utility::empty_init_func;
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x40c3d52a, Offset: 0x45c4
    // Size: 0x156, Type: dev
    function function_b94e527b2778ea04()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level waittill( #"player_spawned", player );
            
            if ( isbot( player ) )
            {
                if ( isdefined( level.var_9fb83b378b2eb8d2 ) && level.var_9fb83b378b2eb8d2 != "<dev string:x2e1>" )
                {
                    if ( level.var_9fb83b378b2eb8d2 == "<dev string:x2e8>" )
                    {
                        player thread function_3ffa67c9822afae3();
                    }
                    else if ( level.var_9fb83b378b2eb8d2 == "<dev string:x2ef>" )
                    {
                        player thread function_a4213301b80ea93d( level.var_31a4a7c1e2de624 );
                    }
                }
                
                if ( !isdefined( player.damageinfo ) )
                {
                    player.damageinfo = [];
                }
                
                player.damageinfo[ "<dev string:x338>" ] = 0;
                player.damageinfo[ "<dev string:x344>" ] = 0;
                player.damageinfo[ "<dev string:x355>" ] = "<dev string:x33>";
                player.damageinfo[ "<dev string:x362>" ] = "<dev string:x33>";
                player.damageinfo[ "<dev string:x36e>" ] = "<dev string:x33>";
            }
            
            host = dev_mp::devfindhost();
            
            if ( is_remote_control_bot( player ) )
            {
                host.var_45f7e72b795b2519 = 0;
                host.var_cc908aa2d972bedb = undefined;
            }
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x3738662b, Offset: 0x4722
    // Size: 0xc3, Type: dev
    function function_3ffa67c9822afae3()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self notify( #"follow_player_singleton" );
        self endon( #"follow_player_singleton" );
        level function_5bc10ff964b427cd( self, 0 );
        
        while ( level.var_9fb83b378b2eb8d2 == "<dev string:x2e8>" )
        {
            if ( player::isreallyalive( self ) )
            {
                if ( !isdefined( self.followtarget ) || !player::isreallyalive( self.followtarget ) )
                {
                    self.followtarget = utility::get_closest_player( 0 );
                }
                
                if ( isdefined( self.followtarget ) )
                {
                    self botsetscriptgoal( self.followtarget.origin, 200, "<dev string:x374>" );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x7adcf9af, Offset: 0x47ed
    // Size: 0x206, Type: dev
    function function_a4213301b80ea93d( radius )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self notify( #"hash_3d86a190f1deea7b" );
        self endon( #"hash_3d86a190f1deea7b" );
        level function_5bc10ff964b427cd( self, 0 );
        self.iscircling = 0;
        
        while ( level.var_9fb83b378b2eb8d2 == "<dev string:x2ef>" )
        {
            if ( player::isreallyalive( self ) )
            {
                if ( !isdefined( self.patroltarget ) || !player::isreallyalive( self.patroltarget ) )
                {
                    self.patroltarget = utility::get_closest_player( 1 );
                    self notify( #"hash_bc046543615fb85e" );
                }
                
                if ( isdefined( self.patroltarget ) )
                {
                    if ( length( self.patroltarget getvelocity() ) <= 1 )
                    {
                        if ( !self.iscircling )
                        {
                            circlenodes = function_f190d1085127d284( self.patroltarget.origin, radius );
                            self.iscircling = 1;
                            childthread function_41c676b0b90d3706( circlenodes );
                        }
                    }
                    else
                    {
                        if ( self.iscircling )
                        {
                            self notify( #"hash_bc046543615fb85e" );
                            self.iscircling = 0;
                        }
                        
                        var_bfa73cb7db7621a3 = vectornormalize2( self.origin - self.patroltarget.origin );
                        targetmovedir = vectornormalize2( self.patroltarget getvelocity() );
                        dotproduct = vectordot2( var_bfa73cb7db7621a3, targetmovedir );
                        
                        if ( dotproduct >= 0 )
                        {
                            point = self.origin + 1000 * targetmovedir;
                            self botsetscriptgoal( point, 10, "<dev string:x374>" );
                            self botsetshorttermgoal( 1 );
                        }
                        else
                        {
                            self botsetscriptgoal( self.patroltarget.origin, radius, "<dev string:x374>" );
                        }
                    }
                }
            }
            
            wait 0.1;
        }
        
        self notify( #"hash_bc046543615fb85e" );
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0xc362210a, Offset: 0x49fb
    // Size: 0xca, Type: dev
    function function_f190d1085127d284( center, radius )
    {
        circle_sides = 8;
        anglefrac = 360 / circle_sides;
        circlepoints = [];
        
        for ( i = 0; i < circle_sides ; i++ )
        {
            angle = anglefrac * i;
            xadd = cos( angle ) * radius;
            yadd = sin( angle ) * radius;
            x = center[ 0 ] + xadd;
            y = center[ 1 ] + yadd;
            z = center[ 2 ];
            circlepoints[ circlepoints.size ] = ( x, y, z );
        }
        
        return circlepoints;
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x5316ba83, Offset: 0x4acd
    // Size: 0xf4, Type: dev
    function function_41c676b0b90d3706( circlenodes )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self endon( #"death" );
        self endon( #"hash_bc046543615fb85e" );
        self endon( #"hash_3d86a190f1deea7b" );
        var_3b87409359b681a1 = 0;
        mindistsq = distancesquared( circlenodes[ var_3b87409359b681a1 ], self.origin );
        
        for ( i = 1; i < circlenodes.size ; i++ )
        {
            distsq = distancesquared( circlenodes[ i ], self.origin );
            
            if ( distsq < mindistsq )
            {
                mindistsq = distsq;
                var_3b87409359b681a1 = i;
            }
        }
        
        while ( self.iscircling )
        {
            self botsetscriptgoal( circlenodes[ var_3b87409359b681a1 ], 10, "<dev string:x374>" );
            self botsetshorttermgoal( 1 );
            bots_util::bot_waittill_goal_or_fail();
            var_3b87409359b681a1++;
            
            if ( var_3b87409359b681a1 == circlenodes.size )
            {
                var_3b87409359b681a1 = 0;
            }
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x2396eab8, Offset: 0x4bc9
    // Size: 0x235, Type: dev
    function function_a687d7c92a633df3()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_64822377536c48af" ) == 1 )
            {
                bots_use( "<dev string:x37d>", "<dev string:x147>" );
                setdvar( @"hash_64822377536c48af", 0 );
            }
            else if ( getdvarint( @"hash_64822377536c48af" ) == 2 )
            {
                bots_use( "<dev string:x37d>", "<dev string:x383>" );
                setdvar( @"hash_64822377536c48af", 0 );
            }
            else if ( getdvarint( @"hash_987a9c75b18ab7ed" ) == 1 )
            {
                bots_use( "<dev string:x38a>", "<dev string:x147>" );
                setdvar( @"hash_987a9c75b18ab7ed", 0 );
            }
            else if ( getdvarint( @"hash_987a9c75b18ab7ed" ) == 2 )
            {
                bots_use( "<dev string:x38a>", "<dev string:x383>" );
                setdvar( @"hash_987a9c75b18ab7ed", 0 );
            }
            else if ( getdvarint( @"hash_b3e82ec369d8b929" ) == 1 )
            {
                bots_use( "<dev string:x395>", "<dev string:x147>" );
                setdvar( @"hash_b3e82ec369d8b929", 0 );
            }
            else if ( getdvarint( @"hash_b3e82ec369d8b929" ) == 2 )
            {
                bots_use( "<dev string:x395>", "<dev string:x383>" );
                setdvar( @"hash_b3e82ec369d8b929", 0 );
            }
            else if ( getdvarint( @"hash_9c38beab079f09a2" ) == 1 )
            {
                bots_use( "<dev string:x128>", "<dev string:x147>" );
                setdvar( @"hash_9c38beab079f09a2", 0 );
            }
            else if ( getdvarint( @"hash_9c38beab079f09a2" ) == 2 )
            {
                bots_use( "<dev string:x128>", "<dev string:x383>" );
                setdvar( @"hash_9c38beab079f09a2", 0 );
            }
            else if ( getdvarint( @"hash_ce29490b019acd60" ) == 1 )
            {
                bots_use( "<dev string:x39c>", "<dev string:x147>" );
                setdvar( @"hash_ce29490b019acd60", 0 );
            }
            else if ( getdvarint( @"hash_ce29490b019acd60" ) == 2 )
            {
                bots_use( "<dev string:x3a5>", "<dev string:x147>" );
                setdvar( @"hash_ce29490b019acd60", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0x6fbb294b, Offset: 0x4e06
    // Size: 0x156, Type: dev
    function bots_use( usetype, bottype )
    {
        bots = [];
        
        if ( bottype == "<dev string:x383>" )
        {
            targetbot = function_944bfd48ce67278e();
            
            if ( player::isreallyalive( targetbot ) )
            {
                bots[ bots.size ] = targetbot;
            }
        }
        else if ( bottype == "<dev string:x147>" )
        {
            bots = function_52f11792f4110a6c( 1 );
        }
        
        foreach ( bot in bots )
        {
            if ( usetype == "<dev string:x37d>" )
            {
                bot function_3dc1d19e01d21d40();
                continue;
            }
            
            if ( usetype == "<dev string:x38a>" )
            {
                bot bot_use_killstreak();
                continue;
            }
            
            if ( usetype == "<dev string:x395>" || usetype == "<dev string:x128>" )
            {
                bot bot_use_equipment( usetype );
                continue;
            }
            
            if ( usetype == "<dev string:x39c>" )
            {
                bot botpressbutton( "<dev string:x3ad>" );
                continue;
            }
            
            if ( usetype == "<dev string:x3a5>" )
            {
                bot botpressbutton( "<dev string:x3ad>", 5 );
            }
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x47d0db34, Offset: 0x4f64
    // Size: 0xd7, Type: dev
    function function_3dc1d19e01d21d40()
    {
        superinfo = supers_mp::getcurrentsuper();
        
        if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
        {
            super = superinfo.staticdata.ref;
            superweaponname = level.superglobals.staticsuperdata[ super ].weapon;
            
            if ( !isdefined( superweaponname ) )
            {
                superweaponname = %"super_default_mp";
            }
            
            superweapon = makeweapon( superweaponname );
            
            if ( isdefined( self.super ) )
            {
                if ( !isnullweapon( superweapon ) && superweapon.basename != %"super_default_mp" )
                {
                    weapon_utility::giveandfireoffhandreliable( superweapon );
                }
                
                thread supers_mp::trysuperusebegin( superweapon );
            }
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x425f48d8, Offset: 0x5043
    // Size: 0x33, Type: dev
    function bot_use_killstreak()
    {
        streakitem = killstreaks::getkillstreakinslot( 0 );
        
        if ( !isdefined( streakitem ) )
        {
            return;
        }
        
        thread killstreaks::triggerkillstreak( streakitem, 0 );
        thread function_af85768e0d5fbf5d( streakitem );
    }

    // Namespace bots_debug
    // Params 2
    // Checksum 0x326d4caf, Offset: 0x507e
    // Size: 0xca, Type: dev
    function bot_use_equipment( equiptype, equipref )
    {
        if ( level.gamemodebundle.var_b8686b90947d6097 && equiptype == "<dev string:x3b1>" )
        {
            slot = equipment_mp::findequipmentslot( equipref );
            
            switch ( slot )
            {
                case #"hash_325cb2e66f67d5b9":
                    equiptype = "<dev string:x395>";
                    break;
                case #"hash_511d3c24fcedcdb1":
                    equiptype = "<dev string:x128>";
                    break;
                case #"hash_a7832978dd2b6523":
                    equiptype = "<dev string:x3dc>";
                    break;
                default:
                    assertmsg( "<dev string:x3e4>" + slot + "<dev string:x3f5>" + equipref );
                    break;
            }
        }
        
        self botpressbutton( equiptype );
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xab1799b9, Offset: 0x5150
    // Size: 0x191, Type: dev
    function function_af85768e0d5fbf5d( streakitem )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self endon( #"death" );
        self notify( #"hash_ae57837f6980b1e4" );
        self endon( #"hash_ae57837f6980b1e4" );
        waitframe();
        streakname = streakitem.streakname;
        
        if ( dev_mp::function_9a0d41eb59b01683( streakname ) )
        {
            return;
        }
        
        wait 2;
        botweapon = self getcurrentweapon();
        
        if ( !isdefined( botweapon.type ) )
        {
            return;
        }
        
        if ( botweapon.type == "<dev string:x405>" )
        {
            if ( killstreak_utility::function_1b357b025e90e8cc( botweapon ) )
            {
                host = dev_mp::devfindhost();
                
                if ( isdefined( host ) )
                {
                    self notify( #"confirm_location", host.origin, randomintrange( 0, 360 ) );
                }
            }
            
            return;
        }
        
        if ( botweapon.type == "<dev string:x414>" || botweapon.type == "<dev string:x420>" )
        {
            self botpressbutton( "<dev string:x428>" );
            return;
        }
        
        if ( botweapon.type == "<dev string:x42f>" )
        {
            wait 2;
            
            if ( killstreak_utility::function_d84b70a08674a174( botweapon ) )
            {
                while ( self getcurrentweapon() == botweapon )
                {
                    self botpressbutton( "<dev string:x428>" );
                    wait 0.5;
                }
            }
            else
            {
                self botpressbutton( "<dev string:x428>" );
            }
            
            return;
        }
        
        while ( self getcurrentweapon() == botweapon )
        {
            self botpressbutton( "<dev string:x428>" );
            wait 0.5;
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x17156c2f, Offset: 0x52e9
    // Size: 0x3ec, Type: dev
    function function_c7b02753c0aa5e11()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_56ec8ca00a388c58" ) == 0 && getdvarint( @"hash_d937709e265ed648" ) == 0 )
            {
                waitframe();
                continue;
            }
            
            bots = function_52f11792f4110a6c( 1 );
            
            foreach ( bot in bots )
            {
                lines = [];
                lines[ lines.size ] = "<dev string:x20b>" + bot.health;
                lines[ lines.size ] = "<dev string:x203>" + ( bot.armorhealth ?? 0 );
                lines[ lines.size ] = "<dev string:x436>" + bot.poise;
                
                if ( getdvarint( @"hash_56ec8ca00a388c58" ) == 1 )
                {
                    host = dev_mp::devfindhost();
                    
                    if ( isdefined( host ) )
                    {
                        lines[ lines.size ] = "<dev string:x43e>" + int( distance( bot.origin, host.origin ) );
                    }
                    
                    botweapon = bot getcurrentweapon();
                    
                    if ( isdefined( botweapon ) )
                    {
                        lines[ lines.size ] = "<dev string:x451>" + botweapon.basename;
                    }
                    
                    equips = function_ebfe556e4816226c( bot );
                    
                    foreach ( equip in equips )
                    {
                        lines[ lines.size ] = equip;
                    }
                    
                    lines[ lines.size ] = function_c4c592fef648d481( bot );
                    streaks = function_8a820fec096d89a9( bot );
                    
                    foreach ( streak in streaks )
                    {
                        lines[ lines.size ] = streak;
                    }
                }
                
                if ( getdvarint( @"hash_d937709e265ed648" ) == 1 )
                {
                    elems = function_5c6ff91eb2fa48b5( bot );
                    
                    foreach ( elem in elems )
                    {
                        lines[ lines.size ] = elem;
                    }
                }
                
                var_fcc1b1056b3f942 = bot.origin + ( 0, 0, 100 );
                linespace = ( 0, 0, -5 );
                
                foreach ( line in lines )
                {
                    print3d( var_fcc1b1056b3f942, line, undefined, undefined, 0.3, 1, 0 );
                    var_fcc1b1056b3f942 += linespace;
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0xa2f8635a, Offset: 0x56dd
    // Size: 0x149, Type: dev
    function function_ebfe556e4816226c( bot )
    {
        if ( isdefined( bot.equipment ) )
        {
            result = [];
            
            foreach ( equip in bot.equipment )
            {
                if ( isdefined( level.equipment.table[ equip ] ) && isdefined( level.equipment.table[ equip ].bundle ) )
                {
                    equiptype = level.equipment.table[ equip ].bundle.equipmenttype;
                }
                
                if ( !isdefined( equiptype ) )
                {
                    equiptype = "<dev string:x461>";
                }
                
                result[ result.size ] = equiptype + "<dev string:x46b>" + equip + "<dev string:x46e>" + bot equipment_mp::getequipmentammo( equip ) + "<dev string:x471>";
            }
            
            return result;
        }
        
        return "<dev string:x473>";
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x105a0e94, Offset: 0x582e
    // Size: 0x5a, Type: dev
    function function_c4c592fef648d481( bot )
    {
        super = bot supers_mp::getcurrentsuper();
        
        if ( isdefined( super ) && isdefined( super.staticdata ) )
        {
            return ( "<dev string:x483>" + super.staticdata.ref );
        }
        
        return "<dev string:x492>";
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x5c861c23, Offset: 0x5890
    // Size: 0x146, Type: dev
    function function_8a820fec096d89a9( bot )
    {
        if ( isdefined( bot.streakdata ) && isdefined( bot.streakdata.streaks ) )
        {
            result = [];
            
            if ( bot.streakdata.streaks.size == 0 )
            {
                result[ result.size ] = "<dev string:x4a5>";
            }
            
            foreach ( ks in bot.streakdata.streaks )
            {
                if ( ks.available )
                {
                    result[ result.size ] = "<dev string:x4b6>" + ks.streakname;
                }
                
                if ( ks == bot.streakdata.streaks[ 0 ] )
                {
                    result[ result.size - 1 ] += "<dev string:x4c3>";
                }
            }
            
            return result;
        }
        
        return "<dev string:x4a5>";
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x755d5934, Offset: 0x59de
    // Size: 0xca, Type: dev
    function function_5c6ff91eb2fa48b5( bot )
    {
        result = [];
        result[ result.size ] = "<dev string:x4d4>";
        
        if ( isdefined( bot.damageinfo ) )
        {
            foreach ( key in getarraykeys( bot.damageinfo ) )
            {
                result[ result.size ] = key + "<dev string:x46b>" + bot.damageinfo[ key ];
            }
        }
        
        return result;
    }

    // Namespace bots_debug
    // Params 1
    // Checksum 0x44216722, Offset: 0x5ab0
    // Size: 0x14d, Type: dev
    function function_f77865bdc33a68e2( mtxbot )
    {
        hostplayer = get_all_humans()[ 0 ];
        setspawnweap = 0;
        botweapon = mtxbot getcurrentweapon();
        playerweapon = hostplayer getcurrentweapon();
        
        if ( isdefined( playerweapon ) && botweapon != playerweapon )
        {
            if ( mtxbot isreloading() )
            {
                wait 3;
                mtxbot takeallweapons();
                mtxbot class::loadout_updateplayer( hostplayer.var_d30f3c619f5bda56, hostplayer.classstruct, hostplayer.class, setspawnweap, 0 );
            }
            else
            {
                mtxbot takeallweapons();
                mtxbot class::loadout_updateplayer( hostplayer.var_d30f3c619f5bda56, hostplayer.classstruct, hostplayer.class, setspawnweap, 0 );
            }
        }
        
        if ( getdvarint( @"hash_17bb7ff71c139bfe", 0 ) )
        {
            var_75716214ae82e2ab = hostplayer.operatorcustomization.skinref;
            setdvar( @"hash_803cefdbe23f6bfe", getxhashsourcename( var_75716214ae82e2ab ) );
        }
        else
        {
            var_75716214ae82e2ab = getdvar( @"hash_803cefdbe23f6bfe" );
        }
        
        if ( mtxbot.operatorcustomization.skinref != var_75716214ae82e2ab )
        {
            mtxbot operator::createoperatorcustomization();
        }
    }

    // Namespace bots_debug
    // Params 0
    // Checksum 0x8383b5e0, Offset: 0x5c05
    // Size: 0xfc, Type: dev
    function function_2d7d75ca7c5cbc98()
    {
        wait 0.5;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        var_9317ab281caf26f = "<dev string:x4e6>" + self.name;
        devgui_dvar_cmd = "<dev string:x4f7>" + self getentitynumber() + "<dev string:x50f>";
        var_20e6373249b84a7f = var_9317ab281caf26f + "<dev string:x511>" + devgui_dvar_cmd;
        adddebugcommand( "<dev string:x519>" + var_20e6373249b84a7f );
        
        if ( !isdefined( level.var_80c4b08ae079966c ) )
        {
            level.var_80c4b08ae079966c = 0;
        }
        
        level.var_80c4b08ae079966c++;
        
        while ( isdefined( self ) && getdvarint( @"hash_be2aad7916d01add", -1 ) != self getentitynumber() )
        {
            waitframe();
        }
        
        setdvar( @"hash_be2aad7916d01add", -1 );
        
        if ( isdefined( self ) )
        {
            kick( self );
        }
        
        adddebugcommand( "<dev string:x525>" + var_9317ab281caf26f );
        level.var_80c4b08ae079966c--;
        
        if ( level.var_80c4b08ae079966c == 0 )
        {
            adddebugcommand( "<dev string:x525>" + "<dev string:x534>" );
        }
    }

#/
