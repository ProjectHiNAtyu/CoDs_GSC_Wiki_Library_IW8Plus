// script_4f7cbc7a2a2ba890  (hash_4f7cbc7a2a2ba890.gscc) (size: 18006 Bytes / 0x4656 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea831538 (3934459192)
// size ...... 18006 (0x4656)
// includes .. 6   (offset: 0x3e52)
// strings ... 5   (offset: 0x3e82)
// dev strs .. 127 (offset: 0x3ebe)
// exports ... 39  (offset: 0x2bd6)
// cseg ...... 0x92 + 0x2b44 (0x2bd6)
// imports ... 93  (offset: 0x31ee)
// animtree1 . 0   (offset: 0x4656)
// animtree2 . 0   (offset: 0x4656)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_6826532b84b72321;

// Namespace namespace_6826532b84b72321
// Params 2
// Checksum 0xc6122fd2, Offset: 0xb0
// Size: 0x1ef
function function_f79179c6b5c2f11d( player, vfx_struct_array )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !isdefined( vfx_struct_array ) || vfx_struct_array.size == 0 )
    {
        assertmsg( "<dev string:x3d>" );
        return;
    }
    
    for ( i = 0; i < vfx_struct_array.size ; i++ )
    {
        vfx = vfx_struct_array[ i ];
        wait vfx.timetospawn;
        
        if ( vfx.type == "nade" )
        {
            if ( vfx.weaponname == "explosion" )
            {
                if ( !isarray( vfx.startlocation ) && !isvector( vfx.startlocation ) )
                {
                    vfx.startlocation = ( 0, 0, 0 );
                }
                
                radiusdamage( vfx.endlocation, vfx.startlocation[ 0 ] > 0 ? vfx.startlocation[ 0 ] : 100, vfx.startlocation[ 1 ] > 0 ? vfx.startlocation[ 1 ] : 500, vfx.startlocation[ 2 ] > 0 ? vfx.startlocation[ 2 ] : 500, player, "MOD_EXPLOSIVE", "c4_mp" );
            }
            else
            {
                player launchgrenade( vfx.weaponname, vfx.endlocation, ( 0, 0, 0 ), 0.05 );
            }
            
            continue;
        }
        
        if ( vfx.type == "missile" )
        {
            magicbullet( vfx.weaponname, vfx.startlocation, vfx.endlocation );
        }
    }
}

// Namespace namespace_6826532b84b72321
// Params 1
// Checksum 0xdcd0a1b2, Offset: 0x2a7
// Size: 0x185
function function_905e471a4fd5790c( var_d8de5ad82ec5c5ee )
{
    var_dc02108a7f8962d3 = [];
    
    foreach ( vfx_array in var_d8de5ad82ec5c5ee )
    {
        assert( vfx_array.size == 5, "<dev string:x55>" );
        assert( isstring( vfx_array[ 0 ] ) && ( vfx_array[ 0 ] == "<dev string:xc1>" || vfx_array[ 0 ] == "<dev string:xc6>" ), "<dev string:xce>" );
        assert( isstring( vfx_array[ 1 ] ), "<dev string:xe9>" );
        assert( isvector( vfx_array[ 2 ] ) || vfx_array[ 2 ] == 0, "<dev string:x10b>" );
        assert( isvector( vfx_array[ 3 ] ), "<dev string:x130>" );
        assert( isnumber( vfx_array[ 4 ] ), "<dev string:x153>" );
        type = vfx_array[ 0 ];
        weaponname = vfx_array[ 1 ];
        startposition = undefined;
        endposition = vfx_array[ 3 ];
        timetospawn = vfx_array[ 4 ];
        
        if ( vfx_array[ 2 ] != 0 )
        {
            startposition = vfx_array[ 2 ];
        }
        
        var_dc02108a7f8962d3[ var_dc02108a7f8962d3.size ] = create_vfx_struct( type, weaponname, startposition, endposition, timetospawn );
    }
    
    return var_dc02108a7f8962d3;
}

// Namespace namespace_6826532b84b72321
// Params 5, eflags: 0x4
// Checksum 0x7718c545, Offset: 0x435
// Size: 0xa8
function private create_vfx_struct( type, weaponname, startlocation, endlocation, timetospawn )
{
    vfx_struct = spawnstruct();
    vfx_struct.endlocation = endlocation ?? ( 0, 0, 0 );
    vfx_struct.startlocation = startlocation ?? ( 0, 0, 0 );
    vfx_struct.type = type;
    vfx_struct.weaponname = weaponname;
    vfx_struct.timetospawn = timetospawn;
    return vfx_struct;
}

