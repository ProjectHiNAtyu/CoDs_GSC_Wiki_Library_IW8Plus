// scripts\common\ai\aitypes\shared\zombie\zombie_liveragdoll.gsc  (hash_480d8775b87d1c2a.gscc) (size: 855 Bytes / 0x357 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9346db5 (3107220917)
// size ...... 855 (0x357)
// includes .. 2   (offset: 0x31b)
// strings ... 3   (offset: 0x32b)
// dev strs .. 0   (offset: 0x357)
// exports ... 4   (offset: 0x197)
// cseg ...... 0x88 + 0x10f (0x197)
// imports ... 8   (offset: 0x237)
// animtree1 . 0   (offset: 0x357)
// animtree2 . 0   (offset: 0x357)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace zombie_liveragdoll;

// Namespace zombie_liveragdoll
// Params 2
// Checksum 0xa56180ff, Offset: 0xa6
// Size: 0x37
function function_3e68edf0cd485244( taskid, params )
{
    if ( !utility::ent_flag( "in_liveragdoll" ) )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace zombie_liveragdoll
// Params 2
// Checksum 0xf4fc42e5, Offset: 0xe6
// Size: 0x9a, Type: bool
function function_6273f9e3a020d096( source_pos, intensity )
{
    if ( !isdefined( source_pos ) )
    {
        return false;
    }
    
    if ( function_47a5a829160e2894() )
    {
        return false;
    }
    
    if ( !self asmhasstate( self.asmname, "live_ragdoll_start" ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_dee78f8c41d19b65", 0 ) > 0 )
    {
        source_to_ai = vectornormalize( self.origin - source_pos );
        self function_1d5453a0507b54e1( "head", source_to_ai * intensity, 1, 0 );
    }
    else
    {
        self startliveragdoll();
    }
    
    asm::function_7256f5ba459c840b( "live_ragdoll_start" );
    return true;
}

// Namespace zombie_liveragdoll
// Params 0
// Checksum 0xc4355e36, Offset: 0x189
// Size: 0xd
function function_47a5a829160e2894()
{
    return utility::ent_flag( "in_liveragdoll" );
}

