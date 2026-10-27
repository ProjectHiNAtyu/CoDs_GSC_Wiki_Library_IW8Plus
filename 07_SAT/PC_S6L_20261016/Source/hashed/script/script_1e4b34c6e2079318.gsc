// script_1e4b34c6e2079318  (hash_1e4b34c6e2079318.gscc) (size: 10142 Bytes / 0x279e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf481c49a (4102145178)
// size ...... 10142 (0x279e)
// includes .. 5   (offset: 0x23b6)
// strings ... 0   (offset: 0x23de)
// dev strs .. 72  (offset: 0x23de)
// exports ... 30  (offset: 0x1682)
// cseg ...... 0x58 + 0x162a (0x1682)
// imports ... 67  (offset: 0x1b32)
// animtree1 . 0   (offset: 0x279e)
// animtree2 . 0   (offset: 0x279e)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_65874e704742c645;

/#

    // Namespace namespace_65874e704742c645
    // Params 1
    // Checksum 0x94b20681, Offset: 0x76
    // Size: 0x10d, Type: dev
    function function_3111a875ed39ca98( player )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( function_2e790a824b317ac7() )
        {
            iprintlnbold( "<dev string:x24>" );
            return 0;
        }
        
        if ( !isdefined( player ) )
        {
            if ( isdefined( level.player ) )
            {
                player = level.player;
            }
            else
            {
                assertmsg( "<dev string:x52>" );
                return 0;
            }
        }
        
        level.var_79a7df24cab1169 = 1;
        function_3eeced085d3ef8d1();
        
        if ( level.var_cfe681c01d8bfc7.size > 0 )
        {
            function_9dd492d7010b65e9( 1 );
        }
        else
        {
            function_9dd492d7010b65e9( 0 );
        }
        
        if ( !player isnoclip() )
        {
            adddebugcommand( "<dev string:x91>" );
        }
        
        level.var_4b3ed0f0ce3a332d = 0;
        
        if ( getdvarint( @"hash_90dfd1b7dc84670e", 0 ) == 0 )
        {
            setdvar( @"hash_90dfd1b7dc84670e", 1 );
            level.var_4b3ed0f0ce3a332d = 1;
        }
        
        iprintlnbold( "<dev string:x98>" );
        thread function_f08a5b8a62a3eb93( player );
        thread function_956eddd69a41f9aa();
        thread function_2b7bccab33958ac9( player );
        thread function_e6d66b272a5deb0f( player );
        return 1;
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0x83bb5f2e, Offset: 0x18b
    // Size: 0x6f, Type: dev
    function function_ade64709c250c57c()
    {
        if ( !function_2e790a824b317ac7() )
        {
            iprintlnbold( "<dev string:xb7>" );
            return;
        }
        
        level notify( #"stop_trigger_tool" );
        level.var_79a7df24cab1169 = 0;
        
        if ( level.player isnoclip() )
        {
            adddebugcommand( "<dev string:x91>" );
        }
        
        if ( level.var_4b3ed0f0ce3a332d )
        {
            setdvar( @"hash_90dfd1b7dc84670e", 0 );
            level.var_4b3ed0f0ce3a332d = 0;
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 3
    // Checksum 0x23f687e8, Offset: 0x202
    // Size: 0x128, Type: dev
    function function_c99d3717aef15779( trigger_name_id, callbackfunction, var_5c6cf7b8db65a693 )
    {
        if ( !isdefined( var_5c6cf7b8db65a693 ) )
        {
            var_5c6cf7b8db65a693 = undefined;
        }
        
        function_3eeced085d3ef8d1();
        
        if ( isdefined( level.var_85d34f97cc5b9f58[ trigger_name_id ] ) )
        {
            assertmsg( "<dev string:xf0>" + trigger_name_id + "<dev string:x111>" );
            return;
        }
        
        trigger_info_struct = spawnstruct();
        trigger_info_struct.name_id = trigger_name_id;
        trigger_info_struct.var_5c6cf7b8db65a693 = var_5c6cf7b8db65a693;
        
        if ( isdefined( callbackfunction ) )
        {
            trigger_info_struct.callbackfunction = callbackfunction;
        }
        else
        {
            trigger_info_struct.callbackfunction = &function_5a8eb6f6cc479751;
        }
        
        if ( level.var_8c42a960acf49218 == -1 )
        {
            trigger_info_struct.isselected = 1;
            level.var_8c42a960acf49218 = 0;
        }
        else
        {
            trigger_info_struct.isselected = 0;
        }
        
        level.var_cfe681c01d8bfc7[ level.var_cfe681c01d8bfc7.size ] = trigger_info_struct;
        level.var_85d34f97cc5b9f58[ trigger_name_id ] = trigger_info_struct;
        
        if ( function_6588ab738d9d9616() == 0 && function_6588ab738d9d9616() != 2 )
        {
            function_9dd492d7010b65e9( 1 );
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0x765e19b4, Offset: 0x332
    // Size: 0x35, Type: dev
    function function_a1d4c1249f95b42e()
    {
        level.var_cfe681c01d8bfc7 = [];
        level.var_85d34f97cc5b9f58 = [];
        level.var_8c42a960acf49218 = -1;
        
        if ( function_2e790a824b317ac7() )
        {
            function_9dd492d7010b65e9( 0 );
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0x94267997, Offset: 0x36f
    // Size: 0xc9, Type: dev
    function function_b4d340c670f105dd()
    {
        function_3eeced085d3ef8d1();
        devgui::function_9082edeb5db93280( "<dev string:x13c>" );
        devgui::add_devgui_func( "<dev string:x159>", "<dev string:x16a>", &function_88c0263d38c20a4a );
        devgui::add_devgui_func( "<dev string:x183>", "<dev string:x197>", &function_b857b2a82ebfa5b1 );
        devgui::add_devgui_func( "<dev string:x1b3>", "<dev string:x1b9>", &function_3111a875ed39ca98 );
        devgui::add_devgui_func( "<dev string:x1c7>", "<dev string:x1d3>", &function_61949f908e3a058e );
        devgui::add_devgui_func( "<dev string:x1e0>", "<dev string:x1e5>", &function_2db5ebdfbe0ed451 );
        devgui::add_devgui_func( "<dev string:x1f2>", "<dev string:x1f7>", &function_fb0e1c80b584d743 );
        devgui::function_77df7fe7dd273e10();
        benchmark_mp_utils::function_52defaf90913e64f( "<dev string:x204>", "<dev string:x231>", "<dev string:x231>", "<dev string:x248>", function_5a5281810874254f(), &function_51c52a494f7db380 );
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0x947dbeea, Offset: 0x440
    // Size: 0x10, Type: dev
    function function_88c0263d38c20a4a()
    {
        function_de6ee02f9fb0e262( function_5a5281810874254f() );
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0x369810cb, Offset: 0x458
    // Size: 0x8f, Type: dev
    function function_b857b2a82ebfa5b1()
    {
        foreach ( trigger_struct in level.var_6e17524d1c295d26 )
        {
            trigger_struct.trigger delete();
        }
        
        level.var_6e17524d1c295d26 = [];
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0xa2fbe1cc, Offset: 0x4ef
    // Size: 0x13, Type: dev
    function private function_61949f908e3a058e()
    {
        function_2db5ebdfbe0ed451();
        function_ade64709c250c57c();
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0xc0afefd7, Offset: 0x50a
    // Size: 0xf, Type: dev
    function private function_cda6be842e63a59c()
    {
        return level.var_2411cdfb44cb75ba;
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0xd14bb2fc, Offset: 0x521
    // Size: 0x18, Type: dev
    function function_5a5281810874254f()
    {
        return "<dev string:x24d>" + game_utility::getmapname() + "<dev string:x262>";
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0x185cba4b, Offset: 0x541
    // Size: 0x10, Type: dev
    function private function_2e790a824b317ac7()
    {
        return istrue( level.var_79a7df24cab1169 );
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0x7ea51a7, Offset: 0x559
    // Size: 0x44, Type: dev
    function private function_d3614fcb4245ae4a()
    {
        if ( isdefined( level.var_8c42a960acf49218 ) && isdefined( level.var_cfe681c01d8bfc7 ) && level.var_cfe681c01d8bfc7.size > 0 )
        {
            return level.var_cfe681c01d8bfc7[ level.var_8c42a960acf49218 ];
        }
        
        return;
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0x3861cc0f, Offset: 0x5a5
    // Size: 0x19, Type: dev
    function private function_5a8eb6f6cc479751( player )
    {
        iprintlnbold( "<dev string:x27a>" );
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0xc8831f6d, Offset: 0x5c6
    // Size: 0xd0, Type: dev
    function private function_3eeced085d3ef8d1()
    {
        if ( !isdefined( level.var_6e17524d1c295d26 ) )
        {
            level.var_6e17524d1c295d26 = [];
        }
        
        if ( !isdefined( level.var_cfe681c01d8bfc7 ) )
        {
            level.var_cfe681c01d8bfc7 = [];
        }
        
        if ( !isdefined( level.var_85d34f97cc5b9f58 ) )
        {
            level.var_85d34f97cc5b9f58 = [];
        }
        
        if ( !isdefined( level.var_8c42a960acf49218 ) )
        {
            level.var_8c42a960acf49218 = -1;
        }
        
        if ( !isdefined( level.var_2411cdfb44cb75ba ) )
        {
            Files = function_73796ddfbc223146( function_5a5281810874254f(), "<dev string:x296>" + "<dev string:x248>" );
            
            if ( Files.size > 0 )
            {
                level.var_2411cdfb44cb75ba = Files[ 0 ];
                return;
            }
            
            level.var_2411cdfb44cb75ba = benchmark_mp_utils::function_5f9b63ec7a92782b( game_utility::getmapname() + "<dev string:x298>" + "<dev string:x231>", "<dev string:x248>", function_5a5281810874254f() );
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0xc30044c, Offset: 0x69e
    // Size: 0x1c, Type: dev
    function private function_a7cf8078b3c43b7a( key_name )
    {
        return level.var_85d34f97cc5b9f58[ key_name ];
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0x23311ccd, Offset: 0x6c2
    // Size: 0x10f, Type: dev
    function private function_fbad3dfd136b8633( direction )
    {
        if ( level.var_cfe681c01d8bfc7.size == 0 )
        {
            return;
        }
        
        if ( direction == "<dev string:x29a>" )
        {
            last_trigger_type = function_d3614fcb4245ae4a();
            last_trigger_type.isselected = 0;
            level.var_8c42a960acf49218 += 1;
            
            if ( level.var_8c42a960acf49218 >= level.var_cfe681c01d8bfc7.size )
            {
                level.var_8c42a960acf49218 = 0;
            }
            
            next_trigger_type = function_d3614fcb4245ae4a();
            next_trigger_type.isselected = 1;
            return;
        }
        
        if ( direction == "<dev string:x29f>" )
        {
            last_trigger_type = function_d3614fcb4245ae4a();
            last_trigger_type.isselected = 0;
            level.var_8c42a960acf49218 -= 1;
            
            if ( level.var_8c42a960acf49218 < 0 )
            {
                level.var_8c42a960acf49218 = level.var_cfe681c01d8bfc7.size - 1;
            }
            
            next_trigger_type = function_d3614fcb4245ae4a();
            next_trigger_type.isselected = 1;
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0xd244567b, Offset: 0x7d9
    // Size: 0x24, Type: dev
    function private function_9dd492d7010b65e9( newstate )
    {
        level.var_c31a0c8c348ea75c = newstate;
        iprintlnbold( "<dev string:x2a2>" );
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0xa0096852, Offset: 0x805
    // Size: 0x25, Type: dev
    function private function_6588ab738d9d9616()
    {
        if ( !isdefined( level.var_c31a0c8c348ea75c ) )
        {
            level.var_c31a0c8c348ea75c = 0;
        }
        
        return level.var_c31a0c8c348ea75c;
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0xf7e048ed, Offset: 0x832
    // Size: 0x277, Type: dev
    function private function_f08a5b8a62a3eb93( player )
    {
        player endon( #"disconnect" );
        level endon( #"game_ended" );
        level endon( #"stop_trigger_tool" );
        select_button_down = 0;
        
        for ( ;; )
        {
            var_77fa0e3cca43db98 = function_6588ab738d9d9616();
            
            if ( var_77fa0e3cca43db98 == 0 )
            {
                wait 1.5;
                continue;
            }
            
            start = player geteye() + ( 7, 7, 7 );
            end = start + vectornormalize( anglestoforward( player getplayerangles() ) ) * 2000;
            [ hit_position, hit_trigger ] = raycastworld( player, start, end );
            var_87c2f2b6e964f3d6 = isdefined( hit_position );
            wireframe_colour = ( 1, 0, 0 );
            var_19aa55953c3b56e2 = 0;
            
            if ( var_87c2f2b6e964f3d6 )
            {
                if ( var_77fa0e3cca43db98 == 1 )
                {
                    var_19aa55953c3b56e2 = !isdefined( hit_trigger );
                }
                else if ( var_77fa0e3cca43db98 == 2 )
                {
                    var_19aa55953c3b56e2 = isdefined( hit_trigger );
                }
                
                if ( var_19aa55953c3b56e2 )
                {
                    wireframe_colour = ( 0, 1, 0 );
                    
                    if ( var_77fa0e3cca43db98 == 1 )
                    {
                        current_trigger_type = function_d3614fcb4245ae4a();
                        
                        if ( isdefined( current_trigger_type ) )
                        {
                            print3d( hit_position, "<dev string:x2b5>" + current_trigger_type.name_id, ( 0, 0, 1 ), 1, 1, 1, 1 );
                        }
                    }
                    else if ( var_77fa0e3cca43db98 == 2 )
                    {
                        wireframe_colour = ( 0, 1, 0 );
                        print3d( hit_position, "<dev string:x2bc>", ( 0, 0, 1 ), 1, 1, 1, 1 );
                    }
                }
                
                if ( var_77fa0e3cca43db98 == 2 )
                {
                    sphere( hit_position, 25, wireframe_colour, 0, 1 );
                }
                else if ( var_77fa0e3cca43db98 == 1 )
                {
                    sphere( hit_position, 50, wireframe_colour, 0, 1 );
                }
            }
            
            line( start, end, wireframe_colour, 1, 0, 1 );
            
            if ( var_19aa55953c3b56e2 && player buttonpressed( "<dev string:x2c3>" ) )
            {
                if ( !select_button_down )
                {
                    if ( var_77fa0e3cca43db98 == 1 )
                    {
                        current_trigger_type = function_d3614fcb4245ae4a();
                        
                        if ( isdefined( current_trigger_type ) )
                        {
                            thread spawntrigger( player, hit_position, current_trigger_type.callbackfunction, current_trigger_type.name_id, current_trigger_type.var_5c6cf7b8db65a693 );
                        }
                    }
                    else if ( var_77fa0e3cca43db98 == 2 )
                    {
                        removetrigger( hit_trigger );
                    }
                }
                
                select_button_down = 1;
            }
            else
            {
                select_button_down = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 3, eflags: 0x4
    // Checksum 0x253a26d0, Offset: 0xab1
    // Size: 0x14e, Type: dev
    function private raycastworld( player, start, end )
    {
        hit_trigger = undefined;
        hit_position = undefined;
        var_87c2f2b6e964f3d6 = undefined;
        wireframe_colour = ( 1, 0, 0 );
        raycast_results = physics_raycast( start, end, trace::create_default_contents(), player, 0, "<dev string:x2ca>" );
        var_87c2f2b6e964f3d6 = raycast_results.size > 0 && isdefined( raycast_results[ 0 ][ "<dev string:x2df>" ] );
        
        if ( var_87c2f2b6e964f3d6 )
        {
            hit_position = raycast_results[ 0 ][ "<dev string:x2df>" ];
        }
        
        foreach ( trigger_struct in level.var_6e17524d1c295d26 )
        {
            if ( math::segmentvssphere( start, end, trigger_struct.trigger.origin, 50 ) )
            {
                hit_trigger = trigger_struct.trigger;
                break;
            }
        }
        
        return [ hit_position, hit_trigger ];
    }

    // Namespace namespace_65874e704742c645
    // Params 5, eflags: 0x4
    // Checksum 0x4b32b65b, Offset: 0xc07
    // Size: 0xc7, Type: dev
    function private spawntrigger( player, origin, callbackfunction, name_id, var_5c6cf7b8db65a693 )
    {
        if ( !isdefined( var_5c6cf7b8db65a693 ) )
        {
            var_5c6cf7b8db65a693 = undefined;
        }
        
        if ( !isdefined( callbackfunction ) )
        {
            assertmsg( "<dev string:x2e8>" );
            return;
        }
        
        iprintlnbold( "<dev string:x31e>" );
        var_d1731c1c5c658b97 = spawnstruct();
        thread benchmark_mp_utils::function_8550afed58d9513c( player, name_id, origin, 50, callbackfunction, var_d1731c1c5c658b97, 0, var_5c6cf7b8db65a693 );
        var_2e98318b64ca5d95 = spawnstruct();
        var_2e98318b64ca5d95.callback_key = name_id;
        var_2e98318b64ca5d95.trigger = var_d1731c1c5c658b97.trigger;
        level.var_6e17524d1c295d26[ level.var_6e17524d1c295d26.size ] = var_2e98318b64ca5d95;
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0x82716d9d, Offset: 0xcd6
    // Size: 0xd8, Type: dev
    function private removetrigger( var_3597ce96da92d837 )
    {
        if ( !isdefined( var_3597ce96da92d837 ) )
        {
            return;
        }
        
        foreach ( index, trigger_struct in level.var_6e17524d1c295d26 )
        {
            if ( trigger_struct.trigger == var_3597ce96da92d837 )
            {
                trigger_struct.trigger delete();
                level.var_6e17524d1c295d26[ index ] = undefined;
                
                if ( isint( index ) )
                {
                    function_cdc669dbc8ea2101( level.var_6e17524d1c295d26 );
                }
                
                iprintlnbold( "<dev string:x32d>" );
                break;
            }
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 0, eflags: 0x4
    // Checksum 0xb7505d0d, Offset: 0xdb6
    // Size: 0x13c, Type: dev
    function private function_956eddd69a41f9aa()
    {
        level endon( #"game_ended" );
        level endon( #"stop_trigger_tool" );
        
        for ( ;; )
        {
            current_state = function_6588ab738d9d9616();
            state_text = "<dev string:x33d>";
            
            switch ( current_state )
            {
                case 1:
                    state_text = "<dev string:x33e>";
                    break;
                case 2:
                    state_text = "<dev string:x34b>";
                    break;
                case 0:
                    state_text = "<dev string:x35b>";
                    break;
            }
            
            printtoscreen2d( 600, 50, "<dev string:x375>" + state_text, ( 0.39, 0.58, 0.93 ), 1.7 );
            printtoscreen2d( 600, 80, "<dev string:x385>" + "<dev string:x38c>" + "<dev string:x392>", ( 0.39, 0.58, 0.93 ), 1.2 );
            printtoscreen2d( 600, 110, "<dev string:x3a4>" + "<dev string:x2c3>" + "<dev string:x3a9>", ( 0.39, 0.58, 0.93 ), 1.2 );
            printtoscreen2d( 600, 140, "<dev string:x3c1>" + string( level.var_6e17524d1c295d26.size ), ( 0.39, 0.58, 0.93 ), 1.2 );
            waitframe();
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0x24d2240b, Offset: 0xefa
    // Size: 0x194, Type: dev
    function private function_2b7bccab33958ac9( player )
    {
        player endon( #"disconnect" );
        level endon( #"game_ended" );
        level endon( #"stop_trigger_tool" );
        var_c4fc8c60609666cf = 1300;
        var_487995f1900477fb = 30;
        
        for ( ;; )
        {
            if ( function_6588ab738d9d9616() != 1 )
            {
                waitframe();
                continue;
            }
            
            var_20052bb0ef52d8ba = 100;
            printtoscreen2d( var_c4fc8c60609666cf - 100, var_20052bb0ef52d8ba - var_487995f1900477fb - 10, "<dev string:x3da>", ( 0.39, 0.58, 0.93 ), 1.8 );
            printtoscreen2d( var_c4fc8c60609666cf - 120, var_20052bb0ef52d8ba + 10, "<dev string:x3f0>" + "<dev string:x3f5>", ( 0, 1, 0 ), 1.3 );
            printtoscreen2d( var_c4fc8c60609666cf - 120, var_20052bb0ef52d8ba + 30, "<dev string:x3fa>" + "<dev string:x401>", ( 0, 1, 0 ), 1.3 );
            
            for ( i = 0; i < level.var_cfe681c01d8bfc7.size ; i++ )
            {
                trigger_info_struct = level.var_cfe681c01d8bfc7[ i ];
                text_colour = ( 0.39, 0.58, 0.93 );
                text_scale = 1.2;
                
                if ( trigger_info_struct.isselected )
                {
                    text_colour = ( 0, 1, 0 );
                    text_scale = 1.6;
                }
                
                printtoscreen2d( var_c4fc8c60609666cf, var_20052bb0ef52d8ba, i + "<dev string:x405>" + trigger_info_struct.name_id, text_colour, text_scale );
                var_20052bb0ef52d8ba += var_487995f1900477fb;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0xdbe98d2, Offset: 0x1096
    // Size: 0xe9, Type: dev
    function private function_e6d66b272a5deb0f( player )
    {
        player endon( #"disconnect" );
        level endon( #"game_ended" );
        level endon( #"stop_trigger_tool" );
        button_down = 0;
        
        for ( ;; )
        {
            var_77fa0e3cca43db98 = function_6588ab738d9d9616();
            
            if ( var_77fa0e3cca43db98 == 1 && player buttonpressed( "<dev string:x401>" ) )
            {
                if ( !button_down )
                {
                    function_fbad3dfd136b8633( "<dev string:x29a>" );
                }
                
                button_down = 1;
            }
            else if ( var_77fa0e3cca43db98 == 1 && player buttonpressed( "<dev string:x3f5>" ) )
            {
                if ( !button_down )
                {
                    function_fbad3dfd136b8633( "<dev string:x29f>" );
                }
                
                button_down = 1;
            }
            else if ( player buttonpressed( "<dev string:x38c>" ) )
            {
                if ( !button_down )
                {
                    function_9dd492d7010b65e9( var_77fa0e3cca43db98 == 1 ? 2 : 1 );
                }
                
                button_down = 1;
            }
            else
            {
                button_down = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_65874e704742c645
    // Params 0
    // Checksum 0xd98a1795, Offset: 0x1187
    // Size: 0x143, Type: dev
    function function_2db5ebdfbe0ed451()
    {
        function_3eeced085d3ef8d1();
        
        if ( level.var_6e17524d1c295d26.size == 0 )
        {
            iprintlnbold( "<dev string:x408>" );
            return;
        }
        
        fileid = function_b70280649f0c0c0d( function_cda6be842e63a59c(), "<dev string:x42c>", function_5a5281810874254f() );
        
        if ( fileid == -1 )
        {
            return;
        }
        
        foreach ( trigger_struct in level.var_6e17524d1c295d26 )
        {
            origin = trigger_struct.trigger.origin;
            callback_key = trigger_struct.callback_key;
            var_d037e0d2aa14fe91 = "<dev string:x432>" + origin[ 0 ] + "<dev string:x43b>" + origin[ 1 ] + "<dev string:x43b>" + origin[ 2 ] + "<dev string:x43e>" + callback_key + "<dev string:x44c>";
            function_ca002d660d981cd( fileid, var_d037e0d2aa14fe91 );
        }
        
        function_9c33c17f1c093741( fileid );
        iprintlnbold( "<dev string:x44e>" );
    }

    // Namespace namespace_65874e704742c645
    // Params 3
    // Checksum 0xbea47fe3, Offset: 0x12d2
    // Size: 0x309, Type: dev
    function function_fb0e1c80b584d743( player, file_name, file_folder )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( !isdefined( file_name ) )
        {
            file_name = undefined;
        }
        
        if ( !isdefined( file_folder ) )
        {
            file_folder = undefined;
        }
        
        function_3eeced085d3ef8d1();
        
        if ( !isdefined( player ) )
        {
            player = level.player;
        }
        
        if ( !isdefined( player ) )
        {
            assertmsg( "<dev string:x483>" );
            return;
        }
        
        if ( !isdefined( file_name ) )
        {
            file_name = function_cda6be842e63a59c();
        }
        
        if ( !isdefined( file_folder ) )
        {
            file_folder = function_5a5281810874254f();
        }
        
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x498>", function_5a5281810874254f() );
        
        if ( fileid == -1 )
        {
            return;
        }
        
        filecontent = function_a865c969ccd16b89( fileid );
        function_9c33c17f1c093741( fileid );
        
        if ( filecontent == "<dev string:x33d>" || filecontent == "<dev string:x49d>" )
        {
            return;
        }
        
        function_b857b2a82ebfa5b1();
        currentline = "<dev string:x33d>";
        var_2aad874c7cdd6ad8 = [];
        
        for ( i = 0; i < filecontent.size ; i++ )
        {
            if ( ( filecontent[ i ] == "<dev string:x49f>" || i == filecontent.size - 1 ) && currentline != "<dev string:x33d>" )
            {
                var_2aad874c7cdd6ad8[ var_2aad874c7cdd6ad8.size ] = currentline;
                currentline = "<dev string:x33d>";
                continue;
            }
            
            currentline += filecontent[ i ];
        }
        
        foreach ( line in var_2aad874c7cdd6ad8 )
        {
            origin = [];
            callback_key = "<dev string:x33d>";
            var_94999b2817dc92ab = 0;
            var_c39ebf336928c017 = "<dev string:x33d>";
            
            for ( i = 0; i < line.size ; i++ )
            {
                char = line[ i ];
                
                if ( char != "<dev string:x4a1>" && var_94999b2817dc92ab == 0 )
                {
                    continue;
                }
                else if ( var_94999b2817dc92ab == 0 )
                {
                    var_94999b2817dc92ab = 1;
                    continue;
                }
                
                if ( origin.size < 3 )
                {
                    if ( char != "<dev string:x4a3>" && char != "<dev string:x44c>" )
                    {
                        var_c39ebf336928c017 += char;
                    }
                    else
                    {
                        origin[ origin.size ] = var_c39ebf336928c017;
                        var_c39ebf336928c017 = "<dev string:x33d>";
                    }
                    
                    if ( origin.size == 3 )
                    {
                        var_94999b2817dc92ab = 0;
                    }
                    
                    continue;
                }
                
                if ( callback_key == "<dev string:x33d>" )
                {
                    if ( char != "<dev string:x44c>" )
                    {
                        var_c39ebf336928c017 += char;
                        continue;
                    }
                    
                    callback_key = var_c39ebf336928c017;
                    var_c39ebf336928c017 = "<dev string:x33d>";
                    var_94999b2817dc92ab = 0;
                    break;
                }
            }
            
            origin_vector = ( float( origin[ 0 ] ), float( origin[ 1 ] ), float( origin[ 2 ] ) );
            trigger_type_struct = function_a7cf8078b3c43b7a( callback_key );
            
            if ( isdefined( trigger_type_struct ) )
            {
                thread spawntrigger( player, origin_vector, trigger_type_struct.callbackfunction, callback_key, trigger_type_struct.var_5c6cf7b8db65a693 );
            }
        }
        
        iprintlnbold( "<dev string:x4a5>" );
    }

    // Namespace namespace_65874e704742c645
    // Params 2
    // Checksum 0x5aadbe67, Offset: 0x15e3
    // Size: 0x2c, Type: dev
    function function_bc8c91f3b418514a( file_name, file_folder )
    {
        function_51c52a494f7db380( [ file_name, file_folder ] );
    }

    // Namespace namespace_65874e704742c645
    // Params 1, eflags: 0x4
    // Checksum 0xaa336beb, Offset: 0x1617
    // Size: 0x6b, Type: dev
    function private function_51c52a494f7db380( params )
    {
        file_name = params[ 0 ];
        file_folder = params[ 1 ];
        function_2db5ebdfbe0ed451();
        function_b857b2a82ebfa5b1();
        level.var_2411cdfb44cb75ba = file_name;
        function_fb0e1c80b584d743( level.player, file_name, file_folder );
        iprintlnbold( "<dev string:x4db>" + file_name + "<dev string:x4f3>" );
    }

#/
