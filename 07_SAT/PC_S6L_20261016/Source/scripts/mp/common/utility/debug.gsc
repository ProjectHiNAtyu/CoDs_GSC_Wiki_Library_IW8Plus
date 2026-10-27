// scripts\mp\common\utility\debug.gsc  (hash_030a611dc97bb45c.gscc) (size: 1403 Bytes / 0x57b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7a18131 (3080814897)
// size ...... 1403 (0x57b)
// includes .. 0   (offset: 0x57b)
// strings ... 0   (offset: 0x57b)
// dev strs .. 0   (offset: 0x57b)
// exports ... 6   (offset: 0x39f)
// cseg ...... 0x58 + 0x347 (0x39f)
// imports ... 7   (offset: 0x48f)
// animtree1 . 0   (offset: 0x57b)
// animtree2 . 0   (offset: 0x57b)
#namespace debug;

/#

    // Namespace debug
    // Params 5
    // Checksum 0xe521dcda, Offset: 0x76
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

    // Namespace debug
    // Params 4
    // Checksum 0x1e24eab3, Offset: 0x129
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

    // Namespace debug
    // Params 4
    // Checksum 0x3b4f07a1, Offset: 0x199
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

    // Namespace debug
    // Params 4
    // Checksum 0x9b6b947f, Offset: 0x209
    // Size: 0xf2, Type: dev
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
            waitframe();
        }
    }

    // Namespace debug
    // Params 6
    // Checksum 0x8f708d84, Offset: 0x303
    // Size: 0x9c, Type: dev
    function function_16b0d1fbf9c99e98( var_b35129dcd443c1bf, var_b35128dcd443bf8c, text, var_1ba50906761b2937, color = ( 1, 0, 0 ), scale = 1 )
    {
        drawframes = int( var_1ba50906761b2937 / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            printtoscreen2d( var_b35129dcd443c1bf, var_b35128dcd443bf8c, text, color, scale, 1 );
            waitframe();
        }
    }

#/
