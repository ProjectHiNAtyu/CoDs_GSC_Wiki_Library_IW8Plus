// script_67ffbe87dc9436fa  (hash_67ffbe87dc9436fa.gscc) (size: 670 Bytes / 0x29e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56c57741 (1455781697)
// size ...... 670 (0x29e)
// includes .. 3   (offset: 0x25e)
// strings ... 1   (offset: 0x276)
// dev strs .. 2   (offset: 0x286)
// exports ... 3   (offset: 0x106)
// cseg ...... 0x6b + 0x9b (0x106)
// imports ... 8   (offset: 0x17e)
// animtree1 . 0   (offset: 0x29e)
// animtree2 . 0   (offset: 0x29e)
#using script_640b69521097c6a5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;

#namespace namespace_f8b8d50b63bcec41;

// Namespace namespace_f8b8d50b63bcec41
// Params 0
// Checksum 0x22d0a59, Offset: 0x89
// Size: 0x44
function function_623484f9e2ef43f6()
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    self clearbtgoal( 0 );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x70>" );
        }
    #/
    
    asm::function_7256f5ba459c840b( "summon_stingers" );
}

// Namespace namespace_f8b8d50b63bcec41
// Params 0
// Checksum 0xee9bbbb9, Offset: 0xd5
// Size: 0x30, Type: bool
function function_36394163e6e2ab8d()
{
    if ( isalive( self ) && isai( self ) && asm::asm_getcurrentstatename( self.asmname ) == "summon_stingers" )
    {
        return true;
    }
    
    return false;
}

