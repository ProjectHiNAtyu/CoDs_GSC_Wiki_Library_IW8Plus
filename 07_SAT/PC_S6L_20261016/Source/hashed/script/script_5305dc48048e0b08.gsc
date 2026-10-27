// script_5305dc48048e0b08  (hash_5305dc48048e0b08.gscc) (size: 6768 Bytes / 0x1a70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb31dc09 (3677477897)
// size ...... 6768 (0x1a70)
// includes .. 3   (offset: 0x16f0)
// strings ... 0   (offset: 0x1708)
// dev strs .. 60  (offset: 0x1708)
// exports ... 16  (offset: 0xfa8)
// cseg ...... 0x58 + 0xf50 (0xfa8)
// imports ... 37  (offset: 0x1228)
// animtree1 . 0   (offset: 0x1a70)
// animtree2 . 0   (offset: 0x1a70)
#using scripts\common\devgui;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_1fd4452aa332cfa1;

/#

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1
    // Checksum 0x385b2317, Offset: 0x76
    // Size: 0x16a, Type: dev
    function function_8293db8aedeb9b3a( var_d36496ca8bd7eb0e )
    {
        if ( level.var_94063039d65633b2 )
        {
            return;
        }
        
        if ( !isdefined( level.var_a8064c9ab36b1d80 ) || level.var_a8064c9ab36b1d80.size == 0 )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x9a>" );
            return;
        }
        else
        {
            level.var_94063039d65633b2 = 1;
        }
        
        level.var_a03d72ea900a0243 = "<dev string:xb9>" + game_utility::getmapname() + "<dev string:xce>";
        Files = function_73796ddfbc223146( level.var_a03d72ea900a0243, "<dev string:xe5>" + "<dev string:xe7>" );
        
        if ( Files.size > 0 )
        {
            level.var_d3d07ca20d34a94 = Files[ 0 ];
        }
        else
        {
            level.var_d3d07ca20d34a94 = game_utility::getmapname() + "<dev string:xec>" + var_d36496ca8bd7eb0e + "<dev string:xe7>";
        }
        
        generatefile( level.var_d3d07ca20d34a94 );
        function_9439acf0975f6414( level.var_d3d07ca20d34a94 );
        generatefile( level.var_d3d07ca20d34a94, 1 );
        devgui::function_9082edeb5db93280( "<dev string:xee>" );
        devgui::add_devgui_func( "<dev string:x106>", "<dev string:x110>", &function_c032afbc04156146 );
        devgui::add_devgui_func( "<dev string:x128>", "<dev string:x138>", &function_9439acf0975f6414 );
        devgui::function_77df7fe7dd273e10();
        benchmark_mp_utils::function_52defaf90913e64f( "<dev string:xee>" + "<dev string:x143>", "<dev string:x154>", var_d36496ca8bd7eb0e, "<dev string:xe7>", function_af8076a398f00983(), &function_51c52a494f7db380 );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 3
    // Checksum 0x52c69c0b, Offset: 0x1e8
    // Size: 0x82, Type: dev
    function function_61aca03884a23108( fieldkey, fieldname, default_value )
    {
        if ( !level.var_94063039d65633b2 )
        {
            return;
        }
        
        if ( isdefined( level.var_a8064c9ab36b1d80[ fieldkey ] ) )
        {
            if ( isdefined( level.var_a8064c9ab36b1d80[ fieldkey ][ fieldname ] ) )
            {
                return level.var_a8064c9ab36b1d80[ fieldkey ][ fieldname ][ 1 ];
            }
        }
        
        iprintlnbold( "<dev string:x16a>" + fieldname + "<dev string:x184>" + fieldkey + "<dev string:x194>" );
        return default_value;
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 3
    // Checksum 0xbd730bb8, Offset: 0x272
    // Size: 0x118, Type: dev
    function function_cf35ac7ba2861345( keyname, fieldname, default_value )
    {
        if ( level.var_94063039d65633b2 )
        {
            iprintln( "<dev string:x197>" );
            return;
        }
        
        if ( !isdefined( level.var_a8064c9ab36b1d80 ) )
        {
            level.var_a8064c9ab36b1d80 = [];
        }
        
        if ( !isdefined( level.var_a8064c9ab36b1d80[ keyname ] ) )
        {
            level.var_a8064c9ab36b1d80[ keyname ] = [];
        }
        
        field_type = undefined;
        
        if ( isvector( default_value ) )
        {
            field_type = "<dev string:x1d4>";
        }
        else if ( isstring( default_value ) && ( default_value == "<dev string:x1db>" || default_value == "<dev string:x1e0>" ) )
        {
            default_value = default_value == "<dev string:x1db>" ? 1 : 0;
            field_type = "<dev string:x1e6>";
        }
        else if ( isnumber( default_value ) )
        {
            field_type = "<dev string:x1eb>";
        }
        else if ( isstring( default_value ) )
        {
            field_type = "<dev string:x1f2>";
        }
        else
        {
            assertmsg( "<dev string:x1f9>" + fieldname );
            return;
        }
        
        level.var_a8064c9ab36b1d80[ keyname ][ fieldname ] = createfield( field_type, default_value );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 0
    // Checksum 0x6b226e48, Offset: 0x392
    // Size: 0x76, Type: dev
    function function_c032afbc04156146()
    {
        fileid = function_b70280649f0c0c0d( level.var_d3d07ca20d34a94, "<dev string:x238>", function_af8076a398f00983() );
        filecontent = function_a865c969ccd16b89( fileid );
        function_9c33c17f1c093741( fileid );
        
        if ( filecontent == "<dev string:x23d>" )
        {
            generatefile( level.var_d3d07ca20d34a94 );
        }
        
        function_de6ee02f9fb0e262( function_af8076a398f00983() + "<dev string:x23e>" + level.var_d3d07ca20d34a94 );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 0
    // Checksum 0xd154b3e5, Offset: 0x410
    // Size: 0xf, Type: dev
    function function_af8076a398f00983()
    {
        return level.var_a03d72ea900a0243;
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1
    // Checksum 0x4db26e3c, Offset: 0x427
    // Size: 0x3c, Type: dev
    function function_82df6c443205500d( callback )
    {
        if ( !isdefined( level.var_2c66786a3e860cc5 ) )
        {
            level.var_2c66786a3e860cc5 = [];
        }
        
        level.var_2c66786a3e860cc5[ level.var_2c66786a3e860cc5.size ] = callback;
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1, eflags: 0x4
    // Checksum 0xb0d29709, Offset: 0x46b
    // Size: 0x54, Type: dev
    function private function_51c52a494f7db380( params )
    {
        file_name = params[ 0 ];
        file_folder = params[ 1 ];
        level.var_d3d07ca20d34a94 = file_name;
        function_9439acf0975f6414( file_name, file_folder );
        iprintlnbold( "<dev string:x240>" + file_name + "<dev string:x258>" );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 2
    // Checksum 0x216663a, Offset: 0x4c7
    // Size: 0x2c, Type: dev
    function function_b0ecf413fdb8413e( file_name, file_folder )
    {
        function_51c52a494f7db380( [ file_name, file_folder ] );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 3, eflags: 0x4
    // Checksum 0x527c65db, Offset: 0x4fb
    // Size: 0x18d, Type: dev
    function private function_a4ab247b2432ef85( fieldkey, fieldname, value )
    {
        if ( isdefined( level.var_a8064c9ab36b1d80[ fieldkey ] ) )
        {
            if ( isdefined( level.var_a8064c9ab36b1d80[ fieldkey ][ fieldname ] ) )
            {
                field_type = level.var_a8064c9ab36b1d80[ fieldkey ][ fieldname ][ 0 ];
                
                if ( field_type == "<dev string:x1d4>" )
                {
                    vector_string = "<dev string:x23d>";
                    
                    for ( i = 0; i < value.size ; i++ )
                    {
                        if ( value[ i ] != "<dev string:x25a>" && value[ i ] != "<dev string:x25c>" )
                        {
                            vector_string += value[ i ];
                        }
                    }
                    
                    vector_array = strtoksubstr( vector_string, "<dev string:x25e>" );
                    
                    if ( vector_array.size != 3 )
                    {
                        iprintlnbold( "<dev string:x260>" + fieldkey + "<dev string:x277>" + fieldname + "<dev string:x27c>" );
                        return;
                    }
                    
                    vector = ( float( vector_array[ 0 ] ), float( vector_array[ 1 ] ), float( vector_array[ 2 ] ) );
                    value = vector;
                }
                else if ( field_type == "<dev string:x1f2>" )
                {
                    if ( !isstring( value ) )
                    {
                        value = string( value );
                    }
                }
                else if ( field_type == "<dev string:x1e6>" )
                {
                    value = int( value );
                    
                    if ( value != 0 )
                    {
                        value = 1;
                    }
                }
                else
                {
                    value = float( value );
                }
                
                level.var_a8064c9ab36b1d80[ fieldkey ][ fieldname ][ 1 ] = value;
                return;
            }
        }
        
        iprintln( "<dev string:x2cb>" + fieldkey + "<dev string:x2fa>" + fieldname );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 2, eflags: 0x4
    // Checksum 0x3e970e19, Offset: 0x690
    // Size: 0x103, Type: dev
    function private createfield( type, default_value )
    {
        valid_value = 0;
        
        switch ( type )
        {
            case #"hash_2dd1902ee3b54300":
                valid_value = isnumber( default_value );
                
                if ( !valid_value )
                {
                    default_value = 0;
                }
                
                break;
            case #"hash_7e95f72ed09f139d":
                valid_value = isnumber( default_value ) && ( default_value == 1 || default_value == 0 );
                
                if ( !valid_value )
                {
                    default_value = 0;
                }
                
                break;
            case #"hash_a08ace5b3c23c762":
                valid_value = isvector( default_value );
                
                if ( !valid_value )
                {
                    default_value = ( 0, 0, 0 );
                }
                
                break;
            case #"hash_2ac140ce3b5ea398":
                valid_value = isstring( default_value );
                
                if ( !valid_value )
                {
                    default_value = "<dev string:x23d>";
                }
                
                break;
        }
        
        if ( !valid_value )
        {
            assertmsg( "<dev string:x304>" + default_value + "<dev string:x30d>" + type + "<dev string:x194>" );
        }
        
        return [ type, default_value ];
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1, eflags: 0x4
    // Checksum 0x38b60102, Offset: 0x79b
    // Size: 0x3c, Type: dev
    function private function_e4d37c4d807d6553( char )
    {
        return char == "<dev string:x23d>" || char == "<dev string:x330>" || char == "<dev string:x332>" || char == "<dev string:x334>";
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 2, eflags: 0x4
    // Checksum 0x6e652c21, Offset: 0x7df
    // Size: 0x2da, Type: dev
    function private generatefile( file_name, var_736d7592e5d30d02 )
    {
        if ( !isdefined( var_736d7592e5d30d02 ) )
        {
            var_736d7592e5d30d02 = 0;
        }
        
        file_id = function_b70280649f0c0c0d( file_name, "<dev string:x238>", function_af8076a398f00983() );
        file_content = function_a865c969ccd16b89( file_id );
        function_9c33c17f1c093741( file_id );
        file_id = function_b70280649f0c0c0d( file_name, "<dev string:x336>", function_af8076a398f00983() );
        var_655235713534028d = 0;
        
        for ( i = 0; i < file_content.size ; i++ )
        {
            if ( !function_e4d37c4d807d6553( file_content[ i ] ) )
            {
                var_655235713534028d = 1;
                break;
            }
        }
        
        var_29a3069c6fb7e274 = [];
        
        if ( var_655235713534028d && !var_736d7592e5d30d02 )
        {
            var_b800577835e0617 = function_702947ec4482d226( file_content );
            
            for ( i = 0; i < var_b800577835e0617.size ; i++ )
            {
                word_found = function_ca79c567aef372c1( var_b800577835e0617[ i ] );
                var_29a3069c6fb7e274[ word_found ] = 1;
            }
            
            function_ca002d660d981cd( file_id, file_content );
        }
        else
        {
            commenttoken = "<dev string:x23d>";
            
            for ( i = 0; i < 2 ; i++ )
            {
                commenttoken += "<dev string:x33c>";
            }
            
            var_eb2031c228d5670a = commenttoken + "<dev string:x33e>" + commenttoken + "<dev string:x35e>" + commenttoken + "<dev string:x38b>" + commenttoken + "<dev string:x38f>" + commenttoken + "<dev string:x3f4>" + commenttoken + "<dev string:x458>" + "<dev string:xee>" + "<dev string:x128>" + "<dev string:x4a8>";
            
            if ( issubstr( file_content, var_eb2031c228d5670a ) || file_content.size == 0 )
            {
                function_ca002d660d981cd( file_id, var_eb2031c228d5670a );
            }
        }
        
        foreach ( fieldkey, fieldarrays in level.var_a8064c9ab36b1d80 )
        {
            if ( isdefined( var_29a3069c6fb7e274[ fieldkey ] ) )
            {
                continue;
            }
            
            function_ca002d660d981cd( file_id, "<dev string:x4ac>" );
            function_ca002d660d981cd( file_id, "<dev string:x4ae>" + fieldkey + "<dev string:xe5>" );
            function_ca002d660d981cd( file_id, "<dev string:x23d>" );
            
            foreach ( fieldname, var_770b777d9e54c875 in fieldarrays )
            {
                function_ca002d660d981cd( file_id, "<dev string:x4b1>" + var_770b777d9e54c875[ 0 ] + "<dev string:x4b4>" + fieldname + "<dev string:x4b7>" + var_770b777d9e54c875[ 1 ] );
            }
            
            function_ca002d660d981cd( file_id, "<dev string:x258>" );
        }
        
        function_9c33c17f1c093741( file_id );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 2
    // Checksum 0xaaca66b, Offset: 0xac1
    // Size: 0x3ae, Type: dev
    function function_9439acf0975f6414( file_name, file_folder )
    {
        if ( !isdefined( file_name ) )
        {
            file_name = undefined;
        }
        
        if ( !isdefined( file_folder ) )
        {
            file_folder = undefined;
        }
        
        if ( !level.var_94063039d65633b2 )
        {
            iprintlnbold( "<dev string:x4ba>" );
            return;
        }
        
        if ( !isdefined( file_name ) )
        {
            file_name = level.var_d3d07ca20d34a94;
        }
        
        if ( !isdefined( file_folder ) )
        {
            file_folder = function_af8076a398f00983();
        }
        
        file_id = function_b70280649f0c0c0d( file_name, "<dev string:x238>", function_af8076a398f00983() );
        file_content = function_a865c969ccd16b89( file_id );
        function_9c33c17f1c093741( file_id );
        
        if ( file_content == "<dev string:x23d>" )
        {
            return;
        }
        
        var_bc3df8a78a04f4f4 = function_702947ec4482d226( file_content );
        
        for ( i = 0; i < var_bc3df8a78a04f4f4.size ; i++ )
        {
            key = function_ca79c567aef372c1( var_bc3df8a78a04f4f4[ i ] );
            var_ca9b1aa2c0533531 = var_bc3df8a78a04f4f4[ i ];
            currentline = "<dev string:x23d>";
            var_7280ac4f5f28ea1b = [];
            
            for ( j = 0; j < var_ca9b1aa2c0533531.size ; j++ )
            {
                if ( ( var_ca9b1aa2c0533531[ j ] == "<dev string:x334>" || j == var_ca9b1aa2c0533531[ j ].size - 1 ) && currentline != "<dev string:x23d>" )
                {
                    var_7280ac4f5f28ea1b[ var_7280ac4f5f28ea1b.size ] = currentline;
                    currentline = "<dev string:x23d>";
                    continue;
                }
                
                currentline += var_ca9b1aa2c0533531[ j ];
            }
            
            foreach ( line in var_7280ac4f5f28ea1b )
            {
                if ( line == "<dev string:x23d>" )
                {
                    continue;
                }
                
                var_2f8b36bdfe337c4f = 0;
                var_fc46431ca6afdde0 = 0;
                
                for ( j = 0; j < line.size ; j++ )
                {
                    if ( line[ j ] == "<dev string:x33c>" )
                    {
                        var_2f8b36bdfe337c4f++;
                        
                        if ( var_2f8b36bdfe337c4f == 2 )
                        {
                            var_fc46431ca6afdde0 = 1;
                            break;
                        }
                        
                        continue;
                    }
                    
                    if ( !function_e4d37c4d807d6553( line[ j ] ) )
                    {
                        var_fc46431ca6afdde0 = 0;
                        break;
                    }
                    
                    var_2f8b36bdfe337c4f = 0;
                }
                
                if ( var_fc46431ca6afdde0 )
                {
                    continue;
                }
                
                foundfieldname = "<dev string:x23d>";
                foundvalue = "<dev string:x23d>";
                foundcolon = 0;
                var_df41fb25c76dda76 = strtoksubstr( line, "<dev string:x4f3>" );
                
                if ( var_df41fb25c76dda76.size == 2 )
                {
                    foundcolon = 1;
                    foundfieldname = var_df41fb25c76dda76[ 0 ];
                    foundvalue = var_df41fb25c76dda76[ 1 ];
                }
                
                if ( !foundcolon )
                {
                    continue;
                }
                
                var_92425fd5af16a28a = "<dev string:x23d>";
                var_6fccc662769ba5b1 = 0;
                
                for ( j = 0; j < foundfieldname.size ; j++ )
                {
                    char = foundfieldname[ j ];
                    
                    if ( char == "<dev string:x25c>" || char == "<dev string:x25a>" )
                    {
                        var_6fccc662769ba5b1 = !var_6fccc662769ba5b1;
                        continue;
                    }
                    
                    if ( var_6fccc662769ba5b1 )
                    {
                        continue;
                    }
                    
                    if ( !function_e4d37c4d807d6553( char ) )
                    {
                        var_92425fd5af16a28a += foundfieldname[ j ];
                    }
                }
                
                function_a4ab247b2432ef85( key, var_92425fd5af16a28a, foundvalue );
            }
        }
        
        if ( isdefined( level.var_2c66786a3e860cc5 ) )
        {
            foreach ( callback in level.var_2c66786a3e860cc5 )
            {
                [[ callback ]]( level.player );
            }
        }
        
        iprintlnbold( "<dev string:x4f5>" );
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1, eflags: 0x4
    // Checksum 0x70c972cf, Offset: 0xe77
    // Size: 0xa5, Type: dev
    function private function_702947ec4482d226( file_content )
    {
        var_7b1bffcf258a1e77 = [];
        contentfound = "<dev string:x23d>";
        var_9fe74b5728c3b7ab = 0;
        
        for ( i = 0; i < file_content.size ; i++ )
        {
            if ( file_content[ i ] == "<dev string:x4ac>" && !var_9fe74b5728c3b7ab )
            {
                var_9fe74b5728c3b7ab = 1;
                continue;
            }
            
            if ( !var_9fe74b5728c3b7ab )
            {
                continue;
            }
            
            if ( file_content[ i ] == "<dev string:x258>" && var_9fe74b5728c3b7ab )
            {
                var_9fe74b5728c3b7ab = 0;
                var_7b1bffcf258a1e77[ var_7b1bffcf258a1e77.size ] = contentfound;
                contentfound = "<dev string:x23d>";
                continue;
            }
            
            contentfound += file_content[ i ];
        }
        
        return var_7b1bffcf258a1e77;
    }

    // Namespace namespace_1fd4452aa332cfa1
    // Params 1, eflags: 0x4
    // Checksum 0x71794062, Offset: 0xf24
    // Size: 0x84, Type: dev
    function private function_ca79c567aef372c1( var_a651d2c1392b36cb )
    {
        word_found = "<dev string:x23d>";
        var_7dc5f847d1651226 = 0;
        
        for ( i = 0; i < var_a651d2c1392b36cb.size ; i++ )
        {
            if ( var_a651d2c1392b36cb[ i ] == "<dev string:xe5>" && !var_7dc5f847d1651226 )
            {
                var_7dc5f847d1651226 = !var_7dc5f847d1651226;
                continue;
            }
            
            if ( !var_7dc5f847d1651226 )
            {
                continue;
            }
            
            if ( var_a651d2c1392b36cb[ i ] == "<dev string:xe5>" )
            {
                break;
            }
            
            word_found += var_a651d2c1392b36cb[ i ];
        }
        
        return word_found;
    }

#/
