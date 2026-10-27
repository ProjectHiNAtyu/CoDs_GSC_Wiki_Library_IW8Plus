// scripts\mp\airdrop_scriptbundle.gsc  (hash_26633cc19c31f1db.gscc) (size: 19910 Bytes / 0x4dc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x674ad9b1 (1732958641)
// size ...... 19910 (0x4dc6)
// includes .. 12  (offset: 0x4a4e)
// strings ... 29  (offset: 0x4aae)
// dev strs .. 25  (offset: 0x4c56)
// exports ... 61  (offset: 0x31c6)
// cseg ...... 0x42d + 0x2d99 (0x31c6)
// imports ... 126 (offset: 0x3b4e)
// animtree1 . 1   (offset: 0x4d8a)
// animtree2 . 3   (offset: 0x4d96)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\outofbounds;

#namespace airdrop_scriptbundle;

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x5
// Checksum 0x71405dd0, Offset: 0x44b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"airdrop_scriptbundle", undefined, &pre_main, undefined );
}

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x4
// Checksum 0xf950217a, Offset: 0x46c
// Size: 0xb1
function private pre_main()
{
    function_bf11b1a1459e1478();
    
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    function_2db01313d7510751();
    utility::registersharedfunc( #"start_airdrop", #"instant_drop", &function_b3b30171322a3417 );
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"custom", &utility::empty_init_func );
    utility::registersharedfunc( #"airdrop_scriptbundle", #"hash_8145eea3e9d095c", &function_82ceb3b2bf11c40f );
    utility::registersharedfunc( #"airdrop_scriptbundle", #"hash_a00cf531d6165113", &function_98cf85f8daab9a40 );
    thread function_17b24efed14edda5();
    
    /#
        thread debug_init();
    #/
}

#using_animtree( "script_model" );

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x4
// Checksum 0x46cf16b9, Offset: 0x525
// Size: 0xcb
function private function_2db01313d7510751()
{
    if ( !isdefined( level.scr_animtree[ "care_package_chute" ] ) )
    {
        level.scr_animtree[ "care_package_chute" ] = #animtree;
    }
    
    if ( !isdefined( level.scr_anim[ "care_package_chute" ][ "brc130_drop_high" ] ) )
    {
        level.scr_anim[ "care_package_chute" ][ "brc130_drop_high" ] = %mp_carepackage_parachute_flyin_10500;
    }
    
    if ( !isdefined( level.scr_anim[ "care_package_chute" ][ "brc130_drop_med" ] ) )
    {
        level.scr_anim[ "care_package_chute" ][ "brc130_drop_med" ] = %mp_carepackage_parachute_flyin_7500;
    }
    
    if ( !isdefined( level.scr_anim[ "care_package_chute" ][ "brc130_drop_low" ] ) )
    {
        level.scr_anim[ "care_package_chute" ][ "brc130_drop_low" ] = %mp_carepackage_parachute_flyin_3000;
    }
}

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x4
// Checksum 0xf6f7522c, Offset: 0x5f8
// Size: 0x133
function private function_17b24efed14edda5()
{
    level waittill( #"prematch_started" );
    
    if ( !isdefined( level.mapcorners ) || level.mapcorners.size < 2 )
    {
        return;
    }
    
    minx = level.mapcorners[ 0 ].origin[ 0 ];
    maxx = level.mapcorners[ 1 ].origin[ 0 ];
    miny = level.mapcorners[ 1 ].origin[ 1 ];
    maxy = level.mapcorners[ 0 ].origin[ 1 ];
    sizex = maxx - minx;
    sizey = maxy - miny;
    var_7ea27201e2fd4447 = sizex > sizey ? sizey : sizex;
    level.package_airdrop.var_2c7c2f74aaff29ef = ( ( minx + maxx ) * 0.5, ( miny + maxy ) * 0.5, 0 );
    level.package_airdrop.var_fb7707969367ed13 = var_7ea27201e2fd4447 * 0.75;
}

// Namespace airdrop_scriptbundle
// Params 0
// Checksum 0x48a57809, Offset: 0x733
// Size: 0x123
function function_bf11b1a1459e1478()
{
    level.package_airdrop = spawnstruct();
    level.package_airdrop.enabled = getdvarint( @"hash_3f81fafbdd04d8c9", isbrgamemode() );
    
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    level.package_airdrop.stableents = [];
    level.package_airdrop.airdroptypes = [];
    level.package_airdrop.loadedeffects = [];
    level.package_airdrop.activeplanes = [];
    level.package_airdrop.activedrones = [];
    level.package_airdrop.var_4dfa54f2d1f0e195 = [];
    level.package_airdrop.var_c8ea1e210052cfc0 = [];
    level.package_airdrop.activevehicles = [];
    level.package_airdrop.var_af8a9d708d570e08 = trace::function_bbd81e56529ef225();
    level.package_airdrop.crates = [];
}

// Namespace airdrop_scriptbundle
// Params 4
// Checksum 0xfa0b8964, Offset: 0x85e
// Size: 0x1e0
function registerairdrop( airdropidentifier, onplayerusefunc, oncrateactivatefunc, oncratedestroyfunc )
{
    assert( !function_fa19528c206bd43( airdropidentifier ), "<dev string:x24>" + airdropidentifier );
    
    if ( !isdefined( level.package_airdrop ) )
    {
        script::demoforcesre( "Airdrop Scriptbundle: package_airdrop data needs to be initialized before registering airdrops." );
        return;
    }
    
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    packagescriptbundle = getscriptbundle( isxhashasset( airdropidentifier ) ? airdropidentifier : hashcat( %"hash_6d8c41a1f85cf7b", airdropidentifier ) );
    
    if ( !isdefined( packagescriptbundle ) )
    {
        script::demoforcesre( "Could not find scriptbundle package airdrop type " + airdropidentifier );
        return;
    }
    
    packagescriptbundle.airdropidentifier = airdropidentifier;
    packagescriptbundle.airdropfuncs = [];
    level.package_airdrop.airdroptypes[ airdropidentifier ] = packagescriptbundle;
    function_eeb87fc1f31bec35( airdropidentifier, #"playerusefunc", onplayerusefunc );
    function_eeb87fc1f31bec35( airdropidentifier, #"crateactivatefunc", oncrateactivatefunc );
    function_eeb87fc1f31bec35( airdropidentifier, #"cratedestroyfunc", oncratedestroyfunc );
    packagesettings = level.package_airdrop.airdroptypes[ packagescriptbundle.airdropidentifier ].packages[ 0 ].variant_object;
    assert( utility::issharedfuncdefined( #"hash_270838ed4fd5716e", packagesettings.type ), "<dev string:x74>" + packagesettings.type );
    utility::callsharedfunc( #"hash_270838ed4fd5716e", packagesettings.type, packagescriptbundle );
    function_c2c7e96c761d2b60( packagescriptbundle );
    
    /#
        if ( level.package_airdrop.var_12c690b2f8308332 )
        {
            function_4f0936ba109e0241( airdropidentifier );
        }
    #/
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0x760d580b, Offset: 0xa46
// Size: 0x2e
function unregisterairdrop( airdropidentifier )
{
    level.package_airdrop.airdroptypes[ airdropidentifier ] = undefined;
    
    /#
        function_a5edbf0cec93d025( airdropidentifier );
    #/
}

// Namespace airdrop_scriptbundle
// Params 4
// Checksum 0x6439e8df, Offset: 0xa7c
// Size: 0xfc
function function_eeb87fc1f31bec35( airdropidentifier, functype, func, shouldoverride = 0 )
{
    if ( !isdefined( level.package_airdrop.airdroptypes ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.package_airdrop.airdroptypes[ airdropidentifier ] ) )
    {
        script::demoforcesre( "setAirdropFunc() called with an invalid airdropIdentifier: " + airdropidentifier );
    }
    
    if ( level.package_airdrop.enabled )
    {
        var_c9be7d02cdf136fb = level.package_airdrop.airdroptypes[ airdropidentifier ];
        assert( isdefined( var_c9be7d02cdf136fb ), "<dev string:xc3>" + airdropidentifier );
        
        if ( !shouldoverride )
        {
            assert( !isdefined( var_c9be7d02cdf136fb.airdropfuncs[ functype ] ), "<dev string:xff>" + airdropidentifier + "<dev string:x14e>" + functype );
        }
        
        var_c9be7d02cdf136fb.airdropfuncs[ functype ] = func;
    }
}

// Namespace airdrop_scriptbundle
// Params 4, eflags: 0x40 variadic
// Checksum 0xea2a784a, Offset: 0xb80
// Size: 0x79
function function_e9dbf2aaef9f1c96( airdropsettings, functype, ... )
{
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    
    if ( var_9ae4b3950522d64e.airdropfuncs[ functype ] )
    {
        self [[ var_9ae4b3950522d64e.airdropfuncs[ functype ] ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xe9fe2667, Offset: 0xc01
// Size: 0x3a, Type: bool
function function_fa19528c206bd43( airdropidentifier )
{
    return level.package_airdrop.enabled && isdefined( level.package_airdrop.airdroptypes[ airdropidentifier ] );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xdc89af6e, Offset: 0xc44
// Size: 0x49
function function_b4c731c3e4c3c17d( effectname )
{
    if ( effectname && !level.package_airdrop.loadedeffects[ effectname ] )
    {
        level.package_airdrop.loadedeffects[ effectname ] = loadfxasset( effectname );
    }
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xac075e96, Offset: 0xc95
// Size: 0x22
function function_2e675cc8eac7be39( effectname )
{
    return level.package_airdrop.loadedeffects[ effectname ];
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xdf4124b3, Offset: 0xcc0
// Size: 0x2b
function function_aef9ca62004f1c71( collisionflags )
{
    surface = physics_getsurfacetypefromflags( collisionflags );
    return getsubstr( surface[ "name" ], 9 );
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x2241d0c9, Offset: 0xcf4
// Size: 0x19
function private function_86f0b6655e0b30b2( var_d6821a6a00d79949 )
{
    return getsubstr( var_d6821a6a00d79949[ "surfacetype" ], 9 );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xeafa8426, Offset: 0xd16
// Size: 0x14, Type: bool
function function_b5d766a4a8dbccd8( surfacetype )
{
    return surfacetype == "water";
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0x1ee8215b, Offset: 0xd33
// Size: 0x14, Type: bool
function function_cb34dc3c8597c121( surfacetype )
{
    return surfacetype == "glass_pane";
}

// Namespace airdrop_scriptbundle
// Params 3
// Checksum 0x786d7210, Offset: 0xd50
// Size: 0x7c, Type: bool
function function_8372b749a15d1bab( surfacetype, origin, collisionposition )
{
    if ( !function_cb34dc3c8597c121( surfacetype ) )
    {
        return false;
    }
    
    dir = vectornormalize( collisionposition - origin );
    traceend = collisionposition + dir * 20;
    glasstrace = trace::ray_trace( origin, traceend, undefined, trace::create_contents( 0, 0, 1 ) );
    return glasstrace[ "hittype" ] != "hittype_none";
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x23ec13ac, Offset: 0xdd5
// Size: 0x2e
function private function_82ceb3b2bf11c40f( ent )
{
    level.package_airdrop.stableents[ ent.script_label ] = 1;
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x746af4f3, Offset: 0xe0b
// Size: 0x2b
function private function_98cf85f8daab9a40( ent )
{
    level.package_airdrop.stableents[ ent.script_label ] = undefined;
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0x34d32ad4, Offset: 0xe3e
// Size: 0x2c, Type: bool
function function_f6a906b34d79afe( ent )
{
    return isdefined( level.package_airdrop.stableents[ ent.script_label ] );
}

// Namespace airdrop_scriptbundle
// Params 2, eflags: 0x4
// Checksum 0xef8adb5e, Offset: 0xe73
// Size: 0x65, Type: bool
function private function_fd6dc4ae28817aaf( ent, surfacetype )
{
    if ( ent && ent.classname != "worldspawn" && !function_f6a906b34d79afe( ent ) )
    {
        return true;
    }
    
    return !ent && !function_b5d766a4a8dbccd8( surfacetype ) && gettime() < ( self.var_f7f321cb87219557 ?? 0 );
}

// Namespace airdrop_scriptbundle
// Params 3
// Checksum 0x7a51c891, Offset: 0xee1
// Size: 0x47, Type: bool
function function_f2c0966ac33e9339( ent, surfacetype, collisionposition )
{
    if ( function_8372b749a15d1bab( surfacetype, self.origin, collisionposition ) )
    {
        return true;
    }
    
    if ( function_fd6dc4ae28817aaf( ent, surfacetype ) )
    {
        return true;
    }
    
    return false;
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0xbf6bc529, Offset: 0xf31
// Size: 0x133
function private function_34666c4446aeae99( timeout = 0 )
{
    waitstarttime = gettime();
    
    while ( true )
    {
        remainingtimeout = timeout;
        
        if ( timeout > 0 )
        {
            elapsedseconds = ( gettime() - waitstarttime ) * 0.001;
            remainingtimeout = max( 0, timeout - elapsedseconds );
            
            if ( remainingtimeout <= 0 )
            {
                return { #timedout:1 };
            }
        }
        
        collisionresult = utility::waittill_any_return_params_or_timeout( remainingtimeout, "collision" );
        
        if ( collisionresult[ "message" ] == "timeout" )
        {
            return { #timedout:1 };
        }
        
        surfacetype = function_aef9ca62004f1c71( collisionresult[ 3 ] );
        
        if ( function_f2c0966ac33e9339( collisionresult[ 7 ], surfacetype, collisionresult[ 4 ] ) )
        {
            continue;
        }
        
        return { #surfacetype:surfacetype, #ent:collisionresult[ 7 ], #impulse:collisionresult[ 6 ] ?? 0, #normal:collisionresult[ 5 ], #position:collisionresult[ 4 ], #flag1:collisionresult[ 3 ], #timedout:0 };
    }
}

// Namespace airdrop_scriptbundle
// Params 2, eflags: 0x4
// Checksum 0x61d64bca, Offset: 0x106c
// Size: 0xc5
function private function_f50bbabe80c24d44( var_99f32d5d0e855a53, var_e4feeb17534cd233 )
{
    probestart = var_99f32d5d0e855a53 - var_e4feeb17534cd233 * 4;
    probeend = probestart - var_e4feeb17534cd233 * 512;
    groundtrace = trace::ray_trace( probestart, probeend, self, trace::create_itemclip_contents(), 1 );
    
    if ( !groundtrace || groundtrace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return { #var_46cfcd687c2f9dee:distance( var_99f32d5d0e855a53, groundtrace[ "position" ] ), #surfacetype:function_86f0b6655e0b30b2( groundtrace ), #normal:groundtrace[ "normal" ], #position:groundtrace[ "position" ], #impulse:0 };
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0xc22bd7da, Offset: 0x113a
// Size: 0x8b
function private function_31b7e4dbbd93c51c( var_143f590ccf7463d1 )
{
    while ( true )
    {
        followupimpact = function_34666c4446aeae99( 0.75 );
        
        if ( !followupimpact || followupimpact.timedout )
        {
            return var_143f590ccf7463d1;
        }
        
        if ( function_b5d766a4a8dbccd8( followupimpact.surfacetype ) )
        {
            self.inwater = 1;
            
            if ( distance( followupimpact.position, var_143f590ccf7463d1.position ) > 16 )
            {
                continue;
            }
        }
        
        return followupimpact;
    }
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x9aaf4bae, Offset: 0x11cd
// Size: 0x1e, Type: bool
function private function_96d7d4722d9bfd7d( impactinfo )
{
    return ( impactinfo.impulse ?? 0 ) > 30;
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x39a75aa5, Offset: 0x11f4
// Size: 0xa7
function private function_c2c7e96c761d2b60( var_c9be7d02cdf136fb )
{
    packagesettings = level.package_airdrop.airdroptypes[ var_c9be7d02cdf136fb.airdropidentifier ].packages[ 0 ].variant_object;
    function_b4c731c3e4c3c17d( packagesettings.var_8297d3fbba03df76 );
    function_b4c731c3e4c3c17d( packagesettings.var_7f32806057b0df72 );
    function_b4c731c3e4c3c17d( packagesettings.var_de54ed6d58e8fa50 );
    function_b4c731c3e4c3c17d( packagesettings.var_911a93319e7aa526 );
    function_b4c731c3e4c3c17d( packagesettings.traileffect );
}

// Namespace airdrop_scriptbundle
// Params 4
// Checksum 0x18e58906, Offset: 0x12a3
// Size: 0x140
function startairdrop( airdropidentifier, player, team, overrideoptions )
{
    level endon( #"game_ended" );
    assert( isdefined( level.package_airdrop ) && isdefined( level.package_airdrop.airdroptypes[ airdropidentifier ] ), "<dev string:x15b>" );
    airdropsettings = function_14577895bfbbf49e( airdropidentifier, player, team, overrideoptions );
    airdropsettings.droparea = function_1ab0abf851fd2a02( airdropsettings );
    
    /#
        level notify( #"hash_211dddd4f2bbd2b7" );
        level thread function_7cd363b1454f7750( airdropsettings.droparea );
    #/
    
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    assert( utility::issharedfuncdefined( #"start_airdrop", var_ef8325c1086c2688.type ), "<dev string:x1ac>" + var_ef8325c1086c2688.type );
    return utility::callsharedfunc( #"start_airdrop", var_ef8325c1086c2688.type, airdropsettings );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xe3362550, Offset: 0x13ec
// Size: 0xba
function function_c4567c2030476d19( airdropidentifier )
{
    airdropbundle = level.package_airdrop.airdroptypes[ airdropidentifier ];
    packagesettings = level.package_airdrop.airdroptypes[ airdropbundle.airdropidentifier ].packages[ 0 ].variant_object;
    assert( utility::issharedfuncdefined( #"can_airdrop_package", packagesettings.type ), "<dev string:x204>" + packagesettings.type );
    return utility::callsharedfunc( #"can_airdrop_package", packagesettings.type );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xbe532509, Offset: 0x14af
// Size: 0xee
function function_b3b30171322a3417( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    dropheight = airdropsettings.overrideoptions.dropheight ?? airdropsettings.droparea.origin[ 2 ] + var_ef8325c1086c2688.dropheightoffset;
    dropangles = airdropsettings.overrideoptions.dropangles;
    return droppackages( airdropsettings, ( airdropsettings.droparea.origin[ 0 ], airdropsettings.droparea.origin[ 1 ], dropheight ), dropheight, dropangles );
}

// Namespace airdrop_scriptbundle
// Params 4, eflags: 0x4
// Checksum 0xdba78c2c, Offset: 0x15a6
// Size: 0x19f
function private function_14577895bfbbf49e( airdropidentifier, player, team, overrideoptions )
{
    airdropbundle = level.package_airdrop.airdroptypes[ airdropidentifier ];
    packagesettings = level.package_airdrop.airdroptypes[ airdropbundle.airdropidentifier ].packages[ 0 ].variant_object;
    var_26b00cc61fbc49d6 = packagesettings.var_abc6bc2495fb4956;
    ownerplayer = var_26b00cc61fbc49d6 == "player" ? player : undefined;
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    ownerteam = isdefined( ownerplayer ) || var_26b00cc61fbc49d6 == "team" ? team : undefined;
    airdropsettings = { #team:team, #player:player, #ownerteam:ownerteam, #ownerplayer:ownerplayer, #var_a4021a4bc7d38fea:overrideoptions.var_a4021a4bc7d38fea, #instance:overrideoptions.instance, #extradata:overrideoptions.extradata, #overrideoptions:overrideoptions, #var_d99cf9bde319cf6f:overrideoptions.dropradius, #var_c2fa1e6335a19103:overrideoptions.droporigin, #airdropidentifier:airdropidentifier };
    return airdropsettings;
}

// Namespace airdrop_scriptbundle
// Params 4
// Checksum 0xbb8320b1, Offset: 0x174e
// Size: 0x1d3
function droppackages( airdropsettings, origin, height, dropangles )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    packagescount = var_ef8325c1086c2688.var_bfe41a56ee5786f4;
    droppedpackages = [];
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    for ( i = 0; i < packagescount ; i++ )
    {
        if ( i > 0 )
        {
            waitframe();
        }
        
        radius = 200 * ( packagescount - 1 ) / packagescount;
        angle = i * 360 / packagescount;
        offset = rotatepointaroundvector( ( 0, 0, 1 ), ( 1, 0, 0 ), angle ) * radius;
        dropdestination = origin + offset;
        
        if ( dropangles && packagesettings.useparachute )
        {
            dropdestination += anglestoforward( dropangles ) * ( airdropsettings.overrideoptions.var_aa2bfcf28487c0ca ?? 500 );
        }
        
        dropdestination = function_70d144f4414e2e81( airdropsettings, dropdestination, packagesettings );
        
        if ( !isdefined( dropdestination ) )
        {
            continue;
        }
        
        dropposition = ( dropdestination[ 0 ], dropdestination[ 1 ], height );
        package = function_2c2cd0fc4ff63793( airdropsettings, dropposition, dropdestination, dropangles );
        
        if ( package )
        {
            droppedpackages[ droppedpackages.size ] = package;
        }
    }
    
    return droppedpackages;
}

// Namespace airdrop_scriptbundle
// Params 5
// Checksum 0x7d00c2f, Offset: 0x192a
// Size: 0xfe
function function_2c2cd0fc4ff63793( airdropsettings, dropposition, dropdestination, dropangles, initialvelocity = undefined )
{
    airdropidentifier = airdropsettings.airdropidentifier;
    
    if ( !function_c4567c2030476d19( airdropidentifier ) )
    {
        script::demoforcesre( "Attempted to start an airdrop that cannot be started due to current limits. AirdropIdentifier: " + airdropidentifier );
        return;
    }
    
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    assert( utility::issharedfuncdefined( #"hash_c0543f4480543c68", packagesettings.type ), "<dev string:x25c>" + packagesettings.type );
    return utility::callsharedfunc( #"hash_c0543f4480543c68", packagesettings.type, airdropsettings, dropposition, dropdestination, dropangles, initialvelocity );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0xe309f19b, Offset: 0x1a31
// Size: 0x2f, Type: bool
function function_db12c5dff94a61c5( airdropsettings )
{
    return isdefined( airdropsettings.var_c2fa1e6335a19103 ) && ( airdropsettings.var_d99cf9bde319cf6f ?? 1 ) <= 1;
}

// Namespace airdrop_scriptbundle
// Params 3
// Checksum 0x58c79f94, Offset: 0x1a69
// Size: 0x148
function function_15ad4ce1fcf6748f( starttrace, var_d5341ff3f19f6b50, avoidwater = 0 )
{
    droplocation = undefined;
    endtrace = ( starttrace[ 0 ], starttrace[ 1 ], -20000 );
    ignorelist = arraycombine( level.package_airdrop.activeplanes, level.package_airdrop.activedrones );
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    
    if ( avoidwater && !trace::ray_trace_passed( starttrace, endtrace, undefined, level.package_airdrop.var_af8a9d708d570e08 ) )
    {
        return;
    }
    
    trace = trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        surfacetype = function_86f0b6655e0b30b2( trace );
        
        if ( !avoidwater || !function_b5d766a4a8dbccd8( surfacetype ) )
        {
            droplocation = trace[ "position" ];
        }
    }
    
    if ( isdefined( droplocation ) && !var_d5341ff3f19f6b50 )
    {
        validpoint = br_c130::ispointinbounds( droplocation );
        
        if ( !validpoint )
        {
            droplocation = undefined;
        }
    }
    
    return droplocation;
}

// Namespace airdrop_scriptbundle
// Params 3
// Checksum 0xdfcd3456, Offset: 0x1bba
// Size: 0x7a
function function_c471cdc4edef5b4( droparea, avoidwater = 0, var_d5341ff3f19f6b50 = 0 )
{
    randompoint = br_circle::getrandompointincircle( droparea.origin, droparea.radius );
    starttrace = randompoint + ( 0, 0, 10000 );
    return function_15ad4ce1fcf6748f( starttrace, var_d5341ff3f19f6b50, avoidwater );
}

// Namespace airdrop_scriptbundle
// Params 2
// Checksum 0xfcd1ad47, Offset: 0x1c3d
// Size: 0x3e, Type: bool
function function_47a1cf76c5dcb2d3( droparea, point )
{
    return distance2dsquared( droparea.origin, point ) <= droparea.radius * droparea.radius;
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0x4d773560, Offset: 0x1c84
// Size: 0xfa
function function_9bb59dc8e54b24b6( droparea )
{
    for ( i = 0; i < 32 ; i++ )
    {
        dropdestination = function_c471cdc4edef5b4( droparea, 1 );
        
        if ( isdefined( dropdestination ) )
        {
            return dropdestination;
        }
    }
    
    var_5df1809ee8bcd894 = droparea.origin + ( 0, 0, 10000 );
    dropdestination = function_15ad4ce1fcf6748f( var_5df1809ee8bcd894, undefined, 1 );
    
    if ( isdefined( dropdestination ) && function_47a1cf76c5dcb2d3( droparea, dropdestination ) )
    {
        return dropdestination;
    }
    
    if ( isnavmeshloaded() )
    {
        navmeshpoint = getclosestpointonnavmesh( droparea.origin );
        
        if ( isdefined( navmeshpoint ) && function_47a1cf76c5dcb2d3( droparea, navmeshpoint ) )
        {
            var_b08ef05e266d5b81 = navmeshpoint + ( 0, 0, 10000 );
            dropdestination = function_15ad4ce1fcf6748f( var_b08ef05e266d5b81, undefined, 1 );
            
            if ( isdefined( dropdestination ) && function_47a1cf76c5dcb2d3( droparea, dropdestination ) )
            {
                return dropdestination;
            }
        }
    }
}

// Namespace airdrop_scriptbundle
// Params 3, eflags: 0x4
// Checksum 0x2f87bbd, Offset: 0x1d87
// Size: 0xeb
function private function_70d144f4414e2e81( airdropsettings, var_eedf11a69d35a3b, packagesettings )
{
    avoidwater = !function_db12c5dff94a61c5( airdropsettings );
    dropdestination = undefined;
    
    if ( !avoidwater || function_47a1cf76c5dcb2d3( airdropsettings.droparea, var_eedf11a69d35a3b ) )
    {
        dropdestination = function_15ad4ce1fcf6748f( var_eedf11a69d35a3b, undefined, avoidwater );
    }
    
    if ( isdefined( dropdestination ) || !avoidwater )
    {
        return dropdestination;
    }
    
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.type == #"plane" )
    {
        return function_15ad4ce1fcf6748f( var_eedf11a69d35a3b, undefined, 0 );
    }
    
    return function_9bb59dc8e54b24b6( airdropsettings.droparea );
}

// Namespace airdrop_scriptbundle
// Params 4, eflags: 0x4
// Checksum 0x9770e33a, Offset: 0x1e7b
// Size: 0x189
function private function_518bcd47d453a16f( airdropsettings, origin, falldistance, var_a59391bbcc198054 )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( var_a59391bbcc198054 == "shallow" )
    {
        soundalias = packagesettings.var_90a744fd35a2991a ?? packagesettings.var_c7f0ae33c8add17e;
        effect = packagesettings.var_7f32806057b0df72 ?? packagesettings.var_8297d3fbba03df76;
    }
    else if ( var_a59391bbcc198054 == "deep" )
    {
        soundalias = packagesettings.var_73e5b6ef8af138cc;
        effect = packagesettings.var_de54ed6d58e8fa50;
    }
    else
    {
        var_22f57ee0bfef4c2f = packagesettings.var_d0bb3dd7b58d957f > 0 && falldistance >= packagesettings.var_d0bb3dd7b58d957f;
        
        if ( var_22f57ee0bfef4c2f )
        {
            soundalias = packagesettings.var_ccbb8f7640a192be ?? packagesettings.var_c7f0ae33c8add17e;
            effect = packagesettings.var_911a93319e7aa526 ?? packagesettings.var_8297d3fbba03df76;
        }
        else
        {
            soundalias = packagesettings.var_c7f0ae33c8add17e;
            effect = packagesettings.var_8297d3fbba03df76;
        }
    }
    
    if ( soundalias )
    {
        playsoundatpos( origin, soundalias );
    }
    
    if ( !isdefined( effect ) )
    {
        return;
    }
    
    playfx( function_2e675cc8eac7be39( effect ), origin );
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0xd27ae553, Offset: 0x200c
// Size: 0x7b
function private function_6117623c4e3a8840( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( !isdefined( packagesettings.traileffect ) )
    {
        return;
    }
    
    waitframe();
    playfxontag( function_2e675cc8eac7be39( packagesettings.traileffect ), self, "tag_origin" );
}

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0xa0fa6ce1, Offset: 0x208f
// Size: 0x7a
function private function_fc5847ceea8be2ef( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( !isdefined( packagesettings.traileffect ) )
    {
        return;
    }
    
    stopfxontag( function_2e675cc8eac7be39( packagesettings.traileffect ), self, "tag_origin" );
}

// Namespace airdrop_scriptbundle
// Params 1
// Checksum 0x2a9d44a1, Offset: 0x2111
// Size: 0x1dd
function function_4c121ea2c29854e8( airdropsettings )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    childthread function_6117623c4e3a8840( airdropsettings );
    spawnheight = self.var_83f994db6ffbd58d ?? self.origin[ 2 ];
    impactinfo = function_34666c4446aeae99();
    
    if ( !impactinfo || impactinfo.timedout )
    {
        function_fc5847ceea8be2ef( airdropsettings );
        return;
    }
    
    if ( function_b5d766a4a8dbccd8( impactinfo.surfacetype ) )
    {
        self.inwater = 1;
        var_4c1b3d72afdc2b50 = function_f50bbabe80c24d44( impactinfo.position, impactinfo.normal );
        
        if ( isdefined( var_4c1b3d72afdc2b50 ) && var_4c1b3d72afdc2b50.var_46cfcd687c2f9dee < 50 )
        {
            falldistance = spawnheight - var_4c1b3d72afdc2b50.position[ 2 ];
            function_518bcd47d453a16f( airdropsettings, var_4c1b3d72afdc2b50.position, falldistance, "shallow" );
            function_fc5847ceea8be2ef( airdropsettings );
            return;
        }
        else
        {
            falldistance = spawnheight - impactinfo.position[ 2 ];
            function_518bcd47d453a16f( airdropsettings, impactinfo.position, falldistance, "deep" );
            function_fc5847ceea8be2ef( airdropsettings );
            
            if ( isdefined( var_4c1b3d72afdc2b50 ) )
            {
                groundimpact = function_31b7e4dbbd93c51c( var_4c1b3d72afdc2b50 );
                
                if ( isdefined( groundimpact ) && function_96d7d4722d9bfd7d( groundimpact ) )
                {
                    falldistance = spawnheight - groundimpact.position[ 2 ];
                    function_518bcd47d453a16f( airdropsettings, groundimpact.position, falldistance );
                }
            }
            
            return;
        }
    }
    
    falldistance = spawnheight - impactinfo.position[ 2 ];
    function_518bcd47d453a16f( airdropsettings, impactinfo.position, falldistance );
    function_fc5847ceea8be2ef( airdropsettings );
}

/#

    // Namespace airdrop_scriptbundle
    // Params 1
    // Checksum 0xd8aac5ef, Offset: 0x22f6
    // Size: 0x18, Type: dev
    function function_4c196eb0fa6f3ddb( airdropsettings )
    {
        return function_1ab0abf851fd2a02( airdropsettings );
    }

#/

// Namespace airdrop_scriptbundle
// Params 1, eflags: 0x4
// Checksum 0x41587fff, Offset: 0x2316
// Size: 0x330
function private function_1ab0abf851fd2a02( airdropsettings )
{
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    droplocationtype = airdropsettings.overrideoptions.droplocationtype ?? var_9ae4b3950522d64e.droplocationtype;
    var_8e83b15472993439 = airdropsettings.overrideoptions.var_8e83b15472993439 ?? var_9ae4b3950522d64e.var_8e83b15472993439;
    
    if ( airdropsettings.var_c2fa1e6335a19103 )
    {
        var_30b7e315315f84cf = { #radius:airdropsettings.var_d99cf9bde319cf6f ?? 1, #origin:airdropsettings.var_c2fa1e6335a19103 };
        assert( droplocationtype == "<dev string:x2a9>" || droplocationtype == "<dev string:x2b0>", "<dev string:x2bb>" );
    }
    else
    {
        var_30b7e315315f84cf = function_c430849f1444afce();
    }
    
    switch ( droplocationtype )
    {
        case #"hash_87d1443ef2805760":
            assert( isdefined( airdropsettings.player ), "<dev string:x32b>" );
            
            if ( isdefined( airdropsettings.player ) )
            {
                droparea = airdropsettings.player function_a1c7fb7a6789175f();
                break;
            }
        case #"hash_33857c6e26098e6c":
            assert( isdefined( airdropsettings.team ), "<dev string:x377>" );
            
            if ( isdefined( airdropsettings.team ) )
            {
                playerfound = undefined;
                teamplayers = arrayrandomize( teams::getteamdata( airdropsettings.team, "players" ) );
                
                foreach ( player in teamplayers )
                {
                    if ( player::isreallyalive( player ) && !player br_public::isplayeringulag() )
                    {
                        droparea = player function_a1c7fb7a6789175f();
                        playerfound = 1;
                        break;
                    }
                }
                
                if ( playerfound )
                {
                    break;
                }
            }
        case #"hash_82dd7c3e206217c2":
            if ( var_8e83b15472993439 )
            {
                droparea = function_3ce287de9991afb3( airdropsettings, var_30b7e315315f84cf );
            }
            else
            {
                droparea = var_30b7e315315f84cf;
            }
            
            var_c97dc7f4bc2dc257 = droparea.origin;
            var_a4ced1b9822867eb = droparea.radius;
            droparea.origin = br_circle::getrandompointincircle( var_c97dc7f4bc2dc257, var_a4ced1b9822867eb );
            droparea.radius = var_a4ced1b9822867eb - distance2d( droparea.origin, var_c97dc7f4bc2dc257 );
            break;
        case #"hash_9bd11cf37195abdf":
            if ( var_8e83b15472993439 )
            {
                droparea = function_3ce287de9991afb3( airdropsettings, var_30b7e315315f84cf );
            }
            else
            {
                droparea = var_30b7e315315f84cf;
            }
            
            break;
        default:
            script::demoforcesre( "Scriptbunle Package Airdrop: Drop location type not supported " + droplocationtype );
            droparea = function_3ce287de9991afb3( airdropsettings, var_30b7e315315f84cf );
            break;
    }
    
    return droparea;
}

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x4
// Checksum 0x30b722e3, Offset: 0x264f
// Size: 0xf0
function private function_a1c7fb7a6789175f()
{
    player = self;
    forward = anglestoforward( player.angles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    
    if ( isnavmeshloaded() )
    {
        safeorigin = getclosestpointonnavmesh( player.origin + offset );
        
        if ( distance2dsquared( player.origin, safeorigin ) > 500000 && !outofbounds::isoob( player ) )
        {
            safeorigin = player.origin;
        }
    }
    else
    {
        safeorigin = player.origin;
    }
    
    droparea = { #radius:50, #origin:safeorigin };
    return droparea;
}

// Namespace airdrop_scriptbundle
// Params 0, eflags: 0x4
// Checksum 0x4400a81e, Offset: 0x2748
// Size: 0x268
function private function_c430849f1444afce()
{
    circle = {};
    
    if ( !level.br_circle_disabled && br_circle::islastcircle() )
    {
        circle.origin = ( level.br_circle.dangercircleent.origin[ 0 ], level.br_circle.dangercircleent.origin[ 1 ], 0 );
        circle.radius = level.br_circle.dangercircleent.origin[ 2 ];
    }
    else if ( level.br_multi_circle_enabled )
    {
        circle.origin = level.br_level.br_circlecenters[ level.br_circle.circleindex + 1 ];
        circle.radius = level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ];
    }
    else if ( isdefined( level.br_circle.safecircleent ) )
    {
        circle.origin = ( level.br_circle.safecircleent.origin[ 0 ], level.br_circle.safecircleent.origin[ 1 ], 0 );
        circle.radius = level.br_circle.safecircleent.origin[ 2 ];
    }
    else if ( isdefined( level.br_level.br_mapcenter ) )
    {
        circle.origin = level.br_level.br_mapcenter + br_c130::function_40c70dc273b74619();
        circle.radius = br_c130::getplanepathsaferadiusfromcenter();
    }
    else if ( isdefined( level.package_airdrop.var_2c7c2f74aaff29ef ) )
    {
        circle.origin = level.package_airdrop.var_2c7c2f74aaff29ef;
        circle.radius = level.package_airdrop.var_fb7707969367ed13;
    }
    else
    {
        script::demoforcesre( "Scriptbunle Package Airdrop: Could not find any valid map center" );
    }
    
    return circle;
}

// Namespace airdrop_scriptbundle
// Params 6
// Checksum 0xdc05f47f, Offset: 0x29b9
// Size: 0xe0
function function_7d52124313f56a( droparea, var_9501319a9b5395cf, overlapcircleradius, var_ac66f9920fd56b55 = 0, var_4e495e1384ee5a32, var_83daa9f5e7d5124c = undefined )
{
    intersection = math::function_58dd1731345885d3( var_9501319a9b5395cf, overlapcircleradius, droparea.origin, droparea.radius );
    
    if ( !isdefined( intersection ) )
    {
        return ( var_83daa9f5e7d5124c ?? droparea );
    }
    
    if ( intersection.radius < var_ac66f9920fd56b55 )
    {
        if ( isdefined( var_4e495e1384ee5a32 ) )
        {
            logstring( var_4e495e1384ee5a32 );
        }
    }
    
    var_5ab183ae8cfd86f3 = { #radius:int( max( 1, intersection.radius ) ), #origin:intersection.center };
    return var_5ab183ae8cfd86f3;
}

// Namespace airdrop_scriptbundle
// Params 2, eflags: 0x4
// Checksum 0x931c2351, Offset: 0x2aa2
// Size: 0x74
function private function_3ce287de9991afb3( airdropsettings, droparea )
{
    if ( !isbrgamemode() )
    {
        return droparea;
    }
    
    var_7fb8be2132b766f3 = level.br_level.br_mapcenter + br_c130::function_40c70dc273b74619();
    var_775868ffd27f178c = br_c130::getplanepathsaferadiusfromcenter();
    return function_7d52124313f56a( droparea, var_7fb8be2132b766f3, var_775868ffd27f178c, 2000, "Scriptbundle Package Airdrop: Intersection is too small, using snapped drop area for " + airdropsettings.airdropidentifier );
}

/#

    // Namespace airdrop_scriptbundle
    // Params 0, eflags: 0x4
    // Checksum 0x4bc16b1f, Offset: 0x2b1f
    // Size: 0x11f, Type: dev
    function private debug_init()
    {
        level endon( #"game_ended" );
        wait 1;
        
        if ( !isdefined( level.package_airdrop.airdroptypes ) || level.package_airdrop.airdroptypes.size <= 0 )
        {
            return;
        }
        
        foreach ( airdropidentifier, _ in level.package_airdrop.airdroptypes )
        {
            function_4f0936ba109e0241( airdropidentifier );
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x3bf>" );
        devgui::add_devgui_func( "<dev string:x3d8>", "<dev string:x3f3>", &function_7e78ffaf476da2c3 );
        devgui::add_devgui_func( "<dev string:x40e>", "<dev string:x428>", &function_45cc7ea2623bc1 );
        devgui::function_77df7fe7dd273e10();
        level.package_airdrop.var_12c690b2f8308332 = 1;
    }

    // Namespace airdrop_scriptbundle
    // Params 1, eflags: 0x4
    // Checksum 0xbd620f85, Offset: 0x2c46
    // Size: 0x44, Type: dev
    function private function_4f0936ba109e0241( airdropidentifier )
    {
        devgui::function_9082edeb5db93280( "<dev string:x3bf>" + airdropidentifier + "<dev string:x43b>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43d>", "<dev string:x443>" + airdropidentifier, &function_69219920dba57fcd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace airdrop_scriptbundle
    // Params 1, eflags: 0x4
    // Checksum 0xe3c52a3b, Offset: 0x2c92
    // Size: 0x1e, Type: dev
    function private function_a5edbf0cec93d025( airdropidentifier )
    {
        devgui::remove_devgui_menu( "<dev string:x3bf>" + airdropidentifier );
    }

    // Namespace airdrop_scriptbundle
    // Params 0, eflags: 0x4
    // Checksum 0xf131f9d0, Offset: 0x2cb8
    // Size: 0xe4, Type: dev
    function private function_c69a02c2d292c86d()
    {
        packagetypes = [];
        
        foreach ( packagestruct in level.package_airdrop.airdroptypes )
        {
            packagesettings = level.package_airdrop.airdroptypes[ packagestruct.airdropidentifier ].packages[ 0 ].variant_object;
            packagetypes = arraycombineunique( packagetypes, [ packagesettings.type ] );
        }
        
        return packagetypes;
    }

    // Namespace airdrop_scriptbundle
    // Params 0, eflags: 0x4
    // Checksum 0x18963abe, Offset: 0x2da4
    // Size: 0xd0, Type: dev
    function private function_7e78ffaf476da2c3()
    {
        packagetypes = function_c69a02c2d292c86d();
        
        foreach ( packagetype in packagetypes )
        {
            assert( utility::issharedfuncdefined( #"hash_957e5882bc1fa7c5", packagetype ), "<dev string:x451>" + packagetype );
            utility::callsharedfunc( #"hash_957e5882bc1fa7c5", packagetype );
        }
        
        level.package_airdrop.var_a345529f4315b20 = undefined;
        level notify( #"hash_bee8fbe5e51d87e5" );
    }

    // Namespace airdrop_scriptbundle
    // Params 3
    // Checksum 0x2ee72e0f, Offset: 0x2e7c
    // Size: 0x5f, Type: dev
    function function_cbfae468752db826( origin, airdropidentifier, color )
    {
        line( origin, origin + ( 0, 0, 2000 ), color );
        print3d( origin + ( 0, 0, 15 ), "<dev string:x4be>" + airdropidentifier, color, 1, 0.4 );
    }

    // Namespace airdrop_scriptbundle
    // Params 0
    // Checksum 0x70bf83b7, Offset: 0x2ee3
    // Size: 0x70, Type: dev
    function function_45cc7ea2623bc1()
    {
        self notify( #"hash_9dc3f9023da9ec77" );
        self endon( #"hash_9dc3f9023da9ec77" );
        level endon( #"game_ended" );
        
        if ( level.package_airdrop.var_a345529f4315b20 )
        {
            level.package_airdrop.var_a345529f4315b20 = undefined;
            return;
        }
        
        level.package_airdrop.var_a345529f4315b20 = 1;
        function_337c85ff68d4b0d7();
    }

    // Namespace airdrop_scriptbundle
    // Params 0, eflags: 0x4
    // Checksum 0x3d450eb, Offset: 0x2f5b
    // Size: 0xa4, Type: dev
    function private function_a25b32e923ba45b7()
    {
        packagetypes = function_c69a02c2d292c86d();
        
        foreach ( packagetype in packagetypes )
        {
            if ( utility::issharedfuncdefined( #"hash_da0b3038771ec485", packagetype ) )
            {
                utility::callsharedfunc( #"hash_da0b3038771ec485", packagetype );
            }
        }
    }

    // Namespace airdrop_scriptbundle
    // Params 0
    // Checksum 0xfbf5bcf1, Offset: 0x3007
    // Size: 0x56, Type: dev
    function function_337c85ff68d4b0d7()
    {
        self notify( #"hash_f915d0f0fcc693c0" );
        self endon( #"hash_f915d0f0fcc693c0" );
        level endon( #"game_ended" );
        level endon( #"hash_bee8fbe5e51d87e5" );
        
        while ( level.package_airdrop.var_a345529f4315b20 )
        {
            function_a25b32e923ba45b7();
            waitframe();
        }
    }

    // Namespace airdrop_scriptbundle
    // Params 1, eflags: 0x4
    // Checksum 0xcaf67666, Offset: 0x3065
    // Size: 0x47, Type: dev
    function private function_69219920dba57fcd( params )
    {
        airdropidentifier = params[ 0 ];
        thread startairdrop( airdropidentifier, level.players[ 0 ], level.players[ 0 ].team );
    }

    // Namespace airdrop_scriptbundle
    // Params 1
    // Checksum 0x7712e84d, Offset: 0x30b4
    // Size: 0x112, Type: dev
    function function_7cd363b1454f7750( droparea )
    {
        self notify( #"hash_b2d5f612bbe54194" );
        self endon( #"hash_b2d5f612bbe54194" );
        
        if ( !getdvarint( @"hash_6760942c9936694d", 0 ) )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"hash_bee8fbe5e51d87e5" );
        
        if ( isdefined( level.var_32caaae7c3aaba66 ) )
        {
            level.var_32caaae7c3aaba66 delete();
        }
        
        level.var_32caaae7c3aaba66 = spawnquestcircle( "<dev string:x4c8>", droparea.origin[ 0 ], droparea.origin[ 1 ], droparea.radius, level.players[ 0 ] );
        
        while ( getdvarint( @"hash_6760942c9936694d", 0 ) )
        {
            utility::draw_circle( droparea.origin, droparea.radius, ( 0, 1, 0 ), 1, 0, 1 );
            waitframe();
        }
        
        if ( isdefined( level.var_32caaae7c3aaba66 ) )
        {
            level.var_32caaae7c3aaba66 delete();
        }
    }

#/
