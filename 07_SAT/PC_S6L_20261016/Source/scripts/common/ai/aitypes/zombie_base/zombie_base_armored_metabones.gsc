// scripts\common\ai\aitypes\zombie_base\zombie_base_armored_metabones.gsc  (hash_42ece70f83b2b93e.gscc) (size: 802 Bytes / 0x322 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ceea289 (1290707593)
// size ...... 802 (0x322)
// includes .. 1   (offset: 0x2de)
// strings ... 4   (offset: 0x2e6)
// dev strs .. 1   (offset: 0x316)
// exports ... 4   (offset: 0x15e)
// cseg ...... 0x97 + 0xc7 (0x15e)
// imports ... 8   (offset: 0x1fe)
// animtree1 . 0   (offset: 0x322)
// animtree2 . 0   (offset: 0x322)
#using scripts\common\metabone;

#namespace zombie_base_armored_metabones;

// Namespace zombie_base_armored_metabones
// Params 0, eflags: 0x1
// Checksum 0x6d0a70ab, Offset: 0xb5
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_base_armored";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_base_armored_metabones
// Params 1, eflags: 0x4
// Checksum 0xf61cb2aa, Offset: 0xde
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_base_armored_metabones
// Params 1, eflags: 0x4
// Checksum 0xe46cd7ab, Offset: 0x104
// Size: 0x5a
function private _on_metabone_destroyed( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "exposed" );
        
        if ( metabone_name == "armored_head" )
        {
            metabone::set_metabone_active( metabone_name, 1 );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

