// scripts\mp\common\utility\debug_utility.gsc  (hash_33e3590e7eb028f3.gscc) (size: 2340 Bytes / 0x924 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd44ec26a (3561931370)
// size ...... 2340 (0x924)
// includes .. 0   (offset: 0x8c8)
// strings ... 0   (offset: 0x8c8)
// dev strs .. 6   (offset: 0x8c8)
// exports ... 8   (offset: 0x588)
// cseg ...... 0x58 + 0x530 (0x588)
// imports ... 16  (offset: 0x6c8)
// animtree1 . 0   (offset: 0x924)
// animtree2 . 0   (offset: 0x924)
#namespace debug_utility;

/#

    // Namespace debug_utility
    // Params 5
    // Checksum 0xdd31a585, Offset: 0x76
    // Size: 0xab, Type: dev
    function drawent( ent, radius, forwardlen, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( ent.origin, radius, color );
            line( ent.origin, ent.origin + anglestoforward( ent.angles ) * forwardlen, color );
            waitframe();
        }
    }

    // Namespace debug_utility
    // Params 4
    // Checksum 0x263493ec, Offset: 0x129
    // Size: 0x68, Type: dev
    function drawline( start, end, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            line( start, end, color );
            waitframe();
        }
    }

    // Namespace debug_utility
    // Params 4
    // Checksum 0x35f7efe, Offset: 0x199
    // Size: 0x68, Type: dev
    function drawsphere( origin, radius, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            waitframe();
        }
    }

    // Namespace debug_utility
    // Params 5
    // Checksum 0x7be1e3b0, Offset: 0x209
    // Size: 0x79, Type: dev
    function drawcylinder( origin, radius, height, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            cylinder( origin, origin + ( 0, 0, height ), radius, color );
            waitframe();
        }
    }

    // Namespace debug_utility
    // Params 4
    // Checksum 0xa22824f, Offset: 0x28a
    // Size: 0x17f, Type: dev
    function drawangles( origin, angles, var_1ba50906761b2937, scalar )
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
            print3d( origin + fwd * 12 * scalar, "<dev string:x24>", ( 1, 0, 0 ), 0.5, 0.1, 1, 1 );
            print3d( origin + right * 12 * scalar, "<dev string:x28>", ( 0, 1, 0 ), 0.5, 0.1, 1, 1 );
            print3d( origin + up * 12 * scalar, "<dev string:x2b>", ( 0, 0, 1 ), 0.5, 0.1, 1, 1 );
            waitframe();
        }
    }

    // Namespace debug_utility
    // Params 0
    // Checksum 0x13fc212, Offset: 0x411
    // Size: 0x6a, Type: dev
    function function_ad307e20cea64956()
    {
        timescalecode = getdvarfloat( @"timescale" );
        
        while ( true )
        {
            timescale = getdvarfloat( @"timescale" );
            
            if ( timescalecode != timescale )
            {
                adddebugcommand( "<dev string:x2e>" + timescale );
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

    // Namespace debug_utility
    // Params 3
    // Checksum 0xa9b1d618, Offset: 0x483
    // Size: 0x105, Type: dev
    function waitfordvar( dvar, dvar_type, input_func )
    {
        level notify( "<dev string:x3d>" + getxhashhexname( dvar ) );
        level endon( "<dev string:x3d>" + getxhashhexname( dvar ) );
        setdvarifuninitialized( dvar, "<dev string:x47>" );
        
        while ( true )
        {
            if ( getdvar( dvar, "<dev string:x47>" ) != "<dev string:x47>" )
            {
                var_e1f70dc44f099ae5 = "<dev string:x47>";
                
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
                        var_e1f70dc44f099ae5 = getdvar( dvar, 0 );
                        break;
                }
                
                level thread [[ input_func ]]( var_e1f70dc44f099ae5 );
                setdvar( dvar, "<dev string:x47>" );
            }
            
            wait 0.1;
        }
    }

#/
