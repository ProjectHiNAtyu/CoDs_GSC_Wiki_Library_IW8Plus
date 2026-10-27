// scripts\mp\br\gametypes\br_publicevent_areadenial.gsc  (hash_5b680497c62f8d5a.gscc) (size: 20678 Bytes / 0x50c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3a77cce (3550969038)
// size ...... 20678 (0x50c6)
// includes .. 11  (offset: 0x4dbe)
// strings ... 40  (offset: 0x4e16)
// dev strs .. 6   (offset: 0x507e)
// exports ... 52  (offset: 0x3592)
// cseg ...... 0x3ba + 0x31d8 (0x3592)
// imports ... 131 (offset: 0x3db2)
// animtree1 . 0   (offset: 0x50c6)
// animtree2 . 0   (offset: 0x50c6)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_killstreaks;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;

#namespace br_publicevent_areadenial;

// Namespace br_publicevent_areadenial
// Params 0, eflags: 0x1
// Checksum 0xd5aac782, Offset: 0x3d8
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"areadenial", &init );
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0xe2bc0887, Offset: 0x3f7
// Size: 0x50
function init( eventinfo )
{
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.deactivatefunc = &function_c7a6338c6f315a82;
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x78652490, Offset: 0x44f
// Size: 0x458
function postinitfunc()
{
    game[ "dialog" ][ "pe_areadenial_name" ] = "bads_wzan_adnm";
    game[ "dialog" ][ "pe_areadenial_event_begin" ] = "bads_wzan_adbs";
    game[ "dialog" ][ "pe_areadenial_enter_detection_radius" ] = "bads_wzan_ader";
    game[ "dialog" ][ "pe_areadenial_enter_drone_path" ] = "bads_wzan_adep";
    game[ "dialog" ][ "pe_areadenial_new_sweep" ] = "bads_wzan_adsw";
    level.var_11a4edb43fa8ba1c = spawnstruct();
    level.var_11a4edb43fa8ba1c.minstarttime = getdvarfloat( @"scr_br_pe_areadenial_starttime_min", 60 );
    level.var_11a4edb43fa8ba1c.maxstarttime = getdvarfloat( @"scr_br_pe_areadenial_starttime_max", 565 );
    level.var_11a4edb43fa8ba1c.var_444064bd00a3306 = getdvarfloat( @"hash_a38f2ce7676edb19", 1800 );
    level.var_11a4edb43fa8ba1c.var_3d3cc93f0e540c9 = getdvarfloat( @"hash_eeeb1f6afe3519ee", 0.05 );
    level.var_11a4edb43fa8ba1c.var_ef60b858a3301237 = getdvarfloat( @"hash_c80aab9d623eec4f", 525 );
    level.var_11a4edb43fa8ba1c.var_71708baadc72719c = getdvarfloat( @"hash_d6eab54faa5aafc7", 38 );
    level.var_11a4edb43fa8ba1c.var_a6d3e8d24058dc17 = getdvarfloat( @"scr_br_pe_areadenial_area_recon_fleet_size", 3 );
    level.var_11a4edb43fa8ba1c.var_5cc32dc41fccc789 = getdvarfloat( @"hash_43fe04b82f4f4", 4650 );
    level.var_11a4edb43fa8ba1c.var_4bd9e0c5cb4212f = getdvarint( @"hash_2ea7541ddf02bd32", 2 );
    level.var_11a4edb43fa8ba1c.var_8d3f48cbb7b82e5e = getdvarfloat( @"hash_158f4b7e0b27abcf", 2 );
    level.var_11a4edb43fa8ba1c.var_efba9875a885e2c1 = getdvarfloat( @"hash_78ddb2523cba6d0b", 1000 );
    level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 = getdvarfloat( @"hash_592c14fd41fee008", 10 );
    level.var_11a4edb43fa8ba1c.var_e5929ecb3fac8d55 = getdvarfloat( @"hash_88d54cc694aa46ab", 20 );
    level.var_11a4edb43fa8ba1c.var_ae740116bc7c25b2 = getdvarfloat( @"hash_8fb32f1d22b03c69", level.var_11a4edb43fa8ba1c.var_e5929ecb3fac8d55 );
    level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c = getscriptbundle( hashcat( %"hash_684724f6313c6a6", "jup_publicevent_areadenial_data" ) );
    level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations = function_7088bb1c7ffa7904( level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations, level.var_11a4edb43fa8ba1c.var_a6d3e8d24058dc17 );
    level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4 = [];
    var_5c520b1b92efd6cb = getdvar( @"hash_417dbdcaaac6190e", "" );
    
    if ( var_5c520b1b92efd6cb != "" )
    {
        var_6c4abf3ca287443c = strtok( var_5c520b1b92efd6cb, " " );
        
        if ( var_6c4abf3ca287443c.size > 0 )
        {
            foreach ( delayoverride in var_6c4abf3ca287443c )
            {
                level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4[ level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4.size ] = float( delayoverride );
            }
        }
    }
    
    cylinderheight = parachute::getc130height();
    level.var_11a4edb43fa8ba1c.var_a315b3194aee145b = getdvarint( @"hash_1c6acd7a92de6c21", cylinderheight );
    level.var_11a4edb43fa8ba1c.detectedplayers = [];
    level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d = [];
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xdd2bd136, Offset: 0x8af
// Size: 0x39
function activatefunc()
{
    br_publicevents::showsplashtoall( "br_pe_areadenial_start", "splash_list_br_pe_areadenial" );
    level thread br_public::brleaderdialog( "pe_areadenial_name", 1, undefined, 0, 0, undefined, "dx_br_brad_" );
    function_48bec679ab02498f();
    thread function_4830f4ec0fb188d3();
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x9891efaf, Offset: 0x8f0
// Size: 0x2ba
function function_4830f4ec0fb188d3()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    thread function_d88a81c66534637d();
    thread function_1ab9b9719e42d9b4();
    radius = level.var_11a4edb43fa8ba1c.var_444064bd00a3306;
    height = level.var_11a4edb43fa8ba1c.var_a315b3194aee145b;
    var_19516aa35144c8f3 = [];
    var_6da238b0346d41ce = [];
    var_142b7745111ea0f8 = 0;
    var_ed85936c77c57975 = level.var_11a4edb43fa8ba1c.var_4bd9e0c5cb4212f;
    
    for ( i = 0; i < var_ed85936c77c57975 ; i++ )
    {
        var_3ef4acbfe84ee35a = function_3cf1f9577d55f8be();
        var_3b625351adb0f5db = function_d5390f3a7088e5e7( var_3ef4acbfe84ee35a );
        var_6da238b0346d41ce[ i ] = var_3b625351adb0f5db;
        var_19516aa35144c8f3[ i ] = var_3ef4acbfe84ee35a;
        var_142b7745111ea0f8 += var_3b625351adb0f5db;
    }
    
    var_ffe791c64738fa41 = var_ed85936c77c57975 * level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 + var_ed85936c77c57975 * level.var_11a4edb43fa8ba1c.var_71708baadc72719c + var_142b7745111ea0f8;
    thread starttimer( var_ffe791c64738fa41 );
    sweepdirection = undefined;
    
    for ( i = 0; i < level.var_11a4edb43fa8ba1c.var_4bd9e0c5cb4212f ; i++ )
    {
        function_1ee321deeb8f07cf( i );
        sweepcenter = function_58f473c4a51e1b5b();
        sweepcenter -= ( 0, 0, sweepcenter[ 2 ] );
        sweepdirection = function_c3db83a12437cd0b( sweepcenter, sweepdirection );
        sweepcenter = function_19b2b22feb3a2a5d( sweepcenter, sweepdirection );
        var_9decc2cd3f50b8fa = var_19516aa35144c8f3[ i ];
        maxdelay = var_6da238b0346d41ce[ i ];
        var_92d14ac9a1c12e65 = level.var_11a4edb43fa8ba1c.var_71708baadc72719c + maxdelay + level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113;
        thread function_89cd17cc3ced203f( i, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa );
        wait var_92d14ac9a1c12e65;
        function_9d130d48eddc7153();
    }
    
    level notify( #"hash_4e460b849cc4934e" );
    level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d = [];
    function_3d466d97dc222b14();
    
    foreach ( player in level.players )
    {
        player.areadenialparticipant = undefined;
        player.var_3e6effbe2ce42c6e = undefined;
    }
}

// Namespace br_publicevent_areadenial
// Params 6
// Checksum 0x5bef396e, Offset: 0xbb2
// Size: 0x121
function function_89cd17cc3ced203f( fleetindex, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !( isdefined( sweepcenter ) && isdefined( radius ) && isdefined( sweepdirection ) && isdefined( height ) ) )
    {
        return;
    }
    
    if ( !isdefined( var_9decc2cd3f50b8fa ) )
    {
        var_9decc2cd3f50b8fa = [];
    }
    
    var_975f82a8a2bb25c6 = ( sweepdirection[ 1 ], sweepdirection[ 0 ] * -1, 0 );
    
    for ( i = 0; i < level.var_11a4edb43fa8ba1c.var_a6d3e8d24058dc17 ; i++ )
    {
        offsetmult = ( i & 1 ) == 0 ? i / 2 : ( i + 1 ) * -1 / 2;
        offsetmult *= level.var_11a4edb43fa8ba1c.var_5cc32dc41fccc789;
        offsetvector = var_975f82a8a2bb25c6 * offsetmult;
        thread function_80b5815b2843f9d5( fleetindex, sweepcenter, radius, sweepdirection, height, var_9decc2cd3f50b8fa[ i ], offsetvector );
    }
}

// Namespace br_publicevent_areadenial
// Params 7
// Checksum 0x890b1942, Offset: 0xcdb
// Size: 0x589
function function_80b5815b2843f9d5( fleetindex, sweepcenter, radius, direction, height, startdelay, originoffset )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !( isdefined( sweepcenter ) && isdefined( radius ) && isdefined( direction ) ) )
    {
        return;
    }
    
    arearecondrone = spawnstruct();
    speed = level.var_11a4edb43fa8ba1c.var_ef60b858a3301237;
    sweepduration = level.var_11a4edb43fa8ba1c.var_71708baadc72719c;
    var_beaf2ab3cc354eab = ( level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 + sweepduration * 0.5 ) * speed;
    droneorigin = function_3195285ff7fd9f80( sweepcenter, direction, var_beaf2ab3cc354eab );
    pathcenter = sweepcenter;
    
    if ( isdefined( originoffset ) )
    {
        droneorigin += originoffset;
        pathcenter += originoffset;
    }
    
    modelheight = level.var_11a4edb43fa8ba1c.var_a315b3194aee145b + level.var_11a4edb43fa8ba1c.var_efba9875a885e2c1;
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
    arearecondrone.warningradius = radius * 5.5;
    arearecondrone.var_81a1fefe32902abb = droneorigin + level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 * speed * direction;
    arearecondrone.var_a80f44dcda15d794 = droneorigin + ( level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 + level.var_11a4edb43fa8ba1c.var_71708baadc72719c ) * speed * direction;
    arearecondrone.detectedplayers = [];
    
    if ( !isdefined( level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d ) )
    {
        level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d = [];
    }
    
    level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d[ level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d.size ] = arearecondrone;
    
    if ( startdelay > 0 )
    {
        wait startdelay;
    }
    
    uavscriptable = spawn( "script_model", var_1eb7555d2eec66de );
    uavscriptable setmodel( "veh9_mil_air_advanced_uav_mp" );
    uavscriptable.angles = directionangles;
    uavscriptable setscriptablepartstate( "lights", "on", 0 );
    uavscriptable setscriptablepartstate( "SFX", "on", 0 );
    arearecondrone.scriptable = uavscriptable;
    arearecondrone.scriptable function_66df55ac471440ed( "ui_map_texture_areadenial_uav" );
    arearecondrone.scriptable function_e883f4dd4c50d389( 1, 1 );
    arearecondrone.reconcircle = spawnstruct();
    arearecondrone.reconcircle game_utility::questcircle_create( "AreaDenial_Path", arearecondrone.origin, arearecondrone.radius );
    sizemultiplier = 11;
    arearecondrone.reconcircle.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.reconcircle.mapcircle addpitch( sizemultiplier );
    arearecondrone.var_90c1b08ecc1bafc9 = spawnstruct();
    arearecondrone.var_90c1b08ecc1bafc9 game_utility::questcircle_create( "AreaDenial", arearecondrone.origin, arearecondrone.radius );
    var_873b8b0b14db018b = direction * speed * sweepduration * 0.5;
    var_a7b1a8806a1a743f = arearecondrone.sweepcenter - var_873b8b0b14db018b;
    arearecondrone.var_37930efe3a5a1c1b = spawnstruct();
    arearecondrone.var_37930efe3a5a1c1b game_utility::questcircle_create( "AreaDenial_Path_Start", var_a7b1a8806a1a743f, arearecondrone.radius );
    sizemultiplier = 8;
    arearecondrone.var_37930efe3a5a1c1b.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.var_37930efe3a5a1c1b.mapcircle addpitch( sizemultiplier );
    arearecondrone.var_37930efe3a5a1c1b game_utility::questcircle_showtoall();
    pathendpos = arearecondrone.sweepcenter + var_873b8b0b14db018b;
    arearecondrone.var_b2e4957dd25f367e = spawnstruct();
    arearecondrone.var_b2e4957dd25f367e game_utility::questcircle_create( "AreaDenial_Path_End", pathendpos, arearecondrone.radius );
    sizemultiplier = 8;
    arearecondrone.var_b2e4957dd25f367e.mapcircle addyaw( vectortoyaw( arearecondrone.direction ) * -1 );
    arearecondrone.var_b2e4957dd25f367e.mapcircle addpitch( sizemultiplier );
    arearecondrone thread function_a639bbbf2bc4a660();
    return arearecondrone;
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x87482c9b, Offset: 0x126d
// Size: 0x151
function function_1855706091bc18b( arearecondrone )
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
    heightlimit = widthlimit * 5.5;
    var_5a40559d8f6250a5 = var_230f68b3e7d826d1 <= widthlimit * widthlimit;
    var_f4f2399663e213dc = var_4c7096939c346967 <= heightlimit;
    var_8dd663f8af1eea46 = var_5a40559d8f6250a5 && var_f4f2399663e213dc && var_4c7096939c346967 > 0;
    return var_8dd663f8af1eea46;
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x65d6f6f3, Offset: 0x13c7
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

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x80eaadcf, Offset: 0x15d9
// Size: 0x65, Type: bool
function function_2d6ba5df1d02a654( arearecondrone )
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
    
    if ( !function_1855706091bc18b( arearecondrone ) )
    {
        return false;
    }
    
    if ( !function_d1e90a208aa31aba( arearecondrone ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x30e4600e, Offset: 0x1647
// Size: 0x1af
function function_d88a81c66534637d()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    level endon( #"hash_4e460b849cc4934e" );
    
    while ( true )
    {
        foreach ( drone in level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d )
        {
            if ( drone.scanningfinished )
            {
                continue;
            }
            
            nearbyplayers = utility::playersincylinder( drone.origin, drone.warningradius, undefined, drone.height );
            
            foreach ( player in nearbyplayers )
            {
                if ( !player function_2d6ba5df1d02a654( drone ) )
                {
                    continue;
                }
                
                br_killstreaks::dangernotifyplayer( player, "areadenial", 3 );
                level thread br_public::brleaderdialogplayer( "pe_areadenial_enter_drone_path", player, 1, 0, 0, undefined, "dx_br_brad_" );
                player.var_3e6effbe2ce42c6e = drone.fleetindex;
            }
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xf18a9035, Offset: 0x17fe
// Size: 0x1d1
function function_1ab9b9719e42d9b4()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x1ab1c607, Offset: 0x19d7
// Size: 0x1d7
function function_e3965afe5cbf22a6()
{
    self endon( #"hash_1939ab86ee3731f6" );
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
    while ( true )
    {
        nearbyplayers = utility::playersincylinder( self.origin, self.radius, undefined, self.height );
        
        foreach ( nearbyplayer in nearbyplayers )
        {
            if ( arraycontains( self.detectedplayers, nearbyplayer ) )
            {
                continue;
            }
            
            thread function_70748d42bab7b4cd( nearbyplayer );
        }
        
        foreach ( detectedplayer in self.detectedplayers )
        {
            if ( arraycontains( nearbyplayers, detectedplayer ) )
            {
                continue;
            }
            
            thread function_e58a30b918de3580( detectedplayer );
        }
        
        /#
            if ( getdvarint( @"hash_e3e9f13280e0fa2f", 0 ) )
            {
                var_f67a110de9ebec9 = self.origin - ( 0, 0, self.height );
                utility::draw_capsule( var_f67a110de9ebec9, self.radius, 2 * self.height );
            }
        #/
        
        wait level.var_11a4edb43fa8ba1c.var_3d3cc93f0e540c9;
    }
}

// Namespace br_publicevent_areadenial
// Params 3
// Checksum 0x6f42ef6e, Offset: 0x1bb6
// Size: 0xfd
function function_a491297c3a8dd5d6( sourcealpha, targetalpha, durationseconds )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    assert( sourcealpha >= 0 && sourcealpha <= 1, "<dev string:x24>" );
    assert( targetalpha >= 0 && targetalpha <= 1, "<dev string:x4b>" );
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

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x70231c12, Offset: 0x1cbb
// Size: 0xae
function function_7333a7c66353da70( durationseconds )
{
    step = level.var_11a4edb43fa8ba1c.var_ef60b858a3301237 * level.framedurationseconds;
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

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x91979846, Offset: 0x1d71
// Size: 0x11a
function function_4efe439dc28c747a( durationseconds )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    self endon( #"hash_1939ab86ee3731f6" );
    widthlimit = self.radius;
    heightlimit = widthlimit * 5.5;
    var_e807fe2204c150d6 = heightlimit * 0.55 / self.sweepspeed;
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x4047e32b, Offset: 0x1e93
// Size: 0x1c
function function_9e99f8b276454169()
{
    function_7333a7c66353da70( level.var_11a4edb43fa8ba1c.var_be6be2bcecf45113 );
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x94c869a8, Offset: 0x1eb7
// Size: 0x22
function function_8c6971bce7ce5e95()
{
    thread function_4efe439dc28c747a( self.sweepduration );
    function_7333a7c66353da70( self.sweepduration );
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x7e46ea95, Offset: 0x1ee1
// Size: 0x71
function function_175d0d59d1d55214()
{
    objective_settint( self.scriptable.iconinfo.all, 255, 255, 255 );
    thread function_a491297c3a8dd5d6( 1, 0, level.var_11a4edb43fa8ba1c.var_ae740116bc7c25b2 );
    function_7333a7c66353da70( level.var_11a4edb43fa8ba1c.var_e5929ecb3fac8d55 );
    self.scriptable function_3070bbc34298d890();
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xe0668c54, Offset: 0x1f5a
// Size: 0x1f5
function function_a639bbbf2bc4a660()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
    if ( !( isdefined( self.sweepduration ) && isdefined( self.radius ) && isdefined( self.origin ) && isdefined( self.scriptable ) && isdefined( self.direction ) ) )
    {
        return;
    }
    
    if ( !( isdefined( self.reconcircle ) && isdefined( self.var_37930efe3a5a1c1b ) && isdefined( self.var_b2e4957dd25f367e ) && isdefined( self.var_90c1b08ecc1bafc9 ) ) )
    {
        return;
    }
    
    function_9e99f8b276454169();
    self.var_37930efe3a5a1c1b game_utility::questcircle_delete();
    self.reconcircle game_utility::questcircle_showtoall();
    self.var_b2e4957dd25f367e game_utility::questcircle_showtoall();
    thread function_e3965afe5cbf22a6();
    objidpoolmanager::function_373aaf492aabde6f( self.scriptable.scriptedobjid, 141, 42, 42 );
    function_8c6971bce7ce5e95();
    self notify( #"hash_1939ab86ee3731f6" );
    self.scanningfinished = 1;
    self.var_90c1b08ecc1bafc9 game_utility::questcircle_delete();
    self.var_b2e4957dd25f367e game_utility::questcircle_delete();
    
    foreach ( player in self.detectedplayers )
    {
        thread function_e58a30b918de3580( player );
    }
    
    level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d = arrayremove( level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d, self );
    function_175d0d59d1d55214();
    self.scriptable delete();
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x8b8fcfe7, Offset: 0x2157
// Size: 0x123
function function_70748d42bab7b4cd( player )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
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
    level.var_11a4edb43fa8ba1c.detectedplayers = arraycombineunique( level.var_11a4edb43fa8ba1c.detectedplayers, [ player ] );
    player function_a795389146361a90( 1 );
    player function_c96735b095fc54b4( 4 );
    player.var_aaa4bf8b1e3f1cce = 1;
    player function_b64e34e878f56c6e( 1 );
    level thread br_public::brleaderdialogplayer( "pe_areadenial_enter_detection_radius", player, 1, 0, 0, undefined, "dx_br_brad_" );
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x848f35d5, Offset: 0x2282
// Size: 0x110
function function_e58a30b918de3580( player )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    
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
    level.var_11a4edb43fa8ba1c.detectedplayers = arrayremove( level.var_11a4edb43fa8ba1c.detectedplayers, player );
    player utility::waittill_any_timeout( level.var_11a4edb43fa8ba1c.var_8d3f48cbb7b82e5e, "death" );
    player function_a795389146361a90( 0 );
    player function_2c796b5cbe343df3( 4 );
    player function_b64e34e878f56c6e( 0 );
}

// Namespace br_publicevent_areadenial
// Params 2
// Checksum 0x548b9ed5, Offset: 0x239a
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
        var_e5e0a799863ba1e = function_196c9a8f11e5f3d6( sweepcenter, level.var_11a4edb43fa8ba1c.var_5cc32dc41fccc789 );
        
        if ( isdefined( var_e5e0a799863ba1e ) )
        {
            var_d20473ac00e8d6f3 = sweepcenter - var_e5e0a799863ba1e;
            var_44914230f9c8ca9b = length( var_d20473ac00e8d6f3 );
            rotationangle = acos( level.var_11a4edb43fa8ba1c.var_5cc32dc41fccc789 / var_44914230f9c8ca9b );
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

// Namespace br_publicevent_areadenial
// Params 2
// Checksum 0xd6489c7e, Offset: 0x249a
// Size: 0x164
function function_19b2b22feb3a2a5d( sweepcenter, sweepdirection )
{
    if ( !( isdefined( sweepcenter ) && isdefined( sweepdirection ) ) )
    {
        return sweepcenter;
    }
    
    dangercircleorigin = br_circle::getdangercircleorigin();
    dangercircleradius = br_circle::getdangercircleradius();
    var_5436c5cc66e633c5 = level.var_11a4edb43fa8ba1c.var_ef60b858a3301237 * level.var_11a4edb43fa8ba1c.var_71708baadc72719c * 0.5;
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

// Namespace br_publicevent_areadenial
// Params 2
// Checksum 0xf31338bf, Offset: 0x2607
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x852bf54d, Offset: 0x2715
// Size: 0x1a0
function function_3cf1f9577d55f8be()
{
    if ( isdefined( level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4 ) && level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4.size > 0 )
    {
        return level.var_11a4edb43fa8ba1c.var_3ce3c58d1579fb4;
    }
    
    delays = [];
    
    if ( !( isdefined( level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c ) && isdefined( level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations ) ) || !isarray( level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations ) || level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations.size <= 0 )
    {
        return delays;
    }
    
    selectedformation = utility::random_weighted_struct( level.var_11a4edb43fa8ba1c.var_2e1ed8612ee39a2c.fleetformations );
    
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

// Namespace br_publicevent_areadenial
// Params 2
// Checksum 0x681d1a45, Offset: 0x28be
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

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x8d9daf3e, Offset: 0x29a1
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xa5c63a04, Offset: 0x2a4e
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x17933c6a, Offset: 0x2b1e
// Size: 0x8
function function_58f473c4a51e1b5b()
{
    return function_f4cded4a570ec778();
}

// Namespace br_publicevent_areadenial
// Params 3
// Checksum 0x89ec841f, Offset: 0x2b2f
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xc0978630, Offset: 0x2b8a
// Size: 0x17
function waitfunc()
{
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xf21914b0, Offset: 0x2ba9
// Size: 0x9
function function_c7a6338c6f315a82()
{
    eventcleanup();
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xcdc27382, Offset: 0x2bba
// Size: 0x1bb
function eventcleanup()
{
    level notify( #"hash_57e3556f0eb5a22d" );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    
    foreach ( drone in level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d )
    {
        if ( isarray( drone.detectedplayers ) && drone.detectedplayers.size > 0 )
        {
            foreach ( player in drone.detectedplayers )
            {
                drone thread function_e58a30b918de3580( player );
            }
        }
        
        drone.var_37930efe3a5a1c1b game_utility::questcircle_delete();
        drone.var_b2e4957dd25f367e game_utility::questcircle_delete();
        drone.reconcircle game_utility::questcircle_delete();
        drone.var_90c1b08ecc1bafc9 game_utility::questcircle_delete();
        drone.scriptable function_3070bbc34298d890();
        drone.scriptable delete();
    }
    
    level.var_11a4edb43fa8ba1c.var_faf6d07a43ff6f7d = [];
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x6ca915b6, Offset: 0x2d7d
// Size: 0x90
function starttimer( var_6178022a28917e8 )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level endon( #"hash_57e3556f0eb5a22d" );
    eventduration = var_6178022a28917e8;
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer_type", 16 );
    setomnvar( "ui_publicevent_timer", eventendtime );
    setomnvar( "ui_minimap_pulse", 1 );
    wait var_6178022a28917e8;
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x9dca6aee, Offset: 0x2e15
// Size: 0x6a
function calculateeventstarttime()
{
    if ( level.var_11a4edb43fa8ba1c.maxstarttime > level.var_11a4edb43fa8ba1c.minstarttime )
    {
        return randomfloatrange( level.var_11a4edb43fa8ba1c.minstarttime, level.var_11a4edb43fa8ba1c.maxstarttime );
    }
    
    return level.var_11a4edb43fa8ba1c.minstarttime;
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x99cb6669, Offset: 0x2e88
// Size: 0x56
function function_1ee321deeb8f07cf( fleetidx )
{
    if ( !isdefined( fleetidx ) || fleetidx < 0 )
    {
        return;
    }
    
    if ( fleetidx == 0 )
    {
        level thread br_public::brleaderdialog( "pe_areadenial_event_begin", 1, undefined, 0, 0, undefined, "dx_br_brad_" );
        return;
    }
    
    level thread br_public::brleaderdialog( "pe_areadenial_new_sweep", 1, undefined, 0, 0, undefined, "dx_br_brad_" );
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0xf7ccd135, Offset: 0x2ee6
// Size: 0x19
function function_b64e34e878f56c6e( value )
{
    self setclientomnvar( "ui_br_area_denial", value );
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xf5c75433, Offset: 0x2f07
// Size: 0xfb
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
    callback::add( "br_player_killed", &function_19cf511c86313288, undefined );
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xc438b985, Offset: 0x300a
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

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x756051dd, Offset: 0x312e
// Size: 0xb8
function function_3d466d97dc222b14()
{
    dlog_recordevent( "dlog_event_areadenial_match_event", [ "circle_index", level.var_11a4edb43fa8ba1c.dlogdata[ "circle_index" ], "affected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "affected_player_count_per_sweep" ].size, "detected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "detected_player_count_per_sweep" ].size, "killed_detected_player_count_per_sweep", level.var_11a4edb43fa8ba1c.dlogdata[ "killed_detected_player_count_per_sweep" ] ] );
    callback::remove( "br_player_killed", &function_19cf511c86313288 );
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0xe0c196c7, Offset: 0x31ee
// Size: 0x5b
function function_19cf511c86313288( player )
{
    if ( !arraycontains( level.var_11a4edb43fa8ba1c.var_dcacbc9defe69d8, player ) )
    {
        level.var_11a4edb43fa8ba1c.var_c1890f722804aca6 = arraycombineunique( level.var_11a4edb43fa8ba1c.var_c1890f722804aca6, [ player ] );
    }
}

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0xe374016f, Offset: 0x3251
// Size: 0x59
function function_66df55ac471440ed( allicon )
{
    gameent = self;
    gameent.iconinfo = spawnstruct();
    gameent.iconinfo.owner = gameent;
    gameent.iconinfo.allicon = allicon;
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0xc9c4e287, Offset: 0x32b2
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

// Namespace br_publicevent_areadenial
// Params 2
// Checksum 0x8deafe9d, Offset: 0x32ee
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

// Namespace br_publicevent_areadenial
// Params 1
// Checksum 0x26875c76, Offset: 0x33af
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

// Namespace br_publicevent_areadenial
// Params 4
// Checksum 0xd2f1275f, Offset: 0x3438
// Size: 0xd1
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
        objidpoolmanager::objective_playermask_showtoallplayers( objid );
        gameent.scriptedobjid = objid;
    }
    else
    {
        println( "<dev string:x72>" );
    }
    
    return objid;
}

// Namespace br_publicevent_areadenial
// Params 0
// Checksum 0x83b061f1, Offset: 0x3512
// Size: 0x1e, Type: bool
function function_6ad72cf932037eb6()
{
    gameent = self;
    return gameent.origin ?? undefined;
}

/#

    // Namespace br_publicevent_areadenial
    // Params 0
    // Checksum 0xf2d5bf5d, Offset: 0x3539
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_areadenial
    // Params 0
    // Checksum 0x96532d2b, Offset: 0x3546
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9e>" );
        devgui::add_devgui_func( "<dev string:xb0>", "<dev string:xbc>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_areadenial
    // Params 0
    // Checksum 0xe5a226f9, Offset: 0x357c
    // Size: 0x16, Type: dev
    function debug_start_event()
    {
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"areadenial" );
    }

#/
