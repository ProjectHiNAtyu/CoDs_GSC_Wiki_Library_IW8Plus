// script_4a699bab157f9bf2  (hash_4a699bab157f9bf2.gscc) (size: 16365 Bytes / 0x3fed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfab05de9 (4205862377)
// size ...... 16365 (0x3fed)
// includes .. 24  (offset: 0x3c11)
// strings ... 52  (offset: 0x3cd1)
// dev strs .. 2   (offset: 0x3fd5)
// exports ... 44  (offset: 0x243d)
// cseg ...... 0x4c2 + 0x1f7b (0x243d)
// imports ... 146 (offset: 0x2b1d)
// animtree1 . 0   (offset: 0x3fed)
// animtree2 . 0   (offset: 0x3fed)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_challenges;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace namespace_8455196ea97e68fe;

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x5
// Checksum 0x95f3be67, Offset: 0x4e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c3dbbf911d80de6d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xdde3b367, Offset: 0x509
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_CRATE_DROP", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_CRATE_DROP" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_8455196ea97e68fe
// Params 1
// Checksum 0x5ecc5af7, Offset: 0x539
// Size: 0xc
function function_323fab1b62a2d5d4( eventinfo )
{
    
}

// Namespace namespace_8455196ea97e68fe
// Params 0
// Checksum 0x1d034c60, Offset: 0x54d
// Size: 0x3c
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_CRATE_DROP", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_CRATE_DROP", 1, &function_477932e3884ea1fd );
    thread function_ecab6d6335bc149d();
    thread function_b068fcde4dd609c0();
    postinitfunc();
}

