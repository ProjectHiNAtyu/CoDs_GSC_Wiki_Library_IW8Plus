// scripts\common\snd\snd_draw.gsc  (hash_40e20f7a89e97828.gscc) (size: 15799 Bytes / 0x3db7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4db9246 (2765853254)
// size ...... 15799 (0x3db7)
// includes .. 2   (offset: 0x3c53)
// strings ... 5   (offset: 0x3c63)
// dev strs .. 19  (offset: 0x3ca3)
// exports ... 41  (offset: 0x2d33)
// cseg ...... 0x8a + 0x2ca9 (0x2d33)
// imports ... 64  (offset: 0x339b)
// animtree1 . 0   (offset: 0x3db7)
// animtree2 . 0   (offset: 0x3db7)
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_utility;

#namespace snd;

/#

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x5f6af2d4, Offset: 0xa8
    // Size: 0xf, Type: dev
    function private function_4d36a47f06c76719( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd
    // Params 7
    // Checksum 0xb94b2eb8, Offset: 0xbf
    // Size: 0xe6, Type: dev
    function print2d( posx, posy, text, color, alpha, scale, duration )
    {
        if ( isdefined( text ) == 0 || text == "<dev string:x24>" )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( function_91beeef81da2dd73( level.snd.callbacks[ "<dev string:x25>" ] ) )
        {
            [[ level.snd.callbacks[ "<dev string:x25>" ] ]]( posx, posy, text, color, alpha, scale, duration );
            return;
        }
        
        printtoscreen2d( posx, posy, text, color, scale );
    }

    // Namespace snd
    // Params 2
    // Checksum 0xb8e7adbc, Offset: 0x1ad
    // Size: 0xce, Type: dev
    function function_d0a9a36c47e05dc6( text, scale )
    {
        assert( isdefined( text ) );
        
        if ( isdefined( scale ) == 0 )
        {
            scale = 1;
        }
        
        vidresolution = function_5e5cdedbd432d043();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        textlength = text.size;
        textwidth = textlength * 8 * scale;
        centerx = vidwidth * 0.5 - textwidth * 0.5;
        centery = vidheight * 0.5 - 8;
        center = [ centerx, centery ];
        return center;
    }

    // Namespace snd
    // Params 2
    // Checksum 0x3c6ccb15, Offset: 0x283
    // Size: 0x72, Type: dev
    function function_7f5ee0c2ceb78e3a( text, scale )
    {
        centerpos = function_d0a9a36c47e05dc6( text, scale );
        defaultposx = centerpos[ 0 ];
        defaultposy = centerpos[ 1 ];
        defaultposy = defaultposy * 0.5 + 8;
        defaultpos = [ defaultposx, defaultposy ];
        return defaultpos;
    }

    // Namespace snd
    // Params 7, eflags: 0x4
    // Checksum 0xb79af534, Offset: 0x2fd
    // Size: 0x345, Type: dev
    function private function_c4eb64eb4a930eaf( posx, posy, text, color, scale, fadeoutseconds, blinkseconds )
    {
        rowincrement = 16 * scale;
        frametime = function_76f9a4325afecc73();
        frametotal = int( fadeoutseconds / frametime );
        framecount = 0;
        blinkframes = int( blinkseconds / frametime );
        var_f660bab76725c3d8 = 1;
        blinkcount = 0;
        
        if ( level.snd.is_client_script )
        {
            var_f660bab76725c3d8 = 2;
        }
        
        assert( isstruct( level.snd ), "<dev string:x31>" );
        
        if ( isarray( level.snd.var_afcb674f6d6be1d3 ) == 0 )
        {
            level.snd.var_afcb674f6d6be1d3 = [];
        }
        
        assert( isarray( level.snd.var_afcb674f6d6be1d3 ) );
        
        if ( level.snd.var_afcb674f6d6be1d3.size > 0 )
        {
            foreach ( row in level.snd.var_afcb674f6d6be1d3 )
            {
                if ( arraycontains( level.snd.var_afcb674f6d6be1d3, posy ) )
                {
                    posy += rowincrement;
                    continue;
                }
                
                break;
            }
        }
        
        level.snd.var_afcb674f6d6be1d3[ level.snd.var_afcb674f6d6be1d3.size ] = posy;
        
        while ( framecount < frametotal )
        {
            if ( framecount < blinkframes )
            {
                blinkstate = int( float( framecount ) / float( var_f660bab76725c3d8 ) );
                blinkstate %= 2;
                
                if ( blinkstate )
                {
                    framecount += 1;
                    waitframe();
                    continue;
                }
            }
            
            framefrac = float( framecount ) / float( frametotal );
            framefrac = clamp( framefrac, 0, 1 );
            alpha = curve_value( 1 - framefrac, "<dev string:x4a>" );
            alphasq = alpha * alpha;
            colorscale = function_69dc1ffd54edd65c( color, alpha );
            function_2e8132539dbcad93( text, posx, posy, scale, "<dev string:x52>", colorscale, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
            framecount += 1;
            waitframe();
        }
        
        if ( isarray( level.snd.var_afcb674f6d6be1d3 ) )
        {
            level.snd.var_afcb674f6d6be1d3 = arrayremove( level.snd.var_afcb674f6d6be1d3, posy );
        }
    }

    // Namespace snd
    // Params 7
    // Checksum 0x3d5eb2be, Offset: 0x64a
    // Size: 0xe2, Type: dev
    function function_7a77574e2157fbce( text, posx, posy, color, scale, fadeoutseconds, blinkseconds )
    {
        assert( isdefined( text ) );
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0.5, 0.5 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1.75;
        }
        
        if ( !isdefined( fadeoutseconds ) )
        {
            fadeoutseconds = 4;
        }
        
        if ( !isdefined( blinkseconds ) )
        {
            blinkseconds = 1;
        }
        
        if ( isdefined( posx ) == 0 || isdefined( posy ) == 0 )
        {
            defaultpos = function_7f5ee0c2ceb78e3a( text, scale );
            
            if ( isdefined( posx ) == 0 )
            {
                posx = defaultpos[ 0 ];
            }
            
            if ( isdefined( posy ) == 0 )
            {
                posy = defaultpos[ 1 ];
            }
        }
        
        level thread function_c4eb64eb4a930eaf( posx, posy, text, color, scale, fadeoutseconds, blinkseconds );
        println( text );
    }

    // Namespace snd
    // Params 1
    // Checksum 0xe87648f3, Offset: 0x734
    // Size: 0x63, Type: dev
    function function_3581ab8642197e85( var_16b4397448456a3a )
    {
        assert( isstruct( level.snd ), "<dev string:x31>" );
        
        if ( isdefined( var_16b4397448456a3a ) && var_16b4397448456a3a != 0 )
        {
            level.snd.debughudactive = 1;
            return;
        }
        
        level.snd.debughudactive = undefined;
    }

    // Namespace snd
    // Params 7
    // Checksum 0xe4168dd3, Offset: 0x79f
    // Size: 0x54, Type: dev
    function print3d( origin, text, color, alpha, scale, duration, centered )
    {
        print3d( origin, text, color, alpha, scale, duration, centered );
    }

    // Namespace snd
    // Params 7
    // Checksum 0x6be96ad1, Offset: 0x7fb
    // Size: 0x54, Type: dev
    function print3dcentered( origin, text, color, alpha, scale, duration, right )
    {
        print3d( origin, text, color, alpha, scale, duration, 1 );
    }

    // Namespace snd
    // Params 12
    // Checksum 0x422675dd, Offset: 0x857
    // Size: 0x270, Type: dev
    function function_2e8132539dbcad93( text, x, y, scale, var_a3ca796ee2f554ea, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( var_a3ca796ee2f554ea ) )
        {
            var_a3ca796ee2f554ea = "<dev string:x54>";
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        offset = ( 0, 0, 0 );
        width = 8 * scale * text.size;
        
        switch ( var_a3ca796ee2f554ea )
        {
            case 0:
            case #"hash_311044bc01bd8beb":
            case #"hash_c9b3133a17a3b2d0":
            default:
                break;
            case 1:
            case #"hash_311041bc01bd8732":
            case #"hash_5a33ecbc44e76355":
            case #"hash_bf1a695c21e57fe4":
                offset += ( width * -0.5, 0, 0 );
                break;
            case 2:
            case #"hash_311052bc01bda1f5":
            case #"hash_96815ce4f2a3dbc5":
                offset += ( width * -1, 0, 0 );
                break;
        }
        
        lightcolor = undefined;
        
        if ( isdefined( shadowcolor ) )
        {
            shadowoffset = 1;
            
            if ( !isdefined( shadowalpha ) )
            {
                shadowalpha = alpha * 0.7333;
            }
            
            position = ( x + 1.333 * scale, y + 1.333 * scale, 0 ) + offset;
            print2d( position[ 0 ], position[ 1 ], text, shadowcolor, shadowalpha, scale, duration );
        }
        
        if ( isdefined( lightcolor ) )
        {
            if ( !isdefined( lightalpha ) )
            {
                lightalpha = alpha * 0.7333;
            }
            
            position = ( x + -0.666 * scale, y + -0.666 * scale, 0 ) + offset;
            print2d( position[ 0 ], position[ 1 ], text, lightcolor, lightalpha, scale, duration );
        }
        
        position = ( x, y, 0 ) + offset;
        print2d( position[ 0 ], position[ 1 ], text, color, alpha, scale, duration );
    }

    // Namespace snd
    // Params 11
    // Checksum 0x3eaa010f, Offset: 0xacf
    // Size: 0x44b, Type: dev
    function print3dplus( text, origin, scale, var_a3ca796ee2f554ea, color, alpha, shadowcolor, shadowalpha, lightcolor, lightalpha, duration )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( var_a3ca796ee2f554ea ) )
        {
            var_a3ca796ee2f554ea = "<dev string:x54>";
        }
        
        duration = int( duration ?? 1 );
        contsize = scale < 0;
        scale = abs( scale );
        textsize = text.size;
        
        if ( issubstr( text, "<dev string:x73>" ) )
        {
            lines = strtok( text, "<dev string:x73>" );
            
            if ( isarray( lines ) && lines.size > 1 )
            {
                longest = 0;
                
                foreach ( line in lines )
                {
                    if ( line.size > longest )
                    {
                        longest = line.size;
                    }
                }
                
                textsize = longest;
            }
        }
        
        viewanglesright = ( 1, 0, 0 );
        viewanglesup = ( 0, 0, 1 );
        players = getplayerssafe();
        
        if ( isarray( players ) && isdefined( players[ 0 ] ) )
        {
            player = players[ 0 ];
            vieworigin = player getplayervieworigin();
            viewangles = player getplayerviewangles();
            viewanglesright = anglestoright( viewangles );
            viewanglesup = anglestoup( viewangles );
            
            if ( contsize )
            {
                dist = distance( origin, vieworigin );
                fixeddistscalar = dist * 0.00133333;
                scale *= fixeddistscalar;
            }
        }
        
        width = 8 * scale * textsize;
        offset = ( 0, 0, 2 * scale * -1 );
        offsetright = viewanglesright * offset[ 0 ];
        offsetup = viewanglesup * offset[ 2 ];
        centered = 0;
        
        switch ( var_a3ca796ee2f554ea )
        {
            case 0:
            case #"hash_311044bc01bd8beb":
            case #"hash_c9b3133a17a3b2d0":
            default:
                break;
            case 1:
            case #"hash_311041bc01bd8732":
            case #"hash_5a33ecbc44e76355":
            case #"hash_bf1a695c21e57fe4":
                centered = 1;
                break;
            case 2:
            case #"hash_311052bc01bda1f5":
            case #"hash_96815ce4f2a3dbc5":
                offset += ( width * -1, 0, 0 );
                break;
        }
        
        shadowcolor = undefined;
        lightcolor = undefined;
        
        if ( isdefined( shadowcolor ) )
        {
            if ( !isdefined( shadowalpha ) )
            {
                shadowalpha = alpha * 0.72974;
            }
            
            shadowoffset = viewanglesright * 1.333 * scale + viewanglesup * -1.333 * scale;
            position = origin + viewanglesright * offset[ 0 ] + viewanglesup * offset[ 2 ];
            position += shadowoffset;
            print3d( position, text, shadowcolor, shadowalpha, scale, duration, centered );
        }
        
        if ( isdefined( lightcolor ) )
        {
            if ( !isdefined( lightalpha ) )
            {
                lightalpha = alpha * 0.72974;
            }
            
            lightoffset = viewanglesright * -0.666 * scale + viewanglesup * 0.666 * scale;
            position = origin + viewanglesright * offset[ 0 ] + viewanglesup * offset[ 2 ];
            position += lightoffset;
            print3d( position, text, lightcolor, lightalpha, scale, duration, centered );
        }
        
        position = origin + viewanglesright * offset[ 0 ] + viewanglesup * offset[ 2 ];
        print3d( position, text, color, alpha, scale, duration, centered );
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0xcc17c29a, Offset: 0xf22
    // Size: 0xf, Type: dev
    function private function_c9d953fce147bfaf( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd
    // Params 4, eflags: 0x4
    // Checksum 0xc1c2cd82, Offset: 0xf39
    // Size: 0xf5, Type: dev
    function private _drawpath_draw( color, depthtest, drawpatharray, offset )
    {
        if ( drawpatharray.size < 2 )
        {
            return;
        }
        
        linecount = drawpatharray.size - 1;
        alpha = 1;
        alphastep = 1 / linecount;
        colorscale = color;
        
        while ( linecount > 0 )
        {
            orgend = drawpatharray[ linecount ];
            orgstart = drawpatharray[ linecount - 1 ];
            
            if ( isvector( orgend ) && isvector( orgstart ) && orgend != orgstart )
            {
                if ( isvector( offset ) )
                {
                    orgend += offset;
                    orgstart += offset;
                }
                
                line( orgend, orgstart, colorscale, alpha, depthtest, 1 );
            }
            
            colorscale = vectorscale( color, alpha * 1.5 );
            alpha -= alphastep;
            linecount--;
        }
    }

    // Namespace snd
    // Params 4, eflags: 0x4
    // Checksum 0xab81e6b5, Offset: 0x1036
    // Size: 0x122, Type: dev
    function private _drawpath_main( color, depthtest, duration, offset )
    {
        assert( isdefined( self.origin ), "<dev string:x75>" );
        assert( isvector( color ), "<dev string:x98>" );
        assert( isdefined( duration ), "<dev string:xb4>" );
        framecount = 0;
        drawpatharray = [];
        drawpatharray[ 0 ] = self.origin;
        self endon( #"hash_2605f8ddd93ed8f9" );
        
        while ( drawpatharray.size > 0 )
        {
            temppatharray = [];
            
            if ( framecount >= duration )
            {
                for ( i = 1; i < drawpatharray.size ; i++ )
                {
                    temppatharray[ i - 1 ] = drawpatharray[ i ];
                }
            }
            else
            {
                temppatharray = drawpatharray;
            }
            
            if ( isdefined( self ) && isdefined( self.origin ) && is_object_invalid( self ) == 0 )
            {
                temppatharray[ temppatharray.size ] = self.origin;
            }
            
            drawpatharray = temppatharray;
            _drawpath_draw( color, depthtest, drawpatharray, offset );
            framecount++;
            waitframe();
        }
    }

    // Namespace snd
    // Params 5
    // Checksum 0xbc3240e8, Offset: 0x1160
    // Size: 0xc3, Type: dev
    function drawpath( movingobject, color, depthtest, duration, offset )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        if ( condition_alert( !isdefined( movingobject ), "<dev string:xd3>" ) )
        {
            return;
        }
        
        if ( level.snd.is_client_script )
        {
            duration = int( 60 * duration );
        }
        else
        {
            duration = int( 20 * duration );
        }
        
        assert( duration > 2, "<dev string:xf9>" );
        movingobject thread _drawpath_main( color, depthtest, duration, offset );
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0xcda51d47, Offset: 0x122b
    // Size: 0xf, Type: dev
    function private function_267ebe1b22ada254( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd
    // Params 7
    // Checksum 0x5c1f6eb8, Offset: 0x1242
    // Size: 0x232, Type: dev
    function function_84a6aedcf09989b1( origin, angles, extents, color, alpha, depthtest, duration )
    {
        half = extents * 0.5;
        halv = ( half, half, half );
        mins = origin - halv;
        maxs = origin + halv;
        side1[ 0 ] = ( maxs[ 0 ], maxs[ 1 ], maxs[ 2 ] );
        side1[ 1 ] = ( maxs[ 0 ], maxs[ 1 ], mins[ 2 ] );
        side1[ 2 ] = ( mins[ 0 ], maxs[ 1 ], mins[ 2 ] );
        side1[ 3 ] = ( mins[ 0 ], maxs[ 1 ], maxs[ 2 ] );
        side2[ 0 ] = ( maxs[ 0 ], mins[ 1 ], maxs[ 2 ] );
        side2[ 1 ] = ( maxs[ 0 ], mins[ 1 ], mins[ 2 ] );
        side2[ 2 ] = ( mins[ 0 ], mins[ 1 ], mins[ 2 ] );
        side2[ 3 ] = ( mins[ 0 ], mins[ 1 ], maxs[ 2 ] );
        
        if ( angles != ( 0, 0, 0 ) )
        {
            side1[ 0 ] = origin + rotatevector( origin - side1[ 0 ], angles );
            side1[ 1 ] = origin + rotatevector( origin - side1[ 1 ], angles );
            side1[ 2 ] = origin + rotatevector( origin - side1[ 2 ], angles );
            side1[ 3 ] = origin + rotatevector( origin - side1[ 3 ], angles );
            side2[ 0 ] = origin + rotatevector( origin - side2[ 0 ], angles );
            side2[ 1 ] = origin + rotatevector( origin - side2[ 1 ], angles );
            side2[ 2 ] = origin + rotatevector( origin - side2[ 2 ], angles );
            side2[ 3 ] = origin + rotatevector( origin - side2[ 3 ], angles );
        }
        
        for ( i = 0; i < 4 ; i++ )
        {
            j = i + 1;
            
            if ( j == 4 )
            {
                j = 0;
            }
            
            line( side1[ i ], side1[ j ], color, alpha, depthtest, duration );
            line( side2[ i ], side2[ j ], color, alpha, depthtest, duration );
            line( side1[ i ], side2[ i ], color, alpha, depthtest, duration );
        }
    }

    // Namespace snd
    // Params 7
    // Checksum 0x4facb4fd, Offset: 0x147c
    // Size: 0x56, Type: dev
    function cube( origin, angles, sidelength, color, alpha, depthtest, duration )
    {
        function_84a6aedcf09989b1( origin, angles, sidelength, color, alpha, depthtest, duration );
    }

    // Namespace snd
    // Params 7
    // Checksum 0x48c73584, Offset: 0x14da
    // Size: 0x1da, Type: dev
    function debugcrosshair( origin, size, angles, color, alpha, depthtest, duration )
    {
        forward = ( 1, 0, 0 );
        right = ( 0, 1, 0 );
        up = ( 0, 0, 1 );
        
        if ( !isdefined( size ) )
        {
            size = 16;
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( angles != ( 0, 0, 0 ) )
        {
            forward = anglestoforward( angles );
            right = anglestoright( angles ) * -1;
            up = anglestoup( angles );
        }
        
        half = size * 0.5;
        forward *= half;
        right *= half;
        up *= half;
        mulc = 0.333;
        mulv = ( mulc, mulc, mulc );
        colr = color * mulv + ( 1, 0, 0 );
        colg = color * mulv + ( 0, 1, 0 );
        colb = color * mulv + ( 0, 0, 1 );
        line( origin - forward, origin + forward, colr, alpha, depthtest, duration );
        line( origin - right, origin + right, colg, alpha, depthtest, duration );
        line( origin - up, origin + up, colb, alpha, depthtest, duration );
    }

    // Namespace snd
    // Params 8
    // Checksum 0x21a8dd17, Offset: 0x16bc
    // Size: 0x1f5, Type: dev
    function debugarrow( origin, angles, length, headsize, color, alpha, depthtest, duration )
    {
        assert( isvector( origin ) );
        assert( isvector( angles ) );
        
        if ( !isdefined( length ) )
        {
            length = 12;
        }
        
        if ( !isdefined( headsize ) )
        {
            headsize = 4;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        duration = int( duration ?? 1 );
        arrow_forward = anglestoforward( angles );
        arrowhead_forward = arrow_forward;
        arrowhead_right = anglestoright( angles );
        arrowhead_up = anglestoup( angles );
        arrowhead_down = arrowhead_up;
        arrow_forward = vectorscale( arrow_forward, length );
        arrowhead_forward = vectorscale( arrowhead_forward, length - headsize );
        arrowhead_right = vectorscale( arrowhead_right, headsize );
        arrowhead_up = vectorscale( arrowhead_up, headsize );
        arrowhead_down = vectorscale( arrowhead_down, -1 * headsize );
        o = origin;
        a = o + arrow_forward;
        b = o + arrowhead_forward - arrowhead_right;
        c = o + arrowhead_forward + arrowhead_right;
        d = o + arrowhead_forward + arrowhead_up;
        e = o + arrowhead_forward + arrowhead_down;
        line( o, a, color, alpha, depthtest, duration );
        line( a, b, color, alpha, depthtest, duration );
        line( b, c, color, alpha, depthtest, duration );
        line( c, a, color, alpha, depthtest, duration );
        line( a, d, color, alpha, depthtest, duration );
        line( d, e, color, alpha, depthtest, duration );
        line( e, a, color, alpha, depthtest, duration );
    }

    // Namespace snd
    // Params 6
    // Checksum 0x47971e84, Offset: 0x18b9
    // Size: 0x59, Type: dev
    function linesphere( origin, radius, color, alpha, depthtest, duration )
    {
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        sphere( origin, radius, color, depthtest, duration );
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x2ff979c4, Offset: 0x191a
    // Size: 0xf, Type: dev
    function private function_2fb78ed50698eb21( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd
    // Params 5
    // Checksum 0xb12cae9b, Offset: 0x1931
    // Size: 0xef, Type: dev
    function function_1ad7983cd9ca1761( origin, text, color, height, radius )
    {
        if ( !isvector( origin ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0.72974, 0.72974, 0.72974 );
        }
        
        if ( !isdefined( height ) )
        {
            height = 72;
        }
        
        if ( !isdefined( radius ) )
        {
            radius = 24;
        }
        
        cylinder_end = origin + ( 0, 0, 6 );
        origin_hi = origin + ( 0, 0, height );
        var_1048e6b305706338 = origin + ( 0, 0, height + 16 );
        var_1048e7b30570656b = origin + ( 0, 0, height + 32 );
        cylinder( origin, cylinder_end, radius, color, 0, 1 );
        line( origin, origin_hi, color, 1, 0, 1 );
        print3d( origin_hi, text, color, 1, 1, 1, 1 );
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0xa291f18e, Offset: 0x1a28
    // Size: 0xf, Type: dev
    function private function_d118ad61acb58f35( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd
// Params 1
// Checksum 0x211e3424, Offset: 0x1a3f
// Size: 0x20
function function_9c07adc14f1a9662( screenheight )
{
    var_31ed822fbb721ba1 = 480 / screenheight;
    return var_31ed822fbb721ba1;
}

// Namespace snd
// Params 2
// Checksum 0x8fa726e9, Offset: 0x1a68
// Size: 0x6e
function function_aca0359b14c390c8( coordinates, screensize = function_5e5cdedbd432d043() )
{
    var_31ed822fbb721ba1 = function_9c07adc14f1a9662( screensize[ 1 ] );
    hudwidth = coordinates[ 0 ] * var_31ed822fbb721ba1;
    hudheight = coordinates[ 1 ] * var_31ed822fbb721ba1;
    return [ int( hudwidth ), int( hudheight ) ];
}

// Namespace snd
// Params 2
// Checksum 0xfb982197, Offset: 0x1adf
// Size: 0xa4
function function_be5f20f46dce1b6d( coordinates, screensize = function_5e5cdedbd432d043() )
{
    var_31ed822fbb721ba1 = function_9c07adc14f1a9662( screensize[ 1 ] );
    hudx = coordinates[ 0 ] * var_31ed822fbb721ba1;
    hudy = coordinates[ 1 ] * var_31ed822fbb721ba1;
    screenaspect = screensize[ 0 ] / screensize[ 1 ];
    var_c3a12d05e451f15a = screenaspect * 480;
    hudxoffset = -0.5 * ( var_c3a12d05e451f15a - 640 );
    hudx += hudxoffset;
    return [ hudx, hudy ];
}

/#

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x56cd7641, Offset: 0x1b8c
    // Size: 0xf, Type: dev
    function private function_837b93acc8b68a5b( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x478c5e96, Offset: 0x1ba3
// Size: 0x54
function private _print_main()
{
    if ( isdefined( level.snd.debughudthread ) )
    {
        return;
    }
    
    InvalidOpCode( 0x7 );
    // Unknown operator ( 0x7, t11, Black Ops 7 )
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xbff84798, Offset: 0x1d2d
// Size: 0x165
function private function_ddd3e0b9473cbf52( duration )
{
    hud = undefined;
    now = gettime();
    timeofdeath = duration * 50;
    
    /#
        foreach ( hud in level.snd.debughuds )
        {
            assert( is_object_invalid( hud ) == 0 );
            
            if ( now >= hud.timeofdeath )
            {
                hud.time = now;
                hud.timeofdeath = now + timeofdeath;
                hud.duration = duration;
                return hud;
            }
        }
        
        hud = newhudelem();
        hud.time = now;
        hud.timeofdeath = now + timeofdeath;
        hud.duration = duration;
        index = level.snd.debughuds.size;
        level.snd.debughuds[ index ] = hud;
    #/
    
    return hud;
}

// Namespace snd
// Params 7, eflags: 0x4
// Checksum 0x910e2a65, Offset: 0x1e9b
// Size: 0x231
function private _print_hud( posx, posy, text, color, alpha, scale, duration )
{
    hud_width = 640;
    hud_height = 480;
    hud_aspect = hud_width / hud_height;
    vidresolution = function_5e5cdedbd432d043();
    vidwidth = vidresolution[ 0 ];
    vidheight = vidresolution[ 1 ];
    vidaspect = vidwidth / vidheight;
    widthoffset = -0.5 * ( hud_height * vidaspect - hud_width );
    hudx = posx / vidwidth * hud_width + ( 1 - posx / vidwidth * 0.5 ) * widthoffset;
    hudy = posy / vidheight * hud_height;
    assert( isstruct( level.snd ), "<dev string:x31>" );
    
    if ( isdefined( level.snd.debughuds ) == 0 )
    {
        level.snd.debughuds = [];
    }
    
    level thread _print_main();
    hud = function_ddd3e0b9473cbf52( duration );
    hud.x = hudx;
    hud.y = hudy;
    hud settext( text );
    hud.color = color;
    hud.alpha = alpha;
    hud.fontscale = scale * 0.5;
    hud.font = "smallfixed";
    hud.alignx = "left";
    hud.aligny = "bottom";
    hud.horizalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.xoffset = 0;
    hud.yoffset = 0;
    hud.xpadding = 0;
    hud.ypadding = 0;
}

/#

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x8c9f6d2f, Offset: 0x20d4
    // Size: 0xf, Type: dev
    function private function_ce941f9c670c9bae( var_dafe4dc0a58bbd2c )
    {
        
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x8d7e3068, Offset: 0x20eb
    // Size: 0x2f, Type: dev
    function private function_2db3fdc113451ffd( num )
    {
        if ( num <= 9 && num >= 0 )
        {
            return ( "<dev string:x11c>" + num );
        }
        
        return string( num );
    }

    // Namespace snd
    // Params 3, eflags: 0x4
    // Checksum 0x15448a6, Offset: 0x2122
    // Size: 0x1af, Type: dev
    function private function_725a991d357e1edb( framecount, fps, var_c99898b49b0b1150 )
    {
        assert( isdefined( framecount ) );
        
        if ( isdefined( fps ) == 0 )
        {
            fps = 20;
        }
        
        if ( isdefined( var_c99898b49b0b1150 ) == 0 )
        {
            var_c99898b49b0b1150 = 0;
        }
        
        totalseconds = int( framecount / fps );
        totalminutes = int( totalseconds / 60 );
        totalhours = int( totalminutes / 60 );
        totaldays = int( totalhours / 24 );
        frames = framecount % fps;
        var_fc03b8eb57df7374 = frames / fps * 100;
        seconds = totalseconds % 60;
        minutes = totalminutes % 60;
        hours = totalhours % 60;
        days = totaldays % 99;
        framesstring = function_2db3fdc113451ffd( frames );
        var_e5e946378f423dd5 = function_2db3fdc113451ffd( var_fc03b8eb57df7374 );
        secondsstring = function_2db3fdc113451ffd( seconds );
        minutesstring = function_2db3fdc113451ffd( minutes );
        hoursstring = function_2db3fdc113451ffd( hours );
        daysstring = function_2db3fdc113451ffd( days );
        timecodestring = daysstring + "<dev string:x11e>" + hoursstring + "<dev string:x11e>" + minutesstring + "<dev string:x11e>" + secondsstring;
        
        if ( var_c99898b49b0b1150 == 1 )
        {
            timecodestring += "<dev string:x120>" + var_e5e946378f423dd5;
        }
        else
        {
            timecodestring += "<dev string:x11e>" + framesstring;
        }
        
        return timecodestring;
    }

    // Namespace snd
    // Params 3, eflags: 0x4
    // Checksum 0xcee44e9a, Offset: 0x22d9
    // Size: 0x75, Type: dev
    function private function_5a198af9a9f264a7( initialframecount, serverframecount, fps )
    {
        if ( isdefined( initialframecount ) == 0 )
        {
            initialframecount = 0;
        }
        
        assert( initialframecount >= 0, "<dev string:x122>" );
        framestep = fps / 20;
        framecount = initialframecount;
        framecount += serverframecount * framestep;
        framecount = floor( framecount );
        framecount = int( framecount );
        return framecount;
    }

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x64f8fd9a, Offset: 0x2356
    // Size: 0x411, Type: dev
    function private _timecode_main( initialframecount )
    {
        assert( isdefined( level.snd.timecode ) );
        
        if ( isdefined( initialframecount ) == 0 )
        {
            initialframecount = 0;
        }
        
        assert( initialframecount >= 0, "<dev string:x122>" );
        framestep = level.snd.timecode.fps / 20;
        level.snd.timecode endon( #"hash_cdca16509013054a" );
        level.snd.timecode.isactive = 1;
        level.snd.timecode.framecount = 0;
        level.snd.timecode.initialframecount = initialframecount;
        
        while ( isdefined( level.snd.timecode ) && level.snd.timecode.isactive == 1 )
        {
            posx = level.snd.timecode.posx;
            posy = level.snd.timecode.posy;
            alpha = 1;
            scale = level.snd.timecode.scale;
            framecount = function_5a198af9a9f264a7( initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps );
            timecodestring = function_725a991d357e1edb( framecount, level.snd.timecode.fps );
            print2d( posx, posy, timecodestring, ( 1, 1, 1 ), alpha, scale, 1 );
            
            if ( level.snd.timecode.marksarray.size > 0 )
            {
                posy += scale * 12;
                print2d( posx, posy, "<dev string:x153>", ( 1, 1, 1 ), alpha, scale, 1 );
                posy += scale * 12;
                
                foreach ( mark in level.snd.timecode.marksarray )
                {
                    markstring = mark[ 1 ];
                    markframecount = function_5a198af9a9f264a7( initialframecount, mark[ 0 ], level.snd.timecode.fps );
                    timecode = function_725a991d357e1edb( markframecount, level.snd.timecode.fps );
                    marksstring = timecode + "<dev string:x162>" + markstring + "<dev string:x73>";
                    print2d( posx, posy, marksstring, ( 1, 1, 1 ), alpha, scale, 1 );
                    posy += scale * 12;
                }
            }
            
            level.snd.timecode.framecount += 1;
            waitframe();
        }
    }

    // Namespace snd
    // Params 0
    // Checksum 0x2fd7157b, Offset: 0x276f
    // Size: 0x15c, Type: dev
    function timecode_stop()
    {
        if ( isdefined( level.snd.timecode ) == 0 )
        {
            return;
        }
        
        level.snd.timecode notify( #"hash_cdca16509013054a" );
        level.snd.timecode.isactive = 0;
        level.snd.timecode.isvisible = 0;
        markframecount = function_5a198af9a9f264a7( level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps );
        timecode = function_725a991d357e1edb( markframecount, level.snd.timecode.fps );
        markstring = timecode + "<dev string:x166>";
        println( markstring );
        level.snd.timecode.marksarray = undefined;
        level.snd.timecode = undefined;
    }

    // Namespace snd
    // Params 1
    // Checksum 0xf0c641eb, Offset: 0x28d3
    // Size: 0x154, Type: dev
    function timecode_mark( text )
    {
        if ( isdefined( level.snd.timecode ) == 0 )
        {
            timecode();
        }
        
        marksarrayindex = level.snd.timecode.marksarray.size;
        level.snd.timecode.marksarray[ marksarrayindex ] = [ level.snd.timecode.framecount, text ];
        markframecount = function_5a198af9a9f264a7( level.snd.timecode.initialframecount, level.snd.timecode.framecount, level.snd.timecode.fps );
        timecode = function_725a991d357e1edb( markframecount, level.snd.timecode.fps );
        markstring = timecode + "<dev string:x162>" + text;
        println( markstring );
    }

    // Namespace snd
    // Params 0
    // Checksum 0x7aa4741e, Offset: 0x2a2f
    // Size: 0x94, Type: dev
    function timecode_mark_clear()
    {
        if ( isdefined( level.snd.timecode ) && isdefined( level.snd.timecode.marksarray ) )
        {
            for ( i = 0; i < level.snd.timecode.marksarray.size ; i++ )
            {
                level.snd.timecode.marksarray[ i ] = undefined;
            }
        }
    }

    // Namespace snd
    // Params 6
    // Checksum 0x87ad18c5, Offset: 0x2acb
    // Size: 0x268, Type: dev
    function timecode( var_9d8e288d4d2a1acf, scale, posx, posy, var_c99898b49b0b1150, initialframecount )
    {
        isvisible = 1;
        assert( isstruct( level.snd ), "<dev string:x31>" );
        
        if ( isdefined( level.snd.timecode ) )
        {
            timecode_stop();
        }
        
        assert( isdefined( level.snd.timecode ) == 0 );
        level.snd.timecode = spawnstruct();
        level.snd.timecode.marksarray = [];
        
        if ( isdefined( var_9d8e288d4d2a1acf ) == 0 )
        {
            var_9d8e288d4d2a1acf = 20;
        }
        
        if ( isdefined( scale ) == 0 )
        {
            scale = 2;
        }
        
        scale /= 1;
        vidresolution = function_5e5cdedbd432d043();
        vidwidth = vidresolution[ 0 ];
        vidheight = vidresolution[ 1 ];
        timecodewidth = 84 * scale;
        centerx = vidwidth * 0.5 - timecodewidth * 0.5;
        centery = vidheight * 0.5 - 6;
        
        if ( isdefined( posx ) == 0 )
        {
            posx = centerx;
        }
        
        if ( isdefined( posy ) == 0 )
        {
            centeroffset = 192;
            posy = centery + centeroffset;
        }
        
        level.snd.timecode.posx = posx;
        level.snd.timecode.posy = posy;
        level.snd.timecode.scale = scale;
        level.snd.timecode.fps = var_9d8e288d4d2a1acf;
        level.snd.timecode.isvisible = isvisible;
        level.snd.timecode.var_c99898b49b0b1150 = var_c99898b49b0b1150;
        level.snd.timecode thread _timecode_main( initialframecount );
    }

#/
