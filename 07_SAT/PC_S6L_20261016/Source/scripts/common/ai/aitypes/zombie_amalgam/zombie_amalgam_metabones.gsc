// scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_metabones.gsc  (hash_09e804020908131f.gscc) (size: 633 Bytes / 0x279 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48868c88 (1216777352)
// size ...... 633 (0x279)
// includes .. 2   (offset: 0x251)
// strings ... 1   (offset: 0x261)
// dev strs .. 1   (offset: 0x26d)
// exports ... 4   (offset: 0x109)
// cseg ...... 0x6a + 0x9f (0x109)
// imports ... 6   (offset: 0x1a9)
// animtree1 . 0   (offset: 0x279)
// animtree2 . 0   (offset: 0x279)
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_parts;
#using scripts\common\metabone;

#namespace zombie_amalgam_metabones;

// Namespace zombie_amalgam_metabones
// Params 0, eflags: 0x1
// Checksum 0xe0c0beb9, Offset: 0x88
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_amalgam";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_amalgam_metabones
// Params 1, eflags: 0x4
// Checksum 0x41c17760, Offset: 0xb1
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_amalgam_metabones
// Params 1, eflags: 0x4
// Checksum 0x651afbec, Offset: 0xd7
// Size: 0x32
function private _on_metabone_destroyed( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        namespace_ef593377fdc8b4e0::function_89631485e1e3ebec( metabone_name );
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

