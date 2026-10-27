// scripts\common\killstreaks\killstreak_common.gsc  (hash_086dd12fbdc320b2.gscc) (size: 416 Bytes / 0x1a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x84f1dc25 (2230443045)
// size ...... 416 (0x1a0)
// includes .. 0   (offset: 0x188)
// strings ... 0   (offset: 0x188)
// dev strs .. 2   (offset: 0x188)
// exports ... 2   (offset: 0x11c)
// cseg ...... 0x58 + 0xc4 (0x11c)
// imports ... 1   (offset: 0x16c)
// animtree1 . 0   (offset: 0x1a0)
// animtree2 . 0   (offset: 0x1a0)
#namespace killstreak;

// Namespace killstreak
// Params 1
// Checksum 0x11433263, Offset: 0x76
// Size: 0xa5
function function_85b2d8e857ab4898( streakname )
{
    globals = level.streakglobals;
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        streakbundlename = self.pers[ #"hash_5358b5a919fe00a6" ][ streakname ];
        
        if ( streakbundlename )
        {
            bundle = globals.var_91bdb7de5b47da10[ streakbundlename ];
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = globals.streakbundles[ streakname ];
    }
    
    /#
        if ( !isdefined( bundle ) && isdefined( streakname ) )
        {
            iprintln( "<dev string:x24>" + streakname + "<dev string:x41>" );
        }
    #/
    
    return bundle;
}

