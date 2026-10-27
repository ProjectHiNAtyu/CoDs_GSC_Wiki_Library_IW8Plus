// script_1ab246a6221f0c14  (hash_1ab246a6221f0c14.gscc) (size: 4949 Bytes / 0x1355 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x890e3857 (2299410519)
// size ...... 4949 (0x1355)
// includes .. 6   (offset: 0x12a5)
// strings ... 10  (offset: 0x12d5)
// dev strs .. 0   (offset: 0x1355)
// exports ... 15  (offset: 0xb9d)
// cseg ...... 0x130 + 0xa6d (0xb9d)
// imports ... 41  (offset: 0xdf5)
// animtree1 . 0   (offset: 0x1355)
// animtree2 . 0   (offset: 0x1355)
#using scripts\common\anim;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\common\killstreaks\airdrop;

#namespace namespace_387207b4de5baeea;

// Namespace namespace_387207b4de5baeea
// Params 0, eflags: 0x5
// Checksum 0x40dc3c58, Offset: 0x14e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7a2896597cf2dd7", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_387207b4de5baeea
// Params 0, eflags: 0x4
// Checksum 0xc2672e7c, Offset: 0x177
// Size: 0x38
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"start_airdrop", #"chopper", &function_9d2ddface95ca292 );
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0x4c94c6ce, Offset: 0x1b7
// Size: 0x2e1
function private function_9d2ddface95ca292( airdropsettings )
{
    level endon( #"game_ended" );
    function_a10d80ee740d67bc( airdropsettings );
    dropdestination = function_726ccd5458b4693c( airdropsettings );
    
    if ( !dropdestination || !function_f7089182e1c931c9( dropdestination ) )
    {
        return [];
    }
    
    owner = function_1a84e77c255a657b( airdropsettings );
    team = function_64b9c20cb9c13b3d( airdropsettings, owner );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    packagetype = packagesettings.type;
    behaviorsettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    airdropidentifier = airdropsettings.airdropidentifier;
    helipos = ( dropdestination[ 0 ], dropdestination[ 1 ], -5000 );
    package = utility::callsharedfunc( #"hash_c0543f4480543c68", packagetype, airdropsettings, helipos, dropdestination, ( 0, 0, 0 ), undefined, 0 );
    
    if ( !package )
    {
        script::demoforcesre( "Failed to create airdrop package of type " + packagetype + " for chopper drop: " + airdropidentifier );
        return [];
    }
    
    flightangles = function_5a22b3bfdd3d0da3( airdropsettings );
    dropdata = { #var_fd2ab891d645a196:behaviorsettings.choppermodel, #var_a9a8df5367d9ad4b:behaviorsettings.choppervehicle, #crateoverride:package, #airdropidentifier:airdropidentifier };
    scenenode = airdrop::dropcratefromscriptedheli( owner, team, airdropidentifier, dropdestination, flightangles, dropdestination, dropdata );
    
    if ( !scenenode )
    {
        package delete();
        return [];
    }
    
    function_86741b6bfd5c1be8( package, scenenode, packagetype );
    
    while ( true )
    {
        if ( !( isdefined( scenenode ) && isdefined( package ) ) )
        {
            return [];
        }
        
        if ( scenenode.ownerdisconnected || scenenode.ownerjoinedteam )
        {
            return [];
        }
        
        if ( packagetype == #"vehicle" || packagetype == #"loot_cache" )
        {
            if ( scenenode.heli.isdestroyed || gettime() >= package.animdroptime )
            {
                if ( isdefined( package.var_fe2a17068a3c0fa6 ) )
                {
                    package [[ package.var_fe2a17068a3c0fa6 ]]();
                }
                else
                {
                    package unlink();
                }
                
                package.scenenode = undefined;
                return [ package ];
            }
        }
        else if ( !package.scenenode )
        {
            return [ package ];
        }
        
        waitframe();
    }
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0xef82d9ce, Offset: 0x4a0
// Size: 0x5d
function private function_a10d80ee740d67bc( airdropsettings )
{
    if ( airdrop_scriptbundle::function_db12c5dff94a61c5( airdropsettings ) )
    {
        return;
    }
    
    var_9879959f256d5c55 = airdrop_scriptbundle::function_9bb59dc8e54b24b6( airdropsettings.droparea );
    
    if ( var_9879959f256d5c55 )
    {
        airdropsettings.droparea = { #radius:1, #origin:var_9879959f256d5c55 };
    }
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0x5ce67191, Offset: 0x505
// Size: 0x3d
function private function_3e3306551f89f25b( scenenode )
{
    firstkey = getfirstarraykey( scenenode.ropes );
    
    if ( !isdefined( firstkey ) )
    {
        return;
    }
    
    return scenenode.ropes[ firstkey ];
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0x25bba90d, Offset: 0x54b
// Size: 0x9c
function private function_726ccd5458b4693c( airdropsettings )
{
    if ( airdrop_scriptbundle::function_db12c5dff94a61c5( airdropsettings ) )
    {
        return ( function_3bddc8485c671822( airdropsettings, airdropsettings.droparea.origin ) ?? airdropsettings.droparea.origin );
    }
    
    var_9879959f256d5c55 = airdrop_scriptbundle::function_9bb59dc8e54b24b6( airdropsettings.droparea );
    var_7237854e3be197ca = var_9879959f256d5c55;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return function_3bddc8485c671822( airdropsettings, airdropsettings.droparea.origin );
}

// Namespace namespace_387207b4de5baeea
// Params 2, eflags: 0x4
// Checksum 0x11b7d5b6, Offset: 0x5f0
// Size: 0xcf
function private function_3bddc8485c671822( airdropsettings, desireddestination )
{
    if ( airdrop_scriptbundle::function_db12c5dff94a61c5( airdropsettings ) )
    {
        return ( airdrop_scriptbundle::function_15ad4ce1fcf6748f( desireddestination + ( 0, 0, 12000 ), 1, 0 ) ?? desireddestination );
    }
    
    if ( function_47a1cf76c5dcb2d3( airdropsettings.droparea, desireddestination ) )
    {
        dropdestination = airdrop_scriptbundle::function_15ad4ce1fcf6748f( desireddestination + ( 0, 0, 12000 ), 0, 1 );
        var_7237854e3be197ca = dropdestination;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    var_9879959f256d5c55 = airdrop_scriptbundle::function_9bb59dc8e54b24b6( airdropsettings.droparea );
    var_7237854e3be197ca = var_9879959f256d5c55;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return airdrop_scriptbundle::function_15ad4ce1fcf6748f( desireddestination + ( 0, 0, 12000 ), 0, 0 );
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0x75215ff3, Offset: 0x6c8
// Size: 0x25, Type: bool
function private function_1a84e77c255a657b( airdropsettings )
{
    return airdropsettings.ownerplayer ?? airdropsettings.player;
}

// Namespace namespace_387207b4de5baeea
// Params 2, eflags: 0x4
// Checksum 0xac18440d, Offset: 0x6f6
// Size: 0x44, Type: bool
function private function_64b9c20cb9c13b3d( airdropsettings, owner )
{
    return airdropsettings.ownerteam ?? airdropsettings.team ?? owner.team ?? "neutral";
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0x56ca9ecc, Offset: 0x743
// Size: 0x46, Type: bool
function private function_5a22b3bfdd3d0da3( airdropsettings )
{
    return airdropsettings.overrideoptions.dropangles ?? airdropsettings.extradata.chopperangles ?? ( 0, randomfloat( 360 ), 0 );
}

// Namespace namespace_387207b4de5baeea
// Params 3, eflags: 0x4
// Checksum 0x1a4c827f, Offset: 0x792
// Size: 0x1d6
function private function_86741b6bfd5c1be8( package, scenenode, packagetype )
{
    package.scenenode = scenenode;
    crateanim = level.scr_anim[ "care_package" ][ "care_package_drop" ];
    crateanimtime = getanimlength( crateanim ) * 1000;
    now = gettime();
    package.animdroptime = now + getnotetracktimes( crateanim, "carepackage_drop" )[ 0 ] * crateanimtime;
    package.animstoptrailtime = now + getnotetracktimes( crateanim, "carepackage_trail_end" )[ 0 ] * crateanimtime;
    package.animendtime = now + crateanimtime;
    
    if ( packagetype == #"crate" )
    {
        if ( !isdefined( scenenode.crates ) )
        {
            scenenode.crates = [];
        }
        
        scenenode.crates[ package getentitynumber() ] = package;
        package.animname = "care_package";
        package animation::setanimtree();
        scenenode.latestanimendtime = package.animendtime > scenenode.latestanimendtime ? package.animendtime : scenenode.latestanimendtime;
        return;
    }
    
    if ( packagetype == #"vehicle" )
    {
        package thread function_18ad53b4fcd876cd( scenenode );
        return;
    }
    
    if ( packagetype == #"loot_cache" )
    {
        rope = function_3e3306551f89f25b( scenenode );
        
        if ( rope )
        {
            package linkto( rope, "wire_mid_jnt_01", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            return;
        }
        
        package linkto( scenenode.heli );
    }
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0xdec4aad3, Offset: 0x970
// Size: 0x134
function private function_18ad53b4fcd876cd( scenenode )
{
    self endon( #"death" );
    rope = function_3e3306551f89f25b( scenenode );
    
    while ( self.scenenode )
    {
        if ( rope )
        {
            posle = rope gettagorigin( "wire_LE_jnt_01" );
            posmid = rope gettagorigin( "wire_mid_jnt_01" );
            posri = rope gettagorigin( "wire_RI_jnt_01" );
            center = ( posle + posmid + posri ) * 0.333333;
            var_28835cb7cb4adf18 = vectornormalize( vectorcross( posri - posle, posmid - posle ) );
            
            if ( var_28835cb7cb4adf18[ 2 ] < 0 )
            {
                var_28835cb7cb4adf18 *= -1;
            }
            
            vehicleangles = generateaxisanglesfromforwardvector( anglestoforward( scenenode.heli.angles ), var_28835cb7cb4adf18 );
            self function_df84c23b1e53ff82( center, vehicleangles );
        }
        else if ( scenenode.heli )
        {
            self function_df84c23b1e53ff82( scenenode.heli.origin, scenenode.heli.angles );
        }
        
        waitframe();
    }
}

// Namespace namespace_387207b4de5baeea
// Params 2, eflags: 0x4
// Checksum 0x5a82e1e9, Offset: 0xaac
// Size: 0x3e, Type: bool
function private function_47a1cf76c5dcb2d3( droparea, point )
{
    return distance2dsquared( droparea.origin, point ) <= droparea.radius * droparea.radius;
}

// Namespace namespace_387207b4de5baeea
// Params 1, eflags: 0x4
// Checksum 0xfefc652c, Offset: 0xaf3
// Size: 0xa9, Type: bool
function private function_f7089182e1c931c9( position )
{
    foreach ( exfil in level.var_e584ab91aed38e8c )
    {
        if ( exfil.b_exfil_started && distancesquared( exfil.origin, position ) < 562500 )
        {
            return false;
        }
    }
    
    return true;
}

