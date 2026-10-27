// script_5d980a4e22af86d  (hash_05d980a4e22af86d.gscc) (size: 19506 Bytes / 0x4c32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49c2da4d (1237506637)
// size ...... 19506 (0x4c32)
// includes .. 14  (offset: 0x49ba)
// strings ... 26  (offset: 0x4a2a)
// dev strs .. 4   (offset: 0x4c02)
// exports ... 52  (offset: 0x31ee)
// cseg ...... 0x288 + 0x2f66 (0x31ee)
// imports ... 131 (offset: 0x3a0e)
// animtree1 . 0   (offset: 0x4c32)
// animtree2 . 0   (offset: 0x4c32)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;

#namespace namespace_41f6b71d9bf353d1;

// Namespace namespace_41f6b71d9bf353d1
// Params 0, eflags: 0x5
// Checksum 0xf99ce3ef, Offset: 0x2a6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d61f85b223ba7bd2", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0, eflags: 0x4
// Checksum 0x8fb64b50, Offset: 0x2cf
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_AREADENIAL", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_AREADENIAL" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xbe64c07c, Offset: 0x2ff
// Size: 0x17b
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.waitfunc = &waitfunc;
    eventbundle = getscriptbundle( hashcat( %"hash_101cabd781153f80", eventinfo.event ) );
    customproperties = namespace_9085ae059032a84f::function_9129cd8075c85c09( eventbundle );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "pe_areadenial_name" + "_" + eventinfo.event ] ) )
    {
        game[ "dialog" ][ "pe_areadenial_name" + "_" + eventinfo.event ] = customproperties.namevo;
        game[ "dialog" ][ "pe_areadenial_event_begin" + "_" + eventinfo.event ] = customproperties.eventvo;
        game[ "dialog" ][ "pe_areadenial_enter_detection_radius" + "_" + eventinfo.event ] = customproperties.radiusvo;
        game[ "dialog" ][ "pe_areadenial_enter_drone_path" + "_" + eventinfo.event ] = customproperties.pathvo;
        game[ "dialog" ][ "pe_areadenial_new_sweep" + "_" + eventinfo.event ] = customproperties.var_5507340296b4983b;
    }
    
    if ( !isdefined( level.var_11a4edb43fa8ba1c ) )
    {
        level.var_11a4edb43fa8ba1c = spawnstruct();
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x7254c11b, Offset: 0x482
// Size: 0x75
function activity_type_init()
{
    if ( getdvarint( @"hash_d2210a829f0a2d4f", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AREADENIAL", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AREADENIAL", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AREADENIAL", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AREADENIAL", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &function_19cf511c86313288, "BR_PUBLIC_EVENT_AREADENIAL" );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xbcd694e4, Offset: 0x4ff
// Size: 0x4a
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( activity_instance );
    initvariables();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x77bd63cc, Offset: 0x551
// Size: 0xcd
function initvariables()
{
    self.var_2e1ed8612ee39a2c = getscriptbundle( hashcat( %"hash_684724f6313c6a6", self.var_332f929de1894b2b.var_552adb2421b3a658 ) );
    self.var_2e1ed8612ee39a2c.fleetformations = function_7088bb1c7ffa7904( self.var_2e1ed8612ee39a2c.fleetformations, self.var_332f929de1894b2b.var_a6d3e8d24058dc17 );
    
    if ( self.var_332f929de1894b2b.var_d6cee19e307e1863 != 0 )
    {
        self.var_a315b3194aee145b = self.var_332f929de1894b2b.var_d6cee19e307e1863;
    }
    else
    {
        self.var_a315b3194aee145b = parachute::getc130height();
    }
    
    self.detectedplayers = [];
    self.var_faf6d07a43ff6f7d = [];
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x573808c1, Offset: 0x626
// Size: 0x37
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    function_48bec679ab02498f();
    thread function_4830f4ec0fb188d3();
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xa975094c, Offset: 0x665
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xcc4865b9, Offset: 0x693
// Size: 0x28
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    self notify( #"hash_57e3556f0eb5a22d" );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xfe20cd55, Offset: 0x6c3
// Size: 0x2a5
function function_4830f4ec0fb188d3()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    thread function_d88a81c66534637d();
    thread function_1ab9b9719e42d9b4();
    radius = self.var_332f929de1894b2b.var_444064bd00a3306;
    height = self.var_a315b3194aee145b;
    var_19516aa35144c8f3 = [];
    var_6da238b0346d41ce = [];
    var_142b7745111ea0f8 = 0;
    var_ed85936c77c57975 = self.var_332f929de1894b2b.var_4bd9e0c5cb4212f;
    
    for ( i = 0; i < var_ed85936c77c57975 ; i++ )
    {
        var_3ef4acbfe84ee35a = function_3cf1f9577d55f8be();
        var_3b625351adb0f5db = function_d5390f3a7088e5e7( var_3ef4acbfe84ee35a );
        var_6da238b0346d41ce[ i ] = var_3b625351adb0f5db;
        var_19516aa35144c8f3[ i ] = var_3ef4acbfe84ee35a;
        var_142b7745111ea0f8 += var_3b625351adb0f5db;
    }
    
    var_ffe791c64738fa41 = var_ed85936c77c57975 * self.var_332f929de1894b2b.var_be6be2bcecf45113 + var_ed85936c77c57975 * self.var_332f929de1894b2b.var_71708baadc72719c + var_142b7745111ea0f8;
    thread starttimer( var_ffe791c64738fa41 );
    sweepdirection = undefined;
    
    for ( i = 0; i < self.var_332f929de1894b2b.var_4bd9e0c5cb4212f ; i++ )
    {
        function_1ee321deeb8f07cf( i );
        sweepcenter = function_58f473c4a51e1b5b();
        sweepcenter -= ( 0, 0, sweepcenter[ 2 ] );
        sweepdirection = function_c3db83a12437cd0b( sweepcenter, sweepdirection );
        sweepcenter = function_19b2b22feb3a2a5d( sweepcenter, sweepdirection );
        var_9decc2cd3f50b8fa = var_19516aa35144c8f3[ i ];
        maxdelay = var_6da238b0346d41ce[ i ];
        var_92d14ac9a1c12e65 = self.var_332f929de1894b2b.var_71708baadc72719c + maxdelay + self.var_332f929de1894b2b.var_be6be2bcecf45113;
        thread function_89cd17cc3ced203f( i, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa );
        wait var_92d14ac9a1c12e65;
        function_9d130d48eddc7153();
    }
    
    level notify( #"hash_4e460b849cc4934e" );
    self.var_faf6d07a43ff6f7d = [];
    function_3d466d97dc222b14();
    
    foreach ( player in level.players )
    {
        player.areadenialparticipant = undefined;
        player.var_3e6effbe2ce42c6e = undefined;
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x7169f5b9, Offset: 0x970
// Size: 0x1d1
function function_1ab9b9719e42d9b4()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    level endon( #"hash_4e460b849cc4934e" );
    var_64fa6d78ecba4404 = [];
    
    foreach ( player in level.players )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = arraycombineunique( level.var_11a4edb43fa8ba1c.var_c1890f722804aca6, [ player ] );
            continue;
        }
        
        var_64fa6d78ecba4404[ var_64fa6d78ecba4404.size ] = player;
    }
    
    while ( var_64fa6d78ecba4404.size > 0 )
    {
        var_726d33884138285d = [];
        
        foreach ( player in var_64fa6d78ecba4404 )
        {
            if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
            {
                level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = arraycombineunique( level.var_11a4edb43fa8ba1c.var_c1890f722804aca6, [ player ] );
                var_726d33884138285d[ var_726d33884138285d.size ] = player;
            }
        }
        
        var_64fa6d78ecba4404 = arrayremove( var_64fa6d78ecba4404, var_726d33884138285d );
        waitframe();
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x1e95ba71, Offset: 0xb49
// Size: 0xda
function function_7088bb1c7ffa7904( var_6509c97b1b10dd27, fleetsize )
{
    possibleformations = [];
    
    if ( !isarray( var_6509c97b1b10dd27 ) || var_6509c97b1b10dd27.size <= 0 )
    {
        return possibleformations;
    }
    
    if ( !isdefined( fleetsize ) )
    {
        return possibleformations;
    }
    
    foreach ( var_d94f6bedfccf1fa1 in var_6509c97b1b10dd27 )
    {
        if ( !isarray( var_d94f6bedfccf1fa1.dronedelays ) )
        {
            continue;
        }
        
        if ( var_d94f6bedfccf1fa1.dronedelays.size == fleetsize )
        {
            possibleformations[ possibleformations.size ] = var_d94f6bedfccf1fa1;
        }
    }
    
    return possibleformations;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xef43c65d, Offset: 0xc2c
// Size: 0x92
function function_1ee321deeb8f07cf( fleetidx )
{
    if ( !isdefined( fleetidx ) || fleetidx < 0 )
    {
        return;
    }
    
    if ( fleetidx == 0 )
    {
        level thread br_public::brleaderdialog( "pe_areadenial_event_begin" + "_" + self.varianttag, 1, undefined, 0, 0, undefined, self.var_332f929de1894b2b.voprefix );
        return;
    }
    
    level thread br_public::brleaderdialog( "pe_areadenial_new_sweep" + "_" + self.varianttag, 1, undefined, 0, 0, undefined, self.var_332f929de1894b2b.voprefix );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xcb425db7, Offset: 0xcc6
// Size: 0x17
function waitfunc()
{
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0xf6620da6, Offset: 0xce5
// Size: 0x6f, Type: bool
function function_2d6ba5df1d02a654( arearecondrone, activity_instance )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( self.var_3e6effbe2ce42c6e >= arearecondrone.fleetindex )
    {
        return false;
    }
    
    if ( !function_1855706091bc18b( arearecondrone, activity_instance ) )
    {
        return false;
    }
    
    if ( !function_d1e90a208aa31aba( arearecondrone ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xf0e1d997, Offset: 0xd5d
// Size: 0x1c4
function function_d88a81c66534637d()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    level endon( #"hash_4e460b849cc4934e" );
    
    while ( true )
    {
        foreach ( drone in self.var_faf6d07a43ff6f7d )
        {
            if ( drone.scanningfinished )
            {
                continue;
            }
            
            nearbyplayers = utility::playersincylinder( drone.origin, drone.warningradius, undefined, drone.height );
            
            foreach ( player in nearbyplayers )
            {
                if ( !player function_2d6ba5df1d02a654( drone, self ) )
                {
                    continue;
                }
                
                br_killstreaks::dangernotifyplayer( player, "areadenial", 3 );
                level thread br_public::brleaderdialogplayer( "pe_areadenial_enter_drone_path" + "_" + self.varianttag, player, 1, 0, 0, undefined, self.var_332f929de1894b2b.voprefix );
                player.var_3e6effbe2ce42c6e = drone.fleetindex;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0xcb5ded4e, Offset: 0xf29
// Size: 0x16a
function function_1855706091bc18b( arearecondrone, activity_instance )
{
    if ( !isdefined( arearecondrone ) || !isplayer( self ) )
    {
        return 0;
    }
    
    if ( !( isdefined( arearecondrone.origin ) && isdefined( arearecondrone.direction ) && isdefined( arearecondrone.radius ) ) )
    {
        return 0;
    }
    
    playerorigin = self.origin;
    droneorigin = arearecondrone.origin;
    var_e3f9374b8144a71c = playerorigin - droneorigin;
    var_e3f9374b8144a71c -= ( 0, 0, var_e3f9374b8144a71c[ 2 ] );
    var_4c7096939c346967 = vectordot2( arearecondrone.direction, var_e3f9374b8144a71c, 0 );
    var_f5916ef8aae322e6 = arearecondrone.direction * var_4c7096939c346967;
    var_200e6945e89714e1 = var_f5916ef8aae322e6 - var_e3f9374b8144a71c;
    var_230f68b3e7d826d1 = var_200e6945e89714e1[ 0 ] * var_200e6945e89714e1[ 0 ] + var_200e6945e89714e1[ 1 ] * var_200e6945e89714e1[ 1 ];
    widthlimit = arearecondrone.radius;
    heightlimit = widthlimit * activity_instance.var_332f929de1894b2b.var_ed8eb2637a1d57b4;
    var_5a40559d8f6250a5 = var_230f68b3e7d826d1 <= widthlimit * widthlimit;
    var_f4f2399663e213dc = var_4c7096939c346967 <= heightlimit;
    var_8dd663f8af1eea46 = var_5a40559d8f6250a5 && var_f4f2399663e213dc && var_4c7096939c346967 > 0;
    return var_8dd663f8af1eea46;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0x6e032d74, Offset: 0x109c
// Size: 0x209
function function_d1e90a208aa31aba( arearecondrone )
{
    if ( !isdefined( arearecondrone ) || !isplayer( self ) )
    {
        return 0;
    }
    
    if ( !( isdefined( arearecondrone.var_81a1fefe32902abb ) && isdefined( arearecondrone.var_a80f44dcda15d794 ) && isdefined( arearecondrone.direction ) && isdefined( arearecondrone.radius ) ) )
    {
        return 0;
    }
    
    playerorigin = self.origin;
    var_b8e40dd0db3d9e91 = arearecondrone.var_81a1fefe32902abb;
    var_4bb51a1cd4ef3eb0 = arearecondrone.var_a80f44dcda15d794;
    var_b42400279185e89a = arearecondrone.radius * arearecondrone.radius;
    var_c18fe1589027640f = distance2dsquared( playerorigin, var_b8e40dd0db3d9e91 );
    var_dbe959ae8709d2d0 = distance2dsquared( playerorigin, var_4bb51a1cd4ef3eb0 );
    var_d01c41e507e954f7 = var_c18fe1589027640f <= var_b42400279185e89a;
    var_272440f68f3dc8f2 = var_dbe959ae8709d2d0 <= var_b42400279185e89a;
    
    if ( var_d01c41e507e954f7 || var_272440f68f3dc8f2 )
    {
        return 1;
    }
    
    var_456552aaa662c5c7 = playerorigin - var_b8e40dd0db3d9e91;
    var_456552aaa662c5c7 -= ( 0, 0, var_456552aaa662c5c7[ 2 ] );
    var_4c7096939c346967 = vectordot2( arearecondrone.direction, var_456552aaa662c5c7, 0 );
    var_f5916ef8aae322e6 = arearecondrone.direction * var_4c7096939c346967;
    var_200e6945e89714e1 = var_f5916ef8aae322e6 - var_456552aaa662c5c7;
    var_230f68b3e7d826d1 = var_200e6945e89714e1[ 0 ] * var_200e6945e89714e1[ 0 ] + var_200e6945e89714e1[ 1 ] * var_200e6945e89714e1[ 1 ];
    var_5a40559d8f6250a5 = var_230f68b3e7d826d1 <= var_b42400279185e89a;
    var_1c77b2c9baff8019 = var_4c7096939c346967 >= 0;
    var_cab1220e0b5301c0 = playerorigin + var_200e6945e89714e1;
    var_9f2bc0a9a755b62f = var_cab1220e0b5301c0 - var_4bb51a1cd4ef3eb0;
    var_9f2bc0a9a755b62f -= ( 0, 0, var_9f2bc0a9a755b62f[ 2 ] );
    var_d1a1b2f57ee36931 = vectordot2( arearecondrone.direction, var_9f2bc0a9a755b62f, 0 );
    var_31e52111a4de9177 = var_d1a1b2f57ee36931 <= 0;
    var_c5e95ed23f986ce5 = var_5a40559d8f6250a5 && var_1c77b2c9baff8019 && var_31e52111a4de9177;
    return var_c5e95ed23f986ce5;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 6
// Checksum 0x503ae2df, Offset: 0x12ae
// Size: 0x121
function function_89cd17cc3ced203f( fleetindex, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !( isdefined( sweepcenter ) && isdefined( radius ) && isdefined( sweepdirection ) && isdefined( height ) ) )
    {
        return;
    }
    
    if ( !isdefined( var_9decc2cd3f50b8fa ) )
    {
        var_9decc2cd3f50b8fa = [];
    }
    
    var_975f82a8a2bb25c6 = ( sweepdirection[ 1 ], sweepdirection[ 0 ] * -1, 0 );
    
    for ( i = 0; i < self.var_332f929de1894b2b.var_a6d3e8d24058dc17 ; i++ )
    {
        offsetmult = ( i & 1 ) == 0 ? i / 2 : ( i + 1 ) * -1 / 2;
        offsetmult *= self.var_332f929de1894b2b.var_5cc32dc41fccc789;
        offsetvector = var_975f82a8a2bb25c6 * offsetmult;
        thread function_80b5815b2843f9d5( fleetindex, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa[ i ], offsetvector );
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 7
// Checksum 0xefe916cd, Offset: 0x13d7
// Size: 0x5ba
function function_80b5815b2843f9d5( fleetindex, sweepcenter, radius, direction, height, startdelay, originoffset )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !( isdefined( sweepcenter ) && isdefined( radius ) && isdefined( direction ) ) )
    {
        return;
    }
    
    arearecondrone = spawnstruct();
    speed = self.var_332f929de1894b2b.var_ef60b858a3301237;
    sweepduration = self.var_332f929de1894b2b.var_71708baadc72719c;
    var_beaf2ab3cc354eab = ( self.var_332f929de1894b2b.var_be6be2bcecf45113 + sweepduration * 0.5 ) * speed;
    droneorigin = function_3195285ff7fd9f80( sweepcenter, direction, var_beaf2ab3cc354eab );
    pathcenter = sweepcenter;
    
    if ( isdefined( originoffset ) )
    {
        droneorigin += originoffset;
        pathcenter += originoffset;
    }
    
    modelheight = self.var_a315b3194aee145b + self.var_332f929de1894b2b.var_efba9875a885e2c1;
    var_1eb7555d2eec66de = droneorigin + ( 0, 0, modelheight );
    directionangles = vectortoangles( direction );
    arearecondrone.origin = droneorigin;
    arearecondrone.radius = radius;
    arearecondrone.direction = direction;
    arearecondrone.height = height;
    arearecondrone.sweepcenter = pathcenter;
    arearecondrone.sweepduration = sweepduration;
    arearecondrone.sweepspeed = speed;
    arearecondrone.fleetindex = fleetindex;
    arearecondrone.warningradius = radius * self.var_332f929de1894b2b.var_ed8eb2637a1d57b4;
    arearecondrone.var_81a1fefe32902abb = droneorigin + self.var_332f929de1894b2b.var_be6be2bcecf45113 * speed * direction;
    arearecondrone.var_a80f44dcda15d794 = droneorigin + ( self.var_332f929de1894b2b.var_be6be2bcecf45113 + self.var_332f929de1894b2b.var_71708baadc72719c ) * speed * direction;
    arearecondrone.detectedplayers = [];
    
    if ( !isdefined( self.var_faf6d07a43ff6f7d ) )
    {
        self.var_faf6d07a43ff6f7d = [];
    }
    
    self.var_faf6d07a43ff6f7d[ self.var_faf6d07a43ff6f7d.size ] = arearecondrone;
    
    if ( startdelay > 0 )
    {
        wait startdelay;
    }
    
    uavscriptable = spawn( "script_model", var_1eb7555d2eec66de );
    uavscriptable setmodel( self.var_332f929de1894b2b.recondronemodel );
    uavscriptable.angles = directionangles;
    uavscriptable setscriptablepartstate( "lights", "on", 0 );
    uavscriptable setscriptablepartstate( "SFX", "on", 0 );
    arearecondrone.scriptable = uavscriptable;
    arearecondrone.scriptable function_66df55ac471440ed( self.var_332f929de1894b2b.recondroneicon );
    arearecondrone.scriptable function_e883f4dd4c50d389( 1, 1 );
    arearecondrone.reconcircle = spawnstruct();
    arearecondrone.reconcircle game_utility::questcircle_create( "AreaDenial_Path", arearecondrone.origin, arearecondrone.radius );
    sizemultiplier = 2 * self.var_332f929de1894b2b.var_ed8eb2637a1d57b4;
    arearecondrone.reconcircle.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.reconcircle.mapcircle addpitch( sizemultiplier );
    arearecondrone.var_90c1b08ecc1bafc9 = spawnstruct();
    arearecondrone.var_90c1b08ecc1bafc9 game_utility::questcircle_create( "AreaDenial", arearecondrone.origin, arearecondrone.radius );
    var_873b8b0b14db018b = direction * speed * sweepduration * 0.5;
    var_a7b1a8806a1a743f = arearecondrone.sweepcenter - var_873b8b0b14db018b;
    arearecondrone.var_37930efe3a5a1c1b = spawnstruct();
    arearecondrone.var_37930efe3a5a1c1b game_utility::questcircle_create( "AreaDenial_Path_Start", var_a7b1a8806a1a743f, arearecondrone.radius );
    sizemultiplier = 2 * self.var_332f929de1894b2b.var_2390b66687a32356;
    arearecondrone.var_37930efe3a5a1c1b.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.var_37930efe3a5a1c1b.mapcircle addpitch( sizemultiplier );
    arearecondrone.var_37930efe3a5a1c1b game_utility::questcircle_showtoall();
    pathendpos = arearecondrone.sweepcenter + var_873b8b0b14db018b;
    arearecondrone.var_b2e4957dd25f367e = spawnstruct();
    arearecondrone.var_b2e4957dd25f367e game_utility::questcircle_create( "AreaDenial_Path_End", pathendpos, arearecondrone.radius );
    sizemultiplier = 2 * self.var_332f929de1894b2b.var_e254cf9548dc6921;
    arearecondrone.var_b2e4957dd25f367e.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.var_b2e4957dd25f367e.mapcircle addpitch( sizemultiplier );
    arearecondrone thread function_a639bbbf2bc4a660( self );
    return arearecondrone;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x16923eb9, Offset: 0x199a
// Size: 0xb9
function function_7333a7c66353da70( durationseconds, activity_instance )
{
    step = activity_instance.var_332f929de1894b2b.var_ef60b858a3301237 * level.framedurationseconds;
    time = 0;
    
    while ( time < durationseconds )
    {
        stepvector = self.direction * step;
        self.origin += stepvector;
        self.scriptable.origin += stepvector;
        time += level.framedurationseconds;
        waitframe();
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x11829db7, Offset: 0x1a5b
// Size: 0x144
function function_4efe439dc28c747a( durationseconds, activity_instance )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    activity_instance endon( #"hash_57e3556f0eb5a22d" );
    self endon( #"hash_1939ab86ee3731f6" );
    widthlimit = self.radius;
    heightlimit = widthlimit * activity_instance.var_332f929de1894b2b.var_ed8eb2637a1d57b4;
    var_e807fe2204c150d6 = heightlimit * activity_instance.var_332f929de1894b2b.var_d3ddca77ecf6666b / self.sweepspeed;
    time = 0;
    var_9825210619961e2a = self.reconcircle;
    circleswapped = 0;
    
    while ( time < durationseconds )
    {
        if ( !circleswapped && durationseconds - time < var_e807fe2204c150d6 )
        {
            var_9825210619961e2a game_utility::questcircle_delete();
            var_9825210619961e2a = self.var_90c1b08ecc1bafc9;
            var_9825210619961e2a game_utility::questcircle_move( self.origin );
            var_9825210619961e2a game_utility::questcircle_showtoall();
            circleswapped = 1;
        }
        else
        {
            var_9825210619961e2a game_utility::questcircle_move( self.origin );
        }
        
        time += level.framedurationseconds;
        waitframe();
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xb991bbc7, Offset: 0x1ba7
// Size: 0x2a
function function_9e99f8b276454169( activity_instance )
{
    function_7333a7c66353da70( activity_instance.var_332f929de1894b2b.var_be6be2bcecf45113, activity_instance );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0x7ac835, Offset: 0x1bd9
// Size: 0x30
function function_8c6971bce7ce5e95( activity_instance )
{
    thread function_4efe439dc28c747a( self.sweepduration, activity_instance );
    function_7333a7c66353da70( self.sweepduration, activity_instance );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xeaf44b08, Offset: 0x1c11
// Size: 0x83
function function_175d0d59d1d55214( activity_instance )
{
    objective_settint( self.scriptable.iconinfo.all, 255, 255, 255 );
    thread function_a491297c3a8dd5d6( 1, 0, activity_instance.var_332f929de1894b2b.var_ae740116bc7c25b2, activity_instance );
    function_7333a7c66353da70( activity_instance.var_332f929de1894b2b.var_e5929ecb3fac8d55, activity_instance );
    self.scriptable function_3070bbc34298d890();
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xe506f515, Offset: 0x1c9c
// Size: 0x1ec
function function_a639bbbf2bc4a660( activity_instance )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    
    if ( !( isdefined( self.sweepduration ) && isdefined( self.radius ) && isdefined( self.origin ) && isdefined( self.scriptable ) && isdefined( self.direction ) ) )
    {
        return;
    }
    
    if ( !( isdefined( self.reconcircle ) && isdefined( self.var_37930efe3a5a1c1b ) && isdefined( self.var_b2e4957dd25f367e ) && isdefined( self.var_90c1b08ecc1bafc9 ) ) )
    {
        return;
    }
    
    function_9e99f8b276454169( activity_instance );
    self.var_37930efe3a5a1c1b game_utility::questcircle_delete();
    self.reconcircle game_utility::questcircle_showtoall();
    self.var_b2e4957dd25f367e game_utility::questcircle_showtoall();
    thread function_e3965afe5cbf22a6( activity_instance );
    objidpoolmanager::function_373aaf492aabde6f( self.scriptable.scriptedobjid, 141, 42, 42 );
    function_8c6971bce7ce5e95( activity_instance );
    self notify( #"hash_1939ab86ee3731f6" );
    self.scanningfinished = 1;
    self.var_90c1b08ecc1bafc9 game_utility::questcircle_delete();
    self.var_b2e4957dd25f367e game_utility::questcircle_delete();
    
    foreach ( player in self.detectedplayers )
    {
        thread function_e58a30b918de3580( player, activity_instance );
    }
    
    activity_instance.var_faf6d07a43ff6f7d = arrayremove( activity_instance.var_faf6d07a43ff6f7d, self );
    function_175d0d59d1d55214( activity_instance );
    self.scriptable delete();
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xe3679ee7, Offset: 0x1e90
// Size: 0x1e6
function function_e3965afe5cbf22a6( activity_instance )
{
    self endon( #"hash_1939ab86ee3731f6" );
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    activity_instance endon( #"hash_57e3556f0eb5a22d" );
    
    while ( true )
    {
        nearbyplayers = utility::playersincylinder( self.origin, self.radius, undefined, self.height );
        
        foreach ( nearbyplayer in nearbyplayers )
        {
            if ( arraycontains( self.detectedplayers, nearbyplayer ) )
            {
                continue;
            }
            
            thread function_70748d42bab7b4cd( nearbyplayer, activity_instance );
        }
        
        foreach ( detectedplayer in self.detectedplayers )
        {
            if ( arraycontains( nearbyplayers, detectedplayer ) )
            {
                continue;
            }
            
            thread function_e58a30b918de3580( detectedplayer, activity_instance );
        }
        
        /#
            if ( getdvarint( @"hash_e3e9f13280e0fa2f", 0 ) )
            {
                var_f67a110de9ebec9 = self.origin - ( 0, 0, self.height );
                utility::draw_capsule( var_f67a110de9ebec9, self.radius, 2 * self.height );
            }
        #/
        
        wait activity_instance.var_332f929de1894b2b.var_3d3cc93f0e540c9;
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x2c29a9f9, Offset: 0x207e
// Size: 0x13f
function function_70748d42bab7b4cd( player, activity_instance )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    activity_instance endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player notify( #"hash_72600f1c98cfd44d" );
    
    if ( !isdefined( self.detectedplayers ) )
    {
        self.detectedplayers = [];
    }
    
    self.detectedplayers = arraycombineunique( self.detectedplayers, [ player ] );
    level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8 = arraycombineunique( level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8, [ player ] );
    activity_instance.detectedplayers = arraycombineunique( activity_instance.detectedplayers, [ player ] );
    player function_a795389146361a90( 1 );
    player function_c96735b095fc54b4( 4 );
    player.var_aaa4bf8b1e3f1cce = 1;
    player function_b64e34e878f56c6e( 1 );
    level thread br_public::brleaderdialogplayer( "pe_areadenial_enter_detection_radius" + "_" + activity_instance.varianttag, player, 1, 0, 0, undefined, activity_instance.var_332f929de1894b2b.voprefix );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x7d596d35, Offset: 0x21c5
// Size: 0x10c
function function_e58a30b918de3580( player, activity_instance )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    activity_instance endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"hash_72600f1c98cfd44d" );
    player endon( #"disconnect" );
    
    if ( !isdefined( self.detectedplayers ) || self.detectedplayers.size <= 0 )
    {
        return;
    }
    
    self.detectedplayers = arrayremove( self.detectedplayers, player );
    player.var_aaa4bf8b1e3f1cce = undefined;
    player.var_e3a0eb63a8b650c4 = gettime();
    activity_instance.detectedplayers = arrayremove( activity_instance.detectedplayers, player );
    player utility::waittill_any_timeout( activity_instance.var_332f929de1894b2b.var_8d3f48cbb7b82e5e, "death" );
    player function_a795389146361a90( 0 );
    player function_2c796b5cbe343df3( 4 );
    player function_b64e34e878f56c6e( 0 );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xfc190ab2, Offset: 0x22d9
// Size: 0x19
function function_b64e34e878f56c6e( value )
{
    self setclientomnvar( "ui_br_area_denial", value );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x22033ee1, Offset: 0x22fa
// Size: 0xf7
function function_c3db83a12437cd0b( sweepcenter, var_7950b0200c93c692 )
{
    if ( !isdefined( sweepcenter ) )
    {
        return;
    }
    
    sweepdirection = undefined;
    
    if ( isvector( var_7950b0200c93c692 ) )
    {
        sweepdirection = rotatevector( var_7950b0200c93c692, ( 0, 90, 0 ) );
    }
    else
    {
        var_e5e0a799863ba1e = function_196c9a8f11e5f3d6( sweepcenter, self.var_332f929de1894b2b.var_5cc32dc41fccc789 );
        
        if ( isdefined( var_e5e0a799863ba1e ) )
        {
            var_d20473ac00e8d6f3 = sweepcenter - var_e5e0a799863ba1e;
            var_44914230f9c8ca9b = length( var_d20473ac00e8d6f3 );
            rotationangle = acos( self.var_332f929de1894b2b.var_5cc32dc41fccc789 / var_44914230f9c8ca9b );
            rotationangle = 90 - rotationangle;
            sweepdirection = rotatevectorinverted( var_d20473ac00e8d6f3, ( 0, rotationangle, 0 ) );
            sweepdirection = vectornormalize2( sweepdirection );
        }
        else
        {
            circlecenter = br_circle::getdangercircleorigin();
            sweepdirection = sweepcenter - circlecenter;
            sweepdirection = vectornormalize2( sweepdirection );
        }
    }
    
    return sweepdirection;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0xdd9d47f9, Offset: 0x23fa
// Size: 0x164
function function_19b2b22feb3a2a5d( sweepcenter, sweepdirection )
{
    if ( !( isdefined( sweepcenter ) && isdefined( sweepdirection ) ) )
    {
        return sweepcenter;
    }
    
    dangercircleorigin = br_circle::getdangercircleorigin();
    dangercircleradius = br_circle::getdangercircleradius();
    var_5436c5cc66e633c5 = self.var_332f929de1894b2b.var_ef60b858a3301237 * self.var_332f929de1894b2b.var_71708baadc72719c * 0.5;
    var_c2323cc7ff35279c = var_5436c5cc66e633c5 * sweepdirection;
    scanstartpoint = sweepcenter - var_c2323cc7ff35279c;
    scanendpoint = sweepcenter + var_c2323cc7ff35279c;
    var_416842ce071e6bd4 = dangercircleradius * dangercircleradius;
    var_efdc8846ba5a317 = distance2dsquared( dangercircleorigin, scanstartpoint ) > var_416842ce071e6bd4;
    var_e600cf83b6a6592e = distance2dsquared( dangercircleorigin, scanendpoint ) > var_416842ce071e6bd4;
    
    if ( !var_efdc8846ba5a317 && !var_e600cf83b6a6592e )
    {
        return sweepcenter;
    }
    
    var_8144050080e38bf5 = dangercircleorigin - sweepcenter;
    var_4c7096939c346967 = vectordot2( sweepdirection, var_8144050080e38bf5, 0 );
    var_f5916ef8aae322e6 = sweepdirection * var_4c7096939c346967;
    
    if ( var_4c7096939c346967 * var_4c7096939c346967 <= var_5436c5cc66e633c5 * var_5436c5cc66e633c5 )
    {
        var_c545603161f3e28d = sweepcenter + var_f5916ef8aae322e6;
    }
    else
    {
        multiplier = var_4c7096939c346967 < 0 ? -1 : 1;
        var_c545603161f3e28d = sweepcenter + sweepdirection * multiplier * var_5436c5cc66e633c5;
    }
    
    return var_c545603161f3e28d;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0x859b988b, Offset: 0x2567
// Size: 0x105
function function_196c9a8f11e5f3d6( sweepcenter, mindistance )
{
    closestpos = undefined;
    
    if ( !( isdefined( sweepcenter ) && isdefined( mindistance ) ) || !isvector( sweepcenter ) )
    {
        return closestpos;
    }
    
    bestdistsqr = 2147483647;
    var_68e48d95a0187354 = mindistance * mindistance;
    
    foreach ( player in level.players )
    {
        distsqr = distance2dsquared( player.origin, sweepcenter );
        
        if ( distsqr > var_68e48d95a0187354 && distsqr < bestdistsqr )
        {
            closestpos = player.origin;
            bestdistsqr = distsqr;
        }
    }
    
    return closestpos;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xd45b2244, Offset: 0x2675
// Size: 0x129
function function_3cf1f9577d55f8be()
{
    delays = [];
    
    if ( !( isdefined( self.var_2e1ed8612ee39a2c ) && isdefined( self.var_2e1ed8612ee39a2c.fleetformations ) ) || !isarray( self.var_2e1ed8612ee39a2c.fleetformations ) || self.var_2e1ed8612ee39a2c.fleetformations.size <= 0 )
    {
        return delays;
    }
    
    selectedformation = utility::random_weighted_struct( self.var_2e1ed8612ee39a2c.fleetformations );
    
    if ( !isarray( selectedformation.dronedelays ) )
    {
        return delays;
    }
    
    foreach ( dronedelay in selectedformation.dronedelays )
    {
        delays[ delays.size ] = dronedelay.delay;
    }
    
    return delays;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0x864874b9, Offset: 0x27a7
// Size: 0xa4
function function_d5390f3a7088e5e7( var_9decc2cd3f50b8fa )
{
    if ( !isarray( var_9decc2cd3f50b8fa ) || var_9decc2cd3f50b8fa.size == 0 )
    {
        return 0;
    }
    
    maxdelay = var_9decc2cd3f50b8fa[ 0 ];
    
    foreach ( dronedelay in var_9decc2cd3f50b8fa )
    {
        if ( dronedelay >= maxdelay )
        {
            maxdelay = dronedelay;
        }
    }
    
    return maxdelay;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xd34e9a30, Offset: 0x2854
// Size: 0xc7
function function_f4cded4a570ec778()
{
    var_37cbd4a3f906df82 = ( 0, 0, 0 );
    numplayers = 0;
    
    foreach ( player in level.players )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            var_37cbd4a3f906df82 += player.origin;
            numplayers++;
        }
    }
    
    var_37cbd4a3f906df82 /= numplayers;
    return var_37cbd4a3f906df82;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x1c46e7ed, Offset: 0x2924
// Size: 0x8
function function_58f473c4a51e1b5b()
{
    return function_f4cded4a570ec778();
}

// Namespace namespace_41f6b71d9bf353d1
// Params 3
// Checksum 0xff64242b, Offset: 0x2935
// Size: 0x52
function function_3195285ff7fd9f80( sweepcenter, sweepdirection, var_e806e995a40ba0f5 )
{
    if ( !( isdefined( sweepcenter ) && isdefined( sweepdirection ) && isdefined( var_e806e995a40ba0f5 ) ) )
    {
        return;
    }
    
    offsetvector = sweepdirection * var_e806e995a40ba0f5;
    sweeporigin = sweepcenter - offsetvector;
    return sweeporigin;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xf9d8dfdb, Offset: 0x2990
// Size: 0x45
function starttimer( var_6178022a28917e8 )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    br_activity_util::function_f255dbc3d969ce02( var_6178022a28917e8, 16 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x86263391, Offset: 0x29dd
// Size: 0x6a
function calculateeventstarttime()
{
    if ( self.var_332f929de1894b2b.maxstarttime > self.var_332f929de1894b2b.minstarttime )
    {
        return randomfloatrange( self.var_332f929de1894b2b.minstarttime, self.var_332f929de1894b2b.maxstarttime );
    }
    
    return self.var_332f929de1894b2b.minstarttime;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0x964936f3, Offset: 0x2a50
// Size: 0x5b
function function_19cf511c86313288( player )
{
    if ( !arraycontains( level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8, player ) )
    {
        level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = arraycombineunique( level.var_11a4edb43fa8ba1c.var_c1890f722804aca6, [ player ] );
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x311c5f1e, Offset: 0x2ab3
// Size: 0xe9
function function_48bec679ab02498f()
{
    level.var_11a4edb43fa8ba1c.dlogdata = [];
    level.var_11a4edb43fa8ba1c.dlogdata[ "circle_index" ] = isdefined( level.br_circle ) ? level.br_circle.circleindex + 1 : -1;
    level.var_11a4edb43fa8ba1c.dlogdata[ "affected_player_count_per_sweep" ] = [];
    level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = [];
    level.var_11a4edb43fa8ba1c.dlogdata[ "detected_player_count_per_sweep" ] = [];
    level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8 = [];
    level.var_11a4edb43fa8ba1c.dlogdata[ "killed_detected_player_count_per_sweep" ] = [];
    level.var_11a4edb43fa8ba1c.var_df94043029ca63f3 = [];
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xb2b019b1, Offset: 0x2ba4
// Size: 0x11c
function function_9d130d48eddc7153()
{
    level.var_11a4edb43fa8ba1c.dlogdata[ "affected_player_count_per_sweep" ][ level.var_11a4edb43fa8ba1c.dlogdata[ "affected_player_count_per_sweep" ].size ] = level.var_11a4edb43fa8ba1c.var_c1890f722804aca6.size;
    level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = [];
    level.var_11a4edb43fa8ba1c.dlogdata[ "detected_player_count_per_sweep" ][ level.var_11a4edb43fa8ba1c.dlogdata[ "detected_player_count_per_sweep" ].size ] = level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8.size;
    level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8 = [];
    level.var_11a4edb43fa8ba1c.dlogdata[ "killed_detected_player_count_per_sweep" ][ level.var_11a4edb43fa8ba1c.dlogdata[ "killed_detected_player_count_per_sweep" ].size ] = level.var_11a4edb43fa8ba1c.var_df94043029ca63f3.size;
    level.var_11a4edb43fa8ba1c.var_df94043029ca63f3 = [];
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0x597c4fbd, Offset: 0x2cc8
// Size: 0xa7
function function_3d466d97dc222b14()
{
    dlog_recordevent( "dlog_event_areadenial_match_event", [ "circle_index", level.var_11a4edb43fa8ba1c.dlogdata[ "circle_index" ], "affected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "affected_player_count_per_sweep" ].size, "detected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "detected_player_count_per_sweep" ].size, "killed_detected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "killed_detected_player_count_per_sweep" ] ] );
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0xe8a1dae8, Offset: 0x2d77
// Size: 0x59
function function_66df55ac471440ed( allicon )
{
    gameent = self;
    gameent.iconinfo = spawnstruct();
    gameent.iconinfo.owner = gameent;
    gameent.iconinfo.allicon = allicon;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xc2113900, Offset: 0x2dd8
// Size: 0x34
function function_b12a093dd5c138c()
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    gameent function_3070bbc34298d890();
    gameent.iconinfo = undefined;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 2
// Checksum 0xfb625ea9, Offset: 0x2e14
// Size: 0xb9
function function_e883f4dd4c50d389( playintro, showdistance )
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    iconorigin = gameent function_6ad72cf932037eb6();
    
    if ( !isdefined( iconorigin ) )
    {
        return;
    }
    
    if ( isdefined( gameent.iconinfo.allicon ) )
    {
        gameent.iconinfo.all = function_d6d1935545e1ca34( gameent.iconinfo.allicon, iconorigin, playintro, showdistance );
        objidpoolmanager::update_objective_onentitywithrotation( gameent.iconinfo.all, gameent );
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 1
// Checksum 0x500ffc42, Offset: 0x2ed5
// Size: 0x81
function function_3070bbc34298d890( var_7dc69ac945958166 )
{
    gameent = self;
    gameent notify( #"icon_hide" );
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    if ( isdefined( gameent.iconinfo.all ) )
    {
        objidpoolmanager::returnobjectiveid( gameent.iconinfo.all );
        gameent.iconinfo.all = undefined;
    }
}

// Namespace namespace_41f6b71d9bf353d1
// Params 4
// Checksum 0x8f48a8e2, Offset: 0x2f5e
// Size: 0x15a
function function_d6d1935545e1ca34( uiicon, iconorigin, playintro, showdistance )
{
    gameent = self;
    objid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objid != -1 )
    {
        objidpoolmanager::objective_add_objective( objid, "active", iconorigin, uiicon );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::objective_set_play_intro( objid, playintro );
        objidpoolmanager::function_9d4895ed38151e46( objid, 1 );
        function_771fb62e0d43ad8( objid, &"mp/br_area_denial_label" );
        objective_setlabel( objid, &"mp/br_area_denial_label" );
        function_3c050d13e1a21c81( objid, 1 );
        objective_removeallfrommask( objid );
        
        foreach ( player in level.players )
        {
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            objective_addclienttomask( objid, player );
        }
        
        objective_showtoplayersinmask( objid );
        gameent.scriptedobjid = objid;
    }
    else
    {
        println( "<dev string:x2b>" );
    }
    
    return objid;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 0
// Checksum 0xf538c1c5, Offset: 0x30c1
// Size: 0x1e, Type: bool
function function_6ad72cf932037eb6()
{
    gameent = self;
    return gameent.origin ?? undefined;
}

// Namespace namespace_41f6b71d9bf353d1
// Params 4
// Checksum 0x86ad3576, Offset: 0x30e8
// Size: 0x106
function function_a491297c3a8dd5d6( sourcealpha, targetalpha, durationseconds, activity_instance )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    self endon( #"hash_57e3556f0eb5a22d" );
    assert( sourcealpha >= 0 && sourcealpha <= 1, "<dev string:x57>" );
    assert( targetalpha >= 0 && targetalpha <= 1, "<dev string:x7e>" );
    objectiveid = self.scriptable.iconinfo.all;
    
    if ( durationseconds == 0 )
    {
        function_6d950100aec1d712( objectiveid, targetalpha );
        return;
    }
    
    step = ( targetalpha - sourcealpha ) / durationseconds * level.framedurationseconds;
    iconalpha = sourcealpha;
    
    while ( iconalpha != targetalpha )
    {
        iconalpha = clamp( iconalpha + step, 0, 1 );
        function_6d950100aec1d712( objectiveid, iconalpha );
        waitframe();
    }
}

