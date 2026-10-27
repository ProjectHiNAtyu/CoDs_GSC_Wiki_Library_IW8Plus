// scripts\mp\flags.gsc  (hash_778027edf01bd587.gscc) (size: 2464 Bytes / 0x9a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff28e59 (267554393)
// size ...... 2464 (0x9a0)
// includes .. 0   (offset: 0x8e4)
// strings ... 1   (offset: 0x8e4)
// dev strs .. 5   (offset: 0x910)
// exports ... 20  (offset: 0x4b8)
// cseg ...... 0x61 + 0x457 (0x4b8)
// imports ... 8   (offset: 0x7d8)
// animtree1 . 0   (offset: 0x9a0)
// animtree2 . 0   (offset: 0x9a0)
#namespace flags;

// Namespace flags
// Params 0
// Checksum 0xcca86129, Offset: 0x7f
// Size: 0x15
function initgameflags()
{
    if ( !isdefined( game[ "flags" ] ) )
    {
        game[ "flags" ] = [];
    }
}

// Namespace flags
// Params 0
// Checksum 0x3a5c66f1, Offset: 0x9c
// Size: 0xb
function function_3e5944c25de5ff61()
{
    game[ "flags" ] = [];
}

// Namespace flags
// Params 2
// Checksum 0x4b91a1d0, Offset: 0xaf
// Size: 0x3b
function gameflaginit( flagname, isenabled )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "flags" ][ flagname ] = isenabled;
    
    if ( isenabled )
    {
        level notify( flagname );
    }
}

// Namespace flags
// Params 1
// Checksum 0x440c3cd4, Offset: 0xf2
// Size: 0x17, Type: bool
function gameflagexists( flagname )
{
    return isdefined( game[ "flags" ][ flagname ] );
}

// Namespace flags
// Params 1
// Checksum 0xdaf3616d, Offset: 0x112
// Size: 0x37
function gameflag( flagname )
{
    assert( isdefined( game[ "<dev string:x24>" ][ flagname ] ), "<dev string:x2a>" + flagname + "<dev string:x34>" );
    return game[ "flags" ][ flagname ];
}

// Namespace flags
// Params 1
// Checksum 0x976737ae, Offset: 0x152
// Size: 0x3f
function gameflagset( flagname )
{
    assert( isdefined( game[ "<dev string:x24>" ][ flagname ] ), "<dev string:x2a>" + flagname + "<dev string:x34>" );
    game[ "flags" ][ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags
// Params 1
// Checksum 0x6e271fc4, Offset: 0x199
// Size: 0x39
function gameflagclear( flagname )
{
    assert( isdefined( game[ "<dev string:x24>" ][ flagname ] ), "<dev string:x2a>" + flagname + "<dev string:x34>" );
    game[ "flags" ][ flagname ] = 0;
}

// Namespace flags
// Params 1
// Checksum 0x24f94917, Offset: 0x1da
// Size: 0x37
function function_5a2cc698dcfaa82a( flagname )
{
    assert( isdefined( game[ "<dev string:x24>" ][ flagname ] ), "<dev string:x2a>" + flagname + "<dev string:x34>" );
    game[ "flags" ][ flagname ] = undefined;
}

// Namespace flags
// Params 1
// Checksum 0x41f0cf5f, Offset: 0x219
// Size: 0x42
function gameflagwait( flagname )
{
    assert( isdefined( game[ "<dev string:x24>" ][ flagname ] ), "<dev string:x2a>" + flagname + "<dev string:x34>" );
    
    while ( !gameflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags
// Params 1
// Checksum 0xda01c062, Offset: 0x263
// Size: 0x2a
function function_2f3408423ccc9b2e( flagname )
{
    while ( !gameflagexists( flagname ) )
    {
        level waittill( flagname );
    }
    
    gameflagwait( flagname );
}

// Namespace flags
// Params 0
// Checksum 0xddd88c12, Offset: 0x295
// Size: 0x18
function initlevelflags()
{
    if ( !isdefined( level.levelflags ) )
    {
        level.levelflags = [];
    }
}

// Namespace flags
// Params 2
// Checksum 0x74feba75, Offset: 0x2b5
// Size: 0x3f
function levelflaginit( flagname, isenabled )
{
    assert( isdefined( level.levelflags ) );
    level.levelflags[ flagname ] = isenabled;
    
    if ( isenabled )
    {
        level notify( flagname );
    }
}

// Namespace flags
// Params 1
// Checksum 0x24f40ddf, Offset: 0x2fc
// Size: 0x19, Type: bool
function function_6125c2f37d92dee( flagname )
{
    return isdefined( level.levelflags[ flagname ] );
}

// Namespace flags
// Params 1
// Checksum 0xe995dcc2, Offset: 0x31e
// Size: 0x3b
function levelflag( flagname )
{
    assert( isdefined( level.levelflags[ flagname ] ), "<dev string:x86>" + flagname + "<dev string:x91>" );
    return level.levelflags[ flagname ];
}

// Namespace flags
// Params 1
// Checksum 0x98e1ba3e, Offset: 0x362
// Size: 0x43
function levelflagset( flagname )
{
    assert( isdefined( level.levelflags[ flagname ] ), "<dev string:x86>" + flagname + "<dev string:x91>" );
    level.levelflags[ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags
// Params 1
// Checksum 0x4b902da3, Offset: 0x3ad
// Size: 0x42
function levelflagclear( flagname )
{
    assert( isdefined( level.levelflags[ flagname ] ), "<dev string:x86>" + flagname + "<dev string:x91>" );
    level.levelflags[ flagname ] = 0;
    level notify( flagname );
}

// Namespace flags
// Params 1
// Checksum 0x72fca3b8, Offset: 0x3f7
// Size: 0x44
function levelflagwait( flagname )
{
    assert( isdefined( level.levelflags[ flagname ] ), "<dev string:x86>" + flagname + "<dev string:x91>" );
    
    while ( !levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags
// Params 1
// Checksum 0x9535047e, Offset: 0x443
// Size: 0x2a
function function_b0491bb92d5acbb6( flagname )
{
    while ( !function_6125c2f37d92dee( flagname ) )
    {
        level waittill( flagname );
    }
    
    levelflagwait( flagname );
}

// Namespace flags
// Params 1
// Checksum 0x565900ef, Offset: 0x475
// Size: 0x43
function levelflagwaitopen( flagname )
{
    assert( isdefined( level.levelflags[ flagname ] ), "<dev string:x86>" + flagname + "<dev string:x91>" );
    
    while ( levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

