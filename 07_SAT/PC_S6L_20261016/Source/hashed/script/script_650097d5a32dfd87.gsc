// script_650097d5a32dfd87  (hash_650097d5a32dfd87.gscc) (size: 1144 Bytes / 0x478 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9afc7a8b (2600237707)
// size ...... 1144 (0x478)
// includes .. 4   (offset: 0x440)
// strings ... 2   (offset: 0x460)
// dev strs .. 0   (offset: 0x478)
// exports ... 6   (offset: 0x1e0)
// cseg ...... 0x74 + 0x16c (0x1e0)
// imports ... 13  (offset: 0x2d0)
// animtree1 . 0   (offset: 0x478)
// animtree2 . 0   (offset: 0x478)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_slayer_arena_gamma;

// Namespace ztron_slayer_arena_gamma
// Params 0, eflags: 0x5
// Checksum 0x4e91a70b, Offset: 0x92
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"gamma", undefined, &arena_init, undefined );
}

// Namespace ztron_slayer_arena_gamma
// Params 0
// Checksum 0xcefad5c9, Offset: 0xb3
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_slayer_arena_gamma
// Params 0
// Checksum 0x992a04a1, Offset: 0xc4
// Size: 0x19
function arena_init_internal()
{
    waittillframeend();
    ztron_slayer::function_2295e22fea1bdcc3( "gamma", &gamma_init, &gamma_shutdown );
}

// Namespace ztron_slayer_arena_gamma
// Params 1
// Checksum 0xd58e9833, Offset: 0xe5
// Size: 0x50
function gamma_init( arena )
{
    arena ztron_util::slickclipsave();
    arena ztron_util::slickclipsetup();
    arena.var_92923dbd082a3897 = getdvarfloat( @"hash_15ab346766b3ef85", 0.9 );
    setdvar( @"hash_15ab346766b3ef85", cos( 5 ) );
}

// Namespace ztron_slayer_arena_gamma
// Params 1
// Checksum 0x5f14701e, Offset: 0x13d
// Size: 0xa3
function gamma_shutdown( arena )
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_bdbf6cf2011e0b2d = ztron_arena::function_973956bb5a6e60f7( "aethereal_swamp" ).id;
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 0;
    }
    
    level notify( #"hash_19a9a93194ad9388" );
    arena ztron_util::slickcliprestore();
    setdvar( @"hash_15ab346766b3ef85", arena.var_92923dbd082a3897 );
}