// Namespace namespace_8455196ea97e68fe
// Params 0
// Checksum 0xebbe2dec, Offset: 0x591
// Size: 0x78
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    if ( activity_instance.var_332f929de1894b2b.var_3492153707b51a68 )
    {
        function_bc041d7a3efbfe87( activity_instance.varianttag, activity_instance.var_332f929de1894b2b );
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_8455196ea97e68fe
// Params 0
// Checksum 0x97688f60, Offset: 0x611
// Size: 0x30
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    function_82ed4e783d69dc53();
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0xac56b53c, Offset: 0x649
// Size: 0x60
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "crate_drop_" + variantname + "_event_global" ] ) )
    {
        game[ "dialog" ][ "crate_drop_" + variantname + "_event_global" ] = data.var_3492153707b51a68;
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xdc2b9de2, Offset: 0x6b1
// Size: 0x47
function private postinitfunc()
{
    if ( isdefined( level.lootcratepostinit ) )
    {
        return;
    }
    
    level.lootcratepostinit = 1;
    game[ "dialog" ][ "cash_drop" ] = "cash_wzan_ncmn";
    level.conf_fx[ "vanish" ] = loadfxasset( "vfx_core_impacts_small_snowhit" );
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xcd1439e4, Offset: 0x700
// Size: 0x30a
function private function_82ed4e783d69dc53()
{
    level.var_fec01d8ee18aaa91 = getdvarfloat( @"hash_302f97714cae9d45", self.var_332f929de1894b2b.var_bb64935e022edec );
    var_d6d923d0e6e387c3 = 1;
    crateinfo = spawnstruct();
    
    switch ( self.var_332f929de1894b2b.cratetype )
    {
        case #"hash_bd0062ccde4b4147":
            level thread br_lootchopper::init();
            level thread airdrop::function_2754449e14898546();
            crateinfo.var_63c98baeac70590c = "battle_royale_cash_crate";
            crateinfo.var_b83d7230d8e0c94 = "active";
            crateinfo.var_97038cf40f484d0d = "cashdrop_common_world";
            crateinfo.var_7eef4e77485c6ef = "on";
            level.var_bea74285059cad6c = 0;
            level.var_9db6eb11c1c26691 = [];
            break;
        case #"hash_448996b42f098602":
            var_d6d923d0e6e387c3 = 0;
            break;
        case #"hash_a578ca7c4f31b3a4":
            crateinfo.var_63c98baeac70590c = "bongo_care_package";
            level.var_9db6eb11c1c26691 = [];
            break;
        default:
            assertmsg( "<dev string:x2b>" );
            break;
    }
    
    if ( var_d6d923d0e6e387c3 )
    {
        leveldata = airdrop::getleveldata( crateinfo.var_63c98baeac70590c );
        leveldata.capturestring = self.var_332f929de1894b2b.capturestring;
        leveldata.minimapicon = undefined;
        
        if ( isdefined( leveldata.var_1c537aa1fb8594a4 ) )
        {
            crateinfo.var_b83d7230d8e0c94 = leveldata.var_1c537aa1fb8594a4;
        }
    }
    
    if ( self.var_332f929de1894b2b.var_3492153707b51a68 )
    {
        function_4c6cd4783450e543();
    }
    
    delays = [];
    
    foreach ( delaystruct in self.var_332f929de1894b2b.delays )
    {
        delays[ delays.size ] = delaystruct.delay;
    }
    
    var_385a7840c3693655 = [ "CarePackage":"bongo_crate_drop", "CashDrop":"pe_crate_drop" ];
    self.crates = [];
    
    if ( self.var_332f929de1894b2b.cratetype == "ContestedLoadout" )
    {
        self.var_6998d2497da6b014 = 0;
        self.var_e43618db03ff56ec = 0;
        self.var_4ba6557016863ac9 = 0;
        thread function_cdb400d7560fd5a2( delays );
        return;
    }
    
    var_d94f6bedfccf1fa1 = br_supply_drops::function_9852bd1ca104d05b( delays, var_385a7840c3693655[ self.var_332f929de1894b2b.cratetype ] );
    var_d94f6bedfccf1fa1 callback::add( #"hash_dbf7cc0694cf219e", &function_f5ee7adb822c3dd, { #activity_instance:self } );
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0xc
// Checksum 0x98cf8f5c, Offset: 0xa12
// Size: 0x8c
function private function_2c8301ae2731c3dd( activity_instance )
{
    self notify( #"hash_48886dce3ac59c33" );
    self endon( #"hash_48886dce3ac59c33" );
    crate = self;
    crate waittill( #"death" );
    activity_instance.crates = arrayremove( activity_instance.crates, crate );
    
    if ( activity_instance.crates.size == 0 && ( activity_instance.var_4ba6557016863ac9 ?? 1 ) )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0xc
// Checksum 0xf5c15417, Offset: 0xaa6
// Size: 0x116
function private function_cdb400d7560fd5a2( delayarray )
{
    self notify( #"hash_733e736a4f08fd65" );
    self endon( #"hash_733e736a4f08fd65" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_6c8a21438b75ad1e = getdvarint( @"hash_4cc81b833e45a79d", 3 );
    
    if ( var_6c8a21438b75ad1e == 0 )
    {
        activity_instance.var_e43618db03ff56ec = 1;
        activity_instance function_e38afe1d10a80ff3();
        return;
    }
    
    totaldelay = 0;
    
    for ( i = 0; i < delayarray.size ; i++ )
    {
        delaytime = delayarray[ i ];
        waittime = delaytime - totaldelay;
        
        if ( waittime <= 0 )
        {
            continue;
        }
        
        wait waittime;
        totaldelay = delaytime;
        var_a5f1a2f029f14e8b = i > 0 ? 1 : var_6c8a21438b75ad1e;
        activity_instance function_90e8df62629a9901( function_280235a86e9cfa93( i ), var_a5f1a2f029f14e8b );
    }
    
    activity_instance.var_e43618db03ff56ec = 1;
    activity_instance function_e38afe1d10a80ff3();
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x265a12aa, Offset: 0xbc4
// Size: 0x1db
function private function_90e8df62629a9901( cratecount, var_6c8a21438b75ad1e )
{
    activity_instance = self;
    multicirclecount = function_4cb0873797342275();
    
    if ( multicirclecount > 1 )
    {
        var_97c7912a6113511d = int( ceil( cratecount / multicirclecount ) );
        
        for ( circleindex = 0; circleindex < multicirclecount ; circleindex++ )
        {
            activity_instance function_f585415e91a454e9( var_97c7912a6113511d, circleindex );
            waitframe();
        }
        
        return;
    }
    
    if ( var_6c8a21438b75ad1e == 2 )
    {
        pathangle = randomfloatrange( 0, 360 );
        var_2fd5afa46e56e8f6 = int( ceil( cratecount / 2 ) );
        activity_instance function_f585415e91a454e9( var_2fd5afa46e56e8f6, 0, pathangle );
        crosswait = getdvarfloat( @"hash_f96cf03ab951508e", 2 );
        
        if ( crosswait > 0 )
        {
            wait crosswait;
        }
        
        pathangle = angleclamp( pathangle + 90 + randomfloatrange( -5, 5 ) );
        activity_instance function_f585415e91a454e9( var_2fd5afa46e56e8f6, 0, pathangle );
        return;
    }
    
    if ( var_6c8a21438b75ad1e == 3 )
    {
        pathangle = randomfloatrange( 0, 360 );
        
        if ( getdvarint( @"hash_89202350d7308671", 1 ) )
        {
            circlecenter = br_circle::getsafecircleorigin();
            pathangle = vectortoyaw( circlecenter * -1 );
        }
        
        var_2fd5afa46e56e8f6 = int( ceil( cratecount / 3 ) );
        offsetpct = getdvarfloat( @"hash_407d738b9ba721fd", 0.5 );
        activity_instance function_f585415e91a454e9( var_2fd5afa46e56e8f6, 0, pathangle, 0 );
        formationwait = getdvarfloat( @"hash_974235136f18adef", 5 );
        
        if ( formationwait > 0 )
        {
            wait formationwait;
        }
        
        activity_instance function_f585415e91a454e9( var_2fd5afa46e56e8f6, 0, pathangle, offsetpct );
        waitframe();
        activity_instance function_f585415e91a454e9( var_2fd5afa46e56e8f6, 0, pathangle, -1 * offsetpct );
        return;
    }
    
    activity_instance function_f585415e91a454e9( cratecount, 0 );
}

// Namespace namespace_8455196ea97e68fe
// Params 4, eflags: 0x4
// Checksum 0xbe06f97, Offset: 0xda7
// Size: 0x4e
function private function_f585415e91a454e9( cratecount, multicircleindex, var_4e6ed342ba62bb28 = undefined, var_28afd4b8e3363d23 = undefined )
{
    self.var_6998d2497da6b014++;
    thread function_d5ebb78da6453fb7( cratecount, multicircleindex, var_4e6ed342ba62bb28, var_28afd4b8e3363d23 );
}

// Namespace namespace_8455196ea97e68fe
// Params 4, eflags: 0x4
// Checksum 0xb2a3d46, Offset: 0xdfd
// Size: 0x152
function private function_d5ebb78da6453fb7( cratecount, multicircleindex, var_4e6ed342ba62bb28 = undefined, var_28afd4b8e3363d23 = undefined )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    droparea = function_4cfcf63206c28609( multicircleindex, var_4e6ed342ba62bb28, var_28afd4b8e3363d23 );
    
    if ( !isdefined( droparea ) || cratecount <= 0 || droparea.radius <= 0 || droparea.pathradius <= 0 )
    {
        activity_instance.var_6998d2497da6b014--;
        activity_instance function_e38afe1d10a80ff3();
        return;
    }
    
    planeangles = function_758cae11414c8165( var_4e6ed342ba62bb28 );
    planeheight = ( level.var_4280cdebdfea8385 ?? 12000 ) + getdvarfloat( @"hash_8f28d4ead9cec8ea", 1000 ) * multicircleindex;
    var_4f6fef3211483c93 = function_40a31ea093186002( droparea, cratecount );
    airdrop_loadout_crate::function_e9b561ee0476740( activity_instance, &function_3c5cc2b1f86c1b53, cratecount, droparea.origin, droparea.radius, planeangles, planeheight, var_4f6fef3211483c93 );
    activity_instance.var_6998d2497da6b014--;
    activity_instance function_e38afe1d10a80ff3();
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x1e0e7b83, Offset: 0xf57
// Size: 0x23
function private function_758cae11414c8165( var_4e6ed342ba62bb28 )
{
    if ( !isdefined( var_4e6ed342ba62bb28 ) )
    {
        return;
    }
    
    return ( 0, angleclamp( var_4e6ed342ba62bb28 + 180 ), 0 );
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0xf8df424, Offset: 0xf83
// Size: 0xad
function private function_40a31ea093186002( droparea, cratecount )
{
    return { #dropdata:{ #var_d552db893c19ac9d:getdvarint( @"hash_d62b4f29572ebf87", 1 ), #checktimer:function_d32885aa8c4b8051( droparea.radius, cratecount ) / br_supply_drops_common::function_1390e81e421284ae(), #bufferpercent:function_634631abe82e6824( droparea ), #var_2fd5afa46e56e8f6:cratecount }, #dropfunc:&function_97f3eeb60cf74ca0, #var_764e4f15c5c12fb3:0, #var_72c0afeaa1bb09fc:0, #pathradius:droparea.pathradius };
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x98ece24b, Offset: 0x1039
// Size: 0x145
function private function_97f3eeb60cf74ca0( airdropsettings )
{
    plane = self;
    dropdata = airdropsettings.extradata.var_1e435386c7339add;
    var_536f6188f71c3845 = plane.lifetime;
    var_a6bb3758a6a7729b = var_536f6188f71c3845 * dropdata.bufferpercent;
    droppedpackages = [];
    numcrates = 0;
    wait var_a6bb3758a6a7729b;
    
    while ( numcrates < dropdata.var_2fd5afa46e56e8f6 )
    {
        if ( dropdata.checktimer < var_536f6188f71c3845 - var_a6bb3758a6a7729b )
        {
            wait dropdata.checktimer;
        }
        else
        {
            waitframe();
        }
        
        if ( !isdefined( plane ) )
        {
            break;
        }
        
        droppoint = plane.origin + plane.dir * 500;
        var_b42e3a919bdcec09 = airdrop_scriptbundle::droppackages( airdropsettings, droppoint, plane.origin[ 2 ] - 100, plane.angles );
        
        if ( !isdefined( var_b42e3a919bdcec09 ) || var_b42e3a919bdcec09.size <= 0 )
        {
            if ( dropdata.var_d552db893c19ac9d )
            {
                numcrates++;
            }
            
            continue;
        }
        
        droppedpackages = arraycombine( droppedpackages, var_b42e3a919bdcec09 );
        numcrates++;
    }
    
    return droppedpackages;
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x7a5d31ad, Offset: 0x1187
// Size: 0x35
function private function_634631abe82e6824( droparea )
{
    return ( droparea.pathradius - droparea.radius ) / droparea.pathradius * 2;
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x86266550, Offset: 0x11c5
// Size: 0x23
function private function_d32885aa8c4b8051( dropradius, cratecount )
{
    return dropradius * 2 / ( cratecount + 1 );
}

// Namespace namespace_8455196ea97e68fe
// Params 3, eflags: 0x4
// Checksum 0x74dfb8d3, Offset: 0x11f1
// Size: 0x1a5
function private function_4cfcf63206c28609( multicircleindex, var_4e6ed342ba62bb28, var_28afd4b8e3363d23 )
{
    droporigin = br_circle::getsafecircleorigin();
    dropradius = br_circle::getsafecircleradius();
    pathradius = max( level.br_level.br_circleradii[ 0 ] ?? dropradius, dropradius );
    
    if ( level.br_multi_circle_enabled )
    {
        droporigin = br_circle_util::function_614ad7680d84e36e( multicircleindex );
        dropradius = br_circle_util::function_6f1e39c56a1f50fa( multicircleindex );
    }
    else
    {
        usenextcircle = getdvarint( @"hash_daf294d5b4e5a87a", 0 );
        
        if ( usenextcircle )
        {
            droporigin = br_circle::getnextsafecircleorigin();
            dropradius = br_circle::getnextsafecircleradius();
        }
    }
    
    if ( isdefined( level.chokeholdcircle ) )
    {
        if ( utility::flag( "chokehold_closed" ) )
        {
            droporigin = br_circle::getdangercircleorigin();
            dropradius = br_circle::getdangercircleradius();
        }
        else if ( !utility::flag( "chokehold_started" ) )
        {
            droporigin = ( 0, 0, 0 );
        }
    }
    
    if ( !isdefined( level.br_circle ) )
    {
        dropradius = level.br_level.br_circleradii[ 0 ];
    }
    
    if ( isdefined( var_4e6ed342ba62bb28 ) && isdefined( var_28afd4b8e3363d23 ) && var_28afd4b8e3363d23 != 0 )
    {
        perpdir = vectornormalize( anglestoright( ( 0, var_4e6ed342ba62bb28, 0 ) ) );
        offsetdist = var_28afd4b8e3363d23 * dropradius;
        droporigin += perpdir * offsetdist;
        dropradius = sqrt( squared( dropradius ) - squared( offsetdist ) );
    }
    
    return { #pathradius:pathradius, #radius:dropradius, #origin:droporigin };
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0x474d6a1f, Offset: 0x139f
// Size: 0x62
function private function_e38afe1d10a80ff3()
{
    activity_instance = self;
    
    if ( !( activity_instance.var_e43618db03ff56ec ?? 0 ) )
    {
        return;
    }
    
    if ( ( activity_instance.var_6998d2497da6b014 ?? 0 ) > 0 )
    {
        return;
    }
    
    activity_instance.var_4ba6557016863ac9 = 1;
    
    if ( activity_instance.crates.size == 0 )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0xe8dcb857, Offset: 0x1409
// Size: 0x16
function private function_3c5cc2b1f86c1b53( activity_instance )
{
    function_274f71dc09dff060( activity_instance, self );
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x53b5d87b, Offset: 0x1427
// Size: 0x5d
function private function_274f71dc09dff060( activity_instance, crate )
{
    activity_instance.crates[ activity_instance.crates.size ] = crate;
    crate callback::add( #"airdrop_crate_activated", &function_7f6640dd3808c050, { #activity_instance:activity_instance } );
    crate thread function_2c8301ae2731c3dd( activity_instance );
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0x902c2bb1, Offset: 0x148c
// Size: 0x2d
function private function_4cb0873797342275()
{
    if ( level.br_multi_circle_enabled && !br_circle_util::function_23705baf6673b0ed() && !br_circle_util::function_209532a1558406f() )
    {
        return br_circle_util::function_7c3401c47d505872();
    }
    
    return 1;
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x246fa463, Offset: 0x14c2
// Size: 0x32
function private function_280235a86e9cfa93( waveindex )
{
    if ( waveindex > 0 )
    {
        return getdvarint( @"hash_b3d8a888eea5f976", 3 );
    }
    
    return getdvarint( @"hash_711a9f3cf948c5c9", 8 );
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x37297ea5, Offset: 0x14fd
// Size: 0x37
function private function_f5ee7adb822c3dd( params, additionalparams )
{
    params.plane callback::add( #"hash_8dfed210571539fe", &function_f31aaf4057af7c71, additionalparams );
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0xa377a7af, Offset: 0x153c
// Size: 0x32
function private function_f31aaf4057af7c71( params, additionalparams )
{
    function_274f71dc09dff060( additionalparams.activity_instance, params.crate );
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x1b5f84ec, Offset: 0x1576
// Size: 0x68
function private function_7f6640dd3808c050( params, additionalparams )
{
    crate = self;
    
    if ( params.isfirstactivation && additionalparams.activity_instance.var_332f929de1894b2b.var_857ff82a0ca1ac63 )
    {
        level thread function_132fd60a482d9101( additionalparams.activity_instance, crate );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x30ca03f5, Offset: 0x15e6
// Size: 0xbc
function private function_132fd60a482d9101( activity_instance, crate )
{
    activity_participation::function_a45fd1c5cc774007( activity_instance );
    join_zone = spatial_zone_container::function_847140d2863dfbf8( activity_instance, "Proximity_Join_Zone", crate.origin, activity_instance.var_332f929de1894b2b.var_5024c971a2612559 );
    abandon_zone = spatial_zone_container::function_847140d2863dfbf8( activity_instance, "Proximity_Abandon_Zone", crate.origin, activity_instance.var_332f929de1894b2b.var_3ffee47fd6452b56 );
    crate waittill( #"death" );
    spatial_zone_container::function_ddcd5f35f0032b25( activity_instance, "Proximity_Join_Zone", join_zone );
    spatial_zone_container::function_ddcd5f35f0032b25( activity_instance, "Proximity_Abandon_Zone", abandon_zone );
}

// Namespace namespace_8455196ea97e68fe
// Params 0
// Checksum 0x8eb3e021, Offset: 0x16aa
// Size: 0xaa
function function_4c6cd4783450e543()
{
    foreach ( player in level.players )
    {
        level thread br_public::brleaderdialogplayer( "crate_drop_" + self.varianttag + "_event_global", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_7b6674861c528284 );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xfcbbb087, Offset: 0x175c
// Size: 0xac
function private player_entergulag()
{
    if ( !( isdefined( self ) && isdefined( level.var_9db6eb11c1c26691 ) ) )
    {
        return;
    }
    
    foreach ( crate in level.var_9db6eb11c1c26691 )
    {
        if ( !isdefined( crate.scriptedobjid ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( crate.scriptedobjid, self );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0x4b57d462, Offset: 0x1810
// Size: 0xac
function private player_respawn()
{
    if ( !( isdefined( self ) && isdefined( level.var_9db6eb11c1c26691 ) ) )
    {
        return;
    }
    
    foreach ( crate in level.var_9db6eb11c1c26691 )
    {
        if ( !isdefined( crate.scriptedobjid ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_addshowplayer( crate.scriptedobjid, self );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 4, eflags: 0x4
// Checksum 0x6a9e1864, Offset: 0x18c4
// Size: 0x370
function private function_d8494684e43811f5( dropend, dropstruct, var_65354ac2a697dcff, minimapicon )
{
    leveldata = airdrop::getleveldata( var_65354ac2a697dcff );
    crateowner = undefined;
    crateteam = undefined;
    cratetype = var_65354ac2a697dcff;
    cratestartposition = ( dropend[ 0 ], dropend[ 1 ], 0 ) + ( 0, 0, level.var_4280cdebdfea8385 );
    crateangles = ( 0, randomfloat( 360 ), 0 );
    cratedestination = dropend;
    crate = airdrop::dropcrate( crateowner, crateteam, cratetype, cratestartposition, crateangles, cratedestination );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( !leveldata.var_1fc61fdb8add2a40 )
    {
        crate setscriptablepartstate( "trail", "active", 0 );
        crate.smokesignal = spawn( "script_model", cratestartposition + ( 0, 0, 58 ) );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal linkto( crate );
        crate.smokesignal setscriptablepartstate( "smoke_trail", "on" );
    }
    
    triggerobject = airdrop::gettriggerobject( crate );
    triggerobject.usetimeoverride = level.var_fec01d8ee18aaa91;
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        objidpoolmanager::objective_add_objective( objid, "current", crate.origin, minimapicon );
        objidpoolmanager::update_objective_setbackground( objid, 5 );
        objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
        objidpoolmanager::update_objective_onentity( objid, crate );
        objidpoolmanager::update_objective_setzoffset( objid, 75 );
        objidpoolmanager::update_objective_description( objid, &"MP_BR_INGAME/SUPPLY_CRATE" );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        objidpoolmanager::objective_showdistance( objid, 1 );
        var_ee7bc8b53cebd37e = getdvarfloat( @"hash_e9d0abfe80024d80", 11811 );
        var_35c6503701d9c2ca = getdvarfloat( @"hash_ec4adb02477bc5b2", 0.97 );
        var_1e1ecace3b3c2a63 = var_ee7bc8b53cebd37e * var_35c6503701d9c2ca;
        function_ac9886e0e2860e18( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        objidpoolmanager::function_373aaf492aabde6f( objid, 151, 171, 128 );
        function_d1fb910ef06fd658( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        function_24edb8a97f6832f0( objid, 1 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !isbot( player ) && !player br_public::isplayeringulag() )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objid, player );
            }
        }
        
        crate.scriptedobjid = objid;
    }
    else
    {
        crate setscriptablepartstate( "objective_map", "cashdrop_common_world" );
    }
    
    crate.nevertimeout = 1;
    crate.smokescriptable = "ks_airdrop_crate_br";
    level.var_9db6eb11c1c26691[ level.var_9db6eb11c1c26691.size ] = crate;
    return crate;
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0xec5732d0, Offset: 0x1c3d
// Size: 0x28
function private function_99f8c763aafc55f6( dropend, dropstruct )
{
    return function_d8494684e43811f5( dropend, dropstruct, "battle_royale_cash_crate", "ui_map_icon_cash_drop" );
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xe11c5a42, Offset: 0x1c6e
// Size: 0xf6
function private function_ecab6d6335bc149d()
{
    level waittill( #"br_supply_drops_init" );
    
    if ( isdefined( level.supplydroptypes[ "pe_crate_drop" ] ) )
    {
        return;
    }
    
    utility::registersharedfunc( #"br_cashcrate", #"cashcrate_oncrateuse", &function_7d5c283a10c16742 );
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "pe_crate_drop", "military_carepackage_03_br", undefined, &function_7d5c283a10c16742 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "spawnDropCrate", &function_99f8c763aafc55f6 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "onPlayerEnterGulag", &player_entergulag );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "onPlayerRespawn", &player_respawn );
    dropstruct.var_7aab74785fcbe440 = 1;
    var_84b20951617728e4 = getdvarint( @"hash_6e2a7271b0aaecd4", 8000 );
    dropstruct.var_c491715796150d41 = var_84b20951617728e4 * var_84b20951617728e4;
    game[ "dialog" ][ "dropbag_incoming" ] = "drpb_wzan_gmst";
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x890130f0, Offset: 0x1d6c
// Size: 0x16e
function private function_7d5c283a10c16742( player )
{
    common_item::function_45c338c4003d5f13( self, 0 );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_publicevent_cratedrop" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        spawnoptions.var_90cdc5dbcd319e5d = 1;
        spawnoptions.ignoreents = [ self ];
        spawnoptions.analyticssource = "pe_crate_drop";
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
    }
    
    if ( isdefined( player.perks[ "specialty_br_extra_killstreak_chance" ] ) )
    {
        script::demoforcesre( "Removed br_lootcache::lootContentsAdjustKllChain. If that logic is desired, re-implement in a data-driven manner." );
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( isdefined( self.scriptedobjid ) )
    {
        objective_delete( self.scriptedobjid );
        objidpoolmanager::returnobjectiveid( self.scriptedobjid );
        self.scriptedobjid = undefined;
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "risk" || gametype == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xe19cf734, Offset: 0x1ee2
// Size: 0xc1
function private function_b068fcde4dd609c0()
{
    level waittill( #"br_supply_drops_init" );
    
    if ( isdefined( level.supplydroptypes[ "bongo_crate_drop" ] ) )
    {
        return;
    }
    
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "bongo_crate_drop" );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "bongo_crate_drop", "spawnDropCrate", &function_b3ccf61665db2575 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "bongo_crate_drop", "onPlayerEnterGulag", &player_entergulag );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "bongo_crate_drop", "onPlayerRespawn", &player_respawn );
    dropstruct.var_7aab74785fcbe440 = 1;
    var_84b20951617728e4 = getdvarint( @"hash_6e2a7271b0aaecd4", 8000 );
    dropstruct.var_c491715796150d41 = var_84b20951617728e4 * var_84b20951617728e4;
    function_836c3fd5af12d946();
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0xb6a5338b, Offset: 0x1fab
// Size: 0x139
function private function_836c3fd5af12d946()
{
    leveldata = airdrop::getleveldata( "bongo_crate_drop" );
    leveldata.capturestring = &"br_gametype_bongo/activity_crate_drop_capture_string";
    leveldata.basemodel = "military_carepackage_01_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = 600;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 3;
    leveldata.friendlyusetime = 3;
    leveldata.enemyusetime = 3;
    leveldata.var_1fc61fdb8add2a40 = 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &function_92bb915ba606fcec;
    leveldata.capturecallback = &function_5063699c14b837a9;
    leveldata.destroycallback = &function_528f4d521ddf1fa2;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x29d5dd3d, Offset: 0x20ec
// Size: 0x43
function private function_92bb915ba606fcec( isfirstactivation )
{
    if ( utility::issharedfuncdefined( #"airdrop", #"registercrateforcleanup" ) )
    {
        [[ utility::getsharedfunc( #"airdrop", #"registercrateforcleanup" ) ]]( self );
    }
}

// Namespace namespace_8455196ea97e68fe
// Params 2, eflags: 0x4
// Checksum 0x4ba46ed0, Offset: 0x2137
// Size: 0x71
function private function_b3ccf61665db2575( dropend, dropstruct )
{
    crate = function_d8494684e43811f5( dropend, dropstruct, "bongo_crate_drop", "hud_icon_minimap_killstreak_carepackage" );
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_bongo_supply_drop" );
    function_3f1a6a0ae5901866( crate.scriptedobjid, hovercardid );
    crate thread function_b2315fdc8719d5fa();
    return crate;
}

// Namespace namespace_8455196ea97e68fe
// Params 0, eflags: 0x4
// Checksum 0x592e58dc, Offset: 0x21b1
// Size: 0x45
function private function_b2315fdc8719d5fa()
{
    crate = self;
    crate endon( #"death" );
    
    while ( br_circle::function_52d62d96409e20b( crate.origin, 1000 ) )
    {
        wait 1;
    }
    
    wait 10;
    airdrop::destroycrate( crate );
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0x4b2b93ce, Offset: 0x21fe
// Size: 0x1a0
function private function_5063699c14b837a9( player )
{
    common_item::function_45c338c4003d5f13( self, 0 );
    
    if ( level.brgametype.hop_bundle )
    {
        scriptkey = level.brgametype.hop_bundle.var_60c9f931e4893279 ?? "bongo_hop_legendary_crate";
        zonedef = level.brgametype.hop_bundle.var_be19117fb13d726e ?? "wz_sat_br_bongo_hop_zone_global";
    }
    else
    {
        scriptkey = "br_bongo_care_package";
        zonedef = "wz_sat_br_bongo_zone_global";
    }
    
    var_f67995529827f79 = common_cache::function_525b81b5b46043f7( scriptkey, zonedef );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        spawnoptions.var_90cdc5dbcd319e5d = 1;
        spawnoptions.ignoreents = [ self ];
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
        player callback::callback( #"lootCacheAddAdditionalLoot", { #cache:self } );
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    activityinstance = { #type:"BR_PUBLIC_EVENT_CRATE_DROP", #var_86737cbe11bf496e:[ player ] };
    br_challenges::function_75a7b7237dc12b8a( activityinstance );
    function_528f4d521ddf1fa2();
}

// Namespace namespace_8455196ea97e68fe
// Params 1, eflags: 0x4
// Checksum 0xbb5524a5, Offset: 0x23a6
// Size: 0x97
function private function_528f4d521ddf1fa2( immediate )
{
    if ( isdefined( self.scriptedobjid ) )
    {
        objective_delete( self.scriptedobjid );
        objidpoolmanager::returnobjectiveid( self.scriptedobjid );
        self.scriptedobjid = undefined;
    }
    
    self setscriptablepartstate( "objective_map", "inactive", 0 );
    self setscriptablepartstate( "objective", "inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
        self.smokesignal delete();
    }
}

