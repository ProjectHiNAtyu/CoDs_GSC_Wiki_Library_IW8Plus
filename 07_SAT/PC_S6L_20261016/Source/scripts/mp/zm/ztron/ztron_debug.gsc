// scripts\mp\zm\ztron\ztron_debug.gsc  (hash_26449e17ccb5e71b.gscc) (size: 4120 Bytes / 0x1018 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xefca7278 (4023022200)
// size ...... 4120 (0x1018)
// includes .. 0   (offset: 0xfa0)
// strings ... 2   (offset: 0xfa0)
// dev strs .. 6   (offset: 0xfb8)
// exports ... 14  (offset: 0xa50)
// cseg ...... 0x70 + 0x9e0 (0xa50)
// imports ... 26  (offset: 0xc80)
// animtree1 . 0   (offset: 0x1018)
// animtree2 . 0   (offset: 0x1018)
#namespace ztron_debug;

/#

    // Namespace ztron_debug
    // Params 5
    // Checksum 0x3ef9cd66, Offset: 0x8e
    // Size: 0xc4, Type: dev
    function drawent( ent, radius, forwardlen, drawtimeseconds = 0.05, color )
    {
        ent endon( #"death" );
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( ent.origin, radius, color );
            line( ent.origin, ent.origin + anglestoforward( ent.angles ) * forwardlen, color );
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 4
    // Checksum 0x6f868f29, Offset: 0x15a
    // Size: 0x88, Type: dev
    function drawline( start, end, drawtimeseconds = 0.05, color = ( 1, 0, 0 ) )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            line( start, end, color );
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 6
    // Checksum 0x23deadbd, Offset: 0x1ea
    // Size: 0x15f, Type: dev
    function draw_circle( center, radius, color, alpha, depthtest, duration = 1 )
    {
        circle_sides = 24;
        drawframes = int( duration / level.framedurationseconds );
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
            
            line( start, end, color, alpha, depthtest, drawframes );
        }
    }

    // Namespace ztron_debug
    // Params 6
    // Checksum 0x14eaa291, Offset: 0x351
    // Size: 0xa7, Type: dev
    function drawsphere( origin, radius, drawtimeseconds = 0.05, color, text, var_87c66310656995ee )
    {
        if ( isdefined( var_87c66310656995ee ) )
        {
            self endon( var_87c66310656995ee );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            
            if ( text )
            {
                print3d( origin, text, color, 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 5
    // Checksum 0x3253ff75, Offset: 0x400
    // Size: 0x85, Type: dev
    function drawcylinder( origin, radius, height, drawtimeseconds = 0.05, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            cylinder( origin, origin + ( 0, 0, height ), radius, color );
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 4
    // Checksum 0x558c4c5f, Offset: 0x48d
    // Size: 0xfe, Type: dev
    function drawangles( origin, angles, var_1ba50906761b2937 = 0.05, scalar )
    {
        if ( !isdefined( scalar ) )
        {
            scalar = 1;
        }
        
        drawframes = int( var_1ba50906761b2937 / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            fwd = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
            line( origin, origin + fwd * 12 * scalar, ( 1, 0, 0 ) );
            line( origin, origin + right * 12 * scalar, ( 0, 1, 0 ) );
            line( origin, origin + up * 12 * scalar, ( 0, 0, 1 ) );
            waitframe();
        }
    }

#/

// Namespace ztron_debug
// Params 5
// Checksum 0xfc9066d8, Offset: 0x593
// Size: 0xad
function drawtrigger( color = ( 0, 1, 0 ), depthtest = 0, duration = 0, drawsolid = 0, interiorcolor = ( 1, 0, 0 ) )
{
    self notify( #"hash_b11ee5b2936d7e0e" );
    self endon( #"hash_b11ee5b2936d7e0e" );
    
    /#
        self endon( #"death" );
        
        while ( true )
        {
            drawtrigger( self, color, depthtest, duration, drawsolid, interiorcolor );
            waitframe();
        }
    #/
}

/#

    // Namespace ztron_debug
    // Params 0
    // Checksum 0xa8c3cd90, Offset: 0x648
    // Size: 0x6a, Type: dev
    function function_ad307e20cea64956()
    {
        timescalecode = getdvarfloat( @"timescale" );
        
        while ( true )
        {
            timescale = getdvarfloat( @"timescale" );
            
            if ( timescalecode != timescale )
            {
                adddebugcommand( "<dev string:x24>" + timescale );
                timescalecode = timescale;
            }
            
            if ( timescale >= 1 )
            {
                wait 0.25;
                continue;
            }
            
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 3
    // Checksum 0x63270d87, Offset: 0x6ba
    // Size: 0x105, Type: dev
    function waitfordvar( dvar, dvar_type, input_func )
    {
        level notify( "<dev string:x33>" + getxhashhexname( dvar ) );
        level endon( "<dev string:x33>" + getxhashhexname( dvar ) );
        setdvarifuninitialized( dvar, "<dev string:x3d>" );
        
        while ( true )
        {
            if ( getdvar( dvar, "<dev string:x3d>" ) != "<dev string:x3d>" )
            {
                var_e1f70dc44f099ae5 = "<dev string:x3d>";
                
                switch ( dvar_type )
                {
                    case #"hash_4730906c2f53f03e":
                        var_e1f70dc44f099ae5 = getdvarint( dvar );
                        break;
                    case #"hash_3e4a6f464c850b65":
                        var_e1f70dc44f099ae5 = getdvarfloat( dvar );
                        break;
                    case #"hash_a08ace5b3c23c762":
                        var_e1f70dc44f099ae5 = getdvarvector( dvar );
                        break;
                    case #"hash_2ac140ce3b5ea398":
                    default:
                        var_e1f70dc44f099ae5 = getdvarint( dvar, 0 );
                        break;
                }
                
                level thread [[ input_func ]]( var_e1f70dc44f099ae5 );
                setdvar( dvar, "<dev string:x3d>" );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace ztron_debug
// Params 2
// Checksum 0xf322e63b, Offset: 0x7c7
// Size: 0x58
function debugmsg( msg, log = 0 )
{
    if ( log )
    {
        logstring( "ZTRON DEBUG(" + gettime() + ") : " + msg );
        return;
    }
    
    println( "<dev string:x56>" + gettime() + "<dev string:x63>" + msg );
}

/#

    // Namespace ztron_debug
    // Params 6
    // Checksum 0xe138115c, Offset: 0x827
    // Size: 0x9f, Type: dev
    function function_7a494955e7b24aa3( posx, posy, text, color = ( 1, 1, 1 ), var_1ba50906761b2937 = 3, scale = 1 )
    {
        if ( !isdefined( text ) || text == "<dev string:x3d>" )
        {
            return;
        }
        
        drawframes = int( var_1ba50906761b2937 / level.framedurationseconds );
        printtoscreen2d( posx, posy, text, color, scale, drawframes );
    }

    // Namespace ztron_debug
    // Params 6
    // Checksum 0x402506c2, Offset: 0x8ce
    // Size: 0xdd, Type: dev
    function function_cadec874ded26d36( text, color = ( 1, 1, 1 ), offset = ( 0, 0, 100 ), scale = 1, var_1ba50906761b2937 = 3, var_87c66310656995ee )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_e60755241178f016" );
        
        if ( isdefined( var_87c66310656995ee ) )
        {
            self endon( var_87c66310656995ee );
        }
        
        for ( drawframes = int( var_1ba50906761b2937 / level.framedurationseconds ); drawframes ; drawframes-- )
        {
            print3d( self.origin + offset, text, color, 1, scale, 1, 1 );
            waitframe();
        }
    }

    // Namespace ztron_debug
    // Params 3
    // Checksum 0xa9bf1004, Offset: 0x9b3
    // Size: 0x9d, Type: dev
    function function_9f9ad9887fd5d1c5( color = ( 1, 1, 0 ), offset = ( 0, 0, 120 ), scale = 1 )
    {
        self endon( #"death" );
        self endon( #"hash_43c5f10e3b6aa35f" );
        
        while ( true )
        {
            print3d( self.origin + offset, "<dev string:x68>" + self.health, color, 1, scale, 1, 1 );
            waitframe();
        }
    }

#/
