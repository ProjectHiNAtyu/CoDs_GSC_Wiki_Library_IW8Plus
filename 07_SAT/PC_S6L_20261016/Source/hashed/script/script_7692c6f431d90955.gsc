// script_7692c6f431d90955  (hash_7692c6f431d90955.gscc) (size: 7130 Bytes / 0x1bda / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x628ee2e2 (1653531362)
// size ...... 7130 (0x1bda)
// includes .. 7   (offset: 0x1b4e)
// strings ... 7   (offset: 0x1b86)
// dev strs .. 0   (offset: 0x1bda)
// exports ... 12  (offset: 0x13ea)
// cseg ...... 0x1a6 + 0x1244 (0x13ea)
// imports ... 48  (offset: 0x15ca)
// animtree1 . 0   (offset: 0x1bda)
// animtree2 . 0   (offset: 0x1bda)
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\objidpoolmanager;

#namespace namespace_d3fbfe58dd81a4f;

// Namespace namespace_d3fbfe58dd81a4f
// Params 0, eflags: 0x5
// Checksum 0x1f57ea42, Offset: 0x1c4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1ab959acb31b6f8e", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 0, eflags: 0x4
// Checksum 0xe556d858, Offset: 0x1ed
// Size: 0x38
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"start_airdrop", #"plane", &function_672bddac5319e7c1 );
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0x11244b2c, Offset: 0x22d
// Size: 0x272
function private function_672bddac5319e7c1( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    planescount = airdropsettings.overrideoptions.planescount ?? var_ef8325c1086c2688.planescount;
    var_e99a789e113b7ba4 = airdropsettings.overrideoptions.var_e99a789e113b7ba4 ?? var_ef8325c1086c2688.var_e99a789e113b7ba4;
    
    if ( !airdrop_scriptbundle::function_db12c5dff94a61c5( airdropsettings ) && var_e99a789e113b7ba4 == 1 && var_ef8325c1086c2688.var_bfe41a56ee5786f4 == 1 && planescount == 1 )
    {
        var_9879959f256d5c55 = airdrop_scriptbundle::function_9bb59dc8e54b24b6( airdropsettings.droparea );
        
        if ( isdefined( var_9879959f256d5c55 ) )
        {
            airdropsettings.droparea = { #radius:1, #origin:var_9879959f256d5c55 };
        }
    }
    
    planesarray = function_c8f0ee8ed686b47e( airdropsettings );
    var_1a42c8fdb124ea5c = var_e99a789e113b7ba4;
    var_9d3b548cb3ab0ff = int( ceil( var_e99a789e113b7ba4 / planesarray.size ) );
    
    foreach ( plane in planesarray )
    {
        plane.var_98f68feda456c65f = minint( var_9d3b548cb3ab0ff, var_1a42c8fdb124ea5c );
        plane thread startplane( airdropsettings );
        var_1a42c8fdb124ea5c -= var_9d3b548cb3ab0ff;
    }
    
    planesarray[ planesarray.size - 1 ] waittill( #"hash_f774a7b82f6e431c" );
    droppedpackages = [];
    
    foreach ( plane in planesarray )
    {
        if ( plane )
        {
            droppedpackages = arraycombine( droppedpackages, plane.droppedpackages );
        }
    }
    
    return droppedpackages;
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0xe11719fe, Offset: 0x4a8
// Size: 0x15d
function private function_c8f0ee8ed686b47e( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    planescount = airdropsettings.overrideoptions.planescount ?? var_ef8325c1086c2688.planescount;
    
    if ( planescount <= 0 )
    {
        return [];
    }
    
    if ( planescount > 1 )
    {
        switch ( var_ef8325c1086c2688.var_bc03076cd80bd03f )
        {
            case #"hash_eb00cb01bd7a6e7b":
                return function_f4cd692075dc51be( airdropsettings );
            case #"hash_3bb1bfa4daffa801":
                return function_eec927f40aec5e14( airdropsettings );
        }
    }
    
    flightangles = airdropsettings.extradata.planeangles ?? ( 0, randomfloat( 360 ), 0 );
    planeheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.planeheight;
    singleplane = function_868dcd0d59a4b711( airdropsettings, airdropsettings.droparea.origin, airdropsettings.droparea, flightangles, planeheight );
    return [ singleplane ];
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 5, eflags: 0x4
// Checksum 0xec81f1d8, Offset: 0x60e
// Size: 0x382
function private function_868dcd0d59a4b711( airdropsettings, targetorigin, droparea, angles, height )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    flyintime = br_c130::function_1a0e2af4b3229059();
    pathradius = max( airdropsettings.overrideoptions.planepathradius ?? droparea.radius, droparea.radius );
    startpadding = airdropsettings.overrideoptions.var_a238f8847e16057e ?? var_ef8325c1086c2688.planespeed * flyintime;
    endpadding = airdropsettings.overrideoptions.var_7ce84f7710a333d1 ?? 100000;
    direction = anglestoforward( angles );
    startorigin = targetorigin - direction * pathradius;
    endorigin = targetorigin + direction * pathradius;
    startorigin -= direction * startpadding;
    endorigin += direction * endpadding;
    
    if ( var_ef8325c1086c2688.var_ea019c07729190a8 )
    {
        height = targetorigin[ 2 ] + height;
    }
    
    startorigin = ( startorigin[ 0 ], startorigin[ 1 ], height );
    endorigin = ( endorigin[ 0 ], endorigin[ 1 ], height );
    distance = distance( startorigin, endorigin );
    time = distance / var_ef8325c1086c2688.planespeed;
    plane = spawn( "script_model", startorigin );
    plane setmodel( var_ef8325c1086c2688.planemodel );
    plane setscriptablepartstate( "objective", "inactive" );
    plane setcandamage( 0 );
    plane.maxhealth = 100000;
    plane.health = plane.maxhealth;
    plane.startpt = startorigin;
    plane.endpt = endorigin;
    plane.centerpt = targetorigin;
    plane.dir = direction;
    plane.angles = angles;
    plane.pathdist = distance;
    plane.speed = var_ef8325c1086c2688.planespeed;
    plane.lifetime = time;
    plane.owner = airdropsettings.ownerplayer;
    plane.team = airdropsettings.ownerteam;
    plane.droparea = droparea;
    plane.height = height;
    plane.minimapid = plane objidpoolmanager::createobjective( var_ef8325c1086c2688.planeobjectiveicon, undefined, undefined, 1, 1 );
    
    if ( isdefined( var_ef8325c1086c2688.var_cae7b1dbaa7b8150 ) && plane.minimapid > -1 )
    {
        rgbcolor = utility::function_c5d9978d36c9459e( var_ef8325c1086c2688.var_cae7b1dbaa7b8150 );
        objidpoolmanager::function_373aaf492aabde6f( plane.minimapid, rgbcolor[ 0 ], rgbcolor[ 1 ], rgbcolor[ 2 ] );
    }
    
    level.package_airdrop.activeplanes[ level.package_airdrop.activeplanes.size ] = plane;
    return plane;
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0x895e78b7, Offset: 0x999
// Size: 0x200
function private function_eec927f40aec5e14( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    planescount = airdropsettings.overrideoptions.planescount ?? var_ef8325c1086c2688.planescount;
    
    if ( planescount < 1 )
    {
        script::demoforcesre( "Scriptbundle Package Airdrop: Delta formation requires at least 1 plane." );
        return [];
    }
    
    dropradius = airdropsettings.droparea.radius;
    basespacing = dropradius * 1.5 / max( 2, planescount - 1 );
    planeheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.planeheight;
    planes = [];
    flightangles = ( 0, randomfloat( 360 ), 0 );
    flightdirection = anglestoforward( flightangles );
    rightdirection = anglestoright( flightangles );
    backwardoffset = 0;
    sideoffset = 0;
    
    for ( i = 0; i < planescount ; i++ )
    {
        isright = !( i & 1 );
        directionmultiplier = isright ? 1 : -1;
        offset = sideoffset * directionmultiplier * rightdirection - flightdirection * backwardoffset;
        var_d9115cd9c3fc0fab = airdropsettings.droparea.origin + offset;
        plane = function_868dcd0d59a4b711( airdropsettings, var_d9115cd9c3fc0fab, airdropsettings.droparea, flightangles, planeheight );
        planes[ planes.size ] = plane;
        
        if ( isright )
        {
            backwardoffset += basespacing;
            sideoffset += basespacing;
        }
    }
    
    return planes;
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0x9cb360b8, Offset: 0xba2
// Size: 0x188
function private function_f4cd692075dc51be( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    planescount = airdropsettings.overrideoptions.planescount ?? var_ef8325c1086c2688.planescount;
    var_52ba350fdcfcc2fc = int( ceil( 360 / planescount ) );
    var_2b3d24a375141680 = 250;
    planeheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.planeheight;
    flightangles = ( 0, randomfloat( 360 ), 0 );
    planes = [];
    
    for ( i = 0; i < planescount ; i++ )
    {
        plane = function_868dcd0d59a4b711( airdropsettings, airdropsettings.droparea.origin, airdropsettings.droparea, flightangles, planeheight );
        plane.dropdelay = randomfloatrange( 0, plane.droparea.radius / plane.speed );
        planes[ planes.size ] = plane;
        planeheight += var_2b3d24a375141680;
        flightangles = ( 0, ( flightangles[ 1 ] + var_52ba350fdcfcc2fc ) % 360, 0 );
    }
    
    return planes;
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0x20649f72, Offset: 0xd33
// Size: 0x187
function private startplane( airdropsettings )
{
    plane = self;
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    plane.airdropsettings = airdropsettings;
    
    if ( var_ef8325c1086c2688.planesound )
    {
        self playloopsound( var_ef8325c1086c2688.planesound );
    }
    
    plane moveto( plane.endpt, plane.lifetime );
    plane thread function_7b9bbfef1858d117();
    
    if ( airdropsettings.overrideoptions.var_55c241b661fa662f )
    {
        plane.droppedpackages = plane [[ airdropsettings.overrideoptions.var_55c241b661fa662f ]]( airdropsettings );
        plane notify( #"hash_f774a7b82f6e431c" );
        return plane.droppedpackages;
    }
    
    if ( packagesettings.type == #"custom" )
    {
        if ( airdropsettings.var_a4021a4bc7d38fea )
        {
            plane [[ airdropsettings.var_a4021a4bc7d38fea ]]( airdropsettings );
        }
        
        return [];
    }
    
    return plane function_dc5cb0c70d811c40( airdropsettings );
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 0, eflags: 0x4
// Checksum 0x14eb0cb7, Offset: 0xec2
// Size: 0x130
function private function_7b9bbfef1858d117()
{
    plane = self;
    level endon( #"game_ended" );
    utility::function_1e67f95b5bdb410( plane.lifetime - 1, plane, "death" );
    
    if ( isdefined( plane ) )
    {
        var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
        
        if ( var_ef8325c1086c2688.var_cd41ad1ab85f0baf )
        {
            plane playsound( var_ef8325c1086c2688.var_cd41ad1ab85f0baf );
        }
    }
    
    wait 1;
    
    if ( isdefined( plane ) )
    {
        if ( isdefined( plane.minimapid ) )
        {
            objidpoolmanager::returnobjectiveid( plane.minimapid );
        }
        
        level.package_airdrop.activeplanes = arrayremove( level.package_airdrop.activeplanes, plane );
        plane delete();
        return;
    }
    
    level.package_airdrop.activeplanes = function_5713d46873b29625( level.package_airdrop.activeplanes );
}

// Namespace namespace_d3fbfe58dd81a4f
// Params 1, eflags: 0x4
// Checksum 0x98cb4917, Offset: 0xffa
// Size: 0x2e3
function private function_dc5cb0c70d811c40( airdropsettings )
{
    plane = self;
    plane.droppedpackages = [];
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    var_f9627035c5111f66 = math::function_14a305b0209b352c( plane.startpt, plane.endpt, airdropsettings.droparea.origin, airdropsettings.droparea.radius );
    
    if ( !isdefined( var_f9627035c5111f66 ) )
    {
        script::demoforcesre( "Scriptbundle Package Airdrop: Could not find intersection between plane path and drop area." );
        return;
    }
    
    if ( var_f9627035c5111f66.size == 1 )
    {
        script::demoforcesre( "Scriptbundle Package Airdrop: Only one intersection found between plane path and drop area." );
        return;
    }
    
    intersectionlength = distance2d( var_f9627035c5111f66[ 0 ], var_f9627035c5111f66[ 1 ] );
    var_c73c4aba5bc1e21b = min( distance2d( plane.startpt, var_f9627035c5111f66[ 0 ] ), distance2d( plane.startpt, var_f9627035c5111f66[ 1 ] ) );
    
    if ( plane.var_98f68feda456c65f <= 2 )
    {
        cratesspacing = intersectionlength / ( plane.var_98f68feda456c65f + 1 );
        var_c73c4aba5bc1e21b += cratesspacing;
    }
    else
    {
        var_7d27cc838d71abc = min( 1000, intersectionlength / ( plane.var_98f68feda456c65f - 1 ) );
        cratesspacing = ( intersectionlength - var_7d27cc838d71abc * 2 ) / ( plane.var_98f68feda456c65f - 1 );
        var_c73c4aba5bc1e21b += var_7d27cc838d71abc;
    }
    
    /#
        thread function_4b638bbe31d58d4e( plane, var_c73c4aba5bc1e21b, cratesspacing );
    #/
    
    var_eb9f3b2c1683ab1b = 0;
    
    if ( packagesettings.useparachute )
    {
        var_eb9f3b2c1683ab1b = airdropsettings.overrideoptions.var_aa2bfcf28487c0ca ?? 500;
    }
    
    var_c73c4aba5bc1e21b = max( 0, var_c73c4aba5bc1e21b - var_eb9f3b2c1683ab1b );
    var_cc15719857f38dfa = var_c73c4aba5bc1e21b / plane.speed + ( plane.dropdelay ?? 0 );
    var_ec82431c093a286e = cratesspacing / plane.speed;
    
    for ( i = 0; i < plane.var_98f68feda456c65f ; i++ )
    {
        wait var_cc15719857f38dfa;
        var_cc15719857f38dfa = var_ec82431c093a286e;
        droppoint = plane.startpt + plane.dir * var_c73c4aba5bc1e21b + plane.dir * cratesspacing * i;
        droppedpackages = airdrop_scriptbundle::droppackages( airdropsettings, droppoint, plane.origin[ 2 ] - 100, plane.angles );
        plane.droppedpackages = arraycombine( plane.droppedpackages, droppedpackages );
    }
    
    plane notify( #"hash_f774a7b82f6e431c" );
}

/#

    // Namespace namespace_d3fbfe58dd81a4f
    // Params 3, eflags: 0x4
    // Checksum 0xcce10b66, Offset: 0x12e5
    // Size: 0x105, Type: dev
    function private function_4b638bbe31d58d4e( plane, var_c73c4aba5bc1e21b, cratesspacing )
    {
        if ( !getdvarint( @"hash_e46152cbdde53253", 0 ) )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_bee8fbe5e51d87e5" );
        direction = plane.dir;
        cratescount = plane.var_98f68feda456c65f;
        startorigin = plane.startpt;
        dropheight = plane.height;
        
        while ( getdvarint( @"hash_e46152cbdde53253", 0 ) )
        {
            for ( i = 0; i < cratescount ; i++ )
            {
                droppoint = startorigin + direction * var_c73c4aba5bc1e21b + direction * cratesspacing * i;
                line( droppoint - ( 0, 0, dropheight ), droppoint, ( 1, 0, 0 ), undefined, undefined, 1 );
            }
            
            waitframe();
        }
    }

#/
