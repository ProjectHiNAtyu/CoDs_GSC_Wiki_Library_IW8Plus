// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_metabones.gsc  (hash_109b0e7c5bd471c3.gscc) (size: 751 Bytes / 0x2ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x250a1df0 (621420016)
// size ...... 751 (0x2ef)
// includes .. 1   (offset: 0x2b3)
// strings ... 3   (offset: 0x2bb)
// dev strs .. 1   (offset: 0x2e3)
// exports ... 3   (offset: 0x15b)
// cseg ...... 0x88 + 0xd3 (0x15b)
// imports ... 8   (offset: 0x1d3)
// animtree1 . 0   (offset: 0x2ef)
// animtree2 . 0   (offset: 0x2ef)
#using scripts\common\metabone;

#namespace zombie_disciple_metabones;

// Namespace zombie_disciple_metabones
// Params 0, eflags: 0x1
// Checksum 0x7343ade0, Offset: 0xa6
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_disciple";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_disciple_metabones
// Params 1, eflags: 0x4
// Checksum 0x1b2623c2, Offset: 0xcf
// Size: 0x8c
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        metabone::set_metabone_active( metabone_name, 1 );
        
        if ( !self.var_e3ff6b5a34e23c16 )
        {
            self function_786bb6aa1b76c7ee( "in_head_pain", 1 );
        }
        
        self notify( #"hash_bbc17a460056247c" );
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

