// script_18adba9cb790f398  (hash_18adba9cb790f398.gscc) (size: 403 Bytes / 0x193 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd18a129 (3172507945)
// size ...... 403 (0x193)
// includes .. 2   (offset: 0x183)
// strings ... 0   (offset: 0x193)
// dev strs .. 0   (offset: 0x193)
// exports ... 3   (offset: 0xb7)
// cseg ...... 0x58 + 0x5f (0xb7)
// imports ... 3   (offset: 0x12f)
// animtree1 . 0   (offset: 0x193)
// animtree2 . 0   (offset: 0x193)
#using scripts\common\system;
#using scripts\mp\ob\systems\ob_quests;

#namespace namespace_f511b0b0653ac7f;

// Namespace namespace_f511b0b0653ac7f
// Params 0, eflags: 0x5
// Checksum 0xd0ab0de7, Offset: 0x76
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_73ce6b990cf24132", #"hash_73ce66990cf238b3", &function_71e5ce509ff79f70, undefined );
}

// Namespace namespace_f511b0b0653ac7f
// Params 0, eflags: 0x4
// Checksum 0xd4bf7a9b, Offset: 0x9f
// Size: 0x18
function private function_71e5ce509ff79f70()
{
    if ( !ob_quests::quests_enabled() )
    {
        return;
    }
    
    level.var_c4d57d774e5f2d68 = 3;
}

