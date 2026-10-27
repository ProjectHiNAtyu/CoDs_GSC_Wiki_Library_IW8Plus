// scripts\mp\assisted_targeting.gsc  (hash_146b12d3d1432238.gscc) (size: 583 Bytes / 0x247 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ec6c7a (49048698)
// size ...... 583 (0x247)
// includes .. 1   (offset: 0x23f)
// strings ... 0   (offset: 0x247)
// dev strs .. 0   (offset: 0x247)
// exports ... 4   (offset: 0x127)
// cseg ...... 0x58 + 0xcf (0x127)
// imports ... 4   (offset: 0x1c7)
// animtree1 . 0   (offset: 0x247)
// animtree2 . 0   (offset: 0x247)
#using scripts\common\utility;

#namespace assisted_targeting_internal;

// Namespace assisted_targeting_internal
// Params 0, eflags: 0x1
// Checksum 0xa7fe3eff, Offset: 0x76
// Size: 0x3e
function autoexec main()
{
    utility::registersharedfunc( #"assisted_targeting", #"applydisabled", &applydisabled );
    utility::registersharedfunc( #"assisted_targeting", #"removedisabled", &removedisabled );
}

// Namespace assisted_targeting_internal
// Params 0, eflags: 0x4
// Checksum 0x361cfa55, Offset: 0xbc
// Size: 0x2f
function private applydisabled()
{
    if ( !self )
    {
        return;
    }
    
    if ( !isdefined( self.var_418616ac3196a5a ) )
    {
        self.var_418616ac3196a5a = 0;
    }
    
    self.var_418616ac3196a5a++;
    self function_ee1c16d57db89f98( 0 );
}

// Namespace assisted_targeting_internal
// Params 0, eflags: 0x4
// Checksum 0xcb0f9b36, Offset: 0xf3
// Size: 0x34
function private removedisabled()
{
    if ( !self )
    {
        return;
    }
    
    if ( self.var_418616ac3196a5a > 1 )
    {
        self.var_418616ac3196a5a--;
        return;
    }
    
    self.var_418616ac3196a5a = undefined;
    self function_ee1c16d57db89f98( 1 );
}

