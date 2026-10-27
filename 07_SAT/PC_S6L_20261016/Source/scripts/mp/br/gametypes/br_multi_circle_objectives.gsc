// scripts\mp\br\gametypes\br_multi_circle_objectives.gsc  (hash_23f891c802b5e501.gscc) (size: 7637 Bytes / 0x1dd5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64506939 (1682991417)
// size ...... 7637 (0x1dd5)
// includes .. 4   (offset: 0x1d61)
// strings ... 6   (offset: 0x1d81)
// dev strs .. 0   (offset: 0x1dd5)
// exports ... 20  (offset: 0x1521)
// cseg ...... 0xf2 + 0x142f (0x1521)
// imports ... 42  (offset: 0x1841)
// animtree1 . 0   (offset: 0x1dd5)
// animtree2 . 0   (offset: 0x1dd5)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_multi_circle;
#using scripts\mp\flags;

#namespace br_multi_circle_objectives;

// Namespace br_multi_circle_objectives
// Params 0
// Checksum 0x1679c720, Offset: 0x110
// Size: 0x2a
function init()
{
    if ( !br_gametypes::isfeatureenabled( #"hash_7bf340059947e149" ) )
    {
        return;
    }
    
    flags::gameflaginit( "customGametypeCirclesInit", 0 );
    thread function_c89b15a556704b5e();
}

// Namespace br_multi_circle_objectives
// Params 0
// Checksum 0xb430e2a0, Offset: 0x142
// Size: 0x101
function function_c89b15a556704b5e()
{
    logstring( "br_multi_circle_objectives::init" );
    
    if ( getdvarint( @"hash_5bd161f5b9367829", 1 ) != 0 )
    {
        br_gametypes::enablefeature( #"circleearlystart" );
    }
    
    initleveldata();
    waitframe();
    circlespath = undefined;
    
    if ( utility::issharedfuncdefined( #"gametype", #"createmulticircleobjectivesstruct" ) )
    {
        circlespath = utility::callsharedfunc( #"gametype", #"createmulticircleobjectivesstruct" );
    }
    
    if ( !isdefined( circlespath ) )
    {
        return;
    }
    
    function_a743365dfeabe184( circlespath );
    function_edccec581ddbd26e();
    configstruct = spawnstruct();
    configstruct.createfunc = &function_8429a93f6f7e2b93;
    level.br_multi_circle.config = configstruct;
    br_multi_circle::function_f34344b1123f1dc0();
    level.var_897bde4d916801b4 = &function_3a1b611a26a372b0;
    level.br_multi_circle.var_23705baf6673b0ed = &function_23705baf6673b0ed;
    flags::gameflagset( "customGametypeCirclesInit" );
}

// Namespace br_multi_circle_objectives
// Params 0
// Checksum 0x26f4ef9b, Offset: 0x24b
// Size: 0x1ad
function initleveldata()
{
    level.br_multi_circle_objectives_enabled = 1;
    level.br_multi_circle_enabled = 1;
    level.br_circle.circleindex = 0;
    level.br_level.br_movingcirclecount = 0;
    level.br_multi_circle = spawnstruct();
    level.br_multi_circle.circlecount = 2;
    level.br_multi_circle.splitindex = -1;
    level.br_multi_circle.mergeindex = -1;
    level.br_multi_circle.var_18fe6f8a036a96bc = getdvarint( @"hash_744515d8c05e3243", 1 );
    level.br_multi_circle.var_92d86ba4c5a7850c = getdvarint( @"hash_c8f6fbc981b7f489", 0 );
    level.br_multi_circle_objectives = spawnstruct();
    level.br_multi_circle_objectives.var_de5df9e303d8d229 = getdvarfloat( @"scr_br_circle_max_speed", 100 );
    level.br_multi_circle_objectives.var_c4aa4775e1ae79cf = getdvarfloat( @"hash_f181e180ed21f06b", 0.4 );
    level.br_multi_circle_objectives.var_de91781aacefcea2 = getdvarint( @"hash_52c6a551a325bc17", 1 );
    level.br_multi_circle_objectives.minimapradius = getdvarint( @"scr_br_multi_circle_minimap_zoom", 3000 );
    level.br_multi_circle_objectives.var_3fa57a14923c6c01 = getdvarint( @"hash_ad4aea439f3dd156", 15000 );
    level.br_multi_circle.isoverlapping = 1;
}

// Namespace br_multi_circle_objectives
// Params 6
// Checksum 0xd0d54d82, Offset: 0x400
// Size: 0xae
function createmulticircleobjectivesstruct( var_b8efe48081ae9154, positiondurations, transitionduration, nextpositiondelays, circlepositions, circleradius )
{
    circlespath = spawnstruct();
    circlespath.var_b8efe48081ae9154 = var_b8efe48081ae9154;
    circlespath.positiondurations = positiondurations;
    circlespath.transitionduration = transitionduration;
    circlespath.nextpositiondelays = nextpositiondelays;
    circlespath.circlepositions = circlepositions;
    circlespath.circleradius = circleradius;
    circlespath.positionscount = circlepositions.size;
    return circlespath;
}

// Namespace br_multi_circle_objectives
// Params 1
// Checksum 0x5573b552, Offset: 0x4b7
// Size: 0x150
function function_a743365dfeabe184( circlespath )
{
    circlespath.var_7c921fc1424fcff0 = [];
    circlespath.var_1d552cab8510e946 = [];
    
    for ( i = 0; i < circlespath.positionscount - 1 ; i++ )
    {
        var_c6aa261c14946023 = int( min( circlespath.transitionduration, circlespath.positiondurations[ i ] ) );
        var_46749a7fb9c2304b = circlespath.nextpositiondelays[ i ] + circlespath.positiondurations[ i + 1 ] - var_c6aa261c14946023 - 1;
        circlespath.var_7c921fc1424fcff0[ i ] = var_c6aa261c14946023;
        circlecenter = circlespath.circlepositions[ i ];
        circleradius = circlespath.circleradius[ i ];
        var_f71edb48d4daeaaa = circlespath.circlepositions[ i + 1 ];
        var_66593cee77adc495 = circlespath.circleradius[ i + 1 ];
        circlespath.var_1d552cab8510e946[ i ] = function_1429e54ac630ddb7( circlecenter, var_f71edb48d4daeaaa, circleradius, var_66593cee77adc495, var_46749a7fb9c2304b );
    }
    
    level.br_multi_circle_objectives.circlespath = circlespath;
}

// Namespace br_multi_circle_objectives
// Params 5
// Checksum 0x1ce35e75, Offset: 0x60f
// Size: 0x73
function function_1429e54ac630ddb7( centerstart, centertarget, radiusstart, radiustarget, maxduration )
{
    deltaradius = radiusstart - radiustarget;
    circletraveldistance = distance2d( centerstart, centertarget ) + deltaradius;
    return int( min( circletraveldistance / level.br_multi_circle_objectives.var_de5df9e303d8d229, maxduration ) );
}

// Namespace br_multi_circle_objectives
// Params 0
// Checksum 0xe00170be, Offset: 0x68b
// Size: 0x188
function function_edccec581ddbd26e()
{
    level.br_level.br_circlecenters = [];
    level.br_level.br_circleradii = [];
    level.br_level.br_circledelaytimes = [];
    level.br_level.br_circleclosetimes = [];
    circlespath = level.br_multi_circle_objectives.circlespath;
    function_a22f7bfa1aeaf0ba( 0, 0, 0, 0 );
    level.br_level.br_circleradii[ 0 ] += 1;
    circledelaytime = circlespath.var_b8efe48081ae9154 + circlespath.positiondurations[ 0 ];
    circleclosetime = circlespath.var_1d552cab8510e946[ 0 ];
    
    for ( i = 0; i < circlespath.positionscount ; i++ )
    {
        function_a22f7bfa1aeaf0ba( i + 1, i, circledelaytime, circleclosetime );
        
        if ( i < circlespath.positionscount - 1 )
        {
            circledelaytime = circlespath.positiondurations[ i + 1 ] + circlespath.nextpositiondelays[ i ] - circlespath.var_1d552cab8510e946[ i ];
            circleclosetime = circlespath.var_1d552cab8510e946[ i + 1 ];
        }
    }
    
    level.var_fbd5de3a03b0c767 = circlespath.circlepositions[ 0 ];
}

// Namespace br_multi_circle_objectives
// Params 0
// Checksum 0xf0aa7608, Offset: 0x81b
// Size: 0xbe
function function_8429a93f6f7e2b93()
{
    circlespath = level.br_multi_circle_objectives.circlespath;
    
    for ( positionindex = 0; positionindex < circlespath.positionscount ; positionindex++ )
    {
        circleindex = int( max( positionindex - 1, 0 ) );
        level.br_multi_circle.circles[ 0 ].circlecenters[ positionindex ] = circlespath.circlepositions[ circleindex ];
        level.br_multi_circle.circles[ 1 ].circlecenters[ positionindex ] = circlespath.circlepositions[ circleindex ];
    }
}

// Namespace br_multi_circle_objectives
// Params 4
// Checksum 0x8b0acd0e, Offset: 0x8e1
// Size: 0xc0
function function_a22f7bfa1aeaf0ba( circleindex, positionindex, circledelaytime, circleclosetime )
{
    circlespath = level.br_multi_circle_objectives.circlespath;
    level.br_level.br_circledelaytimes[ circleindex ] = circledelaytime;
    level.br_level.br_circleclosetimes[ circleindex ] = circleclosetime;
    level.br_level.br_circleradii[ circleindex ] = circlespath.circleradius[ positionindex ];
    level.br_level.br_circlecenters[ circleindex ] = circlespath.circlepositions[ positionindex ];
}

// Namespace br_multi_circle_objectives
// Params 1
// Checksum 0x27dde74d, Offset: 0x9a9
// Size: 0x1f
function function_23705baf6673b0ed( circleindex )
{
    return level.br_multi_circle.isoverlapping;
}

// Namespace br_multi_circle_objectives
// Params 1
// Checksum 0x976b60ae, Offset: 0x9d1
// Size: 0x22a
function function_3a1b611a26a372b0( var_e4b308e319a579e1 )
{
    level endon( #"game_ended" );
    level endon( #"hash_8a39e2cec964ea5e" );
    
    if ( !level.br_multi_circle_objectives_enabled )
    {
        return;
    }
    
    setomnvar( "ui_br_circle_num", level.br_multi_circle.circlecount );
    br_multi_circle::function_de089a2a18f44505();
    br_multi_circle::function_e00a6f21f4f1fd81();
    level thread br_multi_circle::function_f93ddc35478ce86();
    level thread br_multi_circle::function_ee943ec3c49a1c5f();
    
    if ( var_e4b308e319a579e1 )
    {
        flags::gameflagwait( "infil_animatic_complete" );
    }
    
    level.br_multi_circle_objectives.var_ce01c78f11ec728d = level.br_multi_circle_objectives.minimapradius;
    setomnvar( "ui_br_minimap_radius", level.br_multi_circle_objectives.minimapradius );
    circlespath = level.br_multi_circle_objectives.circlespath;
    level.br_circle.circleinittime = gettime();
    level.br_circle.starttime = gettime();
    flags::gameflaginit( "br_circle_init", 1 );
    level notify( #"br_circle_set" );
    level notify( #"br_circle_started" );
    wait circlespath.var_b8efe48081ae9154;
    level notify( #"hash_7f6b2a7b2d05df3e" );
    
    for ( i = 0; i < circlespath.positionscount - 1 ; i++ )
    {
        wait circlespath.positiondurations[ i ] - circlespath.var_7c921fc1424fcff0[ i ];
        function_c37bd5708ebedb13( i + 1, circlespath.var_7c921fc1424fcff0[ i ] );
        wait circlespath.var_7c921fc1424fcff0[ i ];
        
        if ( i < circlespath.positionscount - 1 )
        {
            level.br_circle.circleindex++;
            level.br_circle.starttime = gettime();
        }
        
        staticcircle( 0 );
        thread function_3cb73264ab1cc93f( i + 1 );
        wait circlespath.nextpositiondelays[ i ];
        level notify( #"br_circle_set" );
    }
}

// Namespace br_multi_circle_objectives
// Params 2
// Checksum 0x745362e3, Offset: 0xc03
// Size: 0x1c8
function function_c37bd5708ebedb13( posindex, duration )
{
    level.br_multi_circle.isoverlapping = 0;
    var_4e5d3835422f5e94 = level.br_multi_circle_objectives.circlespath.circlepositions[ posindex ];
    var_2effe873cbffe063 = level.br_multi_circle_objectives.circlespath.circleradius[ posindex ];
    
    if ( level.br_multi_circle_objectives.var_de91781aacefcea2 )
    {
        var_e4c3f3f9bfdf2397 = level.br_multi_circle_objectives.circlespath.circlepositions[ posindex - 1 ];
        secondcircleradius = level.br_multi_circle_objectives.circlespath.circleradius[ posindex - 1 ];
        circlesdistance = distance2d( var_4e5d3835422f5e94, var_e4c3f3f9bfdf2397 );
        var_29d839d84e23c121 = ( secondcircleradius - circlesdistance - var_2effe873cbffe063 ) / secondcircleradius;
        
        if ( var_29d839d84e23c121 < level.br_multi_circle_objectives.var_c4aa4775e1ae79cf )
        {
            var_b54fb23184327b86 = level.br_multi_circle_objectives.var_c4aa4775e1ae79cf * secondcircleradius + circlesdistance - secondcircleradius;
            var_728c9115d4518500 = ( var_b54fb23184327b86 - var_2effe873cbffe063 ) / 2;
            coeff = var_728c9115d4518500 / circlesdistance;
            deltax = var_e4c3f3f9bfdf2397[ 0 ] - var_4e5d3835422f5e94[ 0 ];
            deltay = var_e4c3f3f9bfdf2397[ 1 ] - var_4e5d3835422f5e94[ 1 ];
            var_4e5d3835422f5e94 = ( var_4e5d3835422f5e94[ 0 ] + deltax * coeff, var_4e5d3835422f5e94[ 1 ] + deltay * coeff, 0 );
            var_2effe873cbffe063 += var_728c9115d4518500;
        }
    }
    
    function_d701436e01153d( 0, duration, var_4e5d3835422f5e94, var_2effe873cbffe063 );
    thread function_de424b8929d0cee1( duration, 1 );
}

// Namespace br_multi_circle_objectives
// Params 1
// Checksum 0x61ee6761, Offset: 0xdd3
// Size: 0xb6
function function_3cb73264ab1cc93f( posindex )
{
    level endon( #"game_ended" );
    level endon( #"hash_8a39e2cec964ea5e" );
    transitionduration = level.br_multi_circle_objectives.circlespath.var_1d552cab8510e946[ posindex - 1 ];
    movecircle( 0, posindex, transitionduration );
    movecircle( 1, posindex, transitionduration );
    thread function_de424b8929d0cee1( level.br_multi_circle_objectives.circlespath.nextpositiondelays[ posindex - 1 ] );
    wait transitionduration;
    staticcircle( 1 );
    level.br_multi_circle.isoverlapping = 1;
}

// Namespace br_multi_circle_objectives
// Params 1
// Checksum 0xe85245e0, Offset: 0xe91
// Size: 0x90
function staticcircle( circleindex )
{
    circleents = level.br_multi_circle.circles[ circleindex ].entdata;
    circleents.dangerui.origin = circleents.safeui.origin;
    waitframe();
    br_multi_circle::function_95fb7c198c90802d( circleents.dangerent, circleents.safeui, circleents.dangerui, 999, 0 );
}

// Namespace br_multi_circle_objectives
// Params 3
// Checksum 0x6ba8dc6c, Offset: 0xf29
// Size: 0x96
function movecircle( circleindex, posindex, duration )
{
    level.br_multi_circle.isoverlapping = 0;
    targetorigin = level.br_multi_circle_objectives.circlespath.circlepositions[ posindex ];
    targetradius = level.br_multi_circle_objectives.circlespath.circleradius[ posindex ];
    function_d701436e01153d( circleindex, duration, targetorigin, targetradius );
}

// Namespace br_multi_circle_objectives
// Params 4
// Checksum 0xba9f4ed0, Offset: 0xfc7
// Size: 0x138
function function_d701436e01153d( circleindex, duration, position, radius )
{
    circleents = level.br_multi_circle.circles[ circleindex ].entdata;
    circleents.safeent.origin = ( position[ 0 ], position[ 1 ], radius );
    circleents.safeui.origin = circleents.safeent.origin;
    circleents.dangerui.origin = circleents.dangerent.origin;
    
    if ( circleindex == 0 )
    {
        function_d0d9006b2d733ef4( position, radius );
    }
    
    if ( duration <= 0 )
    {
        duration = 0.001;
    }
    
    br_multi_circle::function_d7d5b45d6631c960( circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, duration, 0 );
    circleents.dangerent brcirclemoveto( position[ 0 ], position[ 1 ], radius, duration );
}

// Namespace br_multi_circle_objectives
// Params 2
// Checksum 0xf319c810, Offset: 0x1107
// Size: 0xb8
function function_d0d9006b2d733ef4( position, radius )
{
    circleents = level.br_multi_circle.circles[ 1 ].entdata;
    circleents.safeent.origin = ( position[ 0 ], position[ 1 ], radius );
    circleents.safeui.origin = circleents.safeent.origin;
    br_multi_circle::function_95fb7c198c90802d( circleents.dangerent, circleents.safeui, circleents.dangerui, 999, 0 );
}

// Namespace br_multi_circle_objectives
// Params 2
// Checksum 0x7884cf17, Offset: 0x11c7
// Size: 0x215
function function_f1d7541d9064ecfd( positionindex, transitionmaxduration )
{
    level notify( #"hash_8a39e2cec964ea5e" );
    level.br_multi_circle.isoverlapping = 0;
    var_a7b1182971f6c865 = level.br_multi_circle.circles[ 0 ].entdata.dangerent.origin;
    firstcircleradius = level.br_multi_circle.circles[ 0 ].entdata.dangerent.origin[ 2 ];
    var_e4c3f3f9bfdf2397 = level.br_multi_circle.circles[ 1 ].entdata.dangerent.origin;
    secondcircleradius = level.br_multi_circle.circles[ 1 ].entdata.dangerent.origin[ 2 ];
    var_f71edb48d4daeaaa = level.br_multi_circle_objectives.circlespath.circlepositions[ positionindex ];
    var_66593cee77adc495 = level.br_multi_circle_objectives.circlespath.circleradius[ positionindex ];
    var_c6aa261c14946023 = function_1429e54ac630ddb7( var_a7b1182971f6c865, var_f71edb48d4daeaaa, firstcircleradius, var_66593cee77adc495, transitionmaxduration );
    var_361b3fe7c01f67d1 = function_1429e54ac630ddb7( var_e4c3f3f9bfdf2397, var_f71edb48d4daeaaa, secondcircleradius, var_66593cee77adc495, transitionmaxduration );
    transitionduration = int( max( var_c6aa261c14946023, var_361b3fe7c01f67d1 ) );
    movecircle( 0, positionindex, transitionduration );
    movecircle( 1, positionindex, transitionduration );
    thread function_de424b8929d0cee1( transitionduration );
    wait transitionduration;
    staticcircle( 0 );
    staticcircle( 1 );
    level.br_multi_circle.isoverlapping = 1;
}

// Namespace br_multi_circle_objectives
// Params 2
// Checksum 0x6fde0c54, Offset: 0x13e4
// Size: 0x13d
function function_de424b8929d0cee1( totallerptime, iszoomout )
{
    level notify( #"br_multi_circle_objectives_minimap_zoom" );
    level endon( #"br_multi_circle_objectives_minimap_zoom" );
    level endon( #"game_ended" );
    
    if ( iszoomout )
    {
        goalzoom = level.br_multi_circle_objectives.var_3fa57a14923c6c01;
    }
    else
    {
        goalzoom = level.br_multi_circle_objectives.minimapradius;
    }
    
    previouszoom = level.br_multi_circle_objectives.var_ce01c78f11ec728d;
    
    if ( goalzoom == previouszoom )
    {
        return;
    }
    
    zoominterval = 0.05;
    var_f0123deeb34dac4c = totallerptime / zoominterval;
    var_b9be49d42bca1d90 = int( ( previouszoom - goalzoom ) / var_f0123deeb34dac4c );
    var_2f15f801377e7439 = previouszoom;
    
    for ( i = 0; i < var_f0123deeb34dac4c ; i++ )
    {
        var_2f15f801377e7439 -= var_b9be49d42bca1d90;
        level.br_multi_circle_objectives.var_ce01c78f11ec728d = var_2f15f801377e7439;
        setomnvar( "ui_br_minimap_radius", var_2f15f801377e7439 );
        wait zoominterval;
    }
    
    setomnvar( "ui_br_minimap_radius", goalzoom );
    level.br_multi_circle_objectives.var_ce01c78f11ec728d = goalzoom;
}

