// script_18c2f6d91cbc576a  (hash_18c2f6d91cbc576a.gscc) (size: 15056 Bytes / 0x3ad0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d84cbc7 (2642725831)
// size ...... 15056 (0x3ad0)
// includes .. 8   (offset: 0x34e4)
// strings ... 0   (offset: 0x3524)
// dev strs .. 102 (offset: 0x3524)
// exports ... 36  (offset: 0x2398)
// cseg ...... 0x58 + 0x2340 (0x2398)
// imports ... 92  (offset: 0x2938)
// animtree1 . 0   (offset: 0x3ad0)
// animtree2 . 0   (offset: 0x3ad0)
#using script_5305dc48048e0b08;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\mp_agent;

#namespace namespace_a4e869218d89862b;

/#

    // Namespace namespace_a4e869218d89862b
    // Params 5
    // Checksum 0x1092c1dd, Offset: 0x76
    // Size: 0x1d0, Type: dev
    function function_18eb5a324873d647( player, var_1cbaab36ffd1f0e0, var_982a59883d734f44, var_734f7a9bb72d1cd9, debug_text_scale )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( !isdefined( var_1cbaab36ffd1f0e0 ) )
        {
            var_1cbaab36ffd1f0e0 = 0;
        }
        
        player = benchmark_mp_utils::validateplayer( player );
        
        if ( level.var_cc20b5f512f860a7 )
        {
            assertmsg( "<dev string:x24>" );
            return 0;
        }
        
        iprintlnbold( "<dev string:x65>" );
        level.var_cc20b5f512f860a7 = 1;
        level.var_85bd03451606a51c = 0;
        level.var_7e9d5b7ac9461569 = [];
        level.var_2fe10111b5bdaf5a = 0;
        thread function_6ea8c9d5f99d3711( player );
        thread function_53e2674bcb2283e0( player );
        devgui::function_9082edeb5db93280( "<dev string:x7d>" );
        devgui::add_devgui_func( "<dev string:x8b>", "<dev string:x9d>", &function_2aeee62eb74ef327 );
        devgui::add_devgui_func( "<dev string:xaa>", "<dev string:xb6>", &function_3c5088361ceee0f4 );
        devgui::add_devgui_func( "<dev string:xbf>", "<dev string:xcb>", &function_ae7f8a94a5fd1e5f );
        devgui::add_devgui_func( "<dev string:xd4>", "<dev string:xe6>", &function_b2b505538108d9f9 );
        devgui::add_devgui_func( "<dev string:xf1>", "<dev string:x109>", &function_ba3f95adcfe491b2 );
        devgui::function_77df7fe7dd273e10();
        Files = function_73796ddfbc223146( function_516c60097c3c8f11(), "<dev string:x113>" + "<dev string:x115>" );
        
        if ( Files.size > 0 )
        {
            level.var_58e59879b0e7af74 = Files[ 0 ];
        }
        else
        {
            level.var_58e59879b0e7af74 = benchmark_mp_utils::function_5f9b63ec7a92782b( game_utility::getmapname() + "<dev string:x11a>" + "<dev string:x11c>", "<dev string:x115>", function_516c60097c3c8f11() );
        }
        
        if ( var_1cbaab36ffd1f0e0 )
        {
            function_4d2db8fad8d77c0e( level.var_58e59879b0e7af74 );
        }
        
        benchmark_mp_utils::function_52defaf90913e64f( "<dev string:x12e>", "<dev string:x14c>", "<dev string:x11c>", "<dev string:x115>", function_516c60097c3c8f11(), &function_51c52a494f7db380 );
        return 1;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1
    // Checksum 0xbee68131, Offset: 0x24e
    // Size: 0xf8, Type: dev
    function function_26a1835f93ca6d0d( var_3c37c256a0a4b047 )
    {
        if ( !isdefined( var_3c37c256a0a4b047 ) )
        {
            var_3c37c256a0a4b047 = 0;
        }
        
        if ( level.var_cc20b5f512f860a7 )
        {
            level notify( #"hash_b8914952fbc70e6f" );
            level.var_cc20b5f512f860a7 = 0;
            
            if ( var_3c37c256a0a4b047 )
            {
                foreach ( enemy_struct in level.var_7e9d5b7ac9461569 )
                {
                    enemy_struct.enemy agent_utils::despawnagent();
                }
                
                level.var_85bd03451606a51c = 0;
            }
            
            level.var_7e9d5b7ac9461569 = [];
            level.var_2fe10111b5bdaf5a = 0;
            iprintlnbold( "<dev string:x15b>" );
            return;
        }
        
        assertmsg( "<dev string:x172>" );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0xa2ccb207, Offset: 0x34e
    // Size: 0x3c, Type: dev
    function function_7947143d9758448b()
    {
        if ( level.var_94063039d65633b2 )
        {
            return int( namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x1ab>", "<dev string:x1ae>", 100 ) );
        }
        
        return int( getdvarint( @"hash_87c94a85ffc74e32", 100 ) );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0x1d7382dc, Offset: 0x392
    // Size: 0x45, Type: dev
    function function_2aeee62eb74ef327()
    {
        fileid = function_b70280649f0c0c0d( function_20688371f05b11e7(), "<dev string:x1b5>", function_516c60097c3c8f11() );
        function_9c33c17f1c093741( fileid );
        function_de6ee02f9fb0e262( function_516c60097c3c8f11() + "<dev string:x1ba>" + function_20688371f05b11e7() );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0x12c14e46, Offset: 0x3df
    // Size: 0x18, Type: dev
    function function_516c60097c3c8f11()
    {
        return "<dev string:x1bc>" + game_utility::getmapname() + "<dev string:x1d1>";
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0xfedb935, Offset: 0x3ff
    // Size: 0x186, Type: dev
    function function_3c5088361ceee0f4()
    {
        foreach ( enemy_struct in level.var_7e9d5b7ac9461569 )
        {
            if ( !( isdefined( enemy_struct ) && isdefined( enemy_struct.enemy ) ) || enemy_struct.is_dead == 1 )
            {
                level.var_7e9d5b7ac9461569 = arrayremove( level.var_7e9d5b7ac9461569, enemy_struct );
            }
        }
        
        for ( i = 0; i < level.var_7e9d5b7ac9461569.size - 1 ; i++ )
        {
            for ( j = 0; j < level.var_7e9d5b7ac9461569.size - i - 1 ; j++ )
            {
                if ( level.var_7e9d5b7ac9461569[ j ].group_index > level.var_7e9d5b7ac9461569[ j + 1 ].group_index )
                {
                    temp_value = level.var_7e9d5b7ac9461569[ j + 1 ];
                    level.var_7e9d5b7ac9461569[ j + 1 ] = level.var_7e9d5b7ac9461569[ j ];
                    level.var_7e9d5b7ac9461569[ j ] = temp_value;
                }
            }
        }
        
        function_15a9cbc92403f6f2( level.var_7e9d5b7ac9461569 );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 2
    // Checksum 0x62dee9bc, Offset: 0x58d
    // Size: 0x1b6, Type: dev
    function function_4d2db8fad8d77c0e( file_name, file_folder )
    {
        if ( !isdefined( file_folder ) )
        {
            file_folder = undefined;
        }
        
        new_ai_info = function_8b6a4a7e0d07d952( file_name );
        
        if ( new_ai_info.size > 0 )
        {
            function_b2b505538108d9f9();
        }
        
        if ( !isdefined( file_folder ) )
        {
            file_folder = function_516c60097c3c8f11();
        }
        
        var_51613f46b0475eed = 0;
        
        foreach ( info in new_ai_info )
        {
            assert( isdefined( info.starting_origin ), "<dev string:x1e1>" );
            assert( isdefined( info.starting_angles ), "<dev string:x204>" );
            assert( isdefined( info.stance ), "<dev string:x227>" );
            assert( isdefined( info.is_moving ), "<dev string:x24a>" );
            assert( isdefined( info.goal_location ), "<dev string:x270>" );
            assert( isdefined( info.speed ), "<dev string:x29a>" );
            assert( isdefined( info.group_index ), "<dev string:x2bc>" );
            function_8b305053f35f967d( info );
            
            if ( info.group_index >= var_51613f46b0475eed )
            {
                var_51613f46b0475eed = info.group_index + 1;
            }
        }
        
        level.var_2fe10111b5bdaf5a = var_51613f46b0475eed;
        function_1a049368047ff094( level.player );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1
    // Checksum 0x3e372780, Offset: 0x74b
    // Size: 0xb8, Type: dev
    function function_699c2ae3a530d919( group_index )
    {
        foreach ( enemy_struct in level.var_7e9d5b7ac9461569 )
        {
            if ( enemy_struct.group_index == group_index && enemy_struct.is_moving && !enemy_struct.is_dead )
            {
                function_d1be6fef6225f16d( enemy_struct );
            }
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0xf8b6e2be, Offset: 0x80b
    // Size: 0x10, Type: dev
    function function_f9a574a419cf108c()
    {
        return istrue( level.var_cc20b5f512f860a7 );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0
    // Checksum 0x65917238, Offset: 0x823
    // Size: 0xf, Type: dev
    function function_afacc4827d5a0c17()
    {
        return level.var_2fe10111b5bdaf5a;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1
    // Checksum 0xa171a7e, Offset: 0x83a
    // Size: 0x3c, Type: dev
    function function_f0396df5e1bddae9( callback )
    {
        if ( !isdefined( level.var_67eb6946ace32e53 ) )
        {
            level.var_67eb6946ace32e53 = [];
        }
        
        level.var_67eb6946ace32e53[ level.var_67eb6946ace32e53.size ] = callback;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0, eflags: 0x4
    // Checksum 0xa174743b, Offset: 0x87e
    // Size: 0xf, Type: dev
    function private function_20688371f05b11e7()
    {
        return level.var_58e59879b0e7af74;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x6833c3fd, Offset: 0x895
    // Size: 0x94, Type: dev
    function private function_1a049368047ff094( player )
    {
        if ( !isdefined( level.var_67eb6946ace32e53 ) )
        {
            return;
        }
        
        foreach ( callback in level.var_67eb6946ace32e53 )
        {
            [[ callback ]]( player );
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0, eflags: 0x4
    // Checksum 0xab6818cd, Offset: 0x931
    // Size: 0xb6, Type: dev
    function private function_b2b505538108d9f9()
    {
        foreach ( enemy_struct in level.var_7e9d5b7ac9461569 )
        {
            enemy_struct.from_despawn = 1;
            enemy_struct.enemy agent_utils::despawnagent();
        }
        
        level.var_7e9d5b7ac9461569 = [];
        level.var_2fe10111b5bdaf5a = 0;
        function_ec35558e2c5a5ad3( 0 );
        removeallcorpses();
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0, eflags: 0x4
    // Checksum 0xb4a4fb2c, Offset: 0x9ef
    // Size: 0xfc, Type: dev
    function private function_ba3f95adcfe491b2()
    {
        foreach ( enemy_struct in level.var_7e9d5b7ac9461569 )
        {
            if ( enemy_struct.is_moving && isdefined( enemy_struct.enemy ) && !enemy_struct.is_dead )
            {
                enemy_struct.enemy setorigin( enemy_struct.starting_origin );
                enemy_struct.enemy notify( #"hash_d2e900705a2046a7" );
                
                if ( enemy_struct.group_index != -1 )
                {
                    function_f6be3c5d86d0cdf6( enemy_struct, 1 );
                    continue;
                }
                
                function_d1be6fef6225f16d( enemy_struct );
            }
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x58697394, Offset: 0xaf3
    // Size: 0x1b, Type: dev
    function private function_463bdc45ee2d33df( player )
    {
        return player buttonpressed( "<dev string:x2de>" );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xac4da40f, Offset: 0xb16
    // Size: 0x2a, Type: dev
    function private saveinput( player )
    {
        return player buttonpressed( "<dev string:x2e3>" ) && player buttonpressed( "<dev string:x2e8>" );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xa39b4a78, Offset: 0xb48
    // Size: 0x2a, Type: dev
    function private loadinput( player )
    {
        return player buttonpressed( "<dev string:x2ed>" ) && player buttonpressed( "<dev string:x2f2>" );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xe26fb1f0, Offset: 0xb7a
    // Size: 0x324, Type: dev
    function private function_53e2674bcb2283e0( player )
    {
        player endon( #"disconnect" );
        level endon( #"game_ended" );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_8715e266c3f6650e", 1 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            var_61889edd99154c0e = 1;
            
            for ( i = 0; i < level.var_7e9d5b7ac9461569.size ; i++ )
            {
                enemy_struct = level.var_7e9d5b7ac9461569[ i ];
                
                if ( !enemy_struct.is_dead && isdefined( enemy_struct.enemy ) )
                {
                    enemy = enemy_struct.enemy;
                    enemy_origin = enemy.origin;
                    capsule_data = enemy physics_getcharactercollisioncapsule();
                    
                    if ( isdefined( capsule_data ) )
                    {
                        height = 0;
                        
                        switch ( enemy_struct.stance )
                        {
                            case #"hash_c6775c88e38f7803":
                                height = capsule_data[ "<dev string:x2fd>" ] * 2;
                                break;
                            case #"hash_3fed0cbd303639eb":
                                height = capsule_data[ "<dev string:x2fd>" ] * 1.5;
                                break;
                            case #"hash_d91940431ed7c605":
                                height = capsule_data[ "<dev string:x2fd>" ] * 0.5;
                                break;
                        }
                        
                        if ( getdvarint( @"hash_42de9d4c1c64a0b7", 0 ) == 1 )
                        {
                            utility::draw_capsule( enemy_origin, capsule_data[ "<dev string:x316>" ], height, enemy.angles, ( 1, 0, 0 ), 0, 1 );
                        }
                        
                        textposition = ( enemy_origin[ 0 ], enemy_origin[ 1 ], enemy_origin[ 2 ] + height * 0.5 );
                        print3d( textposition, "<dev string:x31d>", ( 1, 0, 0 ), 0.8, 0.5, 1 );
                        var_b661057304f3aa5e = ( enemy_origin[ 0 ], enemy_origin[ 1 ], enemy_origin[ 2 ] + height );
                        
                        if ( enemy_struct.is_moving )
                        {
                            stats_text = "<dev string:x326>" + enemy_struct.speed;
                            print3d( var_b661057304f3aa5e + ( 0, 0, 5 ), stats_text, ( 1, 0, 0 ), 1, 0.6, 1, 1 );
                        }
                        
                        group_position = var_b661057304f3aa5e + ( 0, 0, 10 );
                        group_text = enemy_struct.group_index != -1 ? "<dev string:x32e>" + enemy_struct.group_index + 1 : "<dev string:x335>";
                        group_text += "<dev string:x33e>" + var_61889edd99154c0e;
                        print3d( var_b661057304f3aa5e + ( 0, 0, 20 ), group_text, ( 0, 1, 0 ), 1, 0.6, 1, 1 );
                        
                        if ( i < level.var_7e9d5b7ac9461569.size - 1 && enemy_struct.group_index == level.var_7e9d5b7ac9461569[ i + 1 ].group_index )
                        {
                            var_61889edd99154c0e++;
                            continue;
                        }
                        
                        var_61889edd99154c0e = 1;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 8, eflags: 0x4
    // Checksum 0xced6fc5d, Offset: 0xea6
    // Size: 0xde, Type: dev
    function private function_53d75b945528df43( enemyref, stance, starting_origin, starting_angles, is_moving, goal_location, speed, group_index )
    {
        enemy_data = spawnstruct();
        enemy_data.enemy = enemyref;
        enemy_data.stance = stance;
        enemy_data.is_dead = 0;
        enemy_data.starting_origin = starting_origin;
        enemy_data.starting_angles = starting_angles;
        enemy_data.is_moving = is_moving;
        enemy_data.goal_location = goal_location;
        enemy_data.speed = speed;
        enemy_data.group_index = group_index;
        return enemy_data;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xcbf8a468, Offset: 0xf8c
    // Size: 0x56, Type: dev
    function private function_97a68fb88ec425df( enemystruct )
    {
        enemystruct.enemy waittill( #"death" );
        enemystruct.is_dead = 1;
        
        if ( !enemystruct.from_despawn )
        {
            function_ec35558e2c5a5ad3( level.var_85bd03451606a51c - 1 );
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xbe63a880, Offset: 0xfea
    // Size: 0x165, Type: dev
    function private function_8b305053f35f967d( enemy_info_struct )
    {
        origin = enemy_info_struct.starting_origin;
        angles = enemy_info_struct.starting_angles;
        stance = enemy_info_struct.stance;
        is_moving = enemy_info_struct.is_moving;
        goal_location = enemy_info_struct.goal_location;
        speed = enemy_info_struct.speed;
        group_index = enemy_info_struct.group_index;
        enemyspawned = mp_agent::spawnnewagentaitype( "<dev string:x347>" + tolower( getprojectname() ), origin, angles, "<dev string:x35b>" );
        
        if ( !isdefined( enemyspawned ) )
        {
            assertmsg( "<dev string:x360>" );
            return;
        }
        
        enemy_info_struct.enemy = enemyspawned;
        enemyspawned.health = function_7947143d9758448b();
        
        if ( group_index == -1 && is_moving )
        {
            function_d1be6fef6225f16d( enemy_info_struct );
        }
        else
        {
            function_f6be3c5d86d0cdf6( enemy_info_struct, 1 );
        }
        
        if ( is_moving )
        {
            thread function_e0c9b2c59966131c( enemy_info_struct );
        }
        
        level.var_7e9d5b7ac9461569[ level.var_7e9d5b7ac9461569.size ] = enemy_info_struct;
        thread function_97a68fb88ec425df( enemy_info_struct );
        function_ec35558e2c5a5ad3( level.var_85bd03451606a51c + 1 );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x3a4483dd, Offset: 0x1157
    // Size: 0xd6, Type: dev
    function private function_6cc69abb4f8b9f0a( enemy_info_struct )
    {
        enemy = enemy_info_struct.enemy;
        enemy endon( #"death" );
        enemy endon( #"hash_d2e900705a2046a7" );
        waitframe();
        enemy setorigin( enemy_info_struct.starting_origin );
        enemy.angles = enemy_info_struct.starting_angles;
        
        for ( ;; )
        {
            goal_position = enemy getgoalpos();
            
            if ( enemy isingoal( enemy getorigin() ) )
            {
                wait 2;
                
                if ( enemy_info_struct.group_index != -1 )
                {
                    function_f6be3c5d86d0cdf6( enemy_info_struct );
                }
                else
                {
                    enemy setorigin( enemy_info_struct.starting_origin );
                    enemy.angles = enemy_info_struct.starting_angles;
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x3449d5a, Offset: 0x1235
    // Size: 0xac, Type: dev
    function private function_e0c9b2c59966131c( enemy_info_struct )
    {
        if ( !enemy_info_struct.is_moving )
        {
            return;
        }
        
        enemy = enemy_info_struct.enemy;
        goal_position = enemy_info_struct.goal_location;
        enemy endon( #"death" );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_8715e266c3f6650e", 1 ) == 1 )
            {
                line( enemy geteye(), goal_position, ( 0, 1, 0 ), 0.5, 0, 1 );
                sphere( goal_position, 10, ( 0, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 2, eflags: 0x4
    // Checksum 0x72976384, Offset: 0x12e9
    // Size: 0x15a, Type: dev
    function private function_f6be3c5d86d0cdf6( enemy_struct, var_7bcf342291d5a233 )
    {
        if ( !isdefined( var_7bcf342291d5a233 ) )
        {
            var_7bcf342291d5a233 = 0;
        }
        
        enemyentity = enemy_struct.enemy;
        stance = enemy_struct.stance;
        
        if ( !isdefined( enemyentity ) )
        {
            assertmsg( "<dev string:x38c>" );
            return;
        }
        
        enemyentity enabletraversals( 0 );
        enemyentity.dontevershoot = 1;
        enemyentity.bt.cannotmelee = 1;
        enemyentity utility::set_movement_speed( 0 );
        enemyentity enabletraversals( 0 );
        
        if ( isdefined( stance ) )
        {
            enemyentity allowedstances( stance );
        }
        
        enemyentity.aggressivemode = 0;
        enemyentity function_2ef9eb3349906d00( 600 );
        enemyentity.favoriteenemy = undefined;
        enemyentity.ignoreme = 1;
        enemyentity.ignoreall = 1;
        enemyentity.disablebulletwhizbyreaction = 1;
        enemyentity setcanusecover( 0 );
        enemyentity.runngunenabled = 0;
        enemyentity.disabledodge = 1;
        enemyentity.scripted_mode = 1;
        
        if ( getdvarint( @"hash_8495042d50ab4cd2", 1 ) && var_7bcf342291d5a233 && enemy_struct.is_moving )
        {
            enemyentity invisiblenotsolid();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x4bd007cc, Offset: 0x144b
    // Size: 0x192, Type: dev
    function private function_d1be6fef6225f16d( enemy_info_struct )
    {
        enemyentity = enemy_info_struct.enemy;
        stance = enemy_info_struct.stance;
        goalposition = enemy_info_struct.goal_location;
        angles = enemy_info_struct.starting_angles;
        origin = enemy_info_struct.starting_origin;
        speed = enemy_info_struct.speed;
        
        if ( !isdefined( enemyentity ) )
        {
            assertmsg( "<dev string:x38c>" );
            return;
        }
        
        enemyentity.dontevershoot = 1;
        enemyentity.bt.cannotmelee = 1;
        
        if ( isdefined( stance ) )
        {
            enemyentity allowedstances( stance );
        }
        
        enemyentity visiblesolid();
        speed = clamp( speed, 50, 300 );
        enemyentity utility::set_movement_speed( speed );
        enemyentity setgoalpos( goalposition, 0 );
        enemyentity.aggressivemode = 0;
        enemyentity function_2ef9eb3349906d00( 600 );
        enemyentity.favoriteenemy = undefined;
        enemyentity.ignoreme = 1;
        enemyentity.ignoreall = 1;
        enemyentity.disablebulletwhizbyreaction = 1;
        enemyentity setcanusecover( 0 );
        enemyentity.runngunenabled = 0;
        enemyentity.disabledodge = 1;
        enemyentity.scripted_mode = 1;
        enemyentity notify( #"hash_d2e900705a2046a7" );
        thread function_6cc69abb4f8b9f0a( enemy_info_struct );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 2, eflags: 0x4
    // Checksum 0xcf7e756d, Offset: 0x15e5
    // Size: 0x1e4, Type: dev
    function private function_deb83256d68fcd1f( player, ai_start_position )
    {
        raycast_content = trace::create_solid_ai_contents();
        confirm_button = "<dev string:x3c3>";
        cancel_button = "<dev string:x3ca>";
        
        for ( ;; )
        {
            start = player geteye() + ( 7, 7, 7 );
            end = start + vectornormalize( anglestoforward( player getplayerangles() ) ) * 2000;
            trace = trace::ray_trace( start, end, player, raycast_content, 1 );
            ispointonnavmesh = 0;
            
            if ( isdefined( trace[ "<dev string:x3d1>" ] ) )
            {
                position = trace[ "<dev string:x3d1>" ];
                ispointonnavmesh = ispointonnavmesh( position, player );
                
                if ( player buttonpressed( confirm_button ) && ispointonnavmesh )
                {
                    return position;
                }
                
                printtoscreen2d( 500, 250, "<dev string:x3da>", ( 0, 1, 0 ), 1.3, 1 );
                printtoscreen2d( 500, 275, "<dev string:x3fe>" + confirm_button + "<dev string:x407>", ( 0, 1, 0 ), 1.3, 1 );
                printtoscreen2d( 500, 300, "<dev string:x3fe>" + cancel_button + "<dev string:x417>", ( 0, 1, 0 ), 1.3, 1 );
                color = ispointonnavmesh ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                sphere( position, 20, color, 0, 1 );
                print3d( position, ispointonnavmesh ? "<dev string:x422>" : "<dev string:x432>", color, 1, 1, 1, 1 );
                line( position, ai_start_position, ( 0, 0, 1 ), 1, 1, 1 );
            }
            
            if ( player buttonpressed( cancel_button ) )
            {
                return;
            }
            
            waitframe();
        }
        
        return;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x3ea9c5eb, Offset: 0x17d1
    // Size: 0x203, Type: dev
    function private function_6ea8c9d5f99d3711( player )
    {
        level endon( #"hash_b8914952fbc70e6f" );
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        spawn_inputs = [ [ "<dev string:x444>", "<dev string:x2f7>", 0 ], [ "<dev string:x44c>", "<dev string:x309>", 0 ], [ "<dev string:x457>", "<dev string:x310>", 0 ] ];
        buttondown = 0;
        
        for ( ;; )
        {
            var_5bca97962ddaaaab = function_463bdc45ee2d33df( player );
            
            for ( i = 0; i < spawn_inputs.size ; i++ )
            {
                input = spawn_inputs[ i ];
                
                if ( player buttonpressed( input[ 0 ] ) )
                {
                    if ( !input[ 3 ] )
                    {
                        goal_location = ( 0, 0, 0 );
                        speed = 0;
                        player_origin = player getorigin();
                        player_angles = ( 0, player getplayerangles()[ 1 ], 0 );
                        
                        if ( var_5bca97962ddaaaab )
                        {
                            thread function_dd8b403029529939( player_origin, player_angles );
                            speed = benchmark_mp_utils::function_dc6ca849abef4a37( player, "<dev string:x461>", 50, 300 );
                            
                            if ( isdefined( speed ) )
                            {
                                goal_location = function_deb83256d68fcd1f( player, player_origin );
                            }
                        }
                        
                        level notify( #"hash_b68f3c82fcced221" );
                        
                        if ( isdefined( goal_location ) && isdefined( speed ) )
                        {
                            enemy_struct = function_53d75b945528df43( undefined, input[ 1 ], player_origin, player_angles, var_5bca97962ddaaaab, goal_location, speed, -1 );
                            function_8b305053f35f967d( enemy_struct );
                        }
                    }
                    
                    spawn_inputs[ i ][ 3 ] = 1;
                    continue;
                }
                
                spawn_inputs[ i ][ 3 ] = 0;
            }
            
            if ( saveinput( player ) )
            {
                if ( !buttondown )
                {
                    function_3c5088361ceee0f4();
                }
                
                buttondown = 1;
            }
            else if ( loadinput( player ) )
            {
                if ( !buttondown )
                {
                    function_4d2db8fad8d77c0e();
                }
                
                buttondown = 1;
            }
            else
            {
                buttondown = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 2, eflags: 0x4
    // Checksum 0xb89d6edb, Offset: 0x19dc
    // Size: 0xb4, Type: dev
    function private function_dd8b403029529939( origin, angles )
    {
        level endon( #"hash_b68f3c82fcced221" );
        
        for ( ;; )
        {
            utility::draw_capsule( origin, 20, 90, ( 0, 0, 0 ), ( 0, 1, 0 ), 0, 1 );
            arrow_origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + 45 );
            utility::draw_arrow( arrow_origin, arrow_origin + vectornormalize( anglestoforward( angles ) ) * 50, ( 0, 1, 0 ) );
            print3d( arrow_origin, "<dev string:x476>", ( 0, 1, 0 ), 1, 1, 1, 1 );
            waitframe();
        }
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x81adb26f, Offset: 0x1a98
    // Size: 0x3cd, Type: dev
    function private function_15a9cbc92403f6f2( enemyarray )
    {
        if ( enemyarray.size == 0 )
        {
            iprintlnbold( "<dev string:x488>" );
            return 0;
        }
        
        fileid = function_b70280649f0c0c0d( function_20688371f05b11e7(), "<dev string:x4af>", function_516c60097c3c8f11() );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x4b5>" );
            return 0;
        }
        
        fileid = function_9c33c17f1c093741( fileid );
        fileid = function_b70280649f0c0c0d( function_20688371f05b11e7(), "<dev string:x4f3>", function_516c60097c3c8f11() );
        
        if ( fileid == -1 )
        {
            return 0;
        }
        
        var_982294451762d748 = 0;
        var_61889edd99154c0e = 1;
        
        for ( i = 0; i < enemyarray.size ; i++ )
        {
            current_enemy_struct = enemyarray[ i ];
            assert( isdefined( current_enemy_struct.starting_origin ), "<dev string:x4fa>" );
            assert( isdefined( current_enemy_struct.starting_angles ), "<dev string:x52a>" );
            assert( isdefined( current_enemy_struct.stance ), "<dev string:x55a>" );
            assert( isdefined( current_enemy_struct.is_moving ), "<dev string:x58a>" );
            assert( isdefined( current_enemy_struct.goal_location ), "<dev string:x5bd>" );
            assert( isdefined( current_enemy_struct.speed ), "<dev string:x5f4>" );
            assert( isdefined( current_enemy_struct.group_index ), "<dev string:x623>" );
            
            if ( !var_982294451762d748 && current_enemy_struct.group_index != -1 )
            {
                function_ca002d660d981cd( fileid, "<dev string:x652>" + "<dev string:x654>" + current_enemy_struct.group_index + 1 );
                var_982294451762d748 = 1;
                var_61889edd99154c0e = 1;
            }
            
            position = current_enemy_struct.starting_origin;
            angle = current_enemy_struct.starting_angles;
            stance = current_enemy_struct.stance;
            is_moving = current_enemy_struct.is_moving;
            goal_location = current_enemy_struct.goal_location;
            speed = current_enemy_struct.speed;
            position_string = "<dev string:x65d>" + position[ 0 ] + "<dev string:x665>" + position[ 1 ] + "<dev string:x665>" + position[ 2 ] + "<dev string:x667>";
            angle_string = "<dev string:x669>" + angle[ 0 ] + "<dev string:x665>" + angle[ 1 ] + "<dev string:x665>" + angle[ 2 ] + "<dev string:x667>";
            stance_string = "<dev string:x671>" + stance + "<dev string:x667>";
            is_moving_string = "<dev string:x679>" + ( is_moving ? "<dev string:x684>" : "<dev string:x686>" ) + "<dev string:x667>";
            goal_location_string = "<dev string:x688>" + goal_location[ 0 ] + "<dev string:x665>" + goal_location[ 1 ] + "<dev string:x665>" + goal_location[ 2 ] + "<dev string:x667>";
            speed_string = "<dev string:x697>" + speed + "<dev string:x667>";
            final_string_info = position_string + angle_string + stance_string + is_moving_string + goal_location_string + speed_string;
            final_string = ( var_982294451762d748 ? "<dev string:x69e>" : "<dev string:x6a0>" ) + "<dev string:x6a1>" + var_61889edd99154c0e + "<dev string:x6a3>" + final_string_info;
            function_ca002d660d981cd( fileid, final_string );
            var_61889edd99154c0e++;
            
            if ( var_982294451762d748 && ( i < enemyarray.size - 1 && enemyarray[ i + 1 ].group_index != current_enemy_struct.group_index || i == enemyarray.size - 1 ) )
            {
                function_ca002d660d981cd( fileid, "<dev string:x6a5>" );
                var_982294451762d748 = 0;
                var_61889edd99154c0e = 1;
            }
        }
        
        iprintlnbold( "<dev string:x6a7>" );
        function_9c33c17f1c093741( fileid );
        return 1;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0x42bb2fcc, Offset: 0x1e6d
    // Size: 0x458, Type: dev
    function private function_8b6a4a7e0d07d952( file_name )
    {
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x1b5>", function_516c60097c3c8f11() );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x6cd>" + function_516c60097c3c8f11() + "<dev string:x1ba>" + file_name );
            return [];
        }
        
        filecontent = function_a865c969ccd16b89( fileid );
        currentline = "<dev string:x6a0>";
        var_2aad874c7cdd6ad8 = [];
        
        for ( i = 0; i < filecontent.size ; i++ )
        {
            if ( ( filecontent[ i ] == "<dev string:x6f8>" || i == filecontent.size - 1 ) && currentline != "<dev string:x6a0>" )
            {
                var_2aad874c7cdd6ad8[ var_2aad874c7cdd6ad8.size ] = currentline;
                currentline = "<dev string:x6a0>";
                continue;
            }
            
            if ( filecontent[ i ] != "<dev string:x6f8>" )
            {
                currentline += filecontent[ i ];
            }
        }
        
        array_ai_info = [];
        origin = [];
        angles = [];
        stance = "<dev string:x6a0>";
        is_moving = "<dev string:x6a0>";
        goal_location = [];
        speed = "<dev string:x6a0>";
        tempstring = "<dev string:x6a0>";
        var_6d6288aea66d5008 = 0;
        var_331e4706dc23bbd1 = 0;
        current_group_index = 0;
        
        for ( i = 0; i < var_2aad874c7cdd6ad8.size ; i++ )
        {
            if ( var_2aad874c7cdd6ad8[ i ][ 0 ] == "<dev string:x652>" )
            {
                var_331e4706dc23bbd1 = 1;
                continue;
            }
            
            if ( var_2aad874c7cdd6ad8[ i ][ 0 ] == "<dev string:x6a5>" )
            {
                var_331e4706dc23bbd1 = 0;
                current_group_index++;
                continue;
            }
            
            for ( j = 0; j < var_2aad874c7cdd6ad8[ i ].size ; j++ )
            {
                if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x6fa>" )
                {
                    var_6d6288aea66d5008 = 1;
                    continue;
                }
                
                if ( !var_6d6288aea66d5008 )
                {
                    continue;
                }
                
                if ( origin.size != 3 )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x665>" || var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        origin[ origin.size ] = float( tempstring );
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( angles.size != 3 )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x665>" || var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        angles[ angles.size ] = float( tempstring );
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( stance == "<dev string:x6a0>" )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        stance = tempstring;
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( is_moving == "<dev string:x6a0>" )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        is_moving = tempstring;
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( goal_location.size != 3 )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x665>" || var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        goal_location[ goal_location.size ] = float( tempstring );
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( speed == "<dev string:x6a0>" )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                    {
                        speed = tempstring;
                        tempstring = "<dev string:x6a0>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                
                if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x667>" )
                {
                    var_6d6288aea66d5008 = 0;
                }
                
                if ( angles.size == 3 && origin.size == 3 && stance != "<dev string:x6a0>" && is_moving != "<dev string:x6a0>" && goal_location.size == 3 && speed != "<dev string:x6a0>" )
                {
                    ai_info = function_53d75b945528df43( undefined, stance, ( origin[ 0 ], origin[ 1 ], origin[ 2 ] ), ( angles[ 0 ], angles[ 1 ], angles[ 2 ] ), int( is_moving ), ( goal_location[ 0 ], goal_location[ 1 ], goal_location[ 2 ] ), float( speed ), var_331e4706dc23bbd1 ? current_group_index : -1 );
                    array_ai_info[ array_ai_info.size ] = ai_info;
                    angles = [];
                    origin = [];
                    stance = "<dev string:x6a0>";
                    is_moving = "<dev string:x6a0>";
                    goal_location = [];
                    speed = "<dev string:x6a0>";
                    tempstring = "<dev string:x6a0>";
                }
            }
        }
        
        fileid = function_9c33c17f1c093741( fileid );
        
        if ( array_ai_info.size > 0 )
        {
            iprintlnbold( "<dev string:x6fc>" );
        }
        else
        {
            iprintlnbold( "<dev string:x725>" );
        }
        
        return array_ai_info;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xb37d4126, Offset: 0x22cd
    // Size: 0x1a, Type: dev
    function private function_ec35558e2c5a5ad3( amount )
    {
        level.var_85bd03451606a51c = amount;
    }

    // Namespace namespace_a4e869218d89862b
    // Params 0, eflags: 0x4
    // Checksum 0x36ebb23, Offset: 0x22ef
    // Size: 0x12, Type: dev
    function private function_ae7f8a94a5fd1e5f()
    {
        function_4d2db8fad8d77c0e( function_20688371f05b11e7() );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 2
    // Checksum 0xf2b18c42, Offset: 0x2309
    // Size: 0x2c, Type: dev
    function function_7361c9ea28191f1f( file_name, file_folder )
    {
        function_51c52a494f7db380( [ file_name, file_folder ] );
    }

    // Namespace namespace_a4e869218d89862b
    // Params 1, eflags: 0x4
    // Checksum 0xf69b87a9, Offset: 0x233d
    // Size: 0x5b, Type: dev
    function private function_51c52a494f7db380( params )
    {
        file_name = params[ 0 ];
        file_folder = params[ 1 ];
        level.var_58e59879b0e7af74 = file_name;
        function_b2b505538108d9f9();
        function_4d2db8fad8d77c0e( file_name, file_folder );
        iprintlnbold( "<dev string:x741>" + file_name + "<dev string:x6a5>" );
    }

#/
