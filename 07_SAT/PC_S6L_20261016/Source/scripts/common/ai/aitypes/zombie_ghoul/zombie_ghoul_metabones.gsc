// scripts\common\ai\aitypes\zombie_ghoul\zombie_ghoul_metabones.gsc  (hash_2958012ac0490539.gscc) (size: 1050 Bytes / 0x41a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5977d2c8 (1501024968)
// size ...... 1050 (0x41a)
// includes .. 3   (offset: 0x3c2)
// strings ... 4   (offset: 0x3da)
// dev strs .. 1   (offset: 0x40e)
// exports ... 3   (offset: 0x1de)
// cseg ...... 0x96 + 0x148 (0x1de)
// imports ... 13  (offset: 0x256)
// animtree1 . 0   (offset: 0x41a)
// animtree2 . 0   (offset: 0x41a)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\metabone;

#namespace zombie_ghoul_metabones;

// Namespace zombie_ghoul_metabones
// Params 0, eflags: 0x1
// Checksum 0xd521eff1, Offset: 0xb4
// Size: 0x13
function autoexec main()
{
    metabone::function_cd947f1a3391c065( "zombie_ghoul", &on_metabone_destroyed );
}

// Namespace zombie_ghoul_metabones
// Params 1, eflags: 0x4
// Checksum 0x37359460, Offset: 0xcf
// Size: 0x10f
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        if ( zombie_utils::function_bf1464d09f4e4b40() )
        {
            metabone::set_metabone_health( metabone_name, 1 );
            metabone::set_metabone_active( metabone_name, 1 );
            return;
        }
        
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        asm::function_7256f5ba459c840b( "metabone_destroyed_in" );
        self dodamage( self.maxhealth * 0.1, self.origin, params.eattacker, params.einflictor, undefined, undefined, "none", undefined, 65536 );
        
        if ( isdefined( self.alive_heads ) )
        {
            self.alive_heads = arrayremove( self.alive_heads, metabone_name );
            
            if ( self.alive_heads.size == 1 )
            {
                metabone::set_metabone_health( self.alive_heads[ 0 ] );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