/#

    // Namespace namespace_6826532b84b72321
    // Params 2
    // Checksum 0x1f92a2e4, Offset: 0x4e6
    // Size: 0x25c, Type: dev
    function function_eccd82ae06166efe( player, var_19c9e146d475b045 )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( !isdefined( var_19c9e146d475b045 ) )
        {
            var_19c9e146d475b045 = 0;
        }
        
        player = benchmark_mp_utils::validateplayer( player );
        
        if ( function_51c7ab8d7da34b21() )
        {
            assertmsg( "<dev string:x173>" );
            return 0;
        }
        
        level.var_a2f7abc0d3e2325a = 1;
        level.var_bdb1a27a48a3557d[ "<dev string:x1b1>" ] = [ 0, 0 ];
        level.var_bdb1a27a48a3557d[ "<dev string:x1b7>" ] = [ 0, 0 ];
        level.var_bdb1a27a48a3557d[ "<dev string:x1be>" ] = [ 0, 0 ];
        level.var_bdb1a27a48a3557d[ "<dev string:x1c5>" ] = [ 0, 0 ];
        level.var_bdb1a27a48a3557d[ "<dev string:x1cb>" ] = [ 0, 0 ];
        level.var_bdb1a27a48a3557d[ "<dev string:x1d0>" ] = [ 0, 0 ];
        thread function_9488ff1d3760235( player );
        level.var_184b668964a35b4f = [];
        level.var_3d0babb4dbfe48a5 = [];
        level.current_vfx_sequence = 0;
        level.var_78e6f1497af27237 = [];
        thread function_8fd43b235b882e75( player );
        thread function_f254a08bda1f72b0( player );
        thread function_92c83beaa515a069( player );
        Files = function_73796ddfbc223146( function_6dc927311172d69(), "<dev string:x1d4>" + "<dev string:x1d6>" );
        
        if ( Files.size > 0 )
        {
            level.var_d2f3b8b3a4102136 = Files[ 0 ];
        }
        else
        {
            level.var_d2f3b8b3a4102136 = benchmark_mp_utils::function_5f9b63ec7a92782b( game_utility::getmapname() + "<dev string:x1db>" + "<dev string:x1dd>", "<dev string:x1d6>", function_6dc927311172d69() );
        }
        
        iprintlnbold( "<dev string:x1ef>" );
        
        if ( var_19c9e146d475b045 )
        {
            function_e367600de5e67f86( player, level.var_d2f3b8b3a4102136 );
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x205>" );
        devgui::add_devgui_func( "<dev string:x214>", "<dev string:x226>", &function_76bb2949b4acdc81 );
        devgui::add_devgui_func( "<dev string:x23c>", "<dev string:x254>", &function_b52ad47c8bd8f681 );
        devgui::add_devgui_func( "<dev string:x26a>", "<dev string:x27c>", &function_19e1cc665c31e9b9 );
        devgui::add_devgui_func( "<dev string:x28a>", "<dev string:x2a2>", &function_e367600de5e67f86 );
        devgui::function_77df7fe7dd273e10();
        benchmark_mp_utils::function_52defaf90913e64f( "<dev string:x2b6>", "<dev string:x2d5>", "<dev string:x1dd>", "<dev string:x1d6>", function_6dc927311172d69(), &function_51c52a494f7db380 );
        return 1;
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0xe821bd9, Offset: 0x74a
    // Size: 0x5f, Type: dev
    function function_8f6bafd3bf693906()
    {
        if ( !function_51c7ab8d7da34b21() )
        {
            assertmsg( "<dev string:x2e7>" );
            return 0;
        }
        
        level.var_a2f7abc0d3e2325a = 0;
        level.var_184b668964a35b4f = [];
        level.debug_vfx_structs = [];
        level.current_vfx_sequence = 0;
        level notify( #"stop_vfx_tool" );
        iprintlnbold( "<dev string:x324>" );
        return 1;
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0x2e40cfee, Offset: 0x7b1
    // Size: 0x10, Type: dev
    function function_51c7ab8d7da34b21()
    {
        return istrue( level.var_a2f7abc0d3e2325a );
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0x3500866, Offset: 0x7c9
    // Size: 0x12, Type: dev
    function function_22e5ff1d76c7b9dc()
    {
        return level.var_3d0babb4dbfe48a5.size > 0;
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0xce3d31aa, Offset: 0x7e3
    // Size: 0x1c, Type: dev
    function function_4fc61d0fc10f1cd1()
    {
        if ( !function_22e5ff1d76c7b9dc() )
        {
            return 0;
        }
        
        return level.var_3d0babb4dbfe48a5.size;
    }

    // Namespace namespace_6826532b84b72321
    // Params 2
    // Checksum 0x2bd0708a, Offset: 0x807
    // Size: 0xf0, Type: dev
    function function_86b322634bc7159c( player, var_8bd5c37e3806d493 )
    {
        if ( !isdefined( var_8bd5c37e3806d493 ) )
        {
            var_8bd5c37e3806d493 = undefined;
        }
        
        if ( !function_51c7ab8d7da34b21() )
        {
            assertmsg( "<dev string:x339>" );
            return;
        }
        
        if ( !function_22e5ff1d76c7b9dc() )
        {
            assertmsg( "<dev string:x36d>" );
            return;
        }
        
        force_index = 0;
        
        if ( !( isdefined( var_8bd5c37e3806d493 ) && isdefined( level.var_3d0babb4dbfe48a5[ var_8bd5c37e3806d493 ] ) ) )
        {
            if ( isdefined( var_8bd5c37e3806d493 ) && !isdefined( level.var_3d0babb4dbfe48a5[ var_8bd5c37e3806d493 ] ) )
            {
                assertmsg( "<dev string:x387>" + var_8bd5c37e3806d493 + "<dev string:x396>" );
                return;
            }
            
            var_8bd5c37e3806d493 = level.current_vfx_sequence;
        }
        else
        {
            force_index = 1;
        }
        
        thread function_f79179c6b5c2f11d( player, level.var_3d0babb4dbfe48a5[ var_8bd5c37e3806d493 ] );
        
        if ( !force_index )
        {
            level.current_vfx_sequence = ( level.current_vfx_sequence + 1 ) % level.var_3d0babb4dbfe48a5.size;
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0xbdfbe32b, Offset: 0x8ff
    // Size: 0x55, Type: dev
    function function_19e1cc665c31e9b9()
    {
        folder_name = function_6dc927311172d69();
        file_name = function_cda6be842e63a59c();
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x3ce>", folder_name );
        function_9c33c17f1c093741( fileid );
        function_de6ee02f9fb0e262( folder_name + "<dev string:x3d3>" + file_name );
    }

    // Namespace namespace_6826532b84b72321
    // Params 1
    // Checksum 0x583be820, Offset: 0x95c
    // Size: 0x3c, Type: dev
    function function_b42a7f4dd13597d5( callback )
    {
        if ( !isdefined( level.var_78e6f1497af27237 ) )
        {
            level.var_78e6f1497af27237 = [];
        }
        
        level.var_78e6f1497af27237[ level.var_78e6f1497af27237.size ] = callback;
    }

    // Namespace namespace_6826532b84b72321
    // Params 3
    // Checksum 0x7effe5f5, Offset: 0x9a0
    // Size: 0x10c, Type: dev
    function function_e367600de5e67f86( player, file_name, folder_name )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( !isdefined( file_name ) )
        {
            file_name = undefined;
        }
        
        if ( !isdefined( folder_name ) )
        {
            folder_name = undefined;
        }
        
        if ( !function_51c7ab8d7da34b21() )
        {
            return;
        }
        
        if ( !isdefined( player ) )
        {
            player = level.player;
        }
        
        if ( !isdefined( file_name ) )
        {
            file_name = function_cda6be842e63a59c();
        }
        
        if ( !isdefined( folder_name ) )
        {
            folder_name = function_6dc927311172d69();
        }
        
        level.var_3d0babb4dbfe48a5 = function_b245516ddb3ab7f0( file_name );
        level.current_vfx_sequence = 0;
        
        if ( isdefined( level.var_78e6f1497af27237 ) )
        {
            foreach ( callback in level.var_78e6f1497af27237 )
            {
                thread [[ callback ]]( player );
            }
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0xa669df82, Offset: 0xab4
    // Size: 0xf, Type: dev
    function private function_cda6be842e63a59c()
    {
        return level.var_d2f3b8b3a4102136;
    }

    // Namespace namespace_6826532b84b72321
    // Params 0
    // Checksum 0x38c35221, Offset: 0xacb
    // Size: 0x18, Type: dev
    function function_6dc927311172d69()
    {
        return "<dev string:x3d5>" + game_utility::getmapname() + "<dev string:x3ea>";
    }

    // Namespace namespace_6826532b84b72321
    // Params 2, eflags: 0x4
    // Checksum 0x78daa112, Offset: 0xaeb
    // Size: 0x76, Type: dev
    function private function_16a9de2c76c52da6( player, button )
    {
        if ( !isdefined( level.var_bdb1a27a48a3557d[ button ] ) )
        {
            return 0;
        }
        
        if ( level.var_bdb1a27a48a3557d[ button ][ 1 ] == 1 )
        {
            return 0;
        }
        
        isdown = level.var_bdb1a27a48a3557d[ button ][ 0 ];
        
        if ( isdown )
        {
            level.var_bdb1a27a48a3557d[ button ][ 1 ] = 1;
        }
        
        return isdown;
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x7db7e1b, Offset: 0xb69
    // Size: 0xf3, Type: dev
    function private function_9488ff1d3760235( player )
    {
        level endon( #"game_ended" );
        level endon( #"stop_vfx_tool" );
        
        for ( ;; )
        {
            foreach ( button, _ in level.var_bdb1a27a48a3557d )
            {
                isdown = player buttonpressed( button );
                wasdown = level.var_bdb1a27a48a3557d[ button ][ 1 ];
                level.var_bdb1a27a48a3557d[ button ][ 0 ] = isdown;
                
                if ( !isdown && wasdown )
                {
                    level.var_bdb1a27a48a3557d[ button ][ 1 ] = 0;
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0x2f0f8f00, Offset: 0xc64
    // Size: 0x112, Type: dev
    function private function_a80ccdaa22a348a6()
    {
        list = [];
        
        foreach ( equipmentname, entry in level.equipment.table )
        {
            if ( equipmentname != "<dev string:x3fd>" )
            {
                vfx_struct = function_cbde70fff51ad220( entry.weaponname, equipmentname, "<dev string:xc1>" );
                list[ list.size ] = vfx_struct;
            }
        }
        
        list[ list.size ] = function_cbde70fff51ad220( "<dev string:x402>", "<dev string:x416>", "<dev string:xc6>" );
        list[ list.size ] = function_cbde70fff51ad220( "<dev string:x425>", "<dev string:x437>", "<dev string:xc6>" );
        list[ list.size ] = function_cbde70fff51ad220( "<dev string:x449>", "<dev string:x460>", "<dev string:xc6>" );
        return list;
    }

    // Namespace namespace_6826532b84b72321
    // Params 4, eflags: 0x4
    // Checksum 0x8fbb2d6f, Offset: 0xd7e
    // Size: 0x81, Type: dev
    function private function_cbde70fff51ad220( weapon_name, display_name, vfx_type, description )
    {
        if ( !isdefined( description ) )
        {
            description = "<dev string:x477>";
        }
        
        vfx_list_item_struct = spawnstruct();
        vfx_list_item_struct.weapon_name = weapon_name;
        vfx_list_item_struct.display_name = display_name;
        vfx_list_item_struct.vfx_type = vfx_type;
        vfx_list_item_struct.description = description;
        return vfx_list_item_struct;
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0x893246d, Offset: 0xe07
    // Size: 0x2e, Type: dev
    function private function_76bb2949b4acdc81()
    {
        if ( level.var_482460dfac6c6556 )
        {
            iprintlnbold( "<dev string:x478>" );
            return;
        }
        
        level.var_482460dfac6c6556 = 1;
        thread function_6b1393dbbed7df3d();
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0x33f2d316, Offset: 0xe3d
    // Size: 0x68b, Type: dev
    function private function_6b1393dbbed7df3d()
    {
        level endon( #"game_ended" );
        level endon( #"hash_2fee422f1cee2259" );
        level endon( #"stop_vfx_tool" );
        
        if ( getdvarint( @"hash_e35e43cce7cf7506", 1 ) == 0 )
        {
            setdvar( @"hash_e35e43cce7cf7506", 1 );
        }
        
        player = level.player;
        
        if ( !player isnoclip() )
        {
            adddebugcommand( "<dev string:x4b0>" );
        }
        
        player utility::hidehudenable();
        vfx_list = function_a80ccdaa22a348a6();
        var_c34dbf3202b3c66a = spawnstruct();
        var_c34dbf3202b3c66a.value = 0;
        level.var_91bb9979481a41f5 = [];
        level.var_56c1bbbd08571385 = 0;
        level.var_d0785a4fe0816934 = undefined;
        selected_info_struct = spawnstruct();
        selected_info_struct.start_location = undefined;
        selected_info_struct.end_location = undefined;
        selected_info_struct.delay_time = undefined;
        thread function_6def73f094391dff( selected_info_struct );
        thread function_248795d51e186601();
        
        for ( ;; )
        {
            if ( level.var_56c1bbbd08571385 == 0 )
            {
                function_ae87aa39ae51312d( player, vfx_list.size, var_c34dbf3202b3c66a );
                function_3fc6e0ce5014e160( vfx_list, var_c34dbf3202b3c66a );
                
                if ( function_16a9de2c76c52da6( player, "<dev string:x1b1>" ) )
                {
                    level.var_d0785a4fe0816934 = vfx_list[ var_c34dbf3202b3c66a.value ];
                    
                    if ( level.var_d0785a4fe0816934.vfx_type == "<dev string:xc1>" )
                    {
                        function_1193f2fe5781f6be( player, selected_info_struct, 2 );
                    }
                    else if ( level.var_d0785a4fe0816934.vfx_type == "<dev string:xc6>" )
                    {
                        function_1193f2fe5781f6be( player, selected_info_struct, 1 );
                    }
                }
                else if ( function_16a9de2c76c52da6( player, "<dev string:x1c5>" ) )
                {
                    function_1193f2fe5781f6be( player, selected_info_struct, 4 );
                }
            }
            else if ( level.var_56c1bbbd08571385 == 1 )
            {
                selected_position = function_ca0d91148d24a5fd( player, level.var_d0785a4fe0816934, 0 );
                
                if ( function_16a9de2c76c52da6( player, "<dev string:x1be>" ) )
                {
                    selected_info_struct.start_location = selected_position;
                    function_1193f2fe5781f6be( player, selected_info_struct, 2 );
                }
            }
            else if ( level.var_56c1bbbd08571385 == 2 )
            {
                selected_position = function_ca0d91148d24a5fd( player, level.var_d0785a4fe0816934, 1 );
                
                if ( function_16a9de2c76c52da6( player, "<dev string:x1be>" ) )
                {
                    selected_info_struct.end_location = selected_position;
                    function_1193f2fe5781f6be( player, selected_info_struct, 3 );
                }
                
                if ( isdefined( selected_info_struct.start_location ) )
                {
                    trace = trace::ray_trace( selected_info_struct.start_location, selected_position, player, undefined, 1 );
                    color = ( 0, 1, 0 );
                    
                    if ( distance( trace[ "<dev string:x4b7>" ], selected_position ) > 10 )
                    {
                        color = ( 1, 0, 0 );
                        sphere( trace[ "<dev string:x4b7>" ], 10, color, 0, 1 );
                    }
                    
                    line( selected_info_struct.start_location, selected_position, color, 1, 0, 1 );
                }
            }
            else if ( level.var_56c1bbbd08571385 == 3 )
            {
                delay_time = function_24db57d00cb15af4( player );
                
                if ( !isdefined( delay_time ) )
                {
                    function_1193f2fe5781f6be( player, selected_info_struct, 0 );
                    continue;
                }
                
                selected_info_struct.delay_time = delay_time;
                new_vfx_struct = create_vfx_struct( level.var_d0785a4fe0816934.vfx_type, level.var_d0785a4fe0816934.weapon_name, selected_info_struct.start_location, selected_info_struct.end_location, delay_time );
                level.var_91bb9979481a41f5[ level.var_91bb9979481a41f5.size ] = new_vfx_struct;
                function_1193f2fe5781f6be( player, selected_info_struct, 0 );
            }
            else if ( level.var_56c1bbbd08571385 == 4 )
            {
                [ hit_position, start, end ] = function_434b4a36f96c096b( player, 2000 );
                vfx_struct_to_remove = undefined;
                
                foreach ( vfx_struct in level.var_91bb9979481a41f5 )
                {
                    if ( math::segmentvssphere( start, end, vfx_struct.endlocation, 10 ) )
                    {
                        vfx_struct_to_remove = vfx_struct;
                        break;
                    }
                }
                
                color = isdefined( vfx_struct_to_remove ) ? ( 1, 1, 0 ) : ( 1, 0, 0 );
                var_f6bfafd9a094b074 = isdefined( vfx_struct_to_remove ) ? vfx_struct_to_remove.endlocation : hit_position;
                line( start, var_f6bfafd9a094b074, color, 1, 0, 1 );
                sphere( var_f6bfafd9a094b074, 10, color, 0, 1 );
                
                if ( isdefined( vfx_struct_to_remove ) )
                {
                    print3d( var_f6bfafd9a094b074 + ( 0, 0, 10 ), "<dev string:x4c0>", ( 0.72, 0.4, 1 ), 1, 1.4, 1, 1 );
                }
                
                if ( isdefined( vfx_struct_to_remove ) && function_16a9de2c76c52da6( player, "<dev string:x1be>" ) )
                {
                    foreach ( index, vfx_struct in level.var_91bb9979481a41f5 )
                    {
                        if ( vfx_struct == vfx_struct_to_remove )
                        {
                            level.var_91bb9979481a41f5[ index ] = undefined;
                            
                            if ( isint( index ) )
                            {
                                function_cdc669dbc8ea2101( level.var_91bb9979481a41f5 );
                            }
                            
                            break;
                        }
                    }
                }
                
                if ( function_16a9de2c76c52da6( player, "<dev string:x1c5>" ) )
                {
                    function_1193f2fe5781f6be( player, selected_info_struct, 0 );
                }
                
                printtoscreen2d( 500, 70, "<dev string:x4c7>" + "<dev string:x1be>" + "<dev string:x4ce>", ( 0.72, 0.4, 1 ), 1.2, 1 );
                printtoscreen2d( 500, 100, "<dev string:x4c7>" + "<dev string:x1c5>" + "<dev string:x4df>", ( 0.72, 0.4, 1 ), 1.2, 1 );
            }
            
            if ( level.var_56c1bbbd08571385 != 0 )
            {
                if ( function_16a9de2c76c52da6( player, "<dev string:x1b7>" ) )
                {
                    function_1193f2fe5781f6be( player, selected_info_struct, 0 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0xc4a5d06c, Offset: 0x14d0
    // Size: 0x231, Type: dev
    function private function_b52ad47c8bd8f681()
    {
        if ( !level.var_482460dfac6c6556 )
        {
            iprintlnbold( "<dev string:x50a>" );
            return;
        }
        
        if ( level.player isnoclip() )
        {
            adddebugcommand( "<dev string:x4b0>" );
        }
        
        level.var_482460dfac6c6556 = 0;
        level notify( #"hash_2fee422f1cee2259" );
        level.player utility::hidehuddisable();
        vfx_sequence = level.var_91bb9979481a41f5;
        
        if ( !isdefined( vfx_sequence ) || vfx_sequence.size == 0 )
        {
            level.var_91bb9979481a41f5 = [];
            iprintlnbold( "<dev string:x54b>" );
            return;
        }
        
        file_name = function_cda6be842e63a59c();
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x569>", function_6dc927311172d69() );
        function_ca002d660d981cd( fileid, "<dev string:x570>" + "<dev string:x572>" + level.var_3d0babb4dbfe48a5.size + 1 );
        
        foreach ( vfx_struct in vfx_sequence )
        {
            type = "<dev string:x57e>" + vfx_struct.type + "<dev string:x580>";
            weaponname = "<dev string:x57e>" + vfx_struct.weaponname + "<dev string:x580>";
            startlocation = vfx_struct.startlocation;
            endlocation = vfx_struct.endlocation;
            delaytime = "<dev string:x57e>" + vfx_struct.timetospawn + "<dev string:x580>";
            fullline = type + "<dev string:x582>" + weaponname + "<dev string:x582>" + startlocation + "<dev string:x582>" + endlocation + "<dev string:x582>" + delaytime;
            function_ca002d660d981cd( fileid, fullline );
        }
        
        function_9c33c17f1c093741( fileid );
        function_e367600de5e67f86( level.player, file_name );
        iprintlnbold( "<dev string:x585>" );
    }

    // Namespace namespace_6826532b84b72321
    // Params 3, eflags: 0x4
    // Checksum 0x2d0654ce, Offset: 0x1709
    // Size: 0xaf, Type: dev
    function private function_1193f2fe5781f6be( player, selected_info_struct, new_state )
    {
        if ( level.var_56c1bbbd08571385 == new_state )
        {
            return;
        }
        
        switch ( new_state )
        {
            case 0:
            case 4:
                selected_info_struct.start_location = undefined;
                selected_info_struct.end_location = undefined;
                selected_info_struct.delay_time = undefined;
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
        }
        
        level.var_56c1bbbd08571385 = new_state;
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x6246a1c8, Offset: 0x17c0
    // Size: 0x155, Type: dev
    function private function_6def73f094391dff( selected_info_struct )
    {
        level endon( #"game_ended" );
        level endon( #"hash_2fee422f1cee2259" );
        level endon( #"stop_vfx_tool" );
        
        for ( ;; )
        {
            if ( isdefined( selected_info_struct.start_location ) )
            {
                sphere( selected_info_struct.start_location, 15, ( 0, 1, 0 ), 0, 1 );
                text = "<dev string:x5b7>";
                
                if ( isdefined( level.var_d0785a4fe0816934 ) )
                {
                    text = level.var_d0785a4fe0816934.display_name + "<dev string:x5c6>" + text;
                }
                
                print3d( selected_info_struct.start_location, text, ( 0.39, 0.58, 0.93 ), 1, 1, 1, 1 );
            }
            
            if ( isdefined( selected_info_struct.end_location ) )
            {
                sphere( selected_info_struct.end_location, 15, ( 0, 1, 0 ), 0, 1 );
                text = "<dev string:x5c8>";
                
                if ( isdefined( level.var_d0785a4fe0816934 ) )
                {
                    text = level.var_d0785a4fe0816934.display_name + "<dev string:x5c6>" + text;
                }
                
                print3d( selected_info_struct.end_location, text, ( 0.39, 0.58, 0.93 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0xe3e824b, Offset: 0x191d
    // Size: 0x3d, Type: dev
    function private function_248795d51e186601()
    {
        level endon( #"game_ended" );
        level endon( #"hash_2fee422f1cee2259" );
        level endon( #"stop_vfx_tool" );
        
        for ( ;; )
        {
            function_f0ccb754fe59d852( level.var_91bb9979481a41f5 );
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 3, eflags: 0x4
    // Checksum 0xcf97b8d3, Offset: 0x1962
    // Size: 0x9f, Type: dev
    function private function_ae87aa39ae51312d( player, vfx_list_size, var_c34dbf3202b3c66a )
    {
        vfx_list_last_index = vfx_list_size - 1;
        
        if ( function_16a9de2c76c52da6( player, "<dev string:x1cb>" ) )
        {
            var_c34dbf3202b3c66a.value--;
            
            if ( var_c34dbf3202b3c66a.value < 0 )
            {
                var_c34dbf3202b3c66a.value = vfx_list_last_index;
            }
            
            return;
        }
        
        if ( function_16a9de2c76c52da6( player, "<dev string:x1d0>" ) )
        {
            var_c34dbf3202b3c66a.value = ( var_c34dbf3202b3c66a.value + 1 ) % ( vfx_list_last_index + 1 );
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 2, eflags: 0x4
    // Checksum 0xd42b990b, Offset: 0x1a09
    // Size: 0x92, Type: dev
    function private function_434b4a36f96c096b( player, distance )
    {
        start = player geteye() + ( 7, 7, 7 );
        end = start + vectornormalize( anglestoforward( player getplayerangles() ) ) * distance;
        trace = trace::ray_trace( start, end, player, undefined, 1 );
        hit_position = trace[ "<dev string:x4b7>" ];
        return [ hit_position, start, end ];
    }

    // Namespace namespace_6826532b84b72321
    // Params 3, eflags: 0x4
    // Checksum 0xe25075df, Offset: 0x1aa3
    // Size: 0x1a9, Type: dev
    function private function_ca0d91148d24a5fd( player, vfx_list_struct, isend )
    {
        [ selected_position, start, end ] = function_434b4a36f96c096b( player, 200 );
        text = "<dev string:x477>";
        
        if ( isend )
        {
            text = "<dev string:x5dc>" + vfx_list_struct.display_name + "<dev string:x5e5>";
        }
        else
        {
            text = "<dev string:x5dc>" + vfx_list_struct.display_name + "<dev string:x5fb>";
        }
        
        print3d( selected_position, text, ( 0.39, 0.58, 0.93 ), 1, 0.7, 1, 1 );
        sphere( selected_position, 15, ( 0, 1, 0 ), 0, 1 );
        forward_direction = anglestoforward( player getplayerangles() );
        forward_direction = ( forward_direction[ 0 ], forward_direction[ 1 ], 0 );
        function_623799f2d2d10408( forward_direction, selected_position );
        function_623799f2d2d10408( anglestoright( player getplayerangles() ), selected_position );
        function_623799f2d2d10408( anglestoleft( player getplayerangles() ), selected_position );
        function_623799f2d2d10408( ( 0, 0, -1 ), selected_position );
        printtoscreen2d( 500, 120, "<dev string:x4c7>" + "<dev string:x1be>" + "<dev string:x60c>", ( 0.72, 0.4, 1 ), 1.2, 1 );
        printtoscreen2d( 500, 150, "<dev string:x4c7>" + "<dev string:x1b7>" + "<dev string:x61c>", ( 0.72, 0.4, 1 ), 1.2, 1 );
        return selected_position;
    }

    // Namespace namespace_6826532b84b72321
    // Params 2, eflags: 0x4
    // Checksum 0x35a8fd7c, Offset: 0x1c54
    // Size: 0x91, Type: dev
    function private function_623799f2d2d10408( direction_vector, start_position )
    {
        direction_vector = vectornormalize( direction_vector );
        trace = trace::ray_trace( start_position, start_position + direction_vector * 10000, undefined, undefined, 1 );
        
        if ( distance( start_position, trace[ "<dev string:x4b7>" ] ) > 5 )
        {
            line( start_position, trace[ "<dev string:x4b7>" ], ( 0, 0, 1 ), 1, 0, 1 );
            sphere( trace[ "<dev string:x4b7>" ], 5, ( 1, 0, 1 ), 0, 1 );
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0xd311995e, Offset: 0x1ced
    // Size: 0x42, Type: dev
    function private function_24db57d00cb15af4( player )
    {
        delay_seconds = benchmark_mp_utils::function_dc6ca849abef4a37( player, "<dev string:x636>", 0, 30, 1 );
        
        while ( player buttonpressed( "<dev string:x1b1>" ) )
        {
            waitframe();
        }
        
        return delay_seconds;
    }

    // Namespace namespace_6826532b84b72321
    // Params 2, eflags: 0x4
    // Checksum 0xeed90f9c, Offset: 0x1d37
    // Size: 0x1b8, Type: dev
    function private function_3fc6e0ce5014e160( vfx_list, var_c34dbf3202b3c66a )
    {
        printtoscreen2d( 500, 150, "<dev string:x663>" + "<dev string:x1cb>", ( 0, 1, 0 ), 1.2, 1 );
        printtoscreen2d( 500, 180, "<dev string:x668>" + "<dev string:x1d0>", ( 0, 1, 0 ), 1.2, 1 );
        printtoscreen2d( 500, 90, "<dev string:x66f>" + "<dev string:x1b1>", ( 0.72, 0.4, 1 ), 1.2, 1 );
        printtoscreen2d( 500, 120, "<dev string:x4c7>" + "<dev string:x1c5>" + "<dev string:x690>", ( 0.72, 0.4, 1 ), 1.2, 1 );
        var_45c5f42bcdabd483 = 150;
        var_45c5f32bcdabd250 = 600;
        
        for ( i = 0; i < vfx_list.size ; i++ )
        {
            color = var_c34dbf3202b3c66a.value == i ? ( 0, 1, 0 ) : ( 0.72, 0.4, 1 );
            scale = var_c34dbf3202b3c66a.value == i ? 1.4 : 1.2;
            vfx = vfx_list[ i ];
            text = i + 1 + "<dev string:x6b3>" + vfx.display_name;
            printtoscreen2d( var_45c5f32bcdabd250, var_45c5f42bcdabd483, text, color, scale, 1 );
            var_45c5f42bcdabd483 += 30;
            
            if ( i != 0 && i % 17 == 0 )
            {
                var_45c5f42bcdabd483 = 150;
                var_45c5f32bcdabd250 += 275;
            }
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x99672e26, Offset: 0x1ef7
    // Size: 0x1f9, Type: dev
    function private function_8fd43b235b882e75( player )
    {
        level endon( #"stop_vfx_tool" );
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        default_x = 20;
        text_start_y = 250;
        scale = 1.3;
        color = ( 1, 1, 0 );
        
        for ( ;; )
        {
            origin = player.origin;
            x = string( origin[ 0 ] );
            y = string( origin[ 1 ] );
            z = string( origin[ 2 ] );
            printtoscreen2d( default_x, text_start_y, "<dev string:x6b6>" + x + "<dev string:x582>" + y + "<dev string:x582>" + z + "<dev string:x6c9>", color, scale, 1 );
            angles = player.angles;
            angles_x = string( angles[ 0 ] );
            angles_y = string( angles[ 1 ] );
            angles_z = string( angles[ 2 ] );
            printtoscreen2d( default_x, text_start_y + 30, "<dev string:x6cc>" + angles_x + "<dev string:x582>" + angles_y + "<dev string:x582>" + angles_z + "<dev string:x6c9>", color, scale, 1 );
            var_1042a97a1c29b5e2 = level.var_3d0babb4dbfe48a5.size == 0 ? 0 : level.current_vfx_sequence + 1;
            printtoscreen2d( default_x, text_start_y + 60, "<dev string:x6df>" + string( var_1042a97a1c29b5e2 ) + "<dev string:x6f6>" + level.var_3d0babb4dbfe48a5.size + "<dev string:x6fa>" + "<dev string:x6fe>" + "<dev string:x700>", color, scale, 1 );
            printtoscreen2d( default_x, text_start_y + 100, "<dev string:x71e>" + toupper( "<dev string:x735>" ) + "<dev string:x738>", color, scale, 1 );
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x86c57290, Offset: 0x20f8
    // Size: 0xe4, Type: dev
    function private function_f254a08bda1f72b0( player )
    {
        level endon( #"stop_vfx_tool" );
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_e35e43cce7cf7506", 1 ) == 0 || !function_22e5ff1d76c7b9dc() )
            {
                waitframe();
                continue;
            }
            
            if ( level.var_482460dfac6c6556 )
            {
                waitframe();
                continue;
            }
            
            foreach ( vfx_array in level.var_3d0babb4dbfe48a5 )
            {
                function_f0ccb754fe59d852( vfx_array );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x4e611a27, Offset: 0x21e4
    // Size: 0x162, Type: dev
    function private function_f0ccb754fe59d852( vfx_array )
    {
        foreach ( index, vfx_struct in vfx_array )
        {
            if ( vfx_struct.type == "<dev string:xc6>" )
            {
                sphere( vfx_struct.startlocation, 10, ( 0, 1, 0 ), 0, 1 );
                line( vfx_struct.startlocation, vfx_struct.endlocation, ( 0, 1, 0 ), 1, 0, 1 );
            }
            
            sphere( vfx_struct.endlocation, 10, ( 0, 1, 0 ), 0, 1 );
            sphere( vfx_struct.endlocation, 5, ( 0, 1, 0 ), 0, 1 );
            print3d( vfx_struct.endlocation, string( index ) + "<dev string:x6b3>" + vfx_struct.weaponname, ( 0, 1, 0 ), 1, 0.75, 1, 1 );
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x85074913, Offset: 0x234e
    // Size: 0x10b, Type: dev
    function private function_92c83beaa515a069( player )
    {
        level endon( #"stop_vfx_tool" );
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        buttondown = 0;
        
        for ( ;; )
        {
            for ( i = 0; i < level.var_184b668964a35b4f.size ; i++ )
            {
                if ( player buttonpressed( "<dev string:x73b>" + string( i + 1 ) ) )
                {
                    if ( !level.var_184b668964a35b4f[ i ] )
                    {
                        thread function_86b322634bc7159c( player, i );
                    }
                    
                    level.var_184b668964a35b4f[ i ] = 1;
                    break;
                }
                
                level.var_184b668964a35b4f[ i ] = 0;
            }
            
            if ( player buttonpressed( "<dev string:x6fe>" ) )
            {
                if ( !buttondown )
                {
                    thread function_86b322634bc7159c( player );
                }
                
                buttondown = 1;
            }
            else if ( player buttonpressed( "<dev string:x735>" ) )
            {
                if ( !buttondown )
                {
                    function_e367600de5e67f86( player );
                }
                
                buttondown = 1;
            }
            else if ( buttondown )
            {
                buttondown = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6826532b84b72321
    // Params 0, eflags: 0x4
    // Checksum 0x42180f24, Offset: 0x2461
    // Size: 0x1e5, Type: dev
    function private function_91a4debce96cf825()
    {
        missiles = "<dev string:x477>";
        nades = "<dev string:x477>";
        vfx_list = function_a80ccdaa22a348a6();
        
        foreach ( vfx in vfx_list )
        {
            vfx.weapon_name += "<dev string:x5c6>" + vfx.description;
            
            if ( vfx.vfx_type == "<dev string:xc1>" )
            {
                nades += vfx.weapon_name + "<dev string:x73f>";
                continue;
            }
            
            if ( vfx.vfx_type == "<dev string:xc6>" )
            {
                missiles += vfx.weapon_name + "<dev string:x73f>";
            }
        }
        
        vfx_list = [];
        var_a91aed11c1d1b09 = "<dev string:x741>" + "<dev string:x787>" + "<dev string:x7c3>" + "<dev string:x7e9>" + "<dev string:x735>" + "<dev string:x7f1>" + "<dev string:x816>" + "<dev string:x892>" + "<dev string:x73f>" + "<dev string:x8de>" + nades + "<dev string:x73f>" + "<dev string:x8e6>" + missiles + "<dev string:x73f>" + "<dev string:x8f1>" + "<dev string:x949>" + "<dev string:x9ac>" + "<dev string:x9b8>" + "<dev string:x9f6>" + "<dev string:xa34>" + "<dev string:xa72>" + "<dev string:xab0>" + "<dev string:xaf3>" + "<dev string:xb41>" + "<dev string:x73f>" + "<dev string:xb8e>" + "<dev string:xb9a>" + "<dev string:xbda>" + "<dev string:xc1e>" + "<dev string:x73f>" + "<dev string:xc5e>";
        return var_a91aed11c1d1b09;
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x75cbdf1e, Offset: 0x264e
    // Size: 0x4ef, Type: dev
    function private function_b245516ddb3ab7f0( file_name )
    {
        folder_name = function_6dc927311172d69();
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x3ce>", folder_name );
        filecontent = "<dev string:x477>";
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:xca1>" );
        }
        else
        {
            filecontent = function_a865c969ccd16b89( fileid );
            fileid = function_9c33c17f1c093741( fileid );
        }
        
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:xcc9>", folder_name );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:xccf>" + folder_name + "<dev string:x3d3>" + file_name );
            return [];
        }
        
        fileid = function_9c33c17f1c093741( fileid );
        fileid = function_b70280649f0c0c0d( file_name, "<dev string:x569>", folder_name );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:xccf>" + folder_name + "<dev string:x3d3>" + file_name );
            return [];
        }
        
        var_a91aed11c1d1b09 = function_91a4debce96cf825();
        function_ca002d660d981cd( fileid, var_a91aed11c1d1b09 );
        var_84a1e981533dbd38 = "<dev string:x477>";
        var_c8351edc86909ff9 = 0;
        
        for ( i = 0; i < filecontent.size ; i++ )
        {
            if ( filecontent[ i ] == "<dev string:xcfa>" )
            {
                var_c8351edc86909ff9 = !var_c8351edc86909ff9;
                continue;
            }
            
            if ( !var_c8351edc86909ff9 )
            {
                if ( i - 1 > 0 && filecontent[ i - 1 ] == "<dev string:xcfa>" && filecontent[ i ] == "<dev string:x73f>" )
                {
                    continue;
                }
                
                var_84a1e981533dbd38 += filecontent[ i ];
            }
        }
        
        function_ca002d660d981cd( fileid, var_84a1e981533dbd38 );
        fileid = function_9c33c17f1c093741( fileid );
        currentline = "<dev string:x477>";
        var_2aad874c7cdd6ad8 = [];
        
        for ( i = 0; i < var_84a1e981533dbd38.size ; i++ )
        {
            if ( ( var_84a1e981533dbd38[ i ] == "<dev string:x73f>" || i == var_84a1e981533dbd38.size - 1 ) && currentline != "<dev string:x477>" && currentline != "<dev string:x73f>" )
            {
                var_2aad874c7cdd6ad8[ var_2aad874c7cdd6ad8.size ] = currentline;
                currentline = "<dev string:x477>";
                continue;
            }
            
            currentline += var_84a1e981533dbd38[ i ];
        }
        
        var_deabe1c269b7685 = [];
        vfx_structs = [];
        type = "<dev string:x477>";
        weapon_name = "<dev string:x477>";
        startposition = [];
        endposition = [];
        var_10a08915af323fb7 = -1;
        tempstring = "<dev string:x477>";
        var_6d6288aea66d5008 = 0;
        
        for ( i = 0; i < var_2aad874c7cdd6ad8.size ; i++ )
        {
            for ( j = 0; j < var_2aad874c7cdd6ad8[ i ].size ; j++ )
            {
                if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x570>" && vfx_structs.size != 0 )
                {
                    var_deabe1c269b7685[ var_deabe1c269b7685.size ] = arraycopy( vfx_structs );
                    vfx_structs = [];
                    continue;
                }
                
                if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x57e>" )
                {
                    var_6d6288aea66d5008 = 1;
                    tempstring = "<dev string:x477>";
                    continue;
                }
                
                if ( !var_6d6288aea66d5008 )
                {
                    continue;
                }
                
                if ( type == "<dev string:x477>" )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                    {
                        type = tempstring;
                        tempstring = "<dev string:x477>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( weapon_name == "<dev string:x477>" )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                    {
                        weapon_name = tempstring;
                        tempstring = "<dev string:x477>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( startposition.size != 3 )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:xcfc>" || var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                    {
                        startposition[ startposition.size ] = float( tempstring );
                        tempstring = "<dev string:x477>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( endposition.size != 3 )
                {
                    if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:xcfc>" || var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                    {
                        endposition[ endposition.size ] = float( tempstring );
                        tempstring = "<dev string:x477>";
                    }
                    else
                    {
                        tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                    }
                }
                else if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                {
                    var_10a08915af323fb7 = float( tempstring );
                }
                else
                {
                    tempstring += var_2aad874c7cdd6ad8[ i ][ j ];
                }
                
                if ( var_2aad874c7cdd6ad8[ i ][ j ] == "<dev string:x580>" )
                {
                    var_6d6288aea66d5008 = 0;
                }
                
                if ( type != "<dev string:x477>" && weapon_name != "<dev string:x477>" && startposition.size == 3 && endposition.size == 3 && var_10a08915af323fb7 != -1 )
                {
                    vfx_structs[ vfx_structs.size ] = create_vfx_struct( type, weapon_name, ( startposition[ 0 ], startposition[ 1 ], startposition[ 2 ] ), ( endposition[ 0 ], endposition[ 1 ], endposition[ 2 ] ), var_10a08915af323fb7 );
                    type = "<dev string:x477>";
                    weapon_name = "<dev string:x477>";
                    startposition = [];
                    endposition = [];
                    var_10a08915af323fb7 = -1;
                }
            }
        }
        
        if ( vfx_structs.size != 0 )
        {
            var_deabe1c269b7685[ var_deabe1c269b7685.size ] = arraycopy( vfx_structs );
            vfx_structs = [];
        }
        
        iprintlnbold( "<dev string:xcfe>" + file_name + "<dev string:xd14>" );
        level.var_184b668964a35b4f = [];
        
        for ( i = 0; i < var_deabe1c269b7685.size ; i++ )
        {
            level.var_184b668964a35b4f[ level.var_184b668964a35b4f.size ] = 0;
        }
        
        return var_deabe1c269b7685;
    }

    // Namespace namespace_6826532b84b72321
    // Params 2
    // Checksum 0x77d55433, Offset: 0x2b45
    // Size: 0x2c, Type: dev
    function function_c3cf4ac7c2003e80( file_name, folder_name )
    {
        function_51c52a494f7db380( [ file_name, folder_name ] );
    }

    // Namespace namespace_6826532b84b72321
    // Params 1, eflags: 0x4
    // Checksum 0x270d67ab, Offset: 0x2b79
    // Size: 0x5d, Type: dev
    function private function_51c52a494f7db380( params )
    {
        file_name = params[ 0 ];
        folder_name = params[ 1 ];
        level.var_d2f3b8b3a4102136 = file_name;
        function_e367600de5e67f86( level.player, file_name, folder_name );
        iprintlnbold( "<dev string:xd1f>" + file_name + "<dev string:xd37>" );
    }

#/
