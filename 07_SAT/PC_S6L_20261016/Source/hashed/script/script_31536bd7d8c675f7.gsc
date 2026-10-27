// script_31536bd7d8c675f7  (hash_31536bd7d8c675f7.gscc) (size: 425 Bytes / 0x1a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8671460 (2825327712)
// size ...... 425 (0x1a9)
// includes .. 1   (offset: 0x195)
// strings ... 1   (offset: 0x19d)
// dev strs .. 0   (offset: 0x1a9)
// exports ... 3   (offset: 0xe5)
// cseg ...... 0x75 + 0x70 (0xe5)
// imports ... 2   (offset: 0x15d)
// animtree1 . 0   (offset: 0x1a9)
// animtree2 . 0   (offset: 0x1a9)
#using scripts\common\callbacks;

#namespace specialty_directional_uav;

// Namespace specialty_directional_uav
// Params 0, eflags: 0x5
// Checksum 0xda812011, Offset: 0x93
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_ee561f348f7226e3 );
}

// Namespace specialty_directional_uav
// Params 1, eflags: 0x4
// Checksum 0x60be6788, Offset: 0xb3
// Size: 0x32
function private function_ee561f348f7226e3( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_directional_uav", undefined, undefined, [] );
    }
}

