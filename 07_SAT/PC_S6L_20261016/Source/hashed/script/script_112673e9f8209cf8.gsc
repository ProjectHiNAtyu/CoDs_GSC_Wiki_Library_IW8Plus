// script_112673e9f8209cf8  (hash_112673e9f8209cf8.gscc) (size: 623 Bytes / 0x26f)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe621e0ca (3860979914)
// size ...... 623 (0x26f)
// includes .. 0   (offset: 0x26f)
// strings ... 0   (offset: 0x26f)
// dev strs .. 0   (offset: 0x26f)
// exports ... 4   (offset: 0x15b)
// cseg ...... 0x58 + 0x103 (0x15b)
// imports ... 4   (offset: 0x1fb)
// animtree1 . 0   (offset: 0x26f)
// animtree2 . 0   (offset: 0x26f)
#namespace bt_util;

// Namespace bt_util
// Params 0
// Checksum 0xce5c2f6a, Offset: 0x76
// Size: 0x50
function init()
{
    if ( isdefined( level._btactions ) )
    {
        return;
    }
    
    level._btactions = [];
    anim.failure = 0;
    anim.success = 1;
    anim.running = 2;
    anim.skip = 3;
    anim.invalid = 4;
}

// Namespace bt_util
// Params 0
// Checksum 0x50a15e45, Offset: 0xce
// Size: 0x53
function bt_init()
{
    assert( !isdefined( self.bt ) );
    self.bt = spawnstruct();
    
    if ( isdefined( self.behaviortreeasset ) )
    {
        self btregistertreeinstance( self.behaviortreeasset );
    }
    
    self.bt.instancedata = [];
}

// Namespace bt_util
// Params 1
// Checksum 0x58fa0124, Offset: 0x129
// Size: 0x32
function bt_terminateandreplace( var_4dbe9811ad117b11 )
{
    self btterminatetreeinstance();
    
    if ( isdefined( var_4dbe9811ad117b11 ) )
    {
        self.behaviortreeasset = var_4dbe9811ad117b11;
        self btregistertreeinstance( self.behaviortreeasset );
    }
}

