// scripts\common\debug.gsc  (hash_77c18cdedec620b3.gscc) (size: 14016 Bytes / 0x36c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x84dace8a (2228932234)
// size ...... 14016 (0x36c0)
// includes .. 1   (offset: 0x3448)
// strings ... 2   (offset: 0x3450)
// dev strs .. 43  (offset: 0x346c)
// exports ... 35  (offset: 0x25d4)
// cseg ...... 0x6a + 0x256a (0x25d4)
// imports ... 63  (offset: 0x2b4c)
// animtree1 . 0   (offset: 0x36c0)
// animtree2 . 0   (offset: 0x36c0)
#using scripts\common\utility;

#namespace debug;

/#

    // Namespace debug
    // Params 1
    // Checksum 0x69f22c42, Offset: 0x88
    // Size: 0x9d, Type: dev
    function function_4496bef4cfc0d07( ent )
    {
        if ( !isdefined( ent ) )
        {
            return "<dev string:x24>";
        }
        
        text = "<dev string:x25>" + "<dev string:x27>" + ent getentitynumber();
        
        if ( isdefined( ent.classname ) )
        {
            text = text + "<dev string:x2a>" + ent.classname + "<dev string:x36>";
        }
        
        if ( isdefined( ent.model ) )
        {
            text = text + "<dev string:x38>" + ent.model + "<dev string:x36>";
        }
        
        text += "<dev string:x40>";
        return text;
    }

    // Namespace debug
    // Params 1
    // Checksum 0xadda7c73, Offset: 0x12d
    // Size: 0x9f, Type: dev
    function function_b94568e3a7672460( corpse )
    {
        setdvarifuninitialized( @"hash_f806a3434286263f", 0 );
        
        if ( getdvarint( @"hash_f806a3434286263f", 0 ) != 0 )
        {
            level.var_b94568e3a7672460 = 1;
            
            if ( isdefined( corpse ) )
            {
                entnum = corpse getentitynumber();
                cmd = "<dev string:x42>" + entnum + "<dev string:x5c>" + entnum;
                adddebugcommand( cmd + "<dev string:x74>" );
            }
            
            return;
        }
        
        if ( level.var_b94568e3a7672460 )
        {
            adddebugcommand( "<dev string:x76>" );
            level.var_b94568e3a7672460 = undefined;
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xb1c452dd, Offset: 0x1d4
    // Size: 0x32, Type: dev
    function function_a8ee5e70fb7d68d0( ent )
    {
        if ( !isdefined( ent ) )
        {
            return "<dev string:x24>";
        }
        
        if ( isent( ent ) )
        {
            return ( "<dev string:x27>" + ent getentitynumber() );
        }
    }

#/

// Namespace debug
// Params 2
// Checksum 0x1c090630, Offset: 0x20e
// Size: 0x32
function get_text_safe( variable, undefined_return )
{
    if ( isdefined( variable ) )
    {
        return ( variable + "" );
    }
    
    if ( isdefined( undefined_return ) )
    {
        return undefined_return;
    }
    
    return "";
}

// Namespace debug
// Params 3
// Checksum 0xc49bfd88, Offset: 0x249
// Size: 0xac
function function_4be0558f456a7a55( button, before_text, after_text )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !self buttonpressed( button ) )
        {
            break;
        }
        
        waitframe();
    }
    
    while ( true )
    {
        if ( isdefined( before_text ) )
        {
            /#
                printtoscreen2d( 10, 100, "<dev string:xac>" + button + "<dev string:xb3>" + before_text, ( 1, 1, 1 ), 2 );
            #/
        }
        
        if ( self buttonpressed( button ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( after_text ) )
    {
        iprintlnbold( after_text );
        return;
    }
    
    if ( isdefined( before_text ) )
    {
        iprintlnbold( "Performed:" + before_text );
    }
}

/#

    // Namespace debug
    // Params 6
    // Checksum 0x46a04362, Offset: 0x2fd
    // Size: 0x111, Type: dev
    function function_9d6fee9cf5908ddc( text, color, duration, x, y, scale )
    {
        if ( !isdefined( level.debug_print_id ) )
        {
            level.debug_print_text = [];
            level.debug_print_endtime = [];
            level.debug_print_color = [];
            level.debug_print_id = 0;
            level thread function_a06c9bfa7621ba4a( x, y, scale );
        }
        
        if ( !isdefined( text ) )
        {
            text = "<dev string:xb9>";
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( duration ) )
        {
            duration = getdvarfloat( @"hash_e7c6b5ac109cff25", 2 );
        }
        
        level.debug_print_text[ level.debug_print_id ] = text;
        level.debug_print_endtime[ level.debug_print_id ] = gettime() + duration * 1000;
        level.debug_print_color[ level.debug_print_id ] = color;
        level.debug_print_id++;
    }

    // Namespace debug
    // Params 3
    // Checksum 0x80449a59, Offset: 0x416
    // Size: 0x1fe, Type: dev
    function function_a06c9bfa7621ba4a( x, y, scale )
    {
        level notify( #"hash_8edae572b06183c5" );
        level endon( #"hash_8edae572b06183c5" );
        
        if ( !isdefined( x ) )
        {
            x = getdvarint( @"scr_debug_print_x", 850 );
        }
        
        if ( !isdefined( y ) )
        {
            y = getdvarint( @"scr_debug_print_y", 100 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = getdvarfloat( @"scr_debug_print_scale", 2 );
        }
        
        while ( true )
        {
            waittillframeend();
            
            if ( getdvarint( @"hash_e4ceb718c4811e97", 1 ) )
            {
                keys = getarraykeys( level.debug_print_endtime );
                
                if ( keys.size > 0 )
                {
                    vid_width_ratio = getdvarint( @"vid_width" ) / 1920;
                    vid_height_ratio = getdvarint( @"vid_height" ) / 1080;
                    base_x = x * vid_width_ratio;
                    base_y = y * vid_height_ratio;
                    base_scale = scale * vid_height_ratio;
                }
                
                time = gettime();
                linecount = 0;
                
                foreach ( i in keys )
                {
                    if ( time > level.debug_print_endtime[ i ] )
                    {
                        level.debug_print_endtime[ i ] = undefined;
                        level.debug_print_text[ i ] = undefined;
                        level.debug_print_color[ i ] = undefined;
                        continue;
                    }
                    
                    linecount++;
                    printtoscreen2d( base_x, base_y + base_scale * 12 * linecount, level.debug_print_text[ i ], level.debug_print_color[ i ], base_scale );
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug
    // Params 7
    // Checksum 0x8324cc4a, Offset: 0x61c
    // Size: 0x57, Type: dev
    function sphere( target, radius, color, seconds, level_endon, target_endon, depth_test )
    {
        level thread sphere_internal( target, radius, color, seconds, level_endon, target_endon, depth_test );
    }

    // Namespace debug
    // Params 7
    // Checksum 0xd293087b, Offset: 0x67b
    // Size: 0x110, Type: dev
    function sphere_internal( target, radius, color, seconds, level_endon, target_endon, depth_test )
    {
        if ( !isdefined( radius ) )
        {
            radius = 10;
        }
        
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        if ( isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            sphere( target_vector, radius, color, depth_test, 1 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 8
    // Checksum 0xd076f5f8, Offset: 0x793
    // Size: 0x61, Type: dev
    function cylinder( target, target2, radius, color, seconds, level_endon, target_endon, target2_endon )
    {
        level thread cylinder_internal( target, target2, radius, color, seconds, level_endon, target_endon, target2_endon );
    }

    // Namespace debug
    // Params 8
    // Checksum 0xd72a1363, Offset: 0x7fc
    // Size: 0x18d, Type: dev
    function cylinder_internal( target, target2, radius, color, seconds, level_endon, target_endon, target2_endon )
    {
        if ( !isdefined( radius ) )
        {
            radius = 10;
        }
        
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        target2_vector = undefined;
        
        if ( isvector( target2 ) )
        {
            target2_vector = target2;
        }
        
        if ( isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        if ( isdefined( target2_endon ) )
        {
            assert( !isvector( target2 ), "<dev string:xec>" );
            target2 endon( target2_endon );
        }
        
        while ( isdefined( target ) && isdefined( target2 ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            if ( !isvector( target2 ) )
            {
                if ( isnumber( target2 ) )
                {
                    target2_vector = target.origin + ( 0, 0, target2 );
                }
                else
                {
                    target2_vector = target2.origin;
                }
            }
            
            cylinder( target_vector, target2_vector, radius, color, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 7
    // Checksum 0x437f29d5, Offset: 0x991
    // Size: 0x57, Type: dev
    function line( target, target2, color, seconds, level_endon, target_endon, target2_endon )
    {
        level thread line_internal( target, target2, color, seconds, level_endon, target_endon, target2_endon );
    }

    // Namespace debug
    // Params 7
    // Checksum 0x82974254, Offset: 0x9f0
    // Size: 0x15c, Type: dev
    function line_internal( target, target2, color, seconds, level_endon, target_endon, target2_endon )
    {
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        target2_vector = undefined;
        
        if ( isvector( target2 ) )
        {
            target2_vector = target2;
        }
        
        if ( isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        if ( isdefined( target2_endon ) )
        {
            assert( !isvector( target2 ), "<dev string:xec>" );
            target2 endon( target2_endon );
        }
        
        while ( isdefined( target ) && isdefined( target2 ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            if ( !isvector( target2 ) )
            {
                target2_vector = target2.origin;
            }
            
            line( target_vector, target2_vector, color, 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 7
    // Checksum 0xad27c82, Offset: 0xb54
    // Size: 0x1fe, Type: dev
    function linex( target, target2, color, alpha, depth_test, num_lines, line_distance )
    {
        if ( !isdefined( num_lines ) )
        {
            num_lines = 5;
        }
        
        if ( !isdefined( line_distance ) )
        {
            line_distance = 4;
        }
        
        target_vector = isvector( target ) ? target : target.origin;
        target2_vector = isvector( target2 ) ? target2 : target2.origin;
        color = isstring( color ) ? get_color( color ) : color;
        line( target_vector, target2_vector, color, alpha, depth_test );
        direction_vec3 = vectornormalize( target_vector - target2_vector );
        var_988e1911bf3cbf98 = vectorcross( direction_vec3, ( 0, 0, 1 ) );
        
        for ( i = 1; i <= num_lines ; i++ )
        {
            var_5c0712bb218c3b41 = var_988e1911bf3cbf98 * i * line_distance;
            var_5c070fbb218c34a8 = var_988e1911bf3cbf98 * -1 * i * line_distance;
            var_5c0710bb218c36db = vectorcross( var_988e1911bf3cbf98, direction_vec3 ) * i * line_distance;
            var_5c0715bb218c41da = vectorcross( var_988e1911bf3cbf98, direction_vec3 ) * -1 * i * line_distance;
            var_ef4f01b295f6f1e6 = target_vector + var_5c0712bb218c3b41;
            var_9fe8cf7bb1a3e88d = target2_vector + var_5c0712bb218c3b41;
            var_ef4f00b295f6efb3 = target_vector + var_5c070fbb218c34a8;
            var_9fe8cc7bb1a3e1f4 = target2_vector + var_5c070fbb218c34a8;
            var_ef4effb295f6ed80 = target_vector + var_5c0710bb218c36db;
            var_9fe8cd7bb1a3e427 = target2_vector + var_5c0710bb218c36db;
            var_ef4f06b295f6fce5 = target_vector + var_5c0715bb218c41da;
            var_9fe8ca7bb1a3dd8e = target2_vector + var_5c0715bb218c41da;
            line( var_ef4f01b295f6f1e6, var_9fe8cf7bb1a3e88d, color, alpha, depth_test );
            line( var_ef4f00b295f6efb3, var_9fe8cc7bb1a3e1f4, color, alpha, depth_test );
            line( var_ef4effb295f6ed80, var_9fe8cd7bb1a3e427, color, alpha, depth_test );
            line( var_ef4f06b295f6fce5, var_9fe8ca7bb1a3dd8e, color, alpha, depth_test );
        }
    }

    // Namespace debug
    // Params 11
    // Checksum 0xa87edae4, Offset: 0xd5a
    // Size: 0x92, Type: dev
    function function_b098996fe46fd238( target, target2, color, alpha, depth_test, num_lines, line_distance, seconds, level_endon, target_endon, target2_endon )
    {
        if ( !isdefined( num_lines ) )
        {
            num_lines = 5;
        }
        
        if ( !isdefined( line_distance ) )
        {
            line_distance = 4;
        }
        
        level thread function_aba73a791654afe0( target, target2, color, alpha, depth_test, num_lines, line_distance, seconds, level_endon, target_endon, target2_endon );
    }

    // Namespace debug
    // Params 11, eflags: 0x4
    // Checksum 0x57ffcedc, Offset: 0xdf4
    // Size: 0x174, Type: dev
    function private function_aba73a791654afe0( target, target2, color, alpha, depth_test, num_lines, line_distance, seconds, level_endon, target_endon, target2_endon )
    {
        color = isstring( color ) ? get_color( color ) : color;
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        target2_vector = undefined;
        
        if ( isvector( target2 ) )
        {
            target2_vector = target2;
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        if ( isdefined( target2_endon ) )
        {
            assert( !isvector( target2 ), "<dev string:xec>" );
            target2 endon( target2_endon );
        }
        
        while ( isdefined( target ) && isdefined( target2 ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            if ( !isvector( target2 ) )
            {
                target2_vector = target2.origin;
            }
            
            linex( target_vector, target2_vector, color, alpha, depth_test, num_lines, line_distance );
            waitframe();
        }
    }

    // Namespace debug
    // Params 5
    // Checksum 0x5150832b, Offset: 0xf70
    // Size: 0x1e5, Type: dev
    function function_76204bee46fa39fd( midpoint, halfsize, angles, drawtimeseconds, color )
    {
        if ( isdefined( angles ) )
        {
            forward = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
        }
        else
        {
            forward = ( 1, 0, 0 );
            right = ( 0, 1, 0 );
            up = ( 0, 0, 1 );
        }
        
        localcorners = [];
        localcorners[ 0 ] = ( halfsize[ 0 ] * -1, halfsize[ 1 ] * -1, halfsize[ 2 ] );
        localcorners[ 1 ] = ( halfsize[ 0 ], halfsize[ 1 ] * -1, halfsize[ 2 ] );
        localcorners[ 2 ] = ( halfsize[ 0 ] * -1, halfsize[ 1 ], halfsize[ 2 ] );
        localcorners[ 3 ] = ( halfsize[ 0 ], halfsize[ 1 ], halfsize[ 2 ] );
        localcorners[ 4 ] = ( halfsize[ 0 ] * -1, halfsize[ 1 ] * -1, halfsize[ 2 ] * -1 );
        localcorners[ 5 ] = ( halfsize[ 0 ], halfsize[ 1 ] * -1, halfsize[ 2 ] * -1 );
        localcorners[ 6 ] = ( halfsize[ 0 ] * -1, halfsize[ 1 ], halfsize[ 2 ] * -1 );
        localcorners[ 7 ] = ( halfsize[ 0 ], halfsize[ 1 ], halfsize[ 2 ] * -1 );
        worldcorners = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            x = localcorners[ i ][ 0 ];
            y = localcorners[ i ][ 1 ];
            z = localcorners[ i ][ 2 ];
            worldcorners[ i ] = midpoint + x * forward + y * right + z * up;
        }
        
        thread function_5216f7041907b4f3( worldcorners[ 0 ], worldcorners[ 1 ], worldcorners[ 2 ], worldcorners[ 3 ], worldcorners[ 4 ], worldcorners[ 5 ], worldcorners[ 6 ], worldcorners[ 7 ], drawtimeseconds, color );
    }

    // Namespace debug
    // Params 11
    // Checksum 0x6c543135, Offset: 0x115d
    // Size: 0x111, Type: dev
    function function_5216f7041907b4f3( topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, bottomleftback, bottomrightback, drawtimeseconds, color, level_endon )
    {
        line( topleftfront, toprightfront, color, drawtimeseconds, level_endon );
        line( topleftfront, bottomleftfront, color, drawtimeseconds, level_endon );
        line( topleftfront, topleftback, color, drawtimeseconds, level_endon );
        line( toprightfront, toprightback, color, drawtimeseconds, level_endon );
        line( toprightfront, bottomrightfront, color, drawtimeseconds, level_endon );
        line( topleftback, bottomleftback, color, drawtimeseconds, level_endon );
        line( topleftback, toprightback, color, drawtimeseconds, level_endon );
        line( toprightback, bottomrightback, color, drawtimeseconds, level_endon );
        line( bottomleftfront, bottomrightfront, color, drawtimeseconds, level_endon );
        line( bottomleftfront, bottomleftback, color, drawtimeseconds, level_endon );
        line( bottomrightfront, bottomrightback, color, drawtimeseconds, level_endon );
        line( bottomrightback, bottomleftback, color, drawtimeseconds, level_endon );
    }

    // Namespace debug
    // Params 6
    // Checksum 0xad1ba755, Offset: 0x1276
    // Size: 0x4c, Type: dev
    function draw_angles( target, angles, radius, seconds, level_endon, target_endon )
    {
        level thread draw_angles_internal( target, angles, radius, seconds, level_endon, target_endon );
    }

    // Namespace debug
    // Params 6
    // Checksum 0x9f3b33db, Offset: 0x12ca
    // Size: 0x16d, Type: dev
    function draw_angles_internal( target, angles, radius, seconds, level_endon, target_endon )
    {
        if ( !isdefined( radius ) )
        {
            radius = 100;
        }
        
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
                angles = target.angles;
            }
            
            forward = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
            line( target_vector, target_vector + forward * radius, ( 1, 0, 0 ), 1, 0, 1 );
            line( target_vector, target_vector + right * radius, ( 0, 1, 0 ), 1, 0, 1 );
            line( target_vector, target_vector + up * radius, ( 0, 0, 1 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 11
    // Checksum 0xb1de07c7, Offset: 0x143f
    // Size: 0x80, Type: dev
    function interact( target, text, on_use_func, on_use_args, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale )
    {
        level thread interact_internal( target, text, on_use_func, on_use_args, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale );
    }

    // Namespace debug
    // Params 11
    // Checksum 0x461759c3, Offset: 0x14c7
    // Size: 0x241, Type: dev
    function interact_internal( target, text, on_use_func, on_use_args, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale )
    {
        if ( !isdefined( end_on_use ) )
        {
            end_on_use = 0;
        }
        
        if ( !isdefined( z_offset ) )
        {
            z_offset = 10;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        v_target = undefined;
        
        if ( isvector( target ) )
        {
            v_target = target;
        }
        else
        {
            v_target = target.origin;
        }
        
        interact = undefined;
        
        if ( utility::issharedfuncdefined( #"game", #"createhintobject" ) )
        {
            interact = [[ utility::getsharedfunc( #"game", #"createhintobject" ) ]]( v_target, "<dev string:x118>", undefined, undefined, 5, "<dev string:x124>", "<dev string:x133>", 100, 90, 100, 90 );
        }
        else
        {
            assertmsg( "<dev string:x138>" );
        }
        
        if ( isent( target ) )
        {
            interact linkto( target );
            interact thread utility::function_fb5b19421bb35e50( target, "<dev string:x18b>" );
            target endon( #"entitydeleted" );
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
            interact thread utility::function_fb5b19421bb35e50( level, level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
            interact thread utility::function_fb5b19421bb35e50( target, target_endon );
        }
        
        if ( isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( isdefined( text ) )
        {
            childthread print3d_internal( interact, text, color, undefined, undefined, undefined, alpha, scale, z_offset );
        }
        
        childthread sphere_internal( interact, 2, color );
        
        while ( isdefined( target ) )
        {
            interact waittill( #"trigger", player );
            
            if ( isdefined( on_use_func ) )
            {
                if ( isdefined( on_use_args ) )
                {
                    if ( !isarray( on_use_args ) )
                    {
                        on_use_args = [ on_use_args ];
                    }
                    
                    level thread utility::single_func_argarray( player, on_use_func, on_use_args );
                }
                else
                {
                    player thread [[ on_use_func ]]();
                }
            }
            
            if ( end_on_use )
            {
                interact delete();
                return;
            }
        }
    }

    // Namespace debug
    // Params 9
    // Checksum 0x19e9ac93, Offset: 0x1710
    // Size: 0x6b, Type: dev
    function print3d( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset )
    {
        level thread print3d_internal( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset );
    }

    // Namespace debug
    // Params 9
    // Checksum 0x485e68e5, Offset: 0x1783
    // Size: 0x13b, Type: dev
    function print3d_internal( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( z_offset ) )
        {
            z_offset = 0;
        }
        
        v_target = undefined;
        
        if ( isvector( target ) )
        {
            v_target = target;
        }
        
        if ( isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assert( !isvector( target ), "<dev string:xec>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                v_target = target.origin;
            }
            
            print3d( v_target + ( 0, 0, z_offset ), text, color, alpha, scale, 1, 1 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0x8f166353, Offset: 0x18c6
    // Size: 0x2e7, Type: dev
    function get_color( color )
    {
        switch ( color )
        {
            case #"hash_97430f6c58e61cbc":
                return ( 1, 0, 0 );
            case #"hash_35bb3bd014c77f4b":
                return ( 1, 0.5, 0 );
            case #"hash_2ac407c1cd5943a9":
                return ( 1, 1, 0 );
            case #"hash_883ff07272b4f9c":
                return ( 0, 1, 0 );
            case #"hash_6686d129776d649a":
                return ( 0, 1, 1 );
            case #"hash_778bb52ecd08072d":
                return ( 0, 0, 1 );
            case #"hash_40fc63173753ec52":
                return ( 1, 0.5, 1 );
            case #"hash_598a30e44f53045f":
                return ( 0.5, 0, 1 );
            case #"hash_6eb69eb2e91f9fc8":
                return ( 1, 0, 1 );
            case #"hash_8c6e8e84936881cd":
                return ( 1, 0.75, 0.75 );
            case #"hash_1393412d7401c646":
                return ( 1, 1, 1 );
            case #"hash_a4324aac758f0a84":
                return ( 0, 0, 0 );
            case #"hash_dd71850f436e7706":
            case #"hash_dd7e8d0f437910fa":
                return ( 0.75, 0.75, 0.75 );
            case #"hash_2748da0737956f91":
            case #"hash_82bae0726e5ab95":
                return ( 0.1, 0.1, 0.1 );
            case #"hash_82bab0726e5a6dc":
            case #"hash_2748d70737956ad8":
                return ( 0.2, 0.2, 0.2 );
            case #"hash_82bac0726e5a86f":
            case #"hash_2748d80737956c6b":
                return ( 0.3, 0.3, 0.3 );
            case #"hash_82ba90726e5a3b6":
            case #"hash_2748dd073795744a":
                return ( 0.4, 0.4, 0.4 );
            case #"hash_82baa0726e5a549":
            case #"hash_2748de07379575dd":
                return ( 0.5, 0.5, 0.5 );
            case #"hash_2748db0737957124":
            case #"hash_82ba70726e5a090":
                return ( 0.6, 0.6, 0.6 );
            case #"hash_82ba80726e5a223":
            case #"hash_2748dc07379572b7":
                return ( 0.7, 0.7, 0.7 );
            case #"hash_82bb50726e5b69a":
            case #"hash_2748d10737956166":
                return ( 0.8, 0.8, 0.8 );
            case #"hash_82bb60726e5b82d":
            case #"hash_2748d207379562f9":
                return ( 0.9, 0.9, 0.9 );
            default:
                assertmsg( "<dev string:x258>" );
                return;
        }
    }

    // Namespace debug
    // Params 3
    // Checksum 0xb01c989d, Offset: 0x1bb5
    // Size: 0x16c, Type: dev
    function function_154a142652377d60( amt, player, damage_from_player )
    {
        if ( !isdefined( self.hit_times ) )
        {
            self.hit_times = 2;
        }
        
        color = ( 1, 0, 0 );
        
        if ( !damage_from_player )
        {
            color = ( 0, 0, 1 );
        }
        
        start = self.origin + ( 0, 0, 60 );
        extra = 0;
        alpha = 1;
        right = anglestoleft( vectortoangles( player.origin - self.origin ) );
        my_column = self.hit_times % 5 - 2;
        offset = my_column * 19 * right;
        start += offset * 0.25;
        offset *= 0.75;
        self.hit_times++;
        
        while ( extra < 60 )
        {
            if ( extra < 15 )
            {
                alpha = 1;
            }
            else
            {
                alpha = clamp( 1 - ( extra - 15 ) / 45, 0, 1 );
            }
            
            print3d( start + offset * alpha + ( 0, 0, extra ), string( amt ), color, alpha, alpha * 0.75, 1, 1 );
            extra += 2;
            waitframe();
        }
    }

    // Namespace debug
    // Params 6
    // Checksum 0xfa5fa070, Offset: 0x1d29
    // Size: 0x458, Type: dev
    function debug_print_damage( dmg_data, original_damage, pre_final, display_time, display_scale, var_4a17dd271bf78234 )
    {
        if ( !isdefined( display_time ) )
        {
            display_time = 5;
        }
        
        if ( !isdefined( display_scale ) )
        {
            display_scale = 0.25;
        }
        
        if ( !isdefined( var_4a17dd271bf78234 ) )
        {
            var_4a17dd271bf78234 = 1;
        }
        
        if ( !isdefined( dmg_data ) || isdefined( dmg_data ) && !isarray( dmg_data ) )
        {
            return;
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        einflictor = dmg_data[ "<dev string:x2c3>" ] ?? undefined;
        eattacker = dmg_data[ "<dev string:x2ce>" ] ?? undefined;
        idamage = dmg_data[ "<dev string:x2d8>" ] ?? 0;
        smod = dmg_data[ "<dev string:x2e0>" ] ?? undefined;
        sweapon = dmg_data[ "<dev string:x2ee>" ] ?? undefined;
        vpoint = dmg_data[ "<dev string:x2f6>" ] ?? undefined;
        shitloc = dmg_data[ "<dev string:x2fd>" ] ?? undefined;
        objweapon = dmg_data[ "<dev string:x305>" ] ?? undefined;
        
        if ( var_4a17dd271bf78234 )
        {
            if ( !isdefined( eattacker ) || isdefined( eattacker ) && !isplayer( eattacker ) && ( !isdefined( einflictor ) || isdefined( einflictor ) && !isplayer( einflictor ) ) )
            {
                return;
            }
        }
        
        if ( display_time == -1 )
        {
            display_time = undefined;
        }
        
        s = "<dev string:x30f>" + self getentitynumber();
        
        if ( isdefined( einflictor ) )
        {
            s += "<dev string:x31b>" + einflictor getentitynumber();
        }
        
        if ( isdefined( eattacker ) )
        {
            s += "<dev string:x324>" + eattacker getentitynumber();
        }
        
        if ( isdefined( shitloc ) )
        {
            s += "<dev string:x32d>" + shitloc;
        }
        
        s2 = "<dev string:x24>";
        s2 += "<dev string:x334>" + idamage;
        
        if ( isdefined( original_damage ) && original_damage != idamage )
        {
            s2 += "<dev string:x33a>" + original_damage;
        }
        
        if ( isdefined( smod ) )
        {
            s2 += "<dev string:x346>" + smod;
        }
        
        s3 = "<dev string:x24>";
        
        if ( isdefined( self ) && isdefined( self.health ) && isdefined( self.maxhealth ) )
        {
            if ( pre_final )
            {
                s3 = "<dev string:x34c>" + self.health - idamage + "<dev string:x355>" + self.maxhealth;
            }
            else
            {
                s3 = "<dev string:x34c>" + self.health + "<dev string:x355>" + self.maxhealth;
            }
        }
        
        s4 = "<dev string:x24>";
        
        if ( isdefined( sweapon ) )
        {
            if ( isstring( sweapon ) )
            {
                s4 = "<dev string:x359>" + sweapon;
            }
            else if ( isdefined( sweapon.basename ) )
            {
                s4 = "<dev string:x359>" + sweapon.basename;
            }
        }
        else if ( isdefined( objweapon ) )
        {
            if ( isdefined( objweapon.basename ) )
            {
                s4 = "<dev string:x359>" + objweapon.basename;
            }
        }
        
        if ( isdefined( einflictor ) && isdefined( einflictor.weapon_name ) )
        {
            s4 += "<dev string:x362>" + einflictor.weapon_name;
        }
        
        s5 = "<dev string:x37b>";
        printloc = undefined;
        
        if ( isdefined( vpoint ) )
        {
            printloc = vpoint;
        }
        else if ( isdefined( self.origin ) )
        {
            printloc = self.origin;
        }
        
        if ( getdvarint( @"hash_81d89e4abec64203", 0 ) == 1 && isdefined( printloc ) )
        {
            print3d( printloc, s, undefined, display_time, undefined, undefined, undefined, display_scale );
            print3d( printloc, s2, undefined, display_time, undefined, undefined, undefined, display_scale, -5 );
            print3d( printloc, s3, undefined, display_time, undefined, undefined, undefined, display_scale, -10 );
            print3d( printloc, s4, undefined, display_time, undefined, undefined, undefined, display_scale, -15 );
            return;
        }
        
        if ( isdefined( display_time ) )
        {
            function_9d6fee9cf5908ddc( s5, undefined, display_time );
            function_9d6fee9cf5908ddc( s4, undefined, display_time );
            function_9d6fee9cf5908ddc( s3, undefined, display_time );
            function_9d6fee9cf5908ddc( s2, undefined, display_time );
            function_9d6fee9cf5908ddc( s, undefined, display_time );
            return;
        }
        
        function_9d6fee9cf5908ddc( s5, undefined, 300 );
        function_9d6fee9cf5908ddc( s4, undefined, 300 );
        function_9d6fee9cf5908ddc( s3, undefined, 300 );
        function_9d6fee9cf5908ddc( s2, undefined, 300 );
        function_9d6fee9cf5908ddc( s, undefined, 300 );
    }

    // Namespace debug
    // Params 1
    // Checksum 0x85602069, Offset: 0x2189
    // Size: 0x5d, Type: dev
    function function_298a6c4895b8935d( start_pos )
    {
        assert( !isdefined( level.var_4ce8846f2a8daddd ), "<dev string:x396>" );
        var_4ce8846f2a8daddd = spawnstruct();
        var_4ce8846f2a8daddd.origin = start_pos;
        var_4ce8846f2a8daddd.first_print = 0;
        level.var_4ce8846f2a8daddd = var_4ce8846f2a8daddd;
    }

    // Namespace debug
    // Params 4
    // Checksum 0xaa9af261, Offset: 0x21ee
    // Size: 0xcb, Type: dev
    function function_ce323c1a383e915( text, color, scale, duration )
    {
        assert( isdefined( level.var_4ce8846f2a8daddd ), "<dev string:x3f2>" );
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        num_lines = strtok( text, "<dev string:x74>" );
        function_73cf360ef9afd65( level.var_4ce8846f2a8daddd, num_lines.size, scale );
        level thread function_cd774040359eeb32( level.var_4ce8846f2a8daddd.origin[ 0 ], level.var_4ce8846f2a8daddd.origin[ 1 ], text, color, scale, duration );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xdb6f80e1, Offset: 0x22c1
    // Size: 0xf, Type: dev
    function function_9de8db536c079b2d()
    {
        level.var_4ce8846f2a8daddd = undefined;
    }

    // Namespace debug
    // Params 6, eflags: 0x4
    // Checksum 0xb139363d, Offset: 0x22d8
    // Size: 0x72, Type: dev
    function private function_cd774040359eeb32( x, y, text, color, scale, duration_frames )
    {
        /#
            level endon( #"game_ended" );
            
            for ( _ = 0; _ < duration_frames ; _++ )
            {
                printtoscreen2d( x, y, text, color, scale );
                waitframe();
            }
        #/
    }

    // Namespace debug
    // Params 3, eflags: 0x4
    // Checksum 0x232b78e6, Offset: 0x2352
    // Size: 0x6f, Type: dev
    function private function_73cf360ef9afd65( var_4ce8846f2a8daddd, lines, scale )
    {
        if ( var_4ce8846f2a8daddd.first_print )
        {
            var_4ce8846f2a8daddd.origin = ( var_4ce8846f2a8daddd.origin[ 0 ], var_4ce8846f2a8daddd.origin[ 1 ] + 16 * lines * scale, 0 );
        }
        
        var_4ce8846f2a8daddd.first_print = 1;
    }

    // Namespace debug
    // Params 6
    // Checksum 0x67d38068, Offset: 0x23c9
    // Size: 0xea, Type: dev
    function debug_draw_arrow( start, end, color, alpha, depthtest, duration )
    {
        /#
            if ( !isdefined( alpha ) )
            {
                alpha = 1;
            }
            
            if ( !isdefined( depthtest ) )
            {
                depthtest = 1;
            }
            
            if ( !isdefined( duration ) )
            {
                duration = 1;
            }
            
            forward = vectornormalize( end - start );
            left = vectorcross( ( 0, 0, 1 ), forward );
            right = left * -1;
            arrow_head_tip = end;
            arrow_head_base = arrow_head_tip - forward * 24;
            line( start, end, color, alpha, depthtest, duration );
            line( arrow_head_tip, arrow_head_base + left * 16, color, alpha, depthtest, duration );
            line( arrow_head_tip, arrow_head_base + right * 16, color, alpha, depthtest, duration );
        #/
    }

    // Namespace debug
    // Params 7
    // Checksum 0x589ba3a0, Offset: 0x24bb
    // Size: 0x119, Type: dev
    function function_cccfaecda82a4343( origin, forward_dir, length, half_angle, color, duration, num_lines )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( !isdefined( num_lines ) )
        {
            num_lines = 12;
        }
        
        angles = vectortoangles( forward_dir );
        right = anglestoright( angles );
        line( origin, origin + forward_dir * length, color, 1, 0, duration );
        angle_step = half_angle * 2 / ( num_lines - 1 );
        
        for ( i = 0; i < num_lines ; i++ )
        {
            current_angle = half_angle * -1 + i * angle_step;
            sin_val = sin( current_angle );
            cos_val = cos( current_angle );
            rotated_dir = vectornormalize( forward_dir * cos_val + right * sin_val );
            line( origin, origin + rotated_dir * length, color, 1, 0, duration );
        }
    }

#/
