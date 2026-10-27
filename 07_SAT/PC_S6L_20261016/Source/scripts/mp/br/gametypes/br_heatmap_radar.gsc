// scripts\mp\br\gametypes\br_heatmap_radar.gsc  (hash_4b0b02a5f9b44291.gscc) (size: 10951 Bytes / 0x2ac7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x622b14b1 (1646990513)
// size ...... 10951 (0x2ac7)
// includes .. 12  (offset: 0x278f)
// strings ... 10  (offset: 0x27ef)
// dev strs .. 47  (offset: 0x286b)
// exports ... 29  (offset: 0x185f)
// cseg ...... 0x140 + 0x171f (0x185f)
// imports ... 90  (offset: 0x1ce7)
// animtree1 . 0   (offset: 0x2ac7)
// animtree2 . 0   (offset: 0x2ac7)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace br_heatmap_radar;

// Namespace br_heatmap_radar
// Params 0, eflags: 0x5
// Checksum 0xbf25524c, Offset: 0x15e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"br_heatmap_radar", undefined, undefined, &post_main );
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0x4
// Checksum 0xa2e9468b, Offset: 0x17f
// Size: 0x153
function private post_main()
{
    utility::flag_wait( "br_init" );
    
    if ( utility::function_1e6de0f4874e10be( level.mapinfobundle.var_6039e370b22ffb23 ) )
    {
        println( "<dev string:x24>" + "<dev string:x2f>" + level.mapinfobundle.mapname + "<dev string:x50>" );
        br_gametypes::disablefeature( #"heatmapradar" );
        return;
    }
    
    var_2b71e6aa095c958b = getdvarint( @"hash_92d7eaf2f69edd5d", 15 );
    var_ee96e7449d738bde = getdvarint( @"hash_74843417c94687ce", 4 );
    level.br_heatmap_radar = { #var_215b477efa2fb666:[], #var_4c50d2ec45f2389b:[], #var_cce8be4e3fa89372:throttle::throttle_initialize( "heatmap_radar_send_value", var_ee96e7449d738bde ), #var_a4c0428fdf195d73:throttle::throttle_initialize( "heatmap_radar_player_count", var_2b71e6aa095c958b ) };
    function_2bf9bb46c9b06cd2();
    
    if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
    {
        return;
    }
    
    setup_bounds();
    callback::add( #"game_ended", &on_game_ended );
    callback::add( #"player_disconnect", &on_player_disconnect );
    
    /#
        if ( getdvarint( @"hash_76aeafb4df0ec162", 0 ) )
        {
            thread function_23a5a633e309f4a5();
        }
        
        debug_init();
    #/
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0x4
// Checksum 0x10d77c10, Offset: 0x2da
// Size: 0x1c0
function private setup_bounds()
{
    level.br_heatmap_radar.minx = min( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    level.br_heatmap_radar.maxx = max( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    level.br_heatmap_radar.miny = min( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    level.br_heatmap_radar.maxy = max( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    level.br_heatmap_radar.var_c7cae9d76aa51087 = ( level.br_heatmap_radar.maxx - level.br_heatmap_radar.minx ) / 10;
    level.br_heatmap_radar.squareheight = ( level.br_heatmap_radar.maxy - level.br_heatmap_radar.miny ) / 10;
    level.br_heatmap_radar.var_b68b74a75282d22f = getdvarint( @"hash_351f56f1fb38e3de", 0 );
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0x4
// Checksum 0xe683bf9e, Offset: 0x4a2
// Size: 0x16b
function private function_2bf9bb46c9b06cd2()
{
    heatmapscriptbundle = function_568f797e7642c672( "heatmapradar", level.mapinfobundle.var_6039e370b22ffb23 );
    level.br_heatmap_radar.var_dd72fd2d06c2908a = [];
    
    if ( !heatmapscriptbundle )
    {
        script::demoforcesre( "[HEATMAP] " + "No 'heatmapradar' asset found. Can't calculate heat levels." );
        br_gametypes::disablefeature( #"heatmapradar" );
        return;
    }
    
    foreach ( heatlevel in heatmapscriptbundle.heatlevels )
    {
        heatstruct = { #color:heatlevel.heatcolor, #threshold:heatlevel.playerthreshold, #var_9953f03f2db65162:function_91361173f24bc49a( heatlevel.heatlevel ), #heatlevel:heatlevel.heatlevel };
        level.br_heatmap_radar.var_dd72fd2d06c2908a[ heatstruct.var_9953f03f2db65162 ] = heatstruct;
    }
    
    br_gametypes::enablefeature( #"heatmapradar" );
}

// Namespace br_heatmap_radar
// Params 1, eflags: 0x4
// Checksum 0x94bf1588, Offset: 0x615
// Size: 0x60
function private function_91361173f24bc49a( var_ca61760747964ee6 )
{
    switch ( var_ca61760747964ee6 )
    {
        case #"none":
            return 0;
        case #"low":
            return 1;
        case #"medium":
            return 2;
        case #"high":
            return 3;
        default:
            return -1;
    }
}

// Namespace br_heatmap_radar
// Params 1, eflags: 0x4
// Checksum 0x361daf86, Offset: 0x67d
// Size: 0x7d
function private get_heat_level( playerscount = 0 )
{
    var_dd72fd2d06c2908a = level.br_heatmap_radar.var_dd72fd2d06c2908a;
    
    for ( i = var_dd72fd2d06c2908a.size - 1; i >= 0 ; i-- )
    {
        if ( playerscount >= var_dd72fd2d06c2908a[ i ].threshold )
        {
            return i;
        }
    }
    
    assertmsg( "<dev string:x24>" + "<dev string:x73>" + playerscount );
    return 0;
}

// Namespace br_heatmap_radar
// Params 2, eflags: 0x4
// Checksum 0xa2ac03f6, Offset: 0x703
// Size: 0x120
function private get_player_zone_index( player, usecache = 0 )
{
    if ( usecache )
    {
        return level.br_heatmap_radar.var_4c50d2ec45f2389b[ player.clientid ];
    }
    
    if ( !player::isreallyalive( player ) || player br_public::isplayerinorgoingtogulag() )
    {
        index = undefined;
    }
    else
    {
        playerorigin = player.origin;
        var_55e3a4521f2cd1c5 = int( ( playerorigin[ 0 ] - level.br_heatmap_radar.minx ) / level.br_heatmap_radar.var_c7cae9d76aa51087 );
        var_717749b47f47f949 = int( ( level.br_heatmap_radar.maxy - playerorigin[ 1 ] ) / level.br_heatmap_radar.squareheight );
        index = var_717749b47f47f949 * 10 + var_55e3a4521f2cd1c5;
    }
    
    level.br_heatmap_radar.var_4c50d2ec45f2389b[ player.clientid ] = index;
    return index;
}

// Namespace br_heatmap_radar
// Params 0
// Checksum 0x977a8c50, Offset: 0x82c
// Size: 0x109
function function_7f9653b9fb6c7563()
{
    /#
        if ( level.br_heatmap_radar.debug.var_77830616e6f38042 )
        {
            return;
        }
    #/
    
    var_1d67c8a649e17480 = [];
    
    foreach ( player in level.players )
    {
        var_4c50d2ec45f2389b = get_player_zone_index( player );
        
        if ( !isdefined( var_4c50d2ec45f2389b ) )
        {
            continue;
        }
        
        if ( !isdefined( var_1d67c8a649e17480[ var_4c50d2ec45f2389b ] ) )
        {
            var_1d67c8a649e17480[ var_4c50d2ec45f2389b ] = 0;
        }
        
        var_1d67c8a649e17480[ var_4c50d2ec45f2389b ] += 1;
        throttle::throttle_wait_in_queue( level.br_heatmap_radar.var_a4c0428fdf195d73, self );
    }
    
    level.br_heatmap_radar.var_1d67c8a649e17480 = var_1d67c8a649e17480;
    return var_1d67c8a649e17480;
}

// Namespace br_heatmap_radar
// Params 1, eflags: 0x4
// Checksum 0x38be5a12, Offset: 0x93e
// Size: 0x18c
function private function_a28887b2b498c7a9( player )
{
    var_1d67c8a649e17480 = level.br_heatmap_radar.var_1d67c8a649e17480;
    
    if ( !var_1d67c8a649e17480 || var_1d67c8a649e17480.size == 0 )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x9a>" );
        return [];
    }
    
    var_17dbe35c7643ce9a = !level.br_heatmap_radar.var_b68b74a75282d22f && !level.br_heatmap_radar.debug.var_77830616e6f38042;
    
    if ( var_17dbe35c7643ce9a )
    {
        var_1d67c8a649e17480 = arraycopy( var_1d67c8a649e17480 );
        
        foreach ( teammate in teams::getteamdata( player.team, "players" ) )
        {
            var_1f80e586a6a6d6c0 = get_player_zone_index( teammate, 1 );
            
            if ( !( isdefined( var_1f80e586a6a6d6c0 ) && isdefined( var_1d67c8a649e17480[ var_1f80e586a6a6d6c0 ] ) ) )
            {
                continue;
            }
            
            assert( var_1d67c8a649e17480[ var_1f80e586a6a6d6c0 ] > 0 );
            var_1d67c8a649e17480[ var_1f80e586a6a6d6c0 ] -= 1;
        }
    }
    
    var_f0447658b4a74d35 = [];
    
    for ( i = 0; i < 100 ; i++ )
    {
        var_f0447658b4a74d35[ i ] = get_heat_level( var_1d67c8a649e17480[ i ] );
    }
    
    return var_f0447658b4a74d35;
}

// Namespace br_heatmap_radar
// Params 2
// Checksum 0xb4a65ccd, Offset: 0xad3
// Size: 0x8b
function function_42cfd66ef29d2b0b( player, timeout )
{
    if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player function_35031d9b290ddfc1();
    
    if ( timeout > 0 )
    {
        player utility::waittill_any_timeout( timeout, "death" );
    }
    else
    {
        player waittill( #"death" );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player function_1316a52efc290b9e();
}

// Namespace br_heatmap_radar
// Params 1
// Checksum 0xc22f76f0, Offset: 0xb66
// Size: 0xb3
function function_c7604d2fe1e5fb53( var_d33a7950f83061ce )
{
    if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player function_99a884c31446d940() )
        {
            continue;
        }
        
        player function_1316a52efc290b9e( var_d33a7950f83061ce );
    }
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0x4
// Checksum 0xd949ba51, Offset: 0xc21
// Size: 0xa8
function private function_247dd2fef0139b98()
{
    if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player function_99a884c31446d940() )
        {
            continue;
        }
        
        player function_35031d9b290ddfc1();
    }
}

// Namespace br_heatmap_radar
// Params 0
// Checksum 0x2fa464f, Offset: 0xcd1
// Size: 0x120
function function_a45e030c43a4821()
{
    foreach ( team in level.activeteams )
    {
        teamplayers = teams::getteamdata( team, "players" );
        
        foreach ( player in teamplayers )
        {
            player function_e92a943e2352c335();
        }
        
        throttle::throttle_wait_in_queue( level.br_heatmap_radar.var_cce8be4e3fa89372, self );
    }
    
    self notify( #"hash_d5b90ee96fa2305e" );
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0x4
// Checksum 0xae24cf3e, Offset: 0xdf9
// Size: 0x125
function private function_e92a943e2352c335()
{
    team = level.br_heatmap_radar.var_b68b74a75282d22f ? "global" : self.team;
    var_984dae912be84fcc = level.br_heatmap_radar.var_215b477efa2fb666[ team ];
    
    if ( !var_984dae912be84fcc )
    {
        var_f0447658b4a74d35 = function_a28887b2b498c7a9( self );
        var_2a79e7dd5ac6b1c = 0;
        var_da7a793cccc9ab9a = 0;
        
        for ( i = 0; i < var_f0447658b4a74d35.size ; i++ )
        {
            if ( !isdefined( var_984dae912be84fcc[ var_2a79e7dd5ac6b1c ] ) )
            {
                var_984dae912be84fcc[ var_2a79e7dd5ac6b1c ] = 0;
            }
            
            var_984dae912be84fcc[ var_2a79e7dd5ac6b1c ] |= ( var_f0447658b4a74d35[ i ] & 3 ) << var_da7a793cccc9ab9a;
            var_da7a793cccc9ab9a += 2;
            
            if ( var_da7a793cccc9ab9a == 32 )
            {
                var_da7a793cccc9ab9a = 0;
                var_2a79e7dd5ac6b1c++;
            }
        }
        
        level.br_heatmap_radar.var_215b477efa2fb666[ team ] = var_984dae912be84fcc;
    }
    
    assert( var_984dae912be84fcc.size == 7 );
    
    for ( i = 0; i < var_984dae912be84fcc.size ; i++ )
    {
        omnvar_utility::function_85d5f88af471ac4b( "br_heatmap_radar_heat_levels_packed_" + string( i + 1 ), 0, 32, var_984dae912be84fcc[ i ] );
    }
}

// Namespace br_heatmap_radar
// Params 0
// Checksum 0xf09c17, Offset: 0xf26
// Size: 0x17
function function_cf339fc85c7a9b16()
{
    level.br_heatmap_radar.var_215b477efa2fb666 = [];
}

// Namespace br_heatmap_radar
// Params 1, eflags: 0x4
// Checksum 0x3700ed28, Offset: 0xf45
// Size: 0x15
function private on_game_ended( params )
{
    function_c7604d2fe1e5fb53( 1 );
}

// Namespace br_heatmap_radar
// Params 1, eflags: 0x4
// Checksum 0xde9f62fb, Offset: 0xf62
// Size: 0x14
function private on_player_disconnect( params )
{
    self function_1316a52efc290b9e( 1 );
}

// Namespace br_heatmap_radar
// Params 0
// Checksum 0x7615a5d6, Offset: 0xf7e
// Size: 0x20
function function_af96b137d5b71cfa()
{
    if ( level.br_heatmap_radar.var_4e94b83a2d065b10 )
    {
        return;
    }
    
    thread function_7d56881fb632f225();
}

// Namespace br_heatmap_radar
// Params 0, eflags: 0xc
// Checksum 0xbe9890ef, Offset: 0xfa6
// Size: 0xcc
function private function_7d56881fb632f225()
{
    self notify( #"hash_96684797ceb56609" );
    self endon( #"hash_96684797ceb56609" );
    
    if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    level endon( #"game_ended" );
    level.br_heatmap_radar.var_4e94b83a2d065b10 = 1;
    
    while ( true )
    {
        starttime = gettime();
        function_cf339fc85c7a9b16();
        function_7f9653b9fb6c7563();
        function_a45e030c43a4821();
        duration = ( gettime() - starttime ) / 1000;
        
        if ( duration > 5 )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x136>" + duration );
            duration = 5;
        }
        
        wait floor( 5 - duration );
    }
}

// Namespace br_heatmap_radar
// Params 0
// Checksum 0x7ce68387, Offset: 0x107a
// Size: 0x28, Type: bool
function function_99a884c31446d940()
{
    return player::isreallyalive( self ) && !br_public::isplayerinorgoingtogulag() && !isbot( self ) && !self isplayerheadless();
}

/#

    // Namespace br_heatmap_radar
    // Params 0, eflags: 0x4
    // Checksum 0x53a50b3d, Offset: 0x10ab
    // Size: 0x91, Type: dev
    function private debug_init()
    {
        level.br_heatmap_radar.debug = { #var_b316a825aa3d4d8f:[] };
        devgui::function_9082edeb5db93280( "<dev string:x19a>" );
        devgui::add_devgui_func( "<dev string:x1a6>", "<dev string:x1c0>", &function_79bae3f7801719af );
        devgui::add_devgui_func( "<dev string:x1da>", "<dev string:x207>", &function_317e2b471c0e1d6f );
        devgui::add_devgui_func( "<dev string:x222>", "<dev string:x23d>", &function_466097d3e1ca7a3a );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x277>", &function_8ca6bd66a38f8e40, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_heatmap_radar
    // Params 0, eflags: 0x4
    // Checksum 0x64a820a7, Offset: 0x1144
    // Size: 0xbb, Type: dev
    function private function_79bae3f7801719af()
    {
        if ( br_gametypes::isfeaturedisabled( #"heatmapradar" ) )
        {
            assertmsg( "<dev string:xd0>" );
            return;
        }
        
        level.br_heatmap_radar.debug.var_21b93337cd359b97 = !level.br_heatmap_radar.debug.var_21b93337cd359b97;
        
        if ( level.br_heatmap_radar.debug.var_21b93337cd359b97 )
        {
            function_af96b137d5b71cfa();
            function_247dd2fef0139b98();
            iprintlnbold( "<dev string:x24>" + "<dev string:x29e>" );
            return;
        }
        
        function_c7604d2fe1e5fb53( 1 );
        iprintlnbold( "<dev string:x24>" + "<dev string:x2c4>" );
    }

    // Namespace br_heatmap_radar
    // Params 0, eflags: 0x4
    // Checksum 0x6b6d63f2, Offset: 0x1207
    // Size: 0xef, Type: dev
    function private function_317e2b471c0e1d6f()
    {
        player = level.players[ 0 ];
        InvalidOpCode( 0x83, int( player.origin[ 0 ] ), int( player.origin[ 1 ] ) );
        // Unknown operator ( 0x83, t11, Black Ops 7 )
    }

    // Namespace br_heatmap_radar
    // Params 1, eflags: 0x4
    // Checksum 0xddc4bd53, Offset: 0x12fe
    // Size: 0x65, Type: dev
    function private function_1a2ad3a13f0e2f51( params )
    {
        player = level.players[ 0 ];
        InvalidOpCode( 0x83, int( params[ 0 ] ), int( params[ 1 ] ) );
        // Unknown operator ( 0x83, t11, Black Ops 7 )
    }

    // Namespace br_heatmap_radar
    // Params 0
    // Checksum 0x2ff812f5, Offset: 0x136b
    // Size: 0x120, Type: dev
    function function_5827120edeb585e6()
    {
        zonecount = 100;
        
        if ( !isdefined( var_1d67c8a649e17480 ) )
        {
            var_1d67c8a649e17480 = [];
        }
        
        for ( i = 0; i < zonecount ; i++ )
        {
            var_1d67c8a649e17480[ i ] = 0;
        }
        
        var_61978cf6e46a5d72 = 100;
        var_477c82ecfd8f08d9 = 3;
        
        for ( i = 0; i < var_61978cf6e46a5d72 ; i++ )
        {
            randomangle = ( 0, randomfloat( 360 ), 0 );
            var_e73b1f774267127e = anglestoforward( randomangle );
            var_8cc686012ff8bdd9 = var_e73b1f774267127e * randomfloat( var_477c82ecfd8f08d9 );
            centeroffset = 5;
            var_9156559c80090913 = centeroffset + int( floor( var_8cc686012ff8bdd9[ 0 ] ) );
            var_9156549c800906e0 = centeroffset + int( floor( var_8cc686012ff8bdd9[ 1 ] ) );
            index = var_9156559c80090913 + 10 * var_9156549c800906e0;
            index = int( clamp( index, 0, 99 ) );
            var_1d67c8a649e17480[ index ] += 1;
        }
        
        level.br_heatmap_radar.var_1d67c8a649e17480 = var_1d67c8a649e17480;
    }

    // Namespace br_heatmap_radar
    // Params 0
    // Checksum 0x29bea15c, Offset: 0x1493
    // Size: 0x108, Type: dev
    function function_466097d3e1ca7a3a()
    {
        level.br_heatmap_radar.debug.var_77830616e6f38042 = !level.br_heatmap_radar.debug.var_77830616e6f38042;
        
        if ( level.br_heatmap_radar.debug.var_77830616e6f38042 )
        {
            function_5827120edeb585e6();
        }
        else
        {
            function_7f9653b9fb6c7563();
        }
        
        function_cf339fc85c7a9b16();
        
        foreach ( player in level.players )
        {
            if ( !player function_99a884c31446d940() )
            {
                continue;
            }
            
            player function_a45e030c43a4821();
            player function_f338d3d650732316();
        }
    }

    // Namespace br_heatmap_radar
    // Params 0, eflags: 0xc
    // Checksum 0x5237ec49, Offset: 0x15a3
    // Size: 0x28d, Type: dev
    function private function_8ca6bd66a38f8e40()
    {
        self notify( #"hash_68602aff2b24c93f" );
        self endon( #"hash_68602aff2b24c93f" );
        level endon( #"game_ended" );
        var_1d67c8a649e17480 = function_7f9653b9fb6c7563();
        var_d0feb145578f55b8 = int( ceil( 1000 / level.frameduration ) );
        var_b0cb7105c3c48743 = [ "<dev string:x35b>", "<dev string:x35d>", "<dev string:x35f>", "<dev string:x361>", "<dev string:x363>", "<dev string:x365>", "<dev string:x367>", "<dev string:x369>", "<dev string:x36b>", "<dev string:x36d>" ];
        var_fb42aed701096bad = [ "<dev string:x36f>", "<dev string:x371>", "<dev string:x373>", "<dev string:x375>", "<dev string:x377>", "<dev string:x379>", "<dev string:x37b>", "<dev string:x37d>", "<dev string:x37f>", "<dev string:x381>" ];
        var_77c08ec6c5e1303b = ( 0, 0, 1 );
        var_9938f92d5ec736c7 = 45;
        var_270f4c458ccbc479 = 500;
        var_270f4b458ccbc246 = 100;
        printduration = var_d0feb145578f55b8;
        var_dd72fd2d06c2908a = level.br_heatmap_radar.var_dd72fd2d06c2908a;
        
        while ( true )
        {
            for ( i = 0; i < 10 ; i++ )
            {
                printtoscreen2d( var_270f4c458ccbc479 + i * var_9938f92d5ec736c7, var_270f4b458ccbc246 - var_9938f92d5ec736c7, var_b0cb7105c3c48743[ i ], var_77c08ec6c5e1303b, 1, printduration );
                printtoscreen2d( var_270f4c458ccbc479 - var_9938f92d5ec736c7, var_270f4b458ccbc246 + i * var_9938f92d5ec736c7, var_fb42aed701096bad[ i ], var_77c08ec6c5e1303b, 1, printduration );
            }
            
            var_f0447658b4a74d35 = function_a28887b2b498c7a9( level.players[ 0 ] );
            
            for ( k = 0; k < 100 ; k++ )
            {
                heatlevel = var_f0447658b4a74d35[ k ];
                var_a8ff38a1ab23f50a = utility::function_c5d9978d36c9459e( var_dd72fd2d06c2908a[ heatlevel ].color );
                var_440b94c5a9719a61 = ( var_a8ff38a1ab23f50a[ 0 ], var_a8ff38a1ab23f50a[ 1 ], var_a8ff38a1ab23f50a[ 2 ] );
                printtoscreen2d( var_270f4c458ccbc479 + k % 10 * var_9938f92d5ec736c7, var_270f4b458ccbc246 + int( k / 10 ) * var_9938f92d5ec736c7, heatlevel + "<dev string:x383>" + ( var_1d67c8a649e17480[ k ] ?? 0 ) + "<dev string:x385>", var_440b94c5a9719a61, 1, var_d0feb145578f55b8 );
            }
            
            wait 1;
        }
    }

    // Namespace br_heatmap_radar
    // Params 0, eflags: 0x4
    // Checksum 0x3e73e59c, Offset: 0x1838
    // Size: 0x27, Type: dev
    function private function_23a5a633e309f4a5()
    {
        level endon( #"game_ended" );
        flags::function_2f3408423ccc9b2e( "<dev string:x388>" );
        wait 3;
        function_79bae3f7801719af();
    }

#/
