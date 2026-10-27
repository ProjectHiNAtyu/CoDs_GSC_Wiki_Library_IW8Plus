// scripts\common\ai\aitypes\aries_boss\aries_boss_metabones.gsc  (hash_67541e904a151079.gscc) (size: 819 Bytes / 0x333 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d06eb61 (1560734561)
// size ...... 819 (0x333)
// includes .. 2   (offset: 0x2ef)
// strings ... 4   (offset: 0x2ff)
// dev strs .. 0   (offset: 0x333)
// exports ... 4   (offset: 0x16b)
// cseg ...... 0x84 + 0xe7 (0x16b)
// imports ... 8   (offset: 0x20b)
// animtree1 . 0   (offset: 0x333)
// animtree2 . 0   (offset: 0x333)
#using scripts\common\ai\aitypes\aries_boss\aries_boss;
#using scripts\common\metabone;

#namespace aries_boss_metabones;

// Namespace aries_boss_metabones
// Params 0, eflags: 0x1
// Checksum 0x91954540, Offset: 0xa2
// Size: 0x2f
function autoexec main()
{
    var_fb56e56d94279338 = "aries_boss";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    metabone::function_7b57cab1f2311c7b( var_fb56e56d94279338, &function_7af73e5c3e2c4b17 );
}

// Namespace aries_boss_metabones
// Params 1
// Checksum 0x5c35fe17, Offset: 0xd9
// Size: 0x67
function on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    metabone::set_metabone_active( metabone_name, "true" );
    metabone::set_metabone_state( metabone_name, "disabled" );
    aries_boss::function_10287b60f902efb2( -1 );
    metabone::set_metabone_state( metabone_name, "active" );
    metabone::set_metabone_health( metabone_name, 800, "active" );
}

// Namespace aries_boss_metabones
// Params 1
// Checksum 0xb0dc444f, Offset: 0x148
// Size: 0x23
function function_7af73e5c3e2c4b17( params )
{
    metabone = params.metabone_name;
}

