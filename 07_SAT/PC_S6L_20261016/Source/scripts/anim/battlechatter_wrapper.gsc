// scripts\anim\battlechatter_wrapper.gsc  (hash_2cfbd51b20c32d37.gscc) (size: 513 Bytes / 0x201 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x908dc351 (2425209681)
// size ...... 513 (0x201)
// includes .. 1   (offset: 0x1e1)
// strings ... 2   (offset: 0x1e9)
// dev strs .. 0   (offset: 0x201)
// exports ... 5   (offset: 0xf9)
// cseg ...... 0x6d + 0x8c (0xf9)
// imports ... 1   (offset: 0x1c1)
// animtree1 . 0   (offset: 0x201)
// animtree2 . 0   (offset: 0x201)
#using scripts\anim\battlechatter;

#namespace battlechatter_wrapper;

// Namespace battlechatter_wrapper
// Params 1
// Checksum 0xdabeadc2, Offset: 0x8b
// Size: 0xc
function evaluatemoveevent( wasincover )
{
    
}

// Namespace battlechatter_wrapper
// Params 0
// Checksum 0xf87b361c, Offset: 0x9f
// Size: 0x2
function evaluatereloadevent()
{
    
}

// Namespace battlechatter_wrapper
// Params 2
// Checksum 0xe36486cf, Offset: 0xa9
// Size: 0x2e
function function_47ce4c7d8b61f346( enemytype, enemy )
{
    battlechatter::executeevent( "spotted", [ enemytype, enemy ] );
}

// Namespace battlechatter_wrapper
// Params 1
// Checksum 0xaf93af0, Offset: 0xdf
// Size: 0x1a
function evaluateattackevent( type )
{
    battlechatter::executeevent( "attack", type );
}

