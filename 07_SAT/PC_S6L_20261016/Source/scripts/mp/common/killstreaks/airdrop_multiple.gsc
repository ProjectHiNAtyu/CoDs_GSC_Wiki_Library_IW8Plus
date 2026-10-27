// scripts\mp\common\killstreaks\airdrop_multiple.gsc  (hash_67e80bd08f2abd78.gscc) (size: 20527 Bytes / 0x502f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5b70369 (3317105513)
// size ...... 20527 (0x502f)
// includes .. 15  (offset: 0x4a2f)
// strings ... 58  (offset: 0x4aa7)
// dev strs .. 5   (offset: 0x4e8f)
// exports ... 47  (offset: 0x346f)
// cseg ...... 0x694 + 0x2ddb (0x346f)
// imports ... 121 (offset: 0x3bc7)
// animtree1 . 2   (offset: 0x4ecb)
// animtree2 . 17  (offset: 0x4f1f)
#using scripts\common\anim;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;

#namespace airdrop_multiple;

// Namespace airdrop_multiple
// Params 0
// Checksum 0xdc0f0e0a, Offset: 0x6b2
// Size: 0x94
function airdrop_multiple_init()
{
    assert( isdefined( level.cratedropdata ), "<dev string:x24>" );
    level.cratedropdata.ac130s = [];
    
    if ( utility::issharedfuncdefined( #"airdrop_multiple", #"init" ) )
    {
        [[ utility::getsharedfunc( #"airdrop_multiple", #"init" ) ]]();
    }
    
    airdrop_multiple_initanimations();
    airdrop_multiple_initvo();
    
    /#
        setdevdvarifuninitialized( @"hash_2a4cc37411737c83", 0 );
        setdevdvarifuninitialized( @"hash_ca9066b6383c5a0e", -1 );
    #/
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x5ae70bd2, Offset: 0x74e
// Size: 0x1e
function airdrop_multiple_initanimations()
{
    function_1b0911b44560bce2();
    function_9b39f2b195207b73();
    function_cc99ff7c85a5e8f3();
    function_a85933c80d2feb58();
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x1b5f72aa, Offset: 0x774
// Size: 0x1b
function airdrop_multiple_initvo()
{
    game[ "dialog" ][ "airdrop_multiple_use" ] = "killstreak_remote_operator" + "_request_response";
}

#using_animtree( "script_model" );

// Namespace airdrop_multiple
// Params 0
// Checksum 0x6f7a5d87, Offset: 0x797
// Size: 0x184
function function_1b0911b44560bce2()
{
    animname = "care_package_drop_multiple";
    animbasename = undefined;
    animbasename = "ac130";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_acharlie130;
    animbasename = "care_package" + "_1";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_cpkg_01;
    animbasename = "care_package" + "_2";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_cpkg_02;
    animbasename = "care_package" + "_3";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_cpkg_03;
    animbasename = "care_package_chute" + "_1";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_parachute_01;
    animbasename = "care_package_chute" + "_2";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_parachute_02;
    animbasename = "care_package_chute" + "_3";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %mp_eadrop_parachute_03;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace airdrop_multiple
// Params 0
// Checksum 0x9a85d768, Offset: 0x923
// Size: 0x101
function function_9b39f2b195207b73()
{
    animbasename = "care_package_drop_multiple";
    animname = "heli_multi";
    bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop_multiple" );
    
    if ( isdefined( bundle.var_f7555cd09510f33d.animtree.id ) && isdefined( bundle.var_f7555cd09510f33d.animname.id ) )
    {
        level.scr_animtree[ animbasename ] = bundle.var_f7555cd09510f33d.animtree.id;
        level.scr_anim[ animbasename ][ animname ] = bundle.var_f7555cd09510f33d.animname.id;
        return;
    }
    
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_dropoff;
}

#using_animtree( "script_model" );

// Namespace airdrop_multiple
// Params 0
// Checksum 0xd7b596bb, Offset: 0xa2c
// Size: 0x1c3
function function_cc99ff7c85a5e8f3()
{
    animbasename = "care_package_drop_multiple";
    bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop_multiple" );
    numcrates = bundle.var_ce5fc84bae73411a ?? 3;
    
    if ( isdefined( bundle.var_a05a1b30a046c34e.animtree.id ) && isdefined( bundle.var_a05a1b30a046c34e.animname.id ) )
    {
        animname = "heli_multi_rope" + "_3";
        
        if ( numcrates == 1 )
        {
            animname = "heli_multi_rope" + "_1";
        }
        else if ( numcrates == 2 )
        {
            animname = "heli_multi_rope" + "_2";
        }
        
        level.scr_animtree[ animbasename ] = bundle.var_a05a1b30a046c34e.animtree.id;
        level.scr_anim[ animbasename ][ animname ] = bundle.var_a05a1b30a046c34e.animname.id;
        return;
    }
    
    animname = "heli_multi_rope" + "_1";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_rope_dropoff_1;
    animname = "heli_multi_rope" + "_2";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_rope_dropoff_2;
    animname = "heli_multi_rope" + "_3";
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_rope_dropoff_3;
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x760a6b0a, Offset: 0xbf7
// Size: 0x577
function function_a85933c80d2feb58()
{
    animbasename = "care_package_drop_multiple";
    bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop_multiple" );
    numcrates = bundle.var_ce5fc84bae73411a ?? 3;
    
    if ( numcrates == 3 )
    {
        animname = "heli_multi_crate" + "_3a";
        
        if ( isdefined( bundle.var_e5c4c9aa7927364c.animtree.id ) && isdefined( bundle.var_e5c4c9aa7927364c.animname.id ) )
        {
            level.scr_animtree[ animbasename ] = bundle.var_e5c4c9aa7927364c.animtree.id;
            level.scr_anim[ animbasename ][ animname ] = bundle.var_e5c4c9aa7927364c.animname.id;
        }
        else
        {
            animname = "heli_multi_crate" + "_3a";
            level.scr_animtree[ animbasename ] = #animtree;
            level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_3a;
        }
        
        animname = "heli_multi_crate" + "_3b";
        
        if ( isdefined( bundle.var_4292e51fb866f793.animtree.id ) && isdefined( bundle.var_4292e51fb866f793.animname.id ) )
        {
            level.scr_animtree[ animbasename ] = bundle.var_4292e51fb866f793.animtree.id;
            level.scr_anim[ animbasename ][ animname ] = bundle.var_4292e51fb866f793.animname.id;
        }
        else
        {
            level.scr_animtree[ animbasename ] = #animtree;
            level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_3b;
        }
        
        animname = "heli_multi_crate" + "_3c";
        
        if ( isdefined( bundle.var_5b5db71ace58636.animtree.id ) && isdefined( bundle.var_5b5db71ace58636.animname.id ) )
        {
            level.scr_animtree[ animbasename ] = bundle.var_5b5db71ace58636.animtree.id;
            level.scr_anim[ animbasename ][ animname ] = bundle.var_5b5db71ace58636.animname.id;
        }
        else
        {
            level.scr_animtree[ animbasename ] = #animtree;
            level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_3c;
        }
        
        return;
    }
    
    if ( numcrates == 2 )
    {
        animname = "heli_multi_crate" + "_2a";
        
        if ( isdefined( bundle.var_e5c4c9aa7927364c.animtree.id ) && isdefined( bundle.var_e5c4c9aa7927364c.animname.id ) )
        {
            level.scr_animtree[ animbasename ] = bundle.var_e5c4c9aa7927364c.animtree.id;
            level.scr_anim[ animbasename ][ animname ] = bundle.var_e5c4c9aa7927364c.animname.id;
        }
        else
        {
            level.scr_animtree[ animbasename ] = #animtree;
            level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_2a;
        }
        
        animname = "heli_multi_crate" + "_2b";
        
        if ( isdefined( bundle.var_4292e51fb866f793.animtree.id ) && isdefined( bundle.var_4292e51fb866f793.animname.id ) )
        {
            level.scr_animtree[ animbasename ] = bundle.var_4292e51fb866f793.animtree.id;
            level.scr_anim[ animbasename ][ animname ] = bundle.var_4292e51fb866f793.animname.id;
        }
        else
        {
            level.scr_animtree[ animbasename ] = #animtree;
            level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_2b;
        }
        
        return;
    }
    
    animname = "heli_multi_crate" + "_1";
    
    if ( isdefined( bundle.var_5b5db71ace58636.animtree.id ) && isdefined( bundle.var_5b5db71ace58636.animname.id ) )
    {
        level.scr_animtree[ animbasename ] = bundle.var_5b5db71ace58636.animtree.id;
        level.scr_anim[ animbasename ][ animname ] = bundle.var_5b5db71ace58636.animname.id;
        return;
    }
    
    level.scr_animtree[ animbasename ] = #animtree;
    level.scr_anim[ animbasename ][ animname ] = %iw9_air_heli_crate_dropoff_1;
}

// Namespace airdrop_multiple
// Params 7
// Checksum 0xd8f6cae5, Offset: 0x1176
// Size: 0x3e4
function airdrop_multiple_dropcrates( owner, team, position, angles, destination, vehiclereserved, streakinfo )
{
    bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop_multiple" );
    var_cc91890139224ab3 = bundle.var_4edded766b77eab7 ?? "ROPE";
    
    if ( level.cratedropdata.ac130s.size >= 2 )
    {
        if ( isdefined( owner ) && isdefined( streakinfo ) )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/vehicle_refund_killstreak" );
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"awardkillstreakfromstruct" ) )
            {
                owner [[ utility::getsharedfunc( #"killstreak", #"awardkillstreakfromstruct" ) ]]( streakinfo.mpstreaksysteminfo, "other" );
            }
        }
        
        return;
    }
    
    streaknames = [];
    cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    numcrates = 3;
    
    /#
        var_60fcf0a96ba55246 = getdvarint( @"hash_ca9066b6383c5a0e", -1 );
        
        if ( var_60fcf0a96ba55246 > 0 )
        {
            numcrates = var_60fcf0a96ba55246;
        }
    #/
    
    if ( isdefined( streakinfo.cratetype ) )
    {
        cratetype = streakinfo.cratetype;
    }
    
    if ( isdefined( streakinfo.numcrates ) )
    {
        numcrates = streakinfo.numcrates;
    }
    
    for ( i = 0; i < numcrates ; i++ )
    {
        streakname = undefined;
        
        if ( streaknames.size > 0 )
        {
            streakname = airdrop::getrandomkillstreak( streaknames );
        }
        else
        {
            streakname = airdrop::getrandomkillstreak();
        }
        
        streaknames[ streaknames.size ] = streakname;
    }
    
    if ( isdefined( owner ) )
    {
        owner thread airdrop::airdrop_playdeploydialog( streakinfo );
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "airdrop_multiple", owner );
        }
    }
    
    var_eec3699c230ad7a5 = var_cc91890139224ab3 == "PARACHUTE" ? airdrop_multiple_getcratedropcaststart( position, owner ) : function_80046b7da42a6ed1( position, owner );
    var_e64bd5306c74ab7e = angles * ( 0, 1, 0 );
    
    if ( isvector( streakinfo.var_42fd8f278bc84dcd ) )
    {
        var_eec3699c230ad7a5 += streakinfo.var_42fd8f278bc84dcd;
    }
    
    scenenode = spawn( "script_model", var_eec3699c230ad7a5 );
    scenenode.angles = var_e64bd5306c74ab7e;
    scenenode setmodel( "tag_origin" );
    scenenode.owner = owner;
    scenenode.team = team;
    scenenode.grenadelocation = destination;
    scenenode.destination = destination;
    scenenode.numcrates = numcrates;
    scenenode.streaknames = streaknames;
    scenenode.cratetype = cratetype;
    scenenode.streakinfo = streakinfo;
    scenenode.hasowner = isdefined( owner );
    scenenode.latestanimendtime = -1;
    scenenode.crates = [];
    scenenode.chutes = [];
    
    if ( var_cc91890139224ab3 == "PARACHUTE" )
    {
        function_42f7111d2be01446( scenenode );
    }
    else if ( var_cc91890139224ab3 == "ROPE" )
    {
        level thread debug::drawsphere( scenenode.destination, 128, 60, ( 1, 1, 1 ) );
        function_489c84953448da7( scenenode, vehiclereserved, streakinfo, streaknames );
    }
    
    return scenenode;
}

// Namespace airdrop_multiple
// Params 4
// Checksum 0x3c351c25, Offset: 0x1563
// Size: 0xcc
function function_489c84953448da7( scenenode, vehiclereserved, streakinfo, streaknames )
{
    heli = function_36a9900dfebeae3e( scenenode, vehiclereserved, streakinfo );
    
    if ( !isdefined( heli ) )
    {
        scenenode function_d12bf8a7b7b5ecf0();
        return;
    }
    
    rope = function_5b8ab06aa5fc96aa( scenenode, streaknames );
    
    if ( !isdefined( rope ) )
    {
        scenenode function_d12bf8a7b7b5ecf0();
        return;
    }
    
    crates = function_472fa8552e071972( scenenode.cratetype, scenenode, streaknames, streakinfo, scenenode.destination );
    
    if ( scenenode.crates.size < scenenode.numcrates )
    {
        scenenode function_d12bf8a7b7b5ecf0( 1 );
        return;
    }
    
    scenenode thread function_ea49632820f7657d();
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x31189392, Offset: 0x1637
// Size: 0x133
function function_42f7111d2be01446( scenenode )
{
    numcrates = scenenode.numcrates;
    scenenode.var_3f540839f1ef1986 = 900;
    scenenode.cratedroplocations = [];
    scenenode.cratedroplocations = function_bd2eb7c465e874f7( scenenode.grenadelocation, 1, scenenode );
    
    if ( scenenode.cratedroplocations.size >= 1 )
    {
        scenenode.cratedroplocations = arraycombine( scenenode.cratedroplocations, function_bd2eb7c465e874f7( scenenode.cratedroplocations[ 0 ], numcrates - scenenode.cratedroplocations.size, scenenode, 1 ) );
    }
    
    if ( scenenode.cratedroplocations.size < numcrates )
    {
        scenenode.cratedroplocations = arraycombine( scenenode.cratedroplocations, function_1a17d81efed8f4f0( scenenode.grenadelocation, numcrates - scenenode.cratedroplocations.size, scenenode ) );
        
        if ( scenenode.cratedroplocations.size < numcrates )
        {
            iprintln( "Emergency Airdrop could NOT find enough available spots to drop crates. This indicates a problem with either the map itself, or the parameters being used to test drop locations." );
            return scenenode;
        }
    }
    
    airdrop_multiple_createac130( scenenode );
    scenenode thread airdrop_multiple_watchdropcrates();
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0xd8606a98, Offset: 0x1772
// Size: 0x31
function airdrop_multiple_watchdropcrates()
{
    self endon( #"death" );
    animation::anim_first_frame_solo( self.ac130, "care_package_drop_multiple" );
    airdrop_multiple_watchdropcratesinternal();
    thread airdrop_multiple_watchdropcratesend();
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0xff8aead6, Offset: 0x17ab
// Size: 0x16d
function airdrop_multiple_watchdropcratesinternal()
{
    firstframe = undefined;
    
    while ( gettime() <= self.latestanimendtime )
    {
        if ( self.hasowner )
        {
            if ( !isdefined( self.ownerdisconnected ) )
            {
                if ( isdefined( self.owner ) )
                {
                    if ( !isdefined( self.ownerjoinedteam ) )
                    {
                        if ( self.team != self.owner.team )
                        {
                            self.ownerjoinedteam = 1;
                        }
                    }
                }
                else
                {
                    self.ownerdisconnected = 1;
                }
            }
        }
        
        if ( !isdefined( firstframe ) )
        {
            firstframe = 1;
        }
        else if ( firstframe )
        {
            if ( isdefined( self.ac130 ) )
            {
                self.ac130 thread airdrop_multiple_ac130firstframe();
                thread animation::anim_single_solo( self.ac130, "care_package_drop_multiple" );
            }
            
            firstframe = 0;
        }
        else
        {
            disowned = self.ownerdisconnected || self.ownerjoinedteam;
            
            if ( isdefined( self.ac130 ) )
            {
                if ( disowned || gettime() > self.ac130.animendtime )
                {
                    self.ac130 airdrop_multiple_destroyac130();
                }
            }
            
            if ( gettime() > self.boxdroptime && !self.var_280f472407a16f59 )
            {
                thread function_416b402ddf81f5c1( self );
                self.var_280f472407a16f59 = 1;
            }
        }
        
        waitframe();
    }
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0xe3c1022a, Offset: 0x1920
// Size: 0x121
function airdrop_multiple_watchdropcratesend()
{
    if ( isdefined( self.ac130 ) )
    {
        self.ac130 thread airdrop_multiple_destroyac130();
    }
    
    foreach ( crate in self.crates )
    {
        if ( isdefined( crate ) )
        {
            crate thread airdrop::destroycrate();
        }
    }
    
    foreach ( chute in self.chutes )
    {
        if ( isdefined( chute ) )
        {
            chute thread airdrop::destroychute();
        }
    }
    
    self delete();
}

// Namespace airdrop_multiple
// Params 4
// Checksum 0x78611b27, Offset: 0x1a49
// Size: 0x2d1
function function_bd2eb7c465e874f7( destination, var_81c72f5d443af135, scenenode, var_9f37e1fb0444d037 = 0 )
{
    droppositions = [];
    var_28e87a1f02e07cc6 = scenenode.var_3f540839f1ef1986;
    var_690718aebbf50da7 = 75;
    var_440140a1c3dd57ef = 200;
    caststart = destination + ( 0, 0, var_28e87a1f02e07cc6 );
    
    /#
    #/
    
    cratewidth = 50;
    currring = var_9f37e1fb0444d037 ? 2 : 1;
    theta = 0;
    radius = 0;
    maxrings = 7;
    testposition = undefined;
    densitymodifier = 1.5;
    var_dc094266722ef0cc = 0;
    
    while ( droppositions.size < var_81c72f5d443af135 && currring <= maxrings )
    {
        radius = cratewidth * densitymodifier * currring;
        offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
        
        if ( !var_dc094266722ef0cc )
        {
            ignorelist = airdrop::getcratedropignorelist();
            contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0 );
            caststart = destination + offset + ( 0, 0, var_28e87a1f02e07cc6 );
            sampleposition = destination + offset;
            castend = destination + offset - ( 0, 0, var_440140a1c3dd57ef );
            droptrace = trace::sphere_trace( caststart, castend, 50, ignorelist, contentoverride );
            
            if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
            {
                testposition = droptrace[ "position" ];
            }
            
            heightdelta = abs( testposition[ 2 ] - sampleposition[ 2 ] );
            
            if ( !outofbounds::ispointinoutofbounds( testposition, scenenode.owner.team ) && !utility::ispointinwater( testposition ) && heightdelta > 0 && heightdelta < var_690718aebbf50da7 || heightdelta < 0 && abs( heightdelta ) < var_440140a1c3dd57ef )
            {
                thread debug_utility::drawsphere( testposition, 20, 30, ( 1, 0, 1 ) );
                droppositions[ droppositions.size ] = testposition;
                var_dc094266722ef0cc = 1;
            }
        }
        else
        {
            var_dc094266722ef0cc = 0;
        }
        
        var_b06806e8544a1176 = cratewidth * densitymodifier * 2 / radius;
        var_e67529a936be4ce1 = math::radians_to_degrees( var_b06806e8544a1176 );
        theta += var_e67529a936be4ce1;
        
        if ( theta + var_e67529a936be4ce1 / 2 >= 360 )
        {
            theta = 360;
        }
        
        if ( theta >= 360 )
        {
            theta = 0;
            currring += 1;
        }
    }
    
    return droppositions;
}

// Namespace airdrop_multiple
// Params 3
// Checksum 0x2f2d2967, Offset: 0x1d23
// Size: 0x1e0
function function_1a17d81efed8f4f0( destination, var_81c72f5d443af135, scenenode )
{
    droppositions = [];
    nodearray = getnodesinradiussorted( destination, 5000, 0, 5000, "Path", 7 );
    
    if ( !isdefined( nodearray ) || nodearray.size == 0 )
    {
        return droppositions;
    }
    
    var_4b8a5402806818b8 = 0;
    testposition = undefined;
    var_4eaba6ed98314aaa = 0;
    
    while ( !var_4b8a5402806818b8 )
    {
        caststart = nodearray[ var_4eaba6ed98314aaa ].origin + ( 0, 0, scenenode.var_3f540839f1ef1986 );
        castend = nodearray[ var_4eaba6ed98314aaa ].origin;
        ignorelist = airdrop::getcratedropignorelist();
        contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0 );
        droptrace = trace::sphere_trace( caststart, castend, 50, ignorelist, contentoverride );
        
        if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
        {
            testposition = droptrace[ "position" ];
        }
        
        /#
            heightdelta = abs( castend[ 2 ] - testposition[ 2 ] );
            
            if ( heightdelta <= 100 )
            {
                thread debug_utility::drawsphere( testposition, 20, 30, ( 0, 0, 1 ) );
            }
        #/
        
        if ( abs( testposition[ 2 ] - nodearray[ var_4eaba6ed98314aaa ].origin[ 2 ] ) > 100 )
        {
            var_4eaba6ed98314aaa += 1;
        }
        else
        {
            var_4b8a5402806818b8 = 1;
            var_4eaba6ed98314aaa += 1;
            var_bde210d6c29de3c4 = nodearray[ var_4eaba6ed98314aaa ].origin;
            break;
        }
        
        if ( var_4eaba6ed98314aaa >= nodearray.size )
        {
            iprintln( "Ran out of path nodes to test against." );
            return droppositions;
        }
    }
    
    droppositions = function_bd2eb7c465e874f7( var_bde210d6c29de3c4, var_81c72f5d443af135, scenenode );
    return droppositions;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0xca7d8b43, Offset: 0x1f0c
// Size: 0x281
function function_416b402ddf81f5c1( scenenode )
{
    var_d6b35350035c7a99 = 0.1;
    var_28e87a1f02e07cc6 = scenenode.var_3f540839f1ef1986;
    numcrates = scenenode.numcrates;
    cratelocations = scenenode.cratedroplocations;
    
    for ( i = 0; i < numcrates ; i++ )
    {
        data = airdrop::getkillstreakcratedatabystreakname( scenenode.streaknames[ i ], 0 );
        dropstart = ( scenenode.ac130.origin[ 0 ], scenenode.ac130.origin[ 1 ], scenenode.origin[ 2 ] );
        crate = airdrop::createcrate( scenenode.owner, scenenode.owner.team, scenenode.cratetype, dropstart, ( 0, 0, 0 ), cratelocations[ i ], 0, 0, data, 1, cratelocations[ i ] );
        crate.scenenode = scenenode;
        crate.streakinfo = scenenode.streakinfo;
        crate.var_da903b1e8121ea2 = 1;
        crate.data = data;
        
        if ( !isdefined( scenenode.crates ) )
        {
            scenenode.crates = [];
        }
        
        if ( !isdefined( crate ) )
        {
            break;
        }
        
        chute = spawn( "script_model", crate.origin );
        chute.angles = crate.angles;
        chute setmodel( "veh9_mil_lnd_parachute_carepackage_mp" );
        crate.chute = chute;
        crate.var_58f58ae1d854e3e4 = 1;
        chute linkto( crate );
        dropstruct = spawnstruct();
        dropstruct.var_c491715796150d41 = var_28e87a1f02e07cc6 * var_28e87a1f02e07cc6;
        dropstruct.initialmove = 0;
        dropstruct.vertbase = 300;
        dropstruct.var_d51f27c0c0b1350f = 200;
        dropstruct.var_7158594dcc2a08d6 = 1;
        dropstruct.spawnsmoke = 0;
        dropstruct.var_663eca905dad71dd = 1;
        crate thread function_bc537f4afc55ae55( scenenode, cratelocations[ i ], dropstruct );
        wait var_d6b35350035c7a99;
    }
}

// Namespace airdrop_multiple
// Params 3
// Checksum 0x9adca751, Offset: 0x2195
// Size: 0x63
function function_bc537f4afc55ae55( scenenode, destination, dropstruct )
{
    self endon( #"death" );
    thread br_supply_drops_common::function_2d4cad58d926b801( destination, dropstruct );
    self waittill( #"hash_c9163588a1bf092e" );
    
    if ( isdefined( self.chute ) )
    {
        self.chute delete();
    }
    
    airdrop::cratephysicson();
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x97952d02, Offset: 0x2200
// Size: 0x1c9
function airdrop_multiple_createac130( scenenode )
{
    ac130 = spawn( "script_model", scenenode.origin );
    ac130.angles = scenenode.angles;
    ac130.owner = scenenode.owner;
    ac130.team = scenenode.team;
    ac130.scenenode = scenenode;
    scenenode.ac130 = ac130;
    ac130 setmodel( "veh9_mil_air_cargo_plane_exterior_infil" );
    ac130 scriptmoveroutline();
    ac130 scriptmoverthermal();
    ac130 setotherent( scenenode.owner );
    ac130 setentityowner( scenenode.owner );
    ac130 hide();
    airdrop_multiple_addac130tolist( ac130 );
    ac130.animname = "ac130";
    ac130 animation::setanimtree();
    ac130anim = level.scr_anim[ "ac130" ][ "care_package_drop_multiple" ];
    ac130.animendtime = gettime() + getanimlength( ac130anim ) * 1000;
    scenenode.latestanimendtime = ac130.animendtime > scenenode.latestanimendtime ? ac130.animendtime : scenenode.latestanimendtime;
    scenenode.boxdroptime = gettime() + getanimlength( ac130anim ) * 475;
    minimapid = ac130 objidpoolmanager::createobjective( "icon_minimap_dropship", scenenode.team, 1, 1, 1 );
    
    if ( minimapid != -1 )
    {
        ac130.minimapid = minimapid;
    }
    
    return ac130;
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0xed3523d5, Offset: 0x23d2
// Size: 0x80
function airdrop_multiple_ac130firstframe()
{
    self show();
    self playloopsound( "iw8_bradley_drop_c130" );
    self setscriptablepartstate( "lights2", "on", 0 );
    self setscriptablepartstate( "contrails", "on", 0 );
    
    if ( utility::issharedfuncdefined( #"airdrop_multiple", #"monitordamage" ) )
    {
        self thread [[ utility::getsharedfunc( #"airdrop_multiple", #"monitordamage" ) ]]( 1000, "hitequip", &airdrop_multiple_ac130handlefataldamage, &airdrop_multiple_ac130handledamage, 1 );
    }
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x2847a7, Offset: 0x245a
// Size: 0x9
function airdrop_multiple_destroyac130()
{
    airdrop_multiple_deleteac130();
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x8ca685c, Offset: 0x246b
// Size: 0xc4
function airdrop_multiple_deleteac130( deletiondelay )
{
    self notify( #"death" );
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode.ac130 = undefined;
    }
    
    airdrop_multiple_removeac130fromlist( self getentitynumber() );
    self.scenenode = undefined;
    self.animendtime = undefined;
    self stoploopsound();
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    if ( deletiondelay > 0 )
    {
        wait deletiondelay;
    }
    
    self delete();
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x90f7deb2, Offset: 0x2537
// Size: 0x65, Type: bool
function airdrop_multiple_ac130handledamage( data )
{
    if ( isplayer( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
        {
            data.attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "" );
        }
    }
    
    return false;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x37e8910b, Offset: 0x25a5
// Size: 0x124
function airdrop_multiple_ac130handlefataldamage( data )
{
    if ( isplayer( data.attacker ) )
    {
        friendlydamage = 0;
        
        if ( level.teambased && data.attacker.team == self.team )
        {
            friendlydamage = 1;
        }
        else if ( data.attacker == self.owner )
        {
            friendlydamage = 1;
        }
        
        if ( !friendlydamage )
        {
            if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
            {
                thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "callout_destroyed_ac130", data.attacker );
            }
            
            if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
            {
                data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "kill", data.objweapon, 400 );
            }
        }
    }
    
    airdrop_multiple_destroyac130();
}

// Namespace airdrop_multiple
// Params 3
// Checksum 0xdfc1c9a0, Offset: 0x26d1
// Size: 0x25a
function function_36a9900dfebeae3e( scenenode, vehiclereserved, streakinfo )
{
    if ( vehiclereserved )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
    }
    
    heli = vehicle::spawn( "rex_veh_airdrop_mp_phys", { #team:scenenode.team, #owner:scenenode.owner, #angles:scenenode.angles, #origin:scenenode.origin } );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    if ( !isdefined( scenenode.team ) )
    {
        scenenode.team = "neutral";
    }
    
    heli.scenenode = scenenode;
    heli.animname = "care_package_drop_multiple";
    heli.animindex = "heli_multi";
    heli.animtoplay = level.scr_anim[ heli.animname ][ heli.animindex ];
    scenenode.heli = heli;
    scenenode.heliendtime = gettime() + getanimlength( heli.animtoplay ) * 1000;
    scenenode.var_96bc477402b743b6 = getanimlength( heli.animtoplay );
    scenenode.latestanimendtime = scenenode.heliendtime;
    heli.helitype = "airdrop_multiple";
    heli setscriptablepartstate( "engine", "on", 0 );
    heli setscriptablepartstate( "lights", "active", 1 );
    
    if ( isdefined( heli.owner ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
        {
            heli [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( "airdrop_multiple", "Killstreak_Air", heli.owner, 0, 0 );
        }
        
        if ( scenenode.team != "neutral" )
        {
            heli sentientpoolmanager::registersentient( "Killstreak_Air", heli.owner );
        }
    }
    
    heli function_7c152ceb57254a31( streakinfo.streakname );
    heli thread airdrop::watchhelidestroyearly();
    return heli;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x2af34c6, Offset: 0x2934
// Size: 0x10b
function function_7c152ceb57254a31( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_3005003bdef1d1a1;
    var_d188942a41771ea1 = &function_69987a5b0b974e8b;
    premoddamagecallback = &airdrop_multiple_premodifydamage;
    postmoddamagecallback = &airdrop_multiple_postmodifydamage;
    deathcallback = &airdrop_multiple_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    
    if ( isdefined( self.owner ) )
    {
        vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    }
    
    killstreak_utility::function_b555369eba6b0252( 1, 1000, &function_b24576bcd3f0ee53 );
    killstreak_utility::function_b555369eba6b0252( 2, 500, &function_cbd5d430f832b8d4 );
    killstreak_utility::function_b555369eba6b0252( 3, 250, &function_30d731f08208b1d2 );
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0xdef21e0c, Offset: 0x2a47
// Size: 0x17
function function_3005003bdef1d1a1( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 7 );
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x52496ee9, Offset: 0x2a66
// Size: 0xc
function function_69987a5b0b974e8b( streakname )
{
    
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0xa6610a0f, Offset: 0x2a7a
// Size: 0xe, Type: bool
function airdrop_multiple_premodifydamage( data )
{
    return true;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x712e10db, Offset: 0x2a91
// Size: 0x4a, Type: bool
function airdrop_multiple_postmodifydamage( data )
{
    damage = data.damage;
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x27298837, Offset: 0x2ae4
// Size: 0x2
function function_b24576bcd3f0ee53()
{
    
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x7dea2b7, Offset: 0x2aee
// Size: 0x2
function function_cbd5d430f832b8d4()
{
    
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x9e618d66, Offset: 0x2af8
// Size: 0x2
function function_30d731f08208b1d2()
{
    
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x7659d7c2, Offset: 0x2b02
// Size: 0x29, Type: bool
function airdrop_multiple_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    thread airdrop::destroyheli();
    return true;
}

// Namespace airdrop_multiple
// Params 2
// Checksum 0xac4face4, Offset: 0x2b34
// Size: 0xf8
function function_5b8ab06aa5fc96aa( scenenode, streaklist )
{
    heli = scenenode.heli;
    rope = spawn( "script_model", heli.origin );
    rope setmodel( "veh9_mil_air_heli_airdrop_rig_mp" );
    rope.animname = "care_package_drop_multiple";
    rope.animindex = function_90ff33ef5afc25c8( streaklist );
    rope.animtoplay = level.scr_anim[ rope.animname ][ rope.animindex ];
    rope.scenenode = scenenode;
    rope animation::setanimtree();
    scenenode.rope = rope;
    numcrates = streaklist.size;
    
    if ( numcrates < 3 )
    {
        rope setscriptablepartstate( "rope_visibility", "show_" + numcrates );
    }
    
    return rope;
}

// Namespace airdrop_multiple
// Params 5
// Checksum 0xc06596c5, Offset: 0x2c35
// Size: 0x171
function function_472fa8552e071972( cratetype, scenenode, streaklist, streakinfo, markerposition )
{
    owner = scenenode.owner;
    team = scenenode.team;
    destination = scenenode.origin;
    usephysics = 0;
    animbasename = "care_package_drop_multiple";
    crates = [];
    
    for ( i = 0; i < streaklist.size ; i++ )
    {
        animindex = function_e1500ec001886daf( i, streaklist );
        data = airdrop::getkillstreakcratedatabystreakname( streaklist[ i ], 0 );
        crate = airdrop::createcrateforscripteddrop( owner, team, cratetype, destination, usephysics, 0, data, streakinfo, scenenode, animbasename, animindex, 1, markerposition );
        
        if ( !isdefined( crate ) )
        {
            break;
        }
        
        crate.animindex = animindex;
        crate.animtoplay = level.scr_anim[ crate.animname ][ crate.animindex ];
        crate.var_96bc477402b743b6 = getanimlength( crate.animtoplay );
        crate.scenenode = scenenode;
        crates[ crates.size ] = crate;
    }
    
    return crates;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x35f23ade, Offset: 0x2daf
// Size: 0xdb
function function_d12bf8a7b7b5ecf0( cleanupcrates )
{
    if ( isdefined( self.heli ) )
    {
        self.heli thread airdrop::destroyheli();
    }
    
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( cleanupcrates )
    {
        if ( isdefined( self.crates ) )
        {
            foreach ( crate in self.crates )
            {
                if ( isdefined( crate ) )
                {
                    crate thread airdrop::destroycrate();
                }
            }
        }
    }
    
    self delete();
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x1d15f106, Offset: 0x2e92
// Size: 0xdf
function function_ea49632820f7657d()
{
    self endon( #"death" );
    thread animation::anim_first_frame_solo( self.heli, self.heli.animindex );
    thread animation::anim_first_frame_solo( self.rope, self.rope.animindex );
    
    foreach ( crate in self.crates )
    {
        thread animation::anim_first_frame_solo( crate, crate.animindex );
    }
    
    function_ec7a8babcb98095b();
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x4ed972af, Offset: 0x2f79
// Size: 0xf0
function function_ec7a8babcb98095b()
{
    self endon( #"death" );
    animendtime = self.var_96bc477402b743b6;
    thread animation::anim_single_solo( self.heli, self.heli.animindex );
    thread animation::anim_single_solo( self.rope, self.rope.animindex );
    
    foreach ( crate in self.crates )
    {
        if ( isdefined( crate ) )
        {
            thread function_9299073e5583e301( crate );
        }
    }
    
    wait animendtime;
    function_d12bf8a7b7b5ecf0();
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x3aca5330, Offset: 0x3071
// Size: 0x89
function function_9299073e5583e301( crate )
{
    self endon( #"death" );
    crate endon( #"death" );
    animendtime = randomfloatrange( crate.var_96bc477402b743b6 - 0.1, crate.var_96bc477402b743b6 + 0.1 );
    crate setscriptablepartstate( "visibility", "show", 0 );
    thread animation::anim_single_solo( crate, crate.animindex );
    wait animendtime;
    airdrop::docratedropfromscripted( crate );
}

// Namespace airdrop_multiple
// Params 2
// Checksum 0x95cf37df, Offset: 0x3102
// Size: 0x88
function function_80046b7da42a6ed1( position, owner = undefined )
{
    var_fe0ba29b7214421c = position * ( 1, 1, 0 ) + ( 0, 0, airdrop::getscriptedhelidropheightbase( undefined, owner ) );
    var_f007c1d7080eb6e5 = var_fe0ba29b7214421c + ( 0, 0, -30000 );
    var_443055f1526ecad0 = airdrop::getcratedropdestination( var_fe0ba29b7214421c, var_f007c1d7080eb6e5, position );
    var_443055f1526ecad0 += ( 0, 0, 1000 );
    return var_443055f1526ecad0;
}

// Namespace airdrop_multiple
// Params 2
// Checksum 0x678bd466, Offset: 0x3193
// Size: 0x65
function airdrop_multiple_getcratedropcaststart( position, owner = undefined )
{
    position *= ( 1, 1, 0 );
    position += ( 0, 0, airdrop::getscriptedhelidropheightbase( undefined, owner ) + 200 );
    position += ( 0, 0, level.cratedropdata.ac130s.size * 300 );
    return position;
}

// Namespace airdrop_multiple
// Params 0
// Checksum 0x91d7c4b8, Offset: 0x3201
// Size: 0x55
function airdrop_multiple_getdropheight()
{
    assert( isdefined( level.cratedropdata ), "<dev string:x7f>" );
    return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0xce3aab0a, Offset: 0x325f
// Size: 0x4d
function airdrop_multiple_addac130tolist( ac130 )
{
    assert( isdefined( level.cratedropdata ), "<dev string:xc3>" );
    entnum = ac130 getentitynumber();
    level.cratedropdata.ac130s[ entnum ] = ac130;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x39f04cb4, Offset: 0x32b4
// Size: 0x22
function airdrop_multiple_removeac130fromlist( entnum )
{
    level.cratedropdata.ac130s[ entnum ] = undefined;
}

// Namespace airdrop_multiple
// Params 1
// Checksum 0x3d7d7d71, Offset: 0x32de
// Size: 0x7c
function function_90ff33ef5afc25c8( streaklist )
{
    animindex = "heli_multi_rope" + "_1";
    numcrates = streaklist.size;
    assert( numcrates > 0 && numcrates <= 3, "<dev string:x116>" );
    
    if ( numcrates == 2 )
    {
        animindex = "heli_multi_rope" + "_2";
    }
    else if ( numcrates == 3 )
    {
        animindex = "heli_multi_rope" + "_3";
    }
    
    return animindex;
}

// Namespace airdrop_multiple
// Params 2
// Checksum 0x24713823, Offset: 0x3363
// Size: 0x10b
function function_e1500ec001886daf( index, streaklist )
{
    animindex = "heli_multi_crate" + "_1";
    numcrates = streaklist.size;
    assert( numcrates > 0 && numcrates <= 3, "<dev string:x17f>" );
    
    if ( numcrates == 2 )
    {
        switch ( index )
        {
            case 0:
                animindex = "heli_multi_crate" + "_2a";
                break;
            case 1:
                animindex = "heli_multi_crate" + "_2b";
                break;
        }
    }
    else if ( numcrates == 3 )
    {
        switch ( index )
        {
            case 0:
                animindex = "heli_multi_crate" + "_3a";
                break;
            case 1:
                animindex = "heli_multi_crate" + "_3b";
                break;
            case 2:
                animindex = "heli_multi_crate" + "_3c";
                break;
        }
    }
    
    return animindex;
}

