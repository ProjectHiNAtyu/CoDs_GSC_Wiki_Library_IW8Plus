// script_6de1b9fbdf8db6bb  (hash_6de1b9fbdf8db6bb.gscc) (size: 666 Bytes / 0x29a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55430610 (1430455824)
// size ...... 666 (0x29a)
// includes .. 3   (offset: 0x25a)
// strings ... 1   (offset: 0x272)
// dev strs .. 2   (offset: 0x282)
// exports ... 3   (offset: 0x102)
// cseg ...... 0x67 + 0x9b (0x102)
// imports ... 8   (offset: 0x17a)
// animtree1 . 0   (offset: 0x29a)
// animtree2 . 0   (offset: 0x29a)
#using script_640b69521097c6a5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;

#namespace namespace_77f0670c8a2e733c;

// Namespace namespace_77f0670c8a2e733c
// Params 0
// Checksum 0xc2d8b93b, Offset: 0x85
// Size: 0x44
function function_d7144ac95cf9f789()
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    self clearbtgoal( 0 );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x6a>" );
        }
    #/
    
    asm::function_7256f5ba459c840b( "bomb_attack" );
}

// Namespace namespace_77f0670c8a2e733c
// Params 0
// Checksum 0x188cdf32, Offset: 0xd1
// Size: 0x30, Type: bool
function function_37f4de727b08b964()
{
    if ( isalive( self ) && isai( self ) && asm::asm_getcurrentstatename( self.asmname ) == "bomb_attack" )
    {
        return true;
    }
    
    return false;
}

