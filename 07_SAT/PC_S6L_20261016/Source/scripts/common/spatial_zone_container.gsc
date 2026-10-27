// scripts\common\spatial_zone_container.gsc  (hash_73a03aaf11b641f5.gscc) (size: 25040 Bytes / 0x61d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa47d16db (2759661275)
// size ...... 25040 (0x61d0)
// includes .. 4   (offset: 0x5f08)
// strings ... 6   (offset: 0x5f28)
// dev strs .. 41  (offset: 0x5f84)
// exports ... 115 (offset: 0x3e6c)
// cseg ...... 0xf5 + 0x3d77 (0x3e6c)
// imports ... 109 (offset: 0x5064)
// animtree1 . 0   (offset: 0x61d0)
// animtree2 . 0   (offset: 0x61d0)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;

#namespace spatial_zone_container;

// Namespace spatial_zone_container
// Params 0, eflags: 0x5
// Checksum 0x9b212eed, Offset: 0x113
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"spatial_zone_container", undefined, &function_9d7bc24da0235ce1, undefined );
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x7070b228, Offset: 0x134
    // Size: 0x5, Type: dev
    function function_317d883760182fea()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 0, eflags: 0x4
// Checksum 0x5635484f, Offset: 0x141
// Size: 0x38
function private function_9d7bc24da0235ce1()
{
    level.var_54ae469dd0b3c78a = { #var_cbe450c2c2387d7c:getdvarfloat( @"hash_7cea12faaeb9d47" ), #var_f78cf86e749f396e:0 };
    utility::flag_set( "spatial_zone_container_init_complete" );
}

// Namespace spatial_zone_container
// Params 0
// Checksum 0x815254aa, Offset: 0x181
// Size: 0x24
function function_8e5f2c38626c6c9d()
{
    var_79f7b40e044079b7 = level.var_54ae469dd0b3c78a;
    var_79f7b40e044079b7.var_f78cf86e749f396e = 0;
}

// Namespace spatial_zone_container
// Params 0
// Checksum 0xd8f754fd, Offset: 0x1ad
// Size: 0x25
function function_78d783cad237664e()
{
    var_79f7b40e044079b7 = level.var_54ae469dd0b3c78a;
    var_79f7b40e044079b7.var_f78cf86e749f396e = 1;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x91e58c4b, Offset: 0x1da
    // Size: 0x5, Type: dev
    function function_229d00c3da82aeae()
    {
        
    }

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x7d72404d, Offset: 0x1e7
    // Size: 0x5, Type: dev
    function function_695398ed641e4766()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 0
// Checksum 0x6eeef0e6, Offset: 0x1f4
// Size: 0x16
function function_bf9b65032b29d653()
{
    spatialzonecontainer = function_4d27247e5a64f9ea();
    return spatialzonecontainer;
}

// Namespace spatial_zone_container
// Params 1
// Checksum 0x19821251, Offset: 0x213
// Size: 0x31
function function_389ac59074912882( var_b830fb7007cf5c20 )
{
    assert( isstruct( var_b830fb7007cf5c20 ), "<dev string:x24>" );
    var_b830fb7007cf5c20.var_8339fb4f2d23dabf = function_4d27247e5a64f9ea();
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x55f69e1f, Offset: 0x24c
// Size: 0xde
function function_bf7a9233c189639a( var_bdfcadfd71d344c3, var_7ebe5cd79412814f )
{
    function_389ac59074912882( var_bdfcadfd71d344c3 );
    assert( function_fa7cf854729812a7( var_7ebe5cd79412814f ), "<dev string:x6a>" );
    assert( isstruct( var_bdfcadfd71d344c3 ), "<dev string:x24>" );
    var_f75647680dfcd53a = function_611a01c151e4f32e( var_7ebe5cd79412814f );
    
    foreach ( var_e1ec9b66bbdd44d5 in var_f75647680dfcd53a )
    {
        spatialzonestruct = function_7f0e3212ce7f382e( var_e1ec9b66bbdd44d5, var_bdfcadfd71d344c3 );
        function_e2b259b43168dc64( var_bdfcadfd71d344c3, spatialzonestruct );
    }
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x8122b2ea, Offset: 0x332
    // Size: 0x5, Type: dev
    function function_4aab398f705325f1()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1
// Checksum 0x7f3cdfe7, Offset: 0x33f
// Size: 0x18, Type: bool
function function_fa7cf854729812a7( var_ecacea6f622d286d )
{
    return isdefined( var_ecacea6f622d286d.var_8339fb4f2d23dabf );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x72a0ba0f, Offset: 0x360
// Size: 0x3b, Type: bool
function function_3819f09eefb741e2( spatialzonecontainer, zonename )
{
    var_6d8099b682c60c45 = spatialzonecontainer.var_8339fb4f2d23dabf;
    return isdefined( var_6d8099b682c60c45.zones[ zonename ] );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x845dab35, Offset: 0x3a4
// Size: 0x39, Type: bool
function function_afe89aefe6bb53d3( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    return isdefined( spatialzonestruct.spheres[ zonename ] );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x1a1bf8a7, Offset: 0x3e6
// Size: 0x42, Type: bool
function function_3ece75d305a5a944( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
    return istrue( hasdynamicorigin );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0xe625522b, Offset: 0x431
// Size: 0x4a
function function_f7fc3e6c249a8256( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        return function_53f3961c1817039d( spatialzonecontainer, zonename );
    }
    
    return spatialzonestruct.spheres;
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x1bb852c4, Offset: 0x484
// Size: 0xf4
function function_46a131256b075dc1( spatialzonecontainer, zonename )
{
    spatialzonespheres = function_f7fc3e6c249a8256( spatialzonecontainer, zonename );
    var_6484304f1ae788ef = spatialzonespheres.size;
    
    if ( var_6484304f1ae788ef > 0 )
    {
        centerpoint = ( 0, 0, 0 );
        
        foreach ( SpatialZoneSphere in spatialzonespheres )
        {
            sphereorigin = spatialzonecontainer function_2676e037929f0833( SpatialZoneSphere );
            centerpoint += sphereorigin;
        }
        
        centerpoint /= var_6484304f1ae788ef;
        return centerpoint;
    }
    
    assertmsg( "<dev string:xd8>" + zonename + "<dev string:x108>" );
}

// Namespace spatial_zone_container
// Params 1
// Checksum 0x6b0b2be1, Offset: 0x581
// Size: 0xa5
function function_db3efdf4ec087c3f( spatialzonecontainer )
{
    zonenames = [];
    spatialzonestructs = function_611a01c151e4f32e( spatialzonecontainer );
    
    foreach ( spatialzonestruct in spatialzonestructs )
    {
        zonenames[ zonenames.size ] = spatialzonestruct.name;
    }
    
    return zonenames;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x12b30a37, Offset: 0x62f
    // Size: 0x5, Type: dev
    function function_fca3d2674d6fb775()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 5
// Checksum 0xdd8ae0a, Offset: 0x63c
// Size: 0xe8
function function_847140d2863dfbf8( spatialzonecontainer, zonename, orign, radius, ignoreheight )
{
    if ( !function_3819f09eefb741e2( spatialzonecontainer, zonename ) )
    {
        addspatialzone( spatialzonecontainer, zonename );
    }
    
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        assertmsg( "<dev string:x125>" + zonename + "<dev string:x134>" + spatialzonestruct.linkedzonename + "<dev string:x143>" + spatialzonestruct.linkedzonename + "<dev string:x18e>" );
        return;
    }
    
    if ( !function_3ece75d305a5a944( spatialzonecontainer, zonename ) && !isdefined( orign ) )
    {
        function_3edbf3270263b31b( spatialzonecontainer, zonename, &function_3dd3cfeb0e5b52ad );
    }
    
    newsphere = function_2ec4b949c894828a( zonename, orign, radius, ignoreheight );
    function_8f8dc45bfd364e69( spatialzonestruct, newsphere );
    return newsphere;
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x716ac9de, Offset: 0x72d
// Size: 0x35
function addspatialzone( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_4dc7acfc1edeeedf( zonename );
    function_e2b259b43168dc64( spatialzonecontainer, spatialzonestruct );
    return spatialzonestruct;
}

// Namespace spatial_zone_container
// Params 4
// Checksum 0xa9a4a19, Offset: 0x76b
// Size: 0x5d
function function_5252f95edcf9e32c( spatialzonecontainer, zonename, originfunc = &function_3dd3cfeb0e5b52ad, originfuncparams = [] )
{
    spatialzonestruct = function_4dc7acfc1edeeedf( zonename, originfunc, originfuncparams );
    function_e2b259b43168dc64( spatialzonecontainer, spatialzonestruct );
    return spatialzonestruct;
}

// Namespace spatial_zone_container
// Params 4
// Checksum 0x6dae0e98, Offset: 0x7d1
// Size: 0x9a
function function_b14c4bcd92a0c6f2( spatialzonecontainer, zonename, var_af6c84c7bcfa45f7, var_b39ad593c3a51b61 = 1 )
{
    var_6d8099b682c60c45 = function_85630f83c98b3f52( spatialzonecontainer );
    
    if ( !function_3819f09eefb741e2( spatialzonecontainer, zonename ) )
    {
        spatialzonestruct = addspatialzone( spatialzonecontainer, zonename );
    }
    
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( !function_3819f09eefb741e2( spatialzonecontainer, zonename ) )
    {
        addspatialzone( spatialzonecontainer, var_af6c84c7bcfa45f7 );
    }
    
    function_74f9dfacf0f019ee( spatialzonestruct, var_af6c84c7bcfa45f7 );
    function_a5ce8a320f54cd99( spatialzonestruct, var_b39ad593c3a51b61 );
}

// Namespace spatial_zone_container
// Params 4
// Checksum 0x3aaa55eb, Offset: 0x873
// Size: 0xea
function function_3edbf3270263b31b( spatialzonecontainer, zonename, originfunc, originfuncparams = [] )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    function_68c1c04c6e5d8414( spatialzonestruct, 1, originfunc, originfuncparams );
    var_572e323233214bf9 = spatialzonestruct.spheres;
    
    foreach ( spatialzonespherestruct in var_572e323233214bf9 )
    {
        dynamicorigin = function_e7ce0b9160cbf129( spatialzonestruct );
        function_9a7cdff732ca26fd( spatialzonespherestruct, dynamicorigin );
    }
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x2b999e5f, Offset: 0x965
// Size: 0xcc
function function_39b907f49cc2d987( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    var_572e323233214bf9 = spatialzonestruct.spheres;
    
    foreach ( spatialzonespherestruct in var_572e323233214bf9 )
    {
        sphereorigin = spatialzonespherestruct.origin;
        
        if ( isdefined( sphereorigin ) )
        {
            spatialzonespherestruct.originoffset = undefined;
        }
    }
}

// Namespace spatial_zone_container
// Params 3
// Checksum 0xb19f5cfc, Offset: 0xa39
// Size: 0x83
function function_ddcd5f35f0032b25( spatialzonecontainer, zonename, spatialzonespherestruct )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        assertmsg( "<dev string:x125>" + zonename + "<dev string:x134>" + spatialzonestruct.linkedzonename + "<dev string:x194>" + spatialzonestruct.linkedzonename + "<dev string:x18e>" );
        return;
    }
    
    function_817617e89df189a0( spatialzonestruct, spatialzonespherestruct );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0xeb6c8a89, Offset: 0xac4
// Size: 0x7d
function function_a16a7e6ae5875495( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        assertmsg( "<dev string:x125>" + zonename + "<dev string:x134>" + spatialzonestruct.linkedzonename + "<dev string:x1e7>" + spatialzonestruct.linkedzonename + "<dev string:x18e>" );
        return;
    }
    
    spatialzonestruct.spheres = [];
}

// Namespace spatial_zone_container
// Params 3
// Checksum 0xab8a68e, Offset: 0xb49
// Size: 0x116
function function_3e98eaad64cc03e8( spatialzonecontainer, zonename, ignoreheight )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        assertmsg( "<dev string:x125>" + zonename + "<dev string:x134>" + spatialzonestruct.linkedzonename + "<dev string:x23d>" + spatialzonestruct.linkedzonename + "<dev string:x18e>" );
        return;
    }
    
    var_572e323233214bf9 = spatialzonestruct.spheres;
    
    foreach ( spherestruct in var_572e323233214bf9 )
    {
        if ( ignoreheight )
        {
            spherestruct.shouldignoreheight = 1;
            continue;
        }
        
        spherestruct.shouldignoreheight = undefined;
    }
}

// Namespace spatial_zone_container
// Params 3
// Checksum 0x6ee7d2d1, Offset: 0xc67
// Size: 0x116
function function_bec7648919fde60c( spatialzonecontainer, zonename, var_26d62a0d94a344a3 )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        assertmsg( "<dev string:x125>" + zonename + "<dev string:x134>" + spatialzonestruct.linkedzonename + "<dev string:x23d>" + spatialzonestruct.linkedzonename + "<dev string:x18e>" );
        return;
    }
    
    var_572e323233214bf9 = spatialzonestruct.spheres;
    
    foreach ( spherestruct in var_572e323233214bf9 )
    {
        if ( var_26d62a0d94a344a3 )
        {
            spherestruct.var_bcad2d5cf2834f88 = 1;
            continue;
        }
        
        spherestruct.var_bcad2d5cf2834f88 = undefined;
    }
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xe0f7bfcb, Offset: 0xd85
    // Size: 0x5, Type: dev
    function function_6a94dfecf1c28507()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 4
// Checksum 0xec19b187, Offset: 0xd92
// Size: 0x16a, Type: bool
function function_c6b163965cbc2caa( player, spatialzonecontainer, zonename, var_1566d474117d0549 )
{
    assert( function_3819f09eefb741e2( spatialzonecontainer, zonename ), "<dev string:x295>" + zonename + "<dev string:x29c>" );
    
    if ( !isdefined( var_1566d474117d0549 ) )
    {
        var_1566d474117d0549 = 1;
    }
    
    var_2ec2c7af53f81aed = function_f7fc3e6c249a8256( spatialzonecontainer, zonename );
    
    foreach ( spatialzonespherestruct in var_2ec2c7af53f81aed )
    {
        sphereorigin = spatialzonecontainer function_2676e037929f0833( spatialzonespherestruct );
        sphereradius = function_231d9e91d8ef7b5f( spatialzonespherestruct ) * var_1566d474117d0549;
        shouldignoreheight = istrue( spatialzonespherestruct.shouldignoreheight );
        var_bcad2d5cf2834f88 = istrue( spatialzonespherestruct.var_bcad2d5cf2834f88 );
        
        if ( !var_bcad2d5cf2834f88 && !function_bee5f509292d2b5c( sphereorigin, sphereradius ) )
        {
            continue;
        }
        
        playerwithinradius = 0;
        
        if ( shouldignoreheight )
        {
            playerwithinradius = utility::function_92fc197c20834b39( player, sphereorigin, sphereradius );
        }
        else
        {
            playerwithinradius = utility::playerwithindistance( player, sphereorigin, sphereradius );
        }
        
        if ( playerwithinradius )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spatial_zone_container
// Params 4
// Checksum 0xa9018e6b, Offset: 0xf05
// Size: 0x110, Type: bool
function function_4f49a4fe9f39d32b( point, spatialzonecontainer, zonename, var_1566d474117d0549 )
{
    assert( function_3819f09eefb741e2( spatialzonecontainer, zonename ), "<dev string:x295>" + zonename + "<dev string:x2fe>" );
    
    if ( !isdefined( var_1566d474117d0549 ) )
    {
        var_1566d474117d0549 = 1;
    }
    
    var_2ec2c7af53f81aed = function_f7fc3e6c249a8256( spatialzonecontainer, zonename );
    
    foreach ( spatialzonespherestruct in var_2ec2c7af53f81aed )
    {
        sphereorigin = spatialzonecontainer function_2676e037929f0833( spatialzonespherestruct );
        sphereradius = function_231d9e91d8ef7b5f( spatialzonespherestruct ) * var_1566d474117d0549;
        pointwithinradius = utility::ispointinsidecircle( point, sphereorigin, sphereradius );
        
        if ( pointwithinradius )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spatial_zone_container
// Params 4
// Checksum 0x3c452281, Offset: 0x101e
// Size: 0x1f8
function function_84f653d797112085( spatialzonecontainer, zonename, zonescaleoverride, excludedplayers )
{
    assert( function_3819f09eefb741e2( spatialzonecontainer, zonename ), "<dev string:x295>" + zonename + "<dev string:x35f>" );
    
    if ( !isdefined( zonescaleoverride ) )
    {
        zonescaleoverride = 1;
    }
    
    var_2ec2c7af53f81aed = function_f7fc3e6c249a8256( spatialzonecontainer, zonename );
    var_ba0dbe3ec176cc51 = [];
    
    foreach ( spatialzonespherestruct in var_2ec2c7af53f81aed )
    {
        sphereorigin = spatialzonecontainer function_2676e037929f0833( spatialzonespherestruct );
        sphereradius = function_231d9e91d8ef7b5f( spatialzonespherestruct ) * zonescaleoverride;
        shouldignoreheight = istrue( spatialzonespherestruct.shouldignoreheight );
        var_bcad2d5cf2834f88 = istrue( spatialzonespherestruct.var_bcad2d5cf2834f88 );
        
        if ( !var_bcad2d5cf2834f88 && !function_bee5f509292d2b5c( sphereorigin, sphereradius ) )
        {
            continue;
        }
        
        if ( shouldignoreheight )
        {
            foreach ( player in level.players )
            {
                var_d21ebc230f51b8e5 = utility::function_92fc197c20834b39( player, sphereorigin, sphereradius );
                
                if ( var_d21ebc230f51b8e5 )
                {
                    var_ba0dbe3ec176cc51[ var_ba0dbe3ec176cc51.size ] = player;
                }
            }
            
            continue;
        }
        
        var_75989cc97ccccd06 = getplayersinradius( sphereorigin, sphereradius, undefined, undefined, excludedplayers, undefined );
        var_ba0dbe3ec176cc51 = arraycombineunique( var_ba0dbe3ec176cc51, var_75989cc97ccccd06 );
    }
    
    return var_ba0dbe3ec176cc51;
}

// Namespace spatial_zone_container
// Params 5
// Checksum 0x68d93887, Offset: 0x121f
// Size: 0x90
function function_3b687b8681411c9f( spatialzonecontainer, zonename, var_35703e95e989d61, var_13a8eb12ef8eccd2, var_3d23542aeaa02a45 )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    if ( isfunction( var_35703e95e989d61 ) )
    {
        function_9d7d1a73b97d34b2( spatialzonestruct, var_35703e95e989d61 );
    }
    
    if ( spatialzonestruct.istrackingplayers )
    {
        return;
    }
    
    function_f53e3528d318b2af( spatialzonestruct, 1 );
    
    if ( var_3d23542aeaa02a45 )
    {
        childthread function_42fae915e48d5e0e( spatialzonecontainer, zonename, var_13a8eb12ef8eccd2 );
        return;
    }
    
    thread function_42fae915e48d5e0e( spatialzonecontainer, zonename, var_13a8eb12ef8eccd2 );
}

// Namespace spatial_zone_container
// Params 5
// Checksum 0x1dbbe312, Offset: 0x12b7
// Size: 0x7e
function function_3e5d25f80be6b5d1( groupuniquename, var_1501b0ce3cfa8348, var_35703e95e989d61, zonename, var_8cd566b43d09b148 )
{
    if ( !function_24318c90ae096194( groupuniquename ) )
    {
        var_8e0b3c474528b4c0 = function_fc5d4853d99c1f7d( groupuniquename );
        function_d02c3735effd2799( var_8e0b3c474528b4c0 );
        function_11cd1f1428a0af78( groupuniquename, var_35703e95e989d61 );
        var_8e0b3c474528b4c0 thread function_360bb32922172770( var_1501b0ce3cfa8348, var_8e0b3c474528b4c0, zonename, var_8cd566b43d09b148 );
        return;
    }
    
    function_11cd1f1428a0af78( groupuniquename, var_35703e95e989d61 );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x4351c982, Offset: 0x133d
// Size: 0xba
function function_4f9fccd04a537897( spatialzonecontainer, zonename )
{
    spatialzonecontainer notify( "stop_player_zone_watching_" + zonename );
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    foreach ( player in level.players )
    {
        function_21e03c3b4778d25( spatialzonestruct, player, 2 );
    }
    
    function_f53e3528d318b2af( spatialzonestruct, 0 );
}

// Namespace spatial_zone_container
// Params 1
// Checksum 0xd23cdf6a, Offset: 0x13ff
// Size: 0x39
function function_75d951b5f7fb3fe9( groupuniquename )
{
    if ( function_24318c90ae096194( groupuniquename ) )
    {
        level.var_8b6a43bd188565a9[ groupuniquename ] notify( "stop_player_zone_watching_" + groupuniquename );
        level.var_8b6a43bd188565a9[ groupuniquename ] = undefined;
    }
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0xac6003a9, Offset: 0x1440
// Size: 0xf2
function function_11cd1f1428a0af78( groupuniquename, var_35703e95e989d61 )
{
    assert( isfunction( var_35703e95e989d61 ), "<dev string:x3c2>" );
    var_8e0b3c474528b4c0 = level.var_8b6a43bd188565a9[ groupuniquename ];
    
    if ( isdefined( var_8e0b3c474528b4c0 ) )
    {
        foreach ( callbackfunc in var_8e0b3c474528b4c0.var_5b1bb01c467ba788 )
        {
            if ( callbackfunc == var_35703e95e989d61 )
            {
                return;
            }
        }
        
        var_8e0b3c474528b4c0.var_5b1bb01c467ba788[ var_8e0b3c474528b4c0.var_5b1bb01c467ba788.size ] = var_35703e95e989d61;
        return;
    }
    
    assertmsg( "<dev string:x40d>" + groupuniquename + "<dev string:x451>" );
}

// Namespace spatial_zone_container
// Params 2
// Checksum 0x8b88a10f, Offset: 0x153a
// Size: 0x6d
function function_4ef90cae2b42d7fc( groupuniquename, var_7408b2b17c5939f4 )
{
    assert( isfunction( var_7408b2b17c5939f4 ), "<dev string:x3c2>" );
    var_8e0b3c474528b4c0 = level.var_8b6a43bd188565a9[ groupuniquename ];
    
    if ( isdefined( var_8e0b3c474528b4c0 ) )
    {
        var_8e0b3c474528b4c0.var_7408b2b17c5939f4 = var_7408b2b17c5939f4;
        return;
    }
    
    assertmsg( "<dev string:x40d>" + groupuniquename + "<dev string:x451>" );
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xd8a5fb47, Offset: 0x15af
    // Size: 0x5, Type: dev
    function function_2a4fd75f938e68a6()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 0, eflags: 0x4
// Checksum 0xdedd456f, Offset: 0x15bc
// Size: 0x21
function private function_4d27247e5a64f9ea()
{
    var_8339fb4f2d23dabf = spawnstruct();
    var_8339fb4f2d23dabf.zones = [];
    return var_8339fb4f2d23dabf;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xd2855485, Offset: 0x15e6
    // Size: 0x5, Type: dev
    function function_a277eeeec76b0731()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0x857e0e8c, Offset: 0x15f3
// Size: 0x2c
function private function_85630f83c98b3f52( spatialzonecontainer )
{
    assert( function_fa7cf854729812a7( spatialzonecontainer ), "<dev string:x6a>" );
    return spatialzonecontainer.var_8339fb4f2d23dabf;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x97ffdfc5, Offset: 0x1628
// Size: 0x5f
function private function_f8488f051e54c72a( spatialzonecontainer, zonename )
{
    var_6d8099b682c60c45 = spatialzonecontainer.var_8339fb4f2d23dabf;
    assert( isdefined( var_6d8099b682c60c45.zones[ zonename ] ), "<dev string:x495>" + zonename + "<dev string:x4aa>" );
    return var_6d8099b682c60c45.zones[ zonename ];
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xb3c6cdad, Offset: 0x1690
// Size: 0x2b
function private function_611a01c151e4f32e( spatialzonecontainer )
{
    var_6d8099b682c60c45 = function_85630f83c98b3f52( spatialzonecontainer );
    return var_6d8099b682c60c45.zones;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x2e844ae1, Offset: 0x16c4
    // Size: 0x5, Type: dev
    function function_f6db8dd90578d447()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x3dc325e5, Offset: 0x16d1
// Size: 0x71
function private function_e2b259b43168dc64( spatialzonecontainer, spatialzonestruct )
{
    var_6d8099b682c60c45 = function_85630f83c98b3f52( spatialzonecontainer );
    zonename = spatialzonestruct.name;
    
    if ( function_3819f09eefb741e2( spatialzonecontainer, zonename ) )
    {
        assertmsg( "<dev string:x4cf>" + zonename + "<dev string:x4ee>" );
        return;
    }
    
    var_6d8099b682c60c45.zones[ zonename ] = spatialzonestruct;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x7b386bc8, Offset: 0x174a
// Size: 0x17f
function private function_53f3961c1817039d( spatialzonecontainer, zonename )
{
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    spatialzonescale = spatialzonestruct.var_b39ad593c3a51b61 ?? 1;
    
    while ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        var_8d248727a764fc16 = function_8446edc472dcf46e( spatialzonecontainer, spatialzonestruct );
        var_4b04497763e87ef7 = var_8d248727a764fc16.var_b39ad593c3a51b61 ?? 1;
        
        if ( isnumber( var_4b04497763e87ef7 ) )
        {
            spatialzonescale *= var_4b04497763e87ef7;
        }
        
        spatialzonestruct = var_8d248727a764fc16;
    }
    
    if ( spatialzonescale != 1 )
    {
        scaledspheres = [];
        spatialzonespheres = spatialzonestruct.spheres;
        
        foreach ( zonesphere in spatialzonespheres )
        {
            origin = spatialzonecontainer function_2676e037929f0833( zonesphere );
            radius = function_231d9e91d8ef7b5f( zonesphere ) * spatialzonescale;
            ignoreheight = istrue( zonesphere.shouldignoreheight );
            scaledspheres[ scaledspheres.size ] = function_2ec4b949c894828a( zonename, origin, radius, ignoreheight );
        }
        
        return scaledspheres;
    }
    
    return spatialzonestruct.spheres;
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x1c886f67, Offset: 0x18d2
// Size: 0x2ba
function private function_42fae915e48d5e0e( spatialzonecontainer, zonename, var_13a8eb12ef8eccd2 )
{
    level endon( #"game_ended" );
    spatialzonecontainer endon( "stop_player_zone_watching_" + zonename );
    
    if ( !isdefined( var_13a8eb12ef8eccd2 ) )
    {
        var_13a8eb12ef8eccd2 = 1;
    }
    
    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
    
    while ( true )
    {
        var_7e2eadbf67d6ed9b = level.players.size;
        availableframes = max( var_13a8eb12ef8eccd2 / level.framedurationseconds, 1 );
        var_7acc392e770849fe = max( var_7e2eadbf67d6ed9b / availableframes, 1 );
        var_a183055f7548e35d = 0;
        var_b51e6aa29de59b97 = gettime() / 1000;
        var_44566f232955cbdc = level.players;
        
        foreach ( player in var_44566f232955cbdc )
        {
            if ( var_a183055f7548e35d >= var_7acc392e770849fe )
            {
                var_a183055f7548e35d = 0;
                waitframe();
            }
            
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            var_2457793f7765b452 = function_c6b163965cbc2caa( player, spatialzonecontainer, zonename );
            var_6ca7e0c8f32c4b27 = function_679eb54f3a8ffce9( spatialzonestruct, player );
            
            if ( var_2457793f7765b452 )
            {
                if ( var_6ca7e0c8f32c4b27 != 0 )
                {
                    firsttimeinzone = var_6ca7e0c8f32c4b27 == 2;
                    function_21e03c3b4778d25( spatialzonestruct, player, 0 );
                    var_54c779cf281bb58d = { #var_de8af980c94ffa6b:&function_c532942b1c8c3bcd, #var_e56e3e80010d9d44:spatialzonestruct.var_941acf56ccd453c7, #firsttimeinzone:firsttimeinzone, #enteredzone:1, #zonename:zonename, #player:player };
                    function_8b1bf31fc1b33e6d( spatialzonecontainer, spatialzonestruct, var_54c779cf281bb58d );
                }
            }
            else if ( var_6ca7e0c8f32c4b27 == 0 )
            {
                function_21e03c3b4778d25( spatialzonestruct, player, 1 );
                var_54c779cf281bb58d = { #var_de8af980c94ffa6b:&function_c532942b1c8c3bcd, #var_e56e3e80010d9d44:spatialzonestruct.var_941acf56ccd453c7, #firsttimeinzone:0, #enteredzone:0, #zonename:zonename, #player:player };
                function_8b1bf31fc1b33e6d( spatialzonecontainer, spatialzonestruct, var_54c779cf281bb58d );
            }
            
            var_a183055f7548e35d++;
        }
        
        var_de3ea13c55af6d16 = gettime() / 1000;
        elapsedtimeinseconds = var_de3ea13c55af6d16 - var_b51e6aa29de59b97;
        
        if ( elapsedtimeinseconds < var_13a8eb12ef8eccd2 )
        {
            remainingtimeinseconds = var_13a8eb12ef8eccd2 - elapsedtimeinseconds;
            wait remainingtimeinseconds;
            continue;
        }
        
        waitframe();
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xc3f1c9bc, Offset: 0x1b94
// Size: 0x35
function private function_8446edc472dcf46e( spatialzonecontainer, spatialzonestruct )
{
    linkedspatialzonename = spatialzonestruct.linkedzonename;
    return function_f8488f051e54c72a( spatialzonecontainer, linkedspatialzonename );
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xfca16ce6, Offset: 0x1bd2
    // Size: 0x5, Type: dev
    function ___zone()
    {
        
    }

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x21fa9b2f, Offset: 0x1bdf
    // Size: 0x5, Type: dev
    function function_8f8b7a167f5fa7bd()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x2a8ff068, Offset: 0x1bec
// Size: 0xa3
function private function_4dc7acfc1edeeedf( zonename, originfunc, originfuncparams )
{
    spatialzonestruct = spawnstruct();
    spatialzonestruct.name = zonename;
    spatialzonestruct.spheres = [];
    spatialzonestruct.var_b39ad593c3a51b61 = undefined;
    spatialzonestruct.istrackingplayers = undefined;
    spatialzonestruct.linkedzonename = undefined;
    spatialzonestruct.var_941acf56ccd453c7 = undefined;
    spatialzonestruct.trackedplayercallbacks = undefined;
    
    if ( isdefined( originfunc ) )
    {
        function_68c1c04c6e5d8414( spatialzonestruct, 1, originfunc, originfuncparams );
    }
    else
    {
        function_68c1c04c6e5d8414( spatialzonestruct, 0 );
    }
    
    return spatialzonestruct;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x303c499, Offset: 0x1c98
// Size: 0x18a
function private function_7f0e3212ce7f382e( var_e1ec9b66bbdd44d5, var_2f9e99721daafdc1 )
{
    spatialzonestruct = spawnstruct();
    spatialzonestruct.name = var_e1ec9b66bbdd44d5.name;
    spatialzonestruct.originfunc = var_e1ec9b66bbdd44d5.originfunc;
    spatialzonestruct.originfuncparams = var_e1ec9b66bbdd44d5.originfuncparams;
    spatialzonestruct.hasdynamicorigin = var_e1ec9b66bbdd44d5.hasdynamicorigin;
    spatialzonestruct.spheres = [];
    spatialzonestruct.var_941acf56ccd453c7 = [];
    spatialzonestruct.istrackingplayers = undefined;
    spatialzonestruct.linkedzonename = var_e1ec9b66bbdd44d5.linkedzonename;
    spatialzonestruct.var_b39ad593c3a51b61 = var_e1ec9b66bbdd44d5.var_b39ad593c3a51b61;
    spatialzonestruct.trackedplayercallbacks = var_e1ec9b66bbdd44d5.trackedplayercallbacks;
    
    foreach ( var_4e690a763c43526 in var_e1ec9b66bbdd44d5.spheres )
    {
        spherestruct = function_c5b0d63650d54d97( var_4e690a763c43526 );
        spatialzonestruct.spheres[ spatialzonestruct.spheres.size ] = spherestruct;
    }
    
    return spatialzonestruct;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x8d7ef7c7, Offset: 0x1e2b
    // Size: 0x5, Type: dev
    function function_16ddc5b5f072a3ac()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0x3d52e15, Offset: 0x1e38
// Size: 0x28
function private function_fb1bd8c84af6498f( spatialzonestruct )
{
    if ( isdefined( spatialzonestruct.trackedplayercallbacks ) )
    {
        return spatialzonestruct.trackedplayercallbacks;
    }
    
    return [];
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x4dd24dc6, Offset: 0x1e69
// Size: 0x6b
function private function_679eb54f3a8ffce9( spatialzonestruct, player )
{
    if ( isdefined( spatialzonestruct.var_941acf56ccd453c7 ) )
    {
        playerguid = player.guid ?? 0;
        var_6ca7e0c8f32c4b27 = spatialzonestruct.var_941acf56ccd453c7[ playerguid ];
        
        if ( isdefined( var_6ca7e0c8f32c4b27 ) && var_6ca7e0c8f32c4b27 != 2 )
        {
            return var_6ca7e0c8f32c4b27;
        }
    }
    
    return 2;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x1eef4f1a, Offset: 0x1edd
    // Size: 0x5, Type: dev
    function function_4500fef7a69cc430()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x6184c42c, Offset: 0x1eea
// Size: 0x36
function private function_78c7d34ee39874a5( spatialzonestruct, name )
{
    assert( isstring( name ), "<dev string:x513>" );
    spatialzonestruct.name = name;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x3a87a37e, Offset: 0x1f28
// Size: 0x36
function private function_9688116dfa6ff1b0( spatialzonestruct, spheres )
{
    assert( isarray( spheres ), "<dev string:x54c>" );
    spatialzonestruct.spheres = spheres;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x85ee05ae, Offset: 0x1f66
// Size: 0x36
function private function_74f9dfacf0f019ee( spatialzonestruct, linkedzonename )
{
    assert( isstring( linkedzonename ), "<dev string:x587>" );
    spatialzonestruct.linkedzonename = linkedzonename;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xd59a024b, Offset: 0x1fa4
// Size: 0x4c
function private function_a5ce8a320f54cd99( spatialzonestruct, var_b39ad593c3a51b61 )
{
    assert( isnumber( var_b39ad593c3a51b61 ), "<dev string:x5ca>" );
    
    if ( var_b39ad593c3a51b61 == 1 )
    {
        spatialzonestruct.var_b39ad593c3a51b61 = undefined;
        return;
    }
    
    spatialzonestruct.var_b39ad593c3a51b61 = var_b39ad593c3a51b61;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x17f66e91, Offset: 0x1ff8
// Size: 0x36
function private function_30e2cd3e348a47e6( spatialzonestruct, originfunc )
{
    assert( isfunction( originfunc ), "<dev string:x60e>" );
    spatialzonestruct.originfunc = originfunc;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x9f5e7080, Offset: 0x2036
// Size: 0x36
function private function_3ff2e12f3b66e3fc( spatialzonestruct, originfuncparams )
{
    assert( isarray( originfuncparams ), "<dev string:x64f>" );
    spatialzonestruct.originfuncparams = originfuncparams;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xc7dff567, Offset: 0x2074
// Size: 0x24
function private function_4b9d3f1f5e0a74dd( spatialzonestruct, hasdynamicorigin )
{
    spatialzonestruct.hasdynamicorigin = istrue( hasdynamicorigin );
}

// Namespace spatial_zone_container
// Params 4, eflags: 0x4
// Checksum 0x3d0e8c83, Offset: 0x20a0
// Size: 0x6d
function private function_68c1c04c6e5d8414( spatialzonestruct, hasdynamicorigin, originfunc, originfuncparams )
{
    if ( hasdynamicorigin )
    {
        function_30e2cd3e348a47e6( spatialzonestruct, originfunc );
        function_3ff2e12f3b66e3fc( spatialzonestruct, originfuncparams );
        function_4b9d3f1f5e0a74dd( spatialzonestruct, hasdynamicorigin );
        return;
    }
    
    spatialzonestruct.originfunc = undefined;
    spatialzonestruct.originfuncparams = undefined;
    function_4b9d3f1f5e0a74dd( spatialzonestruct, hasdynamicorigin );
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x1ea99292, Offset: 0x2115
// Size: 0x64
function private function_21e03c3b4778d25( spatialzonestruct, player, state )
{
    if ( !isdefined( spatialzonestruct.var_941acf56ccd453c7 ) )
    {
        spatialzonestruct.var_941acf56ccd453c7 = [];
    }
    
    playerguid = player.guid ?? 0;
    spatialzonestruct.var_941acf56ccd453c7[ playerguid ] = state;
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x9be444f7, Offset: 0x2181
// Size: 0x36
function private function_f53e3528d318b2af( spatialzonestruct, trackingplayers )
{
    if ( trackingplayers )
    {
        spatialzonestruct.istrackingplayers = 1;
        return;
    }
    
    spatialzonestruct.istrackingplayers = undefined;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x6183550e, Offset: 0x21bf
    // Size: 0x5, Type: dev
    function function_89420ea7d1445764()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x33a101c, Offset: 0x21cc
// Size: 0x8c
function private function_9d7d1a73b97d34b2( spatialzonestruct, callbackfunc )
{
    if ( !isfunction( callbackfunc ) )
    {
        /#
            zonename = spatialzonestruct.name;
            assert( isfunction( callbackfunc ), "<dev string:x693>" + zonename + "<dev string:x6c2>" );
        #/
        
        return;
    }
    
    if ( !isdefined( spatialzonestruct.trackedplayercallbacks ) )
    {
        spatialzonestruct.trackedplayercallbacks = [];
    }
    
    spatialzonestruct.trackedplayercallbacks[ spatialzonestruct.trackedplayercallbacks.size ] = callbackfunc;
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0xd3ad81b4, Offset: 0x2260
// Size: 0xa0
function private function_8b1bf31fc1b33e6d( spatialzonecontainer, spatialzonestruct, var_54c779cf281bb58d )
{
    trackedplayercallbacks = function_fb1bd8c84af6498f( spatialzonestruct );
    
    foreach ( callbackfunc in trackedplayercallbacks )
    {
        spatialzonecontainer thread [[ callbackfunc ]]( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xbcda3245, Offset: 0x2308
// Size: 0xb4
function private function_8f8dc45bfd364e69( spatialzonestruct, spherestruct )
{
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        /#
            zonename = spatialzonestruct.name;
            linkedzonename = spatialzonestruct.linkedzonename;
            assertmsg( "<dev string:x6f5>" + zonename + "<dev string:x711>" + linkedzonename + "<dev string:x73d>" );
        #/
        
        return;
    }
    
    spatialzonestruct.spheres[ spatialzonestruct.spheres.size ] = spherestruct;
    
    if ( spatialzonestruct.hasdynamicorigin )
    {
        dynamicorigin = function_e7ce0b9160cbf129( spatialzonestruct );
        function_9a7cdff732ca26fd( spherestruct, dynamicorigin );
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xbecad75, Offset: 0x23c4
// Size: 0xcc
function private function_817617e89df189a0( spatialzonestruct, spherestruct )
{
    if ( function_9d38e7f5a66131aa( spatialzonestruct ) )
    {
        /#
            zonename = spatialzonestruct.name;
            linkedzonename = spatialzonestruct.linkedzonename;
            assertmsg( "<dev string:x6f5>" + zonename + "<dev string:x711>" + linkedzonename + "<dev string:x775>" );
        #/
        
        return;
    }
    
    /#
        spherefound = function_f02c63b99c9614c9( spatialzonestruct.spheres, spherestruct );
        assert( isdefined( spherefound ), "<dev string:x7b2>" + spatialzonestruct.name + "<dev string:x7d1>" );
    #/
    
    spatialzonestruct.spheres = arrayremove( spatialzonestruct.spheres, spherestruct );
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xec849ed6, Offset: 0x2498
// Size: 0x18, Type: bool
function private function_9d38e7f5a66131aa( spatialzonestruct )
{
    return isdefined( spatialzonestruct.linkedzonename );
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xe3c46ebd, Offset: 0x24b9
// Size: 0x126
function private function_e7ce0b9160cbf129( spatialzonestruct )
{
    /#
        spatialzonename = spatialzonestruct.name;
        hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
        assert( hasdynamicorigin, "<dev string:x7ff>" + spatialzonename + "<dev string:x813>" );
    #/
    
    originfunc = spatialzonestruct.originfunc;
    originfuncparams = spatialzonestruct.originfuncparams;
    
    if ( originfuncparams.size == 0 )
    {
        return [[ originfunc ]]();
    }
    
    if ( originfuncparams.size == 1 )
    {
        return [[ originfunc ]]( originfuncparams[ 0 ] );
    }
    
    if ( originfuncparams.size == 2 )
    {
        return [[ originfunc ]]( originfuncparams[ 0 ], originfuncparams[ 1 ] );
    }
    
    if ( originfuncparams.size == 3 )
    {
        return [[ originfunc ]]( originfuncparams[ 0 ], originfuncparams[ 1 ], originfuncparams[ 2 ] );
    }
    
    if ( originfuncparams.size == 4 )
    {
        return [[ originfunc ]]( originfuncparams[ 0 ], originfuncparams[ 1 ], originfuncparams[ 2 ], originfuncparams[ 3 ] );
    }
    
    if ( originfuncparams.size == 5 )
    {
        return [[ originfunc ]]( originfuncparams[ 0 ], originfuncparams[ 1 ], originfuncparams[ 2 ], originfuncparams[ 3 ], originfuncparams[ 4 ] );
    }
    
    assertmsg( "<dev string:x840>" );
}

// Namespace spatial_zone_container
// Params 0, eflags: 0x4
// Checksum 0xe9a399ba, Offset: 0x25e7
// Size: 0xf
function private function_3dd3cfeb0e5b52ad()
{
    return ( 0, 0, 0 );
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x424bd8ce, Offset: 0x25ff
    // Size: 0x5, Type: dev
    function function_d624a441ab8482a4()
    {
        
    }

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xa02081e7, Offset: 0x260c
    // Size: 0x5, Type: dev
    function function_7370f349a2e5657f()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1
// Checksum 0x8207b2c6, Offset: 0x2619
// Size: 0x9a
function function_2676e037929f0833( spatialzonespherestruct )
{
    associatedspatialzonename = spatialzonespherestruct.associatedspatialzonename;
    spatialzonestruct = function_f8488f051e54c72a( self, associatedspatialzonename );
    hasdynamicorigin = spatialzonestruct.hasdynamicorigin;
    
    if ( hasdynamicorigin )
    {
        dynamicorigin = function_e7ce0b9160cbf129( spatialzonestruct );
        
        if ( isdefined( spatialzonespherestruct.originoffset ) )
        {
            sphereoriginoffset = spatialzonespherestruct.originoffset;
            dynamicorigin += sphereoriginoffset;
        }
        
        return dynamicorigin;
    }
    
    return spatialzonespherestruct.origin;
}

// Namespace spatial_zone_container
// Params 1
// Checksum 0x9dfde3ca, Offset: 0x26bc
// Size: 0x28
function function_231d9e91d8ef7b5f( spatialzonespherestruct )
{
    if ( isdefined( spatialzonespherestruct.radius ) )
    {
        return spatialzonespherestruct.radius;
    }
    
    return 0;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x4cdaee2, Offset: 0x26ed
    // Size: 0x5, Type: dev
    function function_6519770a317e6b44()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 4, eflags: 0x4
// Checksum 0xcaffec91, Offset: 0x26fa
// Size: 0x8e
function private function_2ec4b949c894828a( associatedspatialzonename, origin, radius, ignoreheightvalue )
{
    spatialzonespherestruct = spawnstruct();
    spatialzonespherestruct.associatedspatialzonename = associatedspatialzonename;
    spatialzonespherestruct.origin = origin;
    spatialzonespherestruct.originoffset = undefined;
    spatialzonespherestruct.radius = radius ? radius : undefined;
    spatialzonespherestruct.shouldignoreheight = ignoreheightvalue ? ignoreheightvalue : undefined;
    return spatialzonespherestruct;
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xd8dfa277, Offset: 0x2791
// Size: 0x91
function private function_c5b0d63650d54d97( var_300da46f97b93200 )
{
    spatialzonespherestruct = spawnstruct();
    spatialzonespherestruct.associatedspatialzonename = var_300da46f97b93200.associatedspatialzonename;
    spatialzonespherestruct.origin = var_300da46f97b93200.origin;
    spatialzonespherestruct.radius = var_300da46f97b93200.radius;
    spatialzonespherestruct.originoffset = var_300da46f97b93200.originoffset;
    spatialzonespherestruct.shouldignoreheight = var_300da46f97b93200.shouldignoreheight;
    return spatialzonespherestruct;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x1c0730dd, Offset: 0x282b
    // Size: 0x5, Type: dev
    function function_9f041ef9103bd50d()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0xa3dce667, Offset: 0x2838
// Size: 0x4c
function private function_9a7cdff732ca26fd( spherestruct, relativeorigin )
{
    sphereorigin = spherestruct.origin;
    
    if ( isdefined( sphereorigin ) )
    {
        spherestruct.originoffset = spherestruct.origin - relativeorigin;
    }
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0x9a6747d5, Offset: 0x288c
// Size: 0x3b
function private function_eb693b81e552e4f9( spatialzonespherestruct )
{
    radius = function_231d9e91d8ef7b5f( spatialzonespherestruct );
    origin = function_2676e037929f0833( spatialzonespherestruct );
    return function_bee5f509292d2b5c( origin, radius );
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x81cd9a17, Offset: 0x28d0
// Size: 0xb0, Type: bool
function private function_bee5f509292d2b5c( origin, radius )
{
    var_79f7b40e044079b7 = level.var_54ae469dd0b3c78a;
    var_26c7eafc008d19c0 = var_79f7b40e044079b7.var_cbe450c2c2387d7c;
    var_d82471ebe160fb46 = 500;
    var_5747cb0cf9173bbe = 150;
    
    if ( !isvector( origin ) )
    {
        return false;
    }
    
    if ( !var_79f7b40e044079b7.var_f78cf86e749f396e || radius > var_26c7eafc008d19c0 )
    {
        return true;
    }
    
    var_dc6e9a378cdaf910 = getinfluencedistanceatposition( origin );
    radiusdistance = max( radius, var_d82471ebe160fb46 );
    radiusdistance += var_5747cb0cf9173bbe;
    
    if ( var_dc6e9a378cdaf910 <= radiusdistance )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xf534dbde, Offset: 0x2989
    // Size: 0x5, Type: dev
    function function_254fd6816ac53780()
    {
        
    }

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xe771cef1, Offset: 0x2996
    // Size: 0x5, Type: dev
    function function_ab43e39c1d23b160()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0x28e2ba43, Offset: 0x29a3
// Size: 0x39
function private function_fc5d4853d99c1f7d( groupuniquename )
{
    var_8e0b3c474528b4c0 = spawnstruct();
    var_8e0b3c474528b4c0.var_5b1bb01c467ba788 = [];
    var_8e0b3c474528b4c0.groupuniquename = groupuniquename;
    return var_8e0b3c474528b4c0;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0xf0a3c410, Offset: 0x29e5
    // Size: 0x5, Type: dev
    function function_3a43faebf2e1600f()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x4045f436, Offset: 0x29f2
// Size: 0x75
function private function_decf592a2f4d9008( var_8e0b3c474528b4c0, spatialzonecontainer, player )
{
    groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
    playerguid = player.guid ?? 0;
    
    if ( isdefined( spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ][ playerguid ] ) )
    {
        return spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ][ playerguid ];
    }
    
    return 2;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x63327ccd, Offset: 0x2a70
    // Size: 0x5, Type: dev
    function function_e42ed2b50a9f75f3()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 4, eflags: 0x4
// Checksum 0x3c1c22dc, Offset: 0x2a7d
// Size: 0x84
function private function_f84be6b5196932dc( var_8e0b3c474528b4c0, spatialzonecontainer, player, state )
{
    groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
    playerguid = player.guid ?? 0;
    
    if ( state == 2 )
    {
        spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ][ playerguid ] = undefined;
        return;
    }
    
    spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ][ playerguid ] = state;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x670f51fa, Offset: 0x2b09
    // Size: 0x5, Type: dev
    function function_bb177065462910b1()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xb1a56030, Offset: 0x2b16
// Size: 0x47
function private function_d02c3735effd2799( var_8e0b3c474528b4c0 )
{
    if ( !isdefined( level.var_8b6a43bd188565a9 ) )
    {
        level.var_8b6a43bd188565a9 = [];
    }
    
    groupuniquename = var_8e0b3c474528b4c0.groupuniquename;
    level.var_8b6a43bd188565a9[ groupuniquename ] = var_8e0b3c474528b4c0;
}

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0xaf09cce8, Offset: 0x2b65
// Size: 0x20, Type: bool
function private function_24318c90ae096194( groupuniquename )
{
    if ( isdefined( level.var_8b6a43bd188565a9[ groupuniquename ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0xf794db3c, Offset: 0x2b8e
// Size: 0x97
function private function_2973cf3beaa4eab6( spatialzonecontainer, var_8e0b3c474528b4c0, var_54c779cf281bb58d )
{
    foreach ( var_1415a4c2aa2f822b in var_8e0b3c474528b4c0.var_5b1bb01c467ba788 )
    {
        spatialzonecontainer thread [[ var_1415a4c2aa2f822b ]]( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x4a114acc, Offset: 0x2c2d
// Size: 0x68
function private function_2e4c60bb5c08d353( var_8e0b3c474528b4c0, spatialzonecontainer )
{
    if ( !isdefined( spatialzonecontainer.var_e489ed9078993471 ) )
    {
        spatialzonecontainer.var_e489ed9078993471 = [];
    }
    
    groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
    
    if ( !isdefined( spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ] ) )
    {
        spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ] = [];
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0x4
// Checksum 0x9b9c1a1c, Offset: 0x2c9d
// Size: 0x55, Type: bool
function private function_8b07120ab7743fe8( var_8e0b3c474528b4c0, spatialzonecontainer )
{
    if ( !isdefined( spatialzonecontainer.var_e489ed9078993471 ) )
    {
        return false;
    }
    
    groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
    
    if ( !isdefined( spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace spatial_zone_container
// Params 4, eflags: 0x4
// Checksum 0x66890981, Offset: 0x2cfb
// Size: 0x403
function private function_360bb32922172770( var_1501b0ce3cfa8348, var_8e0b3c474528b4c0, zonename, var_8cd566b43d09b148 )
{
    level endon( #"game_ended" );
    groupuniquename = var_8e0b3c474528b4c0.groupuniquename;
    var_8e0b3c474528b4c0 endon( "stop_player_zone_watching_" + groupuniquename );
    var_6b5788319fab3aaf = var_8cd566b43d09b148 ?? 2;
    
    while ( true )
    {
        if ( !isdefined( level.players ) || level.players.size == 0 )
        {
            waitframe();
            continue;
        }
        
        var_18da324e41498218 = self [[ var_1501b0ce3cfa8348 ]]();
        var_d3dc362272d762f3 = level.players;
        regularcontainers = [];
        
        foreach ( spatialzonecontainer in var_18da324e41498218 )
        {
            if ( !isdefined( spatialzonecontainer ) || !function_3819f09eefb741e2( spatialzonecontainer, zonename ) )
            {
                continue;
            }
            
            if ( spatialzonecontainer.noenttriggers && spatialzonecontainer.noenttriggers.size > 0 )
            {
                if ( function_3ece75d305a5a944( spatialzonecontainer, zonename ) )
                {
                    spatialzonestruct = function_f8488f051e54c72a( spatialzonecontainer, zonename );
                    neworigin = function_e7ce0b9160cbf129( spatialzonestruct );
                    
                    foreach ( enttrigger in spatialzonecontainer.noenttriggers )
                    {
                        enttrigger.origin = neworigin + ( 0, 0, enttrigger.heightoffset );
                    }
                }
                
                continue;
            }
            
            regularcontainers[ regularcontainers.size ] = spatialzonecontainer;
        }
        
        var_255284215789c258 = var_d3dc362272d762f3.size;
        var_6c7e6799eff81c2c = regularcontainers.size;
        var_c5e2507b2b238bbd = var_255284215789c258 * var_6c7e6799eff81c2c;
        var_bc6d7ae681771a0a = max( var_6b5788319fab3aaf / level.framedurationseconds, 1 );
        var_1537de33d2dd2e30 = max( var_c5e2507b2b238bbd / var_bc6d7ae681771a0a, 1 );
        var_1537de33d2dd2e30 = ceil( var_1537de33d2dd2e30 );
        var_3c2ec7dbeaa59b29 = gettime() / 1000;
        var_a183055f7548e35d = 0;
        
        foreach ( spatialzonecontainer in regularcontainers )
        {
            if ( !function_8b07120ab7743fe8( var_8e0b3c474528b4c0, spatialzonecontainer ) )
            {
                function_2e4c60bb5c08d353( var_8e0b3c474528b4c0, spatialzonecontainer );
            }
            
            var_3babe9c27804c = 0;
            var_e5f8fbb42e1bbdb3 = var_d3dc362272d762f3.size;
            
            while ( var_e5f8fbb42e1bbdb3 > 0 && var_d3dc362272d762f3.size > 0 )
            {
                var_b687c45f25e6371f = 0;
                var_7b6528cceeffaf8e = var_1537de33d2dd2e30 - var_a183055f7548e35d;
                var_3babe9c27804c = int( min( var_3babe9c27804c, var_d3dc362272d762f3.size - 1 ) );
                var_eca3b559a7d534f7 = min( var_3babe9c27804c + var_7b6528cceeffaf8e - 1, var_d3dc362272d762f3.size - 1 );
                var_eca3b559a7d534f7 = int( var_eca3b559a7d534f7 );
                function_ae7de253658df1d7( var_d3dc362272d762f3, var_3babe9c27804c, var_eca3b559a7d534f7, var_8e0b3c474528b4c0, spatialzonecontainer, zonename );
                var_b687c45f25e6371f = var_eca3b559a7d534f7 - var_3babe9c27804c + 1;
                var_e5f8fbb42e1bbdb3 -= var_b687c45f25e6371f;
                var_a183055f7548e35d += var_b687c45f25e6371f;
                var_3babe9c27804c = var_eca3b559a7d534f7 + 1;
                
                if ( var_a183055f7548e35d >= var_1537de33d2dd2e30 )
                {
                    waitframe();
                    var_a183055f7548e35d = 0;
                }
            }
        }
        
        var_af154259cb0a139a = gettime() / 1000;
        var_a41ab09a08a42377 = var_af154259cb0a139a - var_3c2ec7dbeaa59b29;
        
        if ( var_a41ab09a08a42377 < var_6b5788319fab3aaf )
        {
            var_976b794df0df94f7 = var_6b5788319fab3aaf - var_a41ab09a08a42377;
            wait var_976b794df0df94f7;
            continue;
        }
        
        waitframe();
    }
}

// Namespace spatial_zone_container
// Params 7, eflags: 0x4
// Checksum 0xf1d37c31, Offset: 0x3106
// Size: 0x375
function private function_ae7de253658df1d7( playerlist, startingplayerindex, endingplayerindex, var_8e0b3c474528b4c0, spatialzonecontainer, zonename, var_1566d474117d0549 )
{
    assert( startingplayerindex <= endingplayerindex && startingplayerindex >= 0, "<dev string:x8e9>" );
    assert( endingplayerindex < playerlist.size, "<dev string:x94a>" );
    assert( function_3819f09eefb741e2( spatialzonecontainer, zonename ), "<dev string:x295>" + zonename + "<dev string:x29c>" );
    
    if ( !isdefined( var_1566d474117d0549 ) )
    {
        var_1566d474117d0549 = 1;
    }
    
    var_2ec2c7af53f81aed = function_f7fc3e6c249a8256( spatialzonecontainer, zonename );
    var_27717ffae4cfa71b = [];
    cachedorigins = [];
    cachedradii = [];
    skipspheres = [];
    
    for ( playerindex = startingplayerindex; playerindex <= endingplayerindex ; playerindex++ )
    {
        player = playerlist[ playerindex ];
        playerguid = player.guid ?? 0;
        var_2457793f7765b452 = 0;
        
        if ( var_27717ffae4cfa71b[ playerguid ] || !isplayer( player ) || !isalive( player ) )
        {
            continue;
        }
        
        var_90232d5123d79fa4 = var_2ec2c7af53f81aed.size;
        
        for ( sphereindex = 0; sphereindex < var_90232d5123d79fa4 ; sphereindex++ )
        {
            if ( skipspheres[ sphereindex ] )
            {
                continue;
            }
            
            spatialzonespherestruct = var_2ec2c7af53f81aed[ sphereindex ];
            shouldignoreheight = istrue( spatialzonespherestruct.shouldignoreheight );
            var_bcad2d5cf2834f88 = istrue( spatialzonespherestruct.var_bcad2d5cf2834f88 );
            
            if ( !isdefined( cachedorigins[ sphereindex ] ) )
            {
                cachedorigins[ sphereindex ] = spatialzonecontainer function_2676e037929f0833( spatialzonespherestruct );
            }
            
            if ( !isdefined( cachedradii[ sphereindex ] ) )
            {
                cachedradii[ sphereindex ] = function_231d9e91d8ef7b5f( spatialzonespherestruct ) * var_1566d474117d0549;
            }
            
            if ( !var_bcad2d5cf2834f88 && !function_bee5f509292d2b5c( cachedorigins[ sphereindex ], cachedradii[ sphereindex ] ) )
            {
                skipspheres[ sphereindex ] = 1;
                continue;
            }
            
            if ( shouldignoreheight )
            {
                var_2457793f7765b452 = utility::function_92fc197c20834b39( player, cachedorigins[ sphereindex ], cachedradii[ sphereindex ] );
            }
            else
            {
                var_2457793f7765b452 = utility::playerwithindistance( player, cachedorigins[ sphereindex ], cachedradii[ sphereindex ] );
            }
            
            if ( var_2457793f7765b452 )
            {
                break;
            }
        }
        
        var_6ca7e0c8f32c4b27 = function_decf592a2f4d9008( var_8e0b3c474528b4c0, spatialzonecontainer, player );
        
        if ( var_2457793f7765b452 )
        {
            if ( var_6ca7e0c8f32c4b27 != 0 )
            {
                firsttimeinzone = var_6ca7e0c8f32c4b27 == 2;
                function_f84be6b5196932dc( var_8e0b3c474528b4c0, spatialzonecontainer, player, 0 );
                groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
                var_e489ed9078993471 = spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ];
                var_54c779cf281bb58d = { #var_de8af980c94ffa6b:&function_c532942b1c8c3bcd, #var_e56e3e80010d9d44:var_e489ed9078993471, #firsttimeinzone:firsttimeinzone, #enteredzone:1, #zonename:zonename, #player:player };
                function_2973cf3beaa4eab6( spatialzonecontainer, var_8e0b3c474528b4c0, var_54c779cf281bb58d );
            }
            
            continue;
        }
        
        if ( var_6ca7e0c8f32c4b27 == 0 )
        {
            function_f84be6b5196932dc( var_8e0b3c474528b4c0, spatialzonecontainer, player, 1 );
            groupeduniquename = var_8e0b3c474528b4c0.groupuniquename;
            var_e489ed9078993471 = spatialzonecontainer.var_e489ed9078993471[ groupeduniquename ];
            var_54c779cf281bb58d = { #var_de8af980c94ffa6b:&function_c532942b1c8c3bcd, #var_e56e3e80010d9d44:var_e489ed9078993471, #firsttimeinzone:0, #enteredzone:0, #zonename:zonename, #player:player };
            function_2973cf3beaa4eab6( spatialzonecontainer, var_8e0b3c474528b4c0, var_54c779cf281bb58d );
        }
    }
}

// Namespace spatial_zone_container
// Params 4, eflags: 0x4
// Checksum 0xb44f752d, Offset: 0x3483
// Size: 0x149, Type: bool
function private function_d2f935dac041758e( triggeringent, trigger, params, isexiting )
{
    if ( isplayer( triggeringent ) )
    {
        potentialplayers = [ triggeringent ];
        
        if ( isexiting )
        {
            players = [];
            
            foreach ( player in potentialplayers )
            {
                if ( !player.vehicle || !trigger.triggerenterents || !trigger.triggerenterents[ player.vehicle getentitynumber() ] )
                {
                    players[ players.size ] = player;
                }
            }
        }
        else
        {
            players = potentialplayers;
        }
    }
    else if ( triggeringent.occupants || triggeringent.turretoccupants )
    {
        players = arraycombineunique( triggeringent.occupants, triggeringent.turretoccupants );
    }
    
    return players ?? [];
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x3bb259e9, Offset: 0x35d5
// Size: 0x11d
function private function_f189554a08fc9c59( triggeringent, trigger, params )
{
    if ( params.var_edcfe5dcdc005aaf )
    {
        return;
    }
    
    players = function_d2f935dac041758e( triggeringent, trigger, params );
    
    foreach ( player in players )
    {
        firsttimeinzone = 0;
        
        if ( trigger.var_a06757bbd3e0917e.size )
        {
            firsttimeinzone = isdefined( trigger.var_a06757bbd3e0917e[ player getentitynumber() ] );
        }
        
        var_54c779cf281bb58d = { #firsttimeinzone:firsttimeinzone, #enteredzone:1, #player:player, #zonename:"Awareness_Zone" };
        return params activity_instance_common::function_302464b1524a1340( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x7fa0b3f4, Offset: 0x36fa
// Size: 0xfe
function private function_a012fecca39cc823( triggeringent, trigger, params )
{
    if ( params.var_edcfe5dcdc005aaf )
    {
        return;
    }
    
    if ( params.var_fcd586dd4283980 )
    {
        params thread function_d2ac164535192d08( triggeringent, trigger );
        return;
    }
    
    players = function_d2f935dac041758e( triggeringent, trigger, params, 1 );
    
    foreach ( player in players )
    {
        var_54c779cf281bb58d = { #enteredzone:0, #player:player, #zonename:"Awareness_Zone" };
        return params activity_instance_common::function_302464b1524a1340( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 2, eflags: 0xc
// Checksum 0x76f1cf83, Offset: 0x3800
// Size: 0xc6
function private function_d2ac164535192d08( triggeringent, trigger )
{
    self notify( #"hash_3aea66422dae4dce" );
    self endon( #"hash_3aea66422dae4dce" );
    self endon( #"death" );
    trigger endon( #"death" );
    self endon( #"activity_ended" );
    
    while ( isdefined( triggeringent ) && isdefined( trigger ) && self.var_fcd586dd4283980 )
    {
        wait 0.25;
    }
    
    if ( !triggeringent || !trigger )
    {
        return;
    }
    
    awareplayers = activity_instance_common::function_feab7f5d34b69826( self );
    
    if ( awareplayers && awareplayers[ utility::callsharedfunc( #"player", #"getPlayerGuid", triggeringent ) ] )
    {
        return;
    }
    
    function_a012fecca39cc823( triggeringent, trigger, self );
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0xeb80b8ba, Offset: 0x38ce
// Size: 0xe3
function private function_c0937b3a701c5ffb( triggeringent, trigger, params )
{
    if ( params.var_edcfe5dcdc005aaf )
    {
        return;
    }
    
    players = function_d2f935dac041758e( triggeringent, trigger, params );
    
    foreach ( player in players )
    {
        var_54c779cf281bb58d = { #enteredzone:1, #player:player, #zonename:"Proximity_Join_Zone" };
        return params activity_participation::function_b38d32695d903a80( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0xa1a4a016, Offset: 0x39b9
// Size: 0xe4
function private function_95dba2cdffaa7c0c( triggeringent, trigger, params )
{
    if ( params.var_edcfe5dcdc005aaf )
    {
        return;
    }
    
    players = function_d2f935dac041758e( triggeringent, trigger, params, 1 );
    
    foreach ( player in players )
    {
        var_54c779cf281bb58d = { #enteredzone:0, #player:player, #zonename:"Proximity_Abandon_Zone" };
        return params activity_participation::function_44cacb7961053d7d( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x1e8397c1, Offset: 0x3aa5
// Size: 0xd4
function private function_bb9c962dd08ba2ad( triggeringent, trigger, params )
{
    players = function_d2f935dac041758e( triggeringent, trigger, params );
    
    foreach ( player in players )
    {
        var_54c779cf281bb58d = { #enteredzone:1, #player:player, #zonename:"Hibernation_Zone" };
        return params activity_instance_common::function_ccebe3423b966f6a( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 3, eflags: 0x4
// Checksum 0x90753c46, Offset: 0x3b81
// Size: 0xd5
function private function_de706030de1a218d( triggeringent, trigger, params )
{
    players = function_d2f935dac041758e( triggeringent, trigger, params, 1 );
    
    foreach ( player in players )
    {
        var_54c779cf281bb58d = { #enteredzone:0, #player:player, #zonename:"Hibernation_Zone" };
        return params activity_instance_common::function_ccebe3423b966f6a( var_54c779cf281bb58d );
    }
}

// Namespace spatial_zone_container
// Params 1
// Checksum 0x979a8efc, Offset: 0x3c5e
// Size: 0x9b
function function_5f8d3afa30682284( spatialzonename )
{
    switch ( spatialzonename )
    {
        case #"hash_7d0c68484da87929":
            return [ &function_f189554a08fc9c59, &function_a012fecca39cc823 ];
        case #"hash_6167188d05876b3e":
            return [ &function_c0937b3a701c5ffb, undefined ];
        case #"hash_8326ba8dc470cc1b":
            return [ undefined, &function_95dba2cdffaa7c0c ];
        case #"hash_de44efc5ce51aca7":
            return [ &function_bb9c962dd08ba2ad, &function_de706030de1a218d ];
        default:
            return;
    }
}

// Namespace spatial_zone_container
// Params 0
// Checksum 0x86c70223, Offset: 0x3d01
// Size: 0x92
function function_419417792d934793()
{
    if ( !self.noenttriggers.size )
    {
        return;
    }
    
    foreach ( trigger in self.noenttriggers )
    {
        trigger delete();
    }
    
    self.noenttriggers = undefined;
}

/#

    // Namespace spatial_zone_container
    // Params 0
    // Checksum 0x934c2af3, Offset: 0x3d9b
    // Size: 0x5, Type: dev
    function function_dd9a00f1cdf1c01d()
    {
        
    }

#/

// Namespace spatial_zone_container
// Params 1, eflags: 0x4
// Checksum 0x50483e14, Offset: 0x3da8
// Size: 0xc3
function private function_c532942b1c8c3bcd( var_f544a719f5cd8c3c )
{
    var_1d8b76e369a86de = [];
    
    if ( isdefined( var_f544a719f5cd8c3c.var_e56e3e80010d9d44 ) )
    {
        foreach ( playerguid, playerzonestate in var_f544a719f5cd8c3c.var_e56e3e80010d9d44 )
        {
            if ( playerzonestate == 0 )
            {
                player = utility::function_21371fd45f8bcf8a( playerguid );
                
                if ( isplayer( player ) )
                {
                    var_1d8b76e369a86de[ var_1d8b76e369a86de.size ] = player;
                }
            }
        }
    }
    
    return var_1d8b76e369a86de;
}

