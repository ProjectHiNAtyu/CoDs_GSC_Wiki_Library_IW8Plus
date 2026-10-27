// script_709d18f95842bb08  (hash_709d18f95842bb08.gscc) (size: 7994 Bytes / 0x1f3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf0a2b32 (3205114674)
// size ...... 7994 (0x1f3a)
// includes .. 15  (offset: 0x1dca)
// strings ... 13  (offset: 0x1e42)
// dev strs .. 3   (offset: 0x1f16)
// exports ... 25  (offset: 0x11be)
// cseg ...... 0x18b + 0x1033 (0x11be)
// imports ... 71  (offset: 0x15a6)
// animtree1 . 0   (offset: 0x1f3a)
// animtree2 . 0   (offset: 0x1f3a)
#using script_16ea1b94f0f381b3;
#using script_2202b0478c57bf0d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\challenges;
#using scripts\mp\loot\common_item;
#using scripts\mp\poi;

#namespace namespace_7b0a77fff21d2364;

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x5
// Checksum 0x19097e10, Offset: 0x1a9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_20b69f2e04df3783", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x48469afe, Offset: 0x1d2
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0x7b8c974b, Offset: 0x202
// Size: 0xcf
function private function_323fab1b62a2d5d4( eventinfo )
{
    if ( getdvarint( @"scr_special_loot_drone_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "public_events_special_loot_drone_start" ] = "wzan_sld_start";
    game[ "dialog" ][ "public_events_special_loot_drone_end" ] = "wzan_sld_end";
    activity_definition = activity_definition_utils::function_74af1ab4059e3c06( hashcat( %"activitydefinition:", eventinfo.event ), eventinfo.event );
    var_6be487d5d348ad9 = activity_definition_utils::function_9129cd8075c85c09( activity_definition );
    
    if ( var_6be487d5d348ad9.var_6c0951b0e7828e19 )
    {
        activity_definition_utils::function_74af1ab4059e3c06( var_6be487d5d348ad9.var_6c0951b0e7828e19, eventinfo.event + "_camocase" );
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x121fddb2, Offset: 0x2d9
// Size: 0x75
function private activity_type_init()
{
    if ( getdvarint( @"scr_special_loot_drone_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_SPECIAL_LOOT_DRONE", 4, &function_cd1743780b21e3b9 );
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x8712ff2c, Offset: 0x356
// Size: 0xf9
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    
    if ( !airdrop_scriptbundle::function_fa19528c206bd43( self.var_332f929de1894b2b.airdropasset ) )
    {
        airdropidentifier = self.var_332f929de1894b2b.airdropasset ?? "airdrop_special_loot_drone";
        airdrop_scriptbundle::registerairdrop( airdropidentifier );
        airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"hash_852023c9f529dca6", &on_airdrop_drone_destroyed );
        airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"hash_e9a6accd033eb4b9", &function_18064d72dd94f140 );
        airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"hash_82fb75eefaf0a89a", &function_c331e257529feedc );
        airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"hash_cb68d69fe85eb56f", &function_6fcc5ed947b41e9d );
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
    utility::registersharedfunc( #"special_loot_drone", #"get_airdrop_variant_tag", &get_airdrop_variant_tag );
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x5d25e585, Offset: 0x457
// Size: 0x2da
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    eventduration = getdvarfloat( @"scr_special_loot_drone_duration", activity_instance.var_332f929de1894b2b.eventduration ?? 600 );
    circleorigin = br_circle::getsafecircleorigin();
    circleradius = br_circle::getsafecircleradius();
    spawnradius = min( activity_instance.var_332f929de1894b2b.dronespawnradius ?? 3000, circleradius );
    broadcastradius = getdvarint( @"hash_21df8e7e358b1d4a", activity_instance.var_332f929de1894b2b.var_bd15178aa8dbab44 ?? 5000 );
    airdropidentifier = activity_instance.var_332f929de1894b2b.airdropasset ?? "airdrop_special_loot_drone";
    blockedpois = get_blocked_pois( activity_instance );
    activity_instance.var_5d497cb6387efd85 = 1;
    activity_instance.eventduration = eventduration;
    droporigin = function_a527be0838563efe( circleorigin, spawnradius, blockedpois );
    activity_instance.var_36d8f8fa22cc14f6 = droporigin;
    
    /#
        thread function_32facb95ca254f8f( activity_instance );
    #/
    
    overrideoptions = { #extradata:{ #activity_instance:activity_instance }, #dropradius:activity_instance.var_332f929de1894b2b.var_8bbc9a83f266ac43 ?? 100, #droporigin:droporigin };
    level.var_9261f0f8b80230ec = activity_instance.varianttag;
    airdropbundle = level.package_airdrop.airdroptypes[ airdropidentifier ];
    packagesettings = level.package_airdrop.airdroptypes[ airdropbundle.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( packagesettings )
    {
        packagesettings.delivertimeout = eventduration;
    }
    
    thread airdrop_scriptbundle::startairdrop( airdropidentifier, undefined, undefined, overrideoptions );
    thread function_ce44061c9d1d92b7( activity_instance, spawnradius, blockedpois );
    activity_center = activity_instance_common::function_776ee11e7acc64a5( activity_instance );
    var_f438b4e0dbebfa34 = function_3f45c9a665df2b01( activity_center, broadcastradius );
    relevant_info = { #playerlist:var_f438b4e0dbebfa34 };
    activity_instance_common::function_5e2f9c673ccd965f( activity_instance, "br_pe_special_loot_drone_start", relevant_info );
    br_public::brleaderdialog( "public_events_special_loot_drone_start", 1, var_f438b4e0dbebfa34, 0, 0, undefined, "dx_br_brfe_sld_" );
    activity_instance.eventendtime = gettime() + int( eventduration * 1000 );
    function_64f89731b13ded4b( activity_instance, eventduration );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x8118f47e, Offset: 0x739
// Size: 0xb
function private get_airdrop_variant_tag()
{
    return level.var_9261f0f8b80230ec;
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0x6fc6bebb, Offset: 0x74d
// Size: 0x6a
function private function_3f45c9a665df2b01( droporigin, radius = 5000 )
{
    switch ( radius )
    {
        case -1:
            return level.players;
        case 0:
            return [];
        default:
            return function_c44b31a67523b336( level.players, droporigin, radius );
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0x9934fe8f, Offset: 0x7bf
// Size: 0xb
function private function_cd1743780b21e3b9()
{
    return self.var_36d8f8fa22cc14f6;
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0xdd0f1ea9, Offset: 0x7d3
// Size: 0x70
function private function_6fcc5ed947b41e9d( drone )
{
    if ( !drone.airdropsettings.overrideoptions.extradata.activity_instance )
    {
        return;
    }
    
    drone.airdropsettings.overrideoptions.extradata.activity_instance.var_ab003be494980a36 = drone;
}

// Namespace namespace_7b0a77fff21d2364
// Params 3, eflags: 0x4
// Checksum 0x798105b6, Offset: 0x84b
// Size: 0xd4
function private function_ce44061c9d1d92b7( activity_instance, var_8ad66498c2bca923, blockedpois )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        circleorigin = br_circle::getsafecircleorigin();
        circleradius = br_circle::getsafecircleradius();
        var_68c55dd97522e111 = min( var_8ad66498c2bca923, circleradius );
        var_9baf832fa024b3bb = function_a527be0838563efe( circleorigin, var_68c55dd97522e111, blockedpois );
        
        if ( !isdefined( var_9baf832fa024b3bb ) )
        {
            continue;
        }
        
        activity_instance.var_36d8f8fa22cc14f6 = var_9baf832fa024b3bb;
        drone = activity_instance.var_ab003be494980a36;
        
        if ( drone )
        {
            drone.droporigin = var_9baf832fa024b3bb;
        }
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0xb009fef4, Offset: 0x927
// Size: 0x15b
function private on_airdrop_drone_destroyed( drone, eattacker )
{
    if ( !drone.airdropsettings.overrideoptions.extradata )
    {
        return;
    }
    
    extradata = drone.airdropsettings.overrideoptions.extradata;
    packagesettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    itemspawnlist = packagesettings.itemspawnlist;
    itemsquantity = packagesettings.itemsquantity ?? 1;
    
    if ( itemspawnlist )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( drone.origin );
        level common_item::function_38cde6a6acb68ea6( itemspawnlist, itemsquantity, spawnoptions );
    }
    
    function_91d1c79276d02f0( drone );
    
    if ( isplayer( eattacker ) )
    {
        challenges::function_37e945722d6497f3( eattacker, "saw_special_loot_drone_destruction", 1, 0 );
    }
    
    if ( extradata.activity_instance.var_5d497cb6387efd85 > 0 )
    {
        extradata.activity_instance.var_5d497cb6387efd85--;
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0xedb66d2e, Offset: 0xa8a
// Size: 0xa7
function private function_18064d72dd94f140( drone, eattacker )
{
    if ( !isdefined( drone.airdropsettings.overrideoptions.extradata ) )
    {
        return;
    }
    
    if ( !isdefined( drone.package ) )
    {
        return;
    }
    
    extradata = drone.airdropsettings.overrideoptions.extradata;
    drone.package.camocasevarianttag = extradata.activity_instance.varianttag + "_camocase";
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0x386a8e5, Offset: 0xb39
// Size: 0x94
function private function_c331e257529feedc( drone )
{
    if ( !drone.airdropsettings.overrideoptions.extradata )
    {
        return;
    }
    
    drone namespace_df4ff65d6946b16b::function_3168a034ee7decb5();
    extradata = drone.airdropsettings.overrideoptions.extradata;
    
    if ( extradata.activity_instance.var_5d497cb6387efd85 > 0 )
    {
        extradata.activity_instance.var_5d497cb6387efd85--;
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0xcf597e40, Offset: 0xbd5
// Size: 0x99
function private function_91d1c79276d02f0( drone )
{
    foreach ( player in drone.var_904083cc887feb96 )
    {
        if ( isplayer( player ) )
        {
            player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_4f796c46651afc0d" );
        }
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0xd326b538, Offset: 0xc76
// Size: 0x4d
function private function_64f89731b13ded4b( activity_instance, eventduration )
{
    endtime = activity_instance.eventendtime;
    
    while ( gettime() < endtime )
    {
        if ( activity_instance.var_5d497cb6387efd85 <= 0 )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0xde73d6c2, Offset: 0xccb
// Size: 0xd8
function private get_blocked_pois( activity_instance )
{
    blockedpois = [];
    poilist = getdvar( @"hash_5f312b7872c12115", "" );
    
    if ( poilist == "" )
    {
        poilist = activity_instance.var_332f929de1894b2b.blockedpois ?? "";
    }
    
    foreach ( poiname in strtok( poilist, "," ) )
    {
        blockedpois[ poiname ] = 1;
    }
    
    return blockedpois;
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0xccaa8da7, Offset: 0xdac
// Size: 0x3f, Type: bool
function private function_2e71fafdbf4cd952( origin, blockedpois )
{
    if ( !blockedpois.size )
    {
        return false;
    }
    
    poiname = poi::poi_findpoioriginisin( origin, 1 );
    return isdefined( poiname ) && blockedpois[ poiname ];
}

// Namespace namespace_7b0a77fff21d2364
// Params 3, eflags: 0x4
// Checksum 0x8c17c11c, Offset: 0xdf4
// Size: 0xf8
function private function_a527be0838563efe( center, radius, blockedpois = [] )
{
    for ( attempt = 0; attempt < 10 ; attempt++ )
    {
        angle = randomint( 360 );
        dist = randomintrange( int( radius * 0.2 ), int( radius ) );
        x = center[ 0 ] + dist * cos( angle );
        y = center[ 1 ] + dist * sin( angle );
        testpos = ( x, y, center[ 2 ] + 1000 );
        groundpos = getgroundposition( testpos, 1 );
        
        if ( groundpos && utility::function_d9f2bbbeb0e054b8( groundpos ) && !function_2e71fafdbf4cd952( groundpos, blockedpois ) )
        {
            return groundpos;
        }
    }
    
    assertmsg( "<dev string:x2b>" );
}

// Namespace namespace_7b0a77fff21d2364
// Params 1, eflags: 0x4
// Checksum 0x919d6d94, Offset: 0xef5
// Size: 0xfb
function private activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    br_public::brleaderdialog( "public_events_special_loot_drone_end", 1, undefined, 0, 0, undefined, "dx_br_brfe_sld_" );
    drone = activity_instance.var_ab003be494980a36;
    eventduration = activity_instance.eventduration;
    
    if ( drone && !drone.var_a1e594c2cae42e0b && !drone.var_f97ddc37d2cacd36 && !drone.var_dcf7b7678590b6c5 && !drone.var_44f52ace6119ee1d )
    {
        var_68d5c64e3eb8bc82 = activity_instance.eventendtime ? max( 0, activity_instance.eventendtime - gettime() ) : 0;
        drone thread function_cc5fb9c879406db1( eventduration, var_68d5c64e3eb8bc82 * 0.001 );
    }
}

// Namespace namespace_7b0a77fff21d2364
// Params 2, eflags: 0x4
// Checksum 0x4ac6c05b, Offset: 0xff8
// Size: 0xa9
function private function_cc5fb9c879406db1( eventduration, delay )
{
    level endon( #"game_ended" );
    drone = self;
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( !isdefined( drone ) || drone.var_a1e594c2cae42e0b || drone.var_f97ddc37d2cacd36 || drone.var_dcf7b7678590b6c5 || drone.var_44f52ace6119ee1d )
    {
        return;
    }
    
    drone.washovering = 1;
    drone.var_c6f24c128f315724 = gettime() - int( eventduration * 1000 ) - 1000;
}

// Namespace namespace_7b0a77fff21d2364
// Params 0, eflags: 0x4
// Checksum 0xe603233c, Offset: 0x10a9
// Size: 0x23
function private function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    br_activity_util::function_f24cad5d113f4f52();
}

/#

    // Namespace namespace_7b0a77fff21d2364
    // Params 0
    // Checksum 0xedb36fdc, Offset: 0x10d4
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace namespace_7b0a77fff21d2364
    // Params 1, eflags: 0x4
    // Checksum 0xa01f6f0, Offset: 0x10e1
    // Size: 0xdd, Type: dev
    function private function_32facb95ca254f8f( activity_instance )
    {
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        droplocation = activity_instance.var_36d8f8fa22cc14f6;
        
        if ( !droplocation )
        {
            return;
        }
        
        dropradius = activity_instance.var_332f929de1894b2b.var_8bbc9a83f266ac43 ?? 100;
        color = ( 1, 0.6, 0 );
        
        while ( true )
        {
            print3d( droplocation + ( 0, 0, 50 ), "<dev string:x6f>", color, 1, 1, 1 );
            line( droplocation, droplocation + ( 0, 0, 200 ), color, 1, 0, 1 );
            utility::draw_circle( droplocation, dropradius, color, 1, 0, 1 );
            waitframe();
        }
    }

#/
