// script_60f29c1b1972f10b  (hash_60f29c1b1972f10b.gscc) (size: 423 Bytes / 0x1a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x387b8bf2 (947620850)
// size ...... 423 (0x1a7)
// includes .. 1   (offset: 0x193)
// strings ... 1   (offset: 0x19b)
// dev strs .. 0   (offset: 0x1a7)
// exports ... 3   (offset: 0xe3)
// cseg ...... 0x76 + 0x6d (0xe3)
// imports ... 2   (offset: 0x15b)
// animtree1 . 0   (offset: 0x1a7)
// animtree2 . 0   (offset: 0x1a7)
#using scripts\common\callbacks;

#namespace specialty_outline_immunity;

// Namespace specialty_outline_immunity
// Params 0, eflags: 0x1
// Checksum 0x4bddf752, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_outline_immunity
// Params 1
// Checksum 0x28d00816, Offset: 0xb4
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_outline_immunity" );
    }
}

