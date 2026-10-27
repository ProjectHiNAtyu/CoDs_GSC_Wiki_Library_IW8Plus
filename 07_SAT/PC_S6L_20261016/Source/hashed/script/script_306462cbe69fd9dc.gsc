// script_306462cbe69fd9dc  (hash_306462cbe69fd9dc.gscc) (size: 603 Bytes / 0x25b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x123d7b3f (306019135)
// size ...... 603 (0x25b)
// includes .. 1   (offset: 0x20f)
// strings ... 1   (offset: 0x217)
// dev strs .. 4   (offset: 0x223)
// exports ... 4   (offset: 0xfb)
// cseg ...... 0x61 + 0x9a (0xfb)
// imports ... 4   (offset: 0x19b)
// animtree1 . 0   (offset: 0x25b)
// animtree2 . 0   (offset: 0x25b)
#using scripts\mp\br\gametypes\br_secondary_victory_util;

#namespace namespace_72590d5302c2fd67;

// Namespace namespace_72590d5302c2fd67
// Params 0, eflags: 0x1
// Checksum 0x842359cf, Offset: 0x7f
// Size: 0x31
function autoexec main()
{
    /#
        iprintln( "<dev string:x24>" + "<dev string:x38>" + "<dev string:x3e>" );
    #/
    
    br_secondary_victory_util::registermission( "crate", &init, &function_1b65687d205624a3 );
}

// Namespace namespace_72590d5302c2fd67
// Params 3, eflags: 0x4
// Checksum 0x159d7ab4, Offset: 0xb8
// Size: 0x37
function private init( bundle, total, xpbonus )
{
    /#
        iprintln( "<dev string:x24>" + "<dev string:x38>" + "<dev string:x50>" );
    #/
}

// Namespace namespace_72590d5302c2fd67
// Params 0, eflags: 0x4
// Checksum 0x924b4c50, Offset: 0xf7
// Size: 0x3, Type: bool
function private function_1b65687d205624a3()
{
    return false;
}

